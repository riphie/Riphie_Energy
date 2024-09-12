local A, L = ...

local LibStub = LibStub
local LSM = LibStub "LibSharedMedia-3.0"

L.cfg = {
  height = 8,
  width = 359,

  pos = { a1 = "CENTER", a2 = "CENTER", af = "UIParent", x = 0, y = -200 },

  texture = LSM:Fetch("statusbar", "SkullflowerGradient"),

  text = {
    enable = false,
    font = LSM:Fetch("font", "Expressway"),
    size = 12,
    pos = { a1 = "CENTER", a2 = "CENTER", af = "energyBar", x = 0, y = 0 },
  },

  colors = {
    bg = { 0 / 255, 0 / 255, 0 / 255, 0.35 },

    [0] = { 0 / 255, 190 / 255, 230 / 255, 1 }, -- mana
    [1] = { 255 / 255, 0 / 255, 0 / 255, 1 }, -- rage
    [2] = { 230 / 255, 140 / 255, 60 / 255, 1 }, -- focus
    [3] = { 246 / 255, 222 / 255, 32 / 255, 1 }, -- energy
    [6] = { 0 / 255, 209 / 255, 255 / 255, 1 }, -- runic power
    [8] = { 77 / 255, 133 / 255, 230 / 255, 1 }, -- lunar power
    [11] = { 0 / 255, 128 / 255, 255 / 255, 1 }, -- maelstrom
    [13] = { 128 / 255, 0 / 255, 255 / 255, 1 }, -- insanity
    [17] = { 184 / 255, 49 / 255, 243 / 255, 1 }, -- fury
  },
}
