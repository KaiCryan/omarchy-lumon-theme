-- lumon-mdr: a macrodata-refinement floor for the visualizer slot.
--
-- v3. Boxes the grid in a hairline CRT-panel frame with a coarse scanline
-- tint on alternating rows and a footer line with a fake unit ID and a
-- burned-in REC timer — the "boxed readout on old hardware" look, not just
-- numbers floating in open space. Falls back to the unframed grid on
-- terminals too small for the frame to have breathing room.
--
-- Still no colour logic — the active theme tints the whole thing, correct
-- for a monochrome Lumon terminal.

local p = plugin.register({
    name = "lumon-mdr",
    type = "visualizer",
    version = "3.0.0",
    description = "Macrodata refinement floor, boxed in a CRT panel with a scanline tint and a REC timer",
})

local ZONES = 10
local CELL_W = 4 -- " NN " / "[NN]" — both exactly 4 chars, grid never misaligns

-- classic GLSL-style hash: integer seed in, pseudo-random [0,1) out.
local function pseudo(n)
    local x = math.sin(n) * 43758.5453
    return x - math.floor(x)
end

-- one row of the number grid, `per_row` cells wide, with the flagged cluster
-- burned in if this row is the current cluster_row.
local function grid_row(row, per_row, bands, frame, cluster_row, cluster_start, cluster_len)
    local zone_w = math.max(1, math.floor(per_row / ZONES))
    local cells = {}
    for c = 1, per_row do
        local zone = math.min(ZONES, math.floor((c - 1) / zone_w) + 1)
        local level = bands[zone] or 0

        -- idle: a value barely refines. loud: it refines briskly.
        local change_every = math.max(2, math.floor(34 - level * 30))
        local bucket = math.floor(frame / change_every)
        local seed = row * 977 + c * 131 + bucket * 7 + zone * 53
        local value = math.floor(pseudo(seed) * 100)
        local text = string.format("%02d", value)

        local flagged = row == cluster_row
            and c >= cluster_start
            and c < cluster_start + cluster_len
        cells[c] = flagged and ("[" .. text .. "]") or (" " .. text .. " ")
    end
    return table.concat(cells)
end

local function cluster_position(frame, rows, per_row, cluster_len)
    local span = math.max(1, per_row - cluster_len)
    local row = 1 + (math.floor(frame / 48) % rows)
    local start = 1 + (math.floor(frame / 8) % span)
    return row, start
end

-- no frame: the old dense grid, used as a fallback when the terminal is too
-- small for the frame to have breathing room.
local function render_plain(bands, frame, rows, cols)
    local per_row = math.max(1, math.floor(cols / CELL_W))
    local cluster_len = 3
    local cluster_row, cluster_start = cluster_position(frame, rows, per_row, cluster_len)

    local lines = {}
    for row = 1, rows do
        lines[row] = grid_row(row, per_row, bands, frame, cluster_row, cluster_start, cluster_len)
    end
    return table.concat(lines, "\n")
end

function p:render(bands, frame, rows, cols)
    rows = math.max(1, rows)
    cols = math.max(1, cols)

    -- frame overhead is 3 rows (top border, bottom border, footer) and 2
    -- cols (left/right border). below that, degrade rather than break.
    local content_rows = rows - 3
    local inner_cols = cols - 2
    if content_rows < 1 or inner_cols < 12 then
        return render_plain(bands, frame, rows, cols)
    end

    local per_row = math.max(1, math.floor(inner_cols / CELL_W))
    local cluster_len = 3
    local cluster_row, cluster_start = cluster_position(frame, content_rows, per_row, cluster_len)

    local lines = {}
    lines[1] = "╭" .. string.rep("─", inner_cols) .. "╮"

    for row = 1, content_rows do
        local content = grid_row(row, per_row, bands, frame, cluster_row, cluster_start, cluster_len)

        if #content < inner_cols then
            content = content .. string.rep(" ", inner_cols - #content)
        elseif #content > inner_cols then
            content = content:sub(1, inner_cols)
        end

        -- coarse scanline: even rows get a faint tint at each edge, but
        -- never over a bracket -- only ever replace blank padding.
        if row % 2 == 0 then
            local first, last = content:sub(1, 1), content:sub(inner_cols, inner_cols)
            if first == " " then first = "░" end
            if last == " " then last = "░" end
            content = first .. content:sub(2, inner_cols - 1) .. last
        end

        lines[row + 1] = "│" .. content .. "│"
    end

    lines[content_rows + 2] = "╰" .. string.rep("─", inner_cols) .. "╯"

    -- footer: fake unit ID + status, and a burned-in REC timer derived from
    -- the frame counter (~20 FPS per the plugin docs).
    local secs = math.floor(frame / 20)
    local timer_str = string.format("REC %02d:%02d", math.floor(secs / 60), secs % 60)
    local label = " MDR-7 STATUS: NOMINAL"
    local pad = math.max(1, cols - #label - #timer_str)
    local footer = label .. string.rep(" ", pad) .. timer_str
    if #footer > cols then
        footer = footer:sub(1, cols)
    end
    lines[content_rows + 3] = footer

    return table.concat(lines, "\n")
end

function p:init(rows, cols)
    cliamp.log.info("lumon-mdr: floor online (" .. rows .. "x" .. cols .. ")")
end

return p
