local A, L = ...
local cfg = L.cfg

local backdrop_tab = {
  bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
  tile = false,
  tileSize = 0,
  edgeSize = 1,
  insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local powerColors = {
  [0]  = cfg.colors.mana,
  [1]  = cfg.colors.rage,
  [2]  = cfg.colors.focus,
  [3]  = cfg.colors.energy,
  [6]  = cfg.colors.runicpower,
  [8]  = cfg.colors.lunarpower,
  [11] = cfg.colors.maelstrom,
  [13] = cfg.colors.insanity,
  [17] = cfg.colors.fury,
  [18] = cfg.colors.pain,
}

local smoothing = {}

local energyBarBg = CreateFrame("Frame", "energyBarBg", UIParent)
energyBarBg:SetHeight(cfg.height)
energyBarBg:SetWidth(cfg.width)
energyBarBg:SetPoint(cfg.pos.a1, cfg.pos.af, cfg.pos.a2, cfg.pos.x, cfg.pos.y)
energyBarBg:SetBackdrop(backdrop_tab)
energyBarBg:SetBackdropColor(unpack(cfg.colors.bg))
energyBarBg:SetBackdropBorderColor(0, 0, 0, 0)

local energyBar = CreateFrame("StatusBar", "energyBar", energyBarBg)
energyBar:SetStatusBarTexture(cfg.texture)
energyBar:SetPoint("TOPLEFT", energyBarBg, "TOPLEFT", 1, -1)
energyBar:SetPoint("BOTTOMRIGHT", energyBarBg, "BOTTOMRIGHT", -1, 1)

energyBar.SetValue_ = energyBar.SetValue
energyBar.SetValue = function(self, value)
  if value ~= self:GetValue() or value == 0 then
    smoothing[self] = value
	else
    smoothing[self] = nil
	end
end

local energyBarText = energyBar:CreateFontString(nil, "OVERLAY")
energyBarText:SetFont(cfg.text.font, cfg.text.size, "THINOUTLINE")
energyBarText:SetPoint(cfg.text.pos.a1, cfg.text.pos.af, cfg.text.pos.a2, cfg.text.pos.x, cfg.text.pos.y)
energyBarText:SetJustifyH("RIGHT")

local abs, max, min = math.abs, math.max, math.min
energyBar:SetScript("OnUpdate", function(self, elapsed)
  local maxPower = UnitPowerMax("player", UnitPowerType("player"))

  -- hack to fix vengeance dh pain
  if maxPower == 1000 then
    maxPower = maxPower / 10
  end

  -- hack to fix shadow priest insanity
  if maxPower == 10000 then
    maxPower = maxPower / 100
  end

  self:SetMinMaxValues(0, maxPower)
  self:SetValue(UnitPower("player"))

  local limit = 30 / GetFramerate()

  for bar, value in pairs(smoothing) do
    local cur = bar:GetValue()
    local barmin, barmax = bar:GetMinMaxValues()
    local new = cur + min((value-cur)/10, max(value-cur, limit))

    if new ~= new then new = value end

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
energyBar:RegisterEvent("UNIT_POWER")
energyBar:RegisterEvent("UNIT_POWER_FREQUENT")
energyBar:SetScript("OnEvent", function(self, event, ...)
  local powerColor = powerColors[UnitPowerType("player")]
  energyBar:SetStatusBarColor(unpack(powerColor))
  energyBarText:SetText(UnitPower("player"))
end)
