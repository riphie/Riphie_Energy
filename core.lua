local A, L = ...

local backdrop_tab = {
  bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
  tile = false,
  tileSize = 0,
  edgeSize = 1,
  insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local powerColors = {
  [0] = L.cfg.colors.mana,
  [1] = L.cfg.colors.rage,
  [2] = L.cfg.colors.focus,
  [3] = L.cfg.colors.energy,
  [6] = L.cfg.colors.runicpower,
  [8] = L.cfg.colors.lunarpower,
  [11] = L.cfg.colors.maelstrom,
  [13] = L.cfg.colors.insanity,
  [17] = L.cfg.colors.fury,
  [18] = L.cfg.colors.pain,
}

local smoothing = {}

local energyBarBg = CreateFrame("Frame", "Riphie_Energy", UIParent, "BackdropTemplate")
PixelUtil.SetHeight(energyBarBg, L.cfg.height)
PixelUtil.SetWidth(energyBarBg, L.cfg.width)
PixelUtil.SetPoint(energyBarBg, L.cfg.pos.a1, L.cfg.pos.af, L.cfg.pos.a2, L.cfg.pos.x, L.cfg.pos.y, 1, 1)
energyBarBg:SetBackdrop(backdrop_tab)
energyBarBg:SetBackdropColor(unpack(L.cfg.colors.bg))
energyBarBg:SetBackdropBorderColor(0, 0, 0, 0)

local energyBar = CreateFrame("StatusBar", "energyBar", energyBarBg)
energyBar:SetStatusBarTexture(L.cfg.texture)
PixelUtil.SetPoint(energyBar, "TOPLEFT", energyBarBg, "TOPLEFT", 1, -1, 1, 1)
PixelUtil.SetPoint(energyBar, "BOTTOMRIGHT", energyBarBg, "BOTTOMRIGHT", -1, 1)

energyBar.SetValue_ = energyBar.SetValue
energyBar.SetValue = function(self, value)
  if value ~= self:GetValue() or value == 0 then
    smoothing[self] = value
  else
    smoothing[self] = nil
  end
end

local energyBarText = energyBar:CreateFontString(nil, "OVERLAY")
energyBarText:SetFont(L.cfg.text.font, L.cfg.text.size, "THINOUTLINE")
PixelUtil.SetPoint(
  energyBarText,
  L.cfg.text.pos.a1,
  L.cfg.text.pos.af,
  L.cfg.text.pos.a2,
  L.cfg.text.pos.x,
  L.cfg.text.pos.y,
  1,
  1
)
energyBarText:SetJustifyH("CENTER")

if not L.cfg.text.enable then
  energyBarText:Hide()
end

local abs, max, min = math.abs, math.max, math.min
energyBar:SetScript("OnUpdate", function(self, elapsed)
  local _, class = UnitClass("player")
  local _, powerType = UnitPowerType("player")
  local maxPower = UnitPowerMax("player", UnitPowerType("player"))

  if class == "DEATHKNIGHT" then
    maxPower = maxPower / 10
  end

  if class == "DRUID" then
    if powerType == "LUNAR_POWER" then
      maxPower = maxPower / 10
    elseif powerType == "RAGE" then
      maxPower = maxPower / 10
    end
  end

  if class == "PRIEST" and powerType == "INSANITY" then
    maxPower = maxPower / 100
  end

  if class == "WARRIOR" then
    maxPower = maxPower / 10
  end

  self:SetMinMaxValues(0, maxPower)
  self:SetValue(UnitPower("player"))

  local limit = 30 / GetFramerate()

  for bar, value in pairs(smoothing) do
    local cur = bar:GetValue()
    local barmin, barmax = bar:GetMinMaxValues()
    local new = cur + min((value - cur) / 10, max(value - cur, limit))

    if new ~= new then
      new = value
    end

    bar:SetValue_(new)

    if cur == value or abs(cur - value) < 2 then
      bar:SetValue_(value)
      smoothing[bar] = nil
    end
  end
end)

energyBar:RegisterEvent("PLAYER_ENTERING_WORLD")
energyBar:RegisterEvent("PLAYER_SPECIALIZATION_CHANGED")
energyBar:RegisterEvent("UNIT_AURA")
energyBar:RegisterEvent("UNIT_POWER_FREQUENT")
energyBar:RegisterEvent("TRAIT_CONFIG_UPDATED")
energyBar:SetScript("OnEvent", function(self, event, ...)
  local powerColor = powerColors[UnitPowerType("player")]
  energyBar:SetStatusBarColor(unpack(powerColor))
  energyBarText:SetText(UnitPower("player"))
end)
