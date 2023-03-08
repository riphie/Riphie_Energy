local A, L = ...

local mediapath = "Interface\\AddOns\\" .. A .. "\\media\\"

L.cfg = {
  height = 10,
  width = 184,

  pos = { a1 = "CENTER", a2 = "CENTER", af = "UIParent", x = 0, y = -133 },

  texture = mediapath .. "SkullflowerGradient2",

  text = {
    enable = false,
    font = mediapath .. "Expressway.ttf",
    size = 11,
    pos = { a1 = "CENTER", a2 = "CENTER", af = "energyBar", x = 0, y = 0 },
  },

  colors = {
    bg = { 0 / 255, 0 / 255, 0 / 255, 0.5 },

    mana = { 0 / 255, 190 / 255, 230 / 255, 1 },
    rage = { 65 / 255, 65 / 255, 65 / 255, 1 },
    focus = { 230 / 255, 140 / 255, 60 / 255, 1 },
    energy = { 246 / 255, 222 / 255, 32 / 255, 1 },
    runicpower = { 65 / 255, 65 / 255, 65 / 255, 1 },
    lunarpower = { 65 / 255, 65 / 255, 65 / 255, 1 },
    maelstrom = { 0 / 255, 127 / 255, 255 / 255, 1 },
    insanity = { 65 / 255, 65 / 255, 65 / 255, 1 },
    fury = { 65 / 255, 65 / 255, 65 / 255, 1 },
    pain = { 65 / 255, 65 / 255, 65 / 255, 1 },
  },
}
