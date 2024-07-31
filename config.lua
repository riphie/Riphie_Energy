local A, L = ...

local LibStub = LibStub
local LSM = LibStub "LibSharedMedia-3.0"

L.cfg = {
  height = 8,
  width = 359.5,

  pos = { a1 = "BOTTOM", a2 = "CENTER", af = "UIParent", x = 0, y = -158 },

  texture = LSM:Fetch("statusbar", "SkullflowerNeon"),

  text = {
    enable = false,
    font = LSM:Fetch("font", "Expressway"),
    size = 12,
    pos = { a1 = "CENTER", a2 = "CENTER", af = "energyBar", x = 0, y = 0 },
  },

  colors = {
    bg = { 0 / 255, 0 / 255, 0 / 255, 1 },

    -- TODO: update colors
    mana = { 0 / 255, 190 / 255, 230 / 255, 1 },
    rage = { 255 / 255, 0 / 255, 0 / 255, 1 },
    focus = { 230 / 255, 140 / 255, 60 / 255, 1 },
    energy = { 246 / 255, 222 / 255, 32 / 255, 1 },
    runicpower = { 65 / 255, 65 / 255, 65 / 255, 1 },
    lunarpower = { 195 / 255, 205 / 255, 240 / 255, 1 },
    maelstrom = { 0 / 255, 127 / 255, 255 / 255, 1 },
    insanity = { 65 / 255, 65 / 255, 65 / 255, 1 },
    fury = { 184 / 255, 49 / 255, 243 / 255, 1 },
  },
}
