-- lumon-flavor: the rest of the Lumon terminal — everything the theme file
-- and the visualizer plugin can't touch. Two voices on purpose: a cold
-- machine voice (boot sequence, diagnostics, occasional signal corruption —
-- ALL CAPS, terse, no punctuation warmth) and a corporate-human voice
-- (welcome/track/farewell lines) — the same split the show itself runs on.

local p = plugin.register({
    name = "lumon-flavor",
    type = "hook",
    version = "2.0.0",
    description = "Boot sequence, corporate messaging, signal corruption, and a diagnostics keybind",
    permissions = { "keymap" },
})

math.randomseed(os.time())

-- ---------------------------------------------------------------- voices --

local BOOT_SEQUENCE = {
    { text = "LUMON INDUSTRIES -- AUDIO REFINEMENT MODULE", at = 0.0 },
    { text = "SELF-TEST...",                                at = 1.0 },
    { text = "CALIBRATING WAVEFORM SENSORS...",              at = 2.1 },
    { text = "MODULE READY.",                                at = 3.3 },
}

local WELCOME = {
    "Welcome, valued employee.",
    "Please enjoy this jaunty tune.",
    "Your work is important, even if you don't know what it is.",
    "The break room is stocked. Refinement may commence.",
}

local ON_TRACK = {
    "Refining.",
    "This selection has been approved by the board.",
    "Optimal frequency detected.",
    "Marked for macrodata refinement.",
}

local FAREWELL = {
    "Have a fun and productive rest of your day.",
    "Your outie thanks you.",
    "Session terminated. Please exit through the stairwell.",
    "The music department appreciates your patronage.",
}

local DIAGNOSTICS = {
    "CORE TEMP: 41C -- NOMINAL",
    "DRIVE INTEGRITY: 97.2% -- ACCEPTABLE",
    "WAVEFORM SENSOR: OK",
    "BREAK ROOM SUPPLIES: LOW",
    "OUTIE STATUS: UNVERIFIABLE",
    "WELLNESS SCORE: PENDING REVIEW",
    "BADGE ACCESS: GRANTED (PROVISIONAL)",
    "REFINEMENT QUOTA: ON PACE",
    "HANDBOOK REVISION: CURRENT",
}

-- ------------------------------------------------------------ mechanics --

local function pick(list)
    return list[math.random(#list)]
end

-- a dying-CRT pass: a handful of characters swapped for static glyphs.
-- applied sparingly (see call sites) so it reads as an occasional fault,
-- not a broken string.
local GLITCH_CHARS = { "#", "%", "░", "▒", "▓", "x" }

local function glitch(text, chance)
    chance = chance or 0.10
    local out = {}
    for i = 1, #text do
        local c = text:sub(i, i)
        if c ~= " " and math.random() < chance then
            out[i] = GLITCH_CHARS[math.random(#GLITCH_CHARS)]
        else
            out[i] = c
        end
    end
    return table.concat(out)
end

-- --------------------------------------------------------------- hooks --

p:on("app.start", function()
    for _, stage in ipairs(BOOT_SEQUENCE) do
        cliamp.timer.after(stage.at, function()
            cliamp.message(stage.text, 1.3)
        end)
    end
    cliamp.timer.after(4.6, function()
        cliamp.message(pick(WELCOME), 6)
    end)
end)

p:on("track.change", function(track)
    -- Lumon doesn't chatter, it observes -- most tracks pass without comment.
    if math.random() < 0.4 then
        local title = track.title or "this file"
        -- glitch() walks bytes, not UTF-8 runes -- only ever apply it to our
        -- own ASCII copy, never to arbitrary (possibly multi-byte) metadata.
        local line = pick(ON_TRACK)
        if math.random() < 0.15 then
            line = glitch(line)
        end
        cliamp.message(line .. "  [" .. title .. "]", 5)
    end
end)

p:on("app.quit", function()
    cliamp.notify("Lumon Industries", pick(FAREWELL))
end)

-- F9 for a one-line status readout, cycling on repeat presses. F-keys are
-- the old BIOS/DOS convention for exactly this ("system info"), and cliamp's
-- own keymap is letter-dense enough that an F-key is the safer, less
-- collision-prone choice (checked live: d, despite the shipped docs calling
-- it unbound, actually opens the audio device picker).
local diag_i = 0
p:bind("f9", "Lumon diagnostics", function()
    diag_i = diag_i % #DIAGNOSTICS + 1
    cliamp.message("[DIAG] " .. DIAGNOSTICS[diag_i], 4)
end)

return p
