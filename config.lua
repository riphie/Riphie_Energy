local A, L = ...

local LibStub = LibStub
local LSM = LibStub("LibSharedMedia-3.0")

L.cfg = {
  height = 6,
  width = 184,

  pos = { a1 = "BOTTOM", a2 = "CENTER", af = "UIParent", x = 0, y = -155 },

  texture = LSM:Fetch("statusbar", "SkullflowerGradient2"),

  text = {
    enable = false,
    font = LSM:Fetch("font", "Expressway"),
    size = 12,
    pos = { a1 = "CENTER", a2 = "CENTER", af = "energyBar", x = 0, y = 0 },
  },

  colors = {
    bg = { 0 / 255, 0 / 255, 0 / 255, 1 },

    mana = { 0 / 255, 190 / 255, 230 / 255, 1 },
    rage = { 65 / 255, 65 / 255, 65 / 255, 1 },
    focus = { 230 / 255, 140 / 255, 60 / 255, 1 },
    energy = { 246 / 255, 222 / 255, 32 / 255, 1 },
    runicpower = { 65 / 255, 65 / 255, 65 / 255, 1 },
    lunarpower = { 65 / 255, 65 / 255, 65 / 255, 1 },
    maelstrom = { 0 / 255, 127 / 255, 255 / 255, 1 },
    insanity = { 65 / 255, 65 / 255, 65 / 255, 1 },
    fury = { 255 / 255, 110 / 255, 30 / 255, 1 },
    pain = { 255 / 255, 110 / 255, 30 / 255, 1 },
  },
}

local _, class = UnitClass("player")

if class == "DEMONHUNTER" then
  L.cfg.width = 350
end

if class == "EVOKER" then
  L.cfg.width = 353
end

if class == "ROGUE" then
  L.cfg.width = 314
end

if class == "WARRIOR" then
  L.cfg.width = 353
end
