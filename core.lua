local A, L = ...
local abs, max, min = math.abs, math.max, math.min

local backdrop_tab = {
  bgFile = "Interface\\ChatFrame\\ChatFrameBackground",
  edgeFile = "Interface\\ChatFrame\\ChatFrameBackground",
  tile = false,
  tileSize = 0,
  edgeSize = 1,
  insets = { left = 0, right = 0, top = 0, bottom = 0 },
}

local smoothing = {}

local energyBarBg = CreateFrame("Frame", "Riphie_Energy", UIParent, "BackdropTemplate")
PixelUtil.SetHeight(energyBarBg, L.cfg.height, 0)
PixelUtil.SetWidth(energyBarBg, L.cfg.width, 0)
PixelUtil.SetPoint(energyBarBg, L.cfg.pos.a1, L.cfg.pos.af, L.cfg.pos.a2, L.cfg.pos.x, L.cfg.pos.y, 0, 0)
energyBarBg:SetBackdrop(backdrop_tab)
energyBarBg:SetBackdropColor(unpack(L.cfg.colors.bg))
energyBarBg:SetBackdropBorderColor(0, 0, 0, 1)

local energyBar = CreateFrame("StatusBar", "energyBar", energyBarBg)
energyBar:SetStatusBarTexture(L.cfg.texture)
PixelUtil.SetPoint(energyBar, "TOPLEFT", energyBarBg, "TOPLEFT", 1, -1, 0, 0)
PixelUtil.SetPoint(energyBar, "BOTTOMRIGHT", energyBarBg, "BOTTOMRIGHT", -1, 1, 0, 0)

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
  0,
  0
)
energyBarText:SetJustifyH "CENTER"

if not L.cfg.text.enable then
  energyBarText:Hide()
end

energyBar:SetScript("OnUpdate", function(self)
  local _, class = UnitClass "player"
  local _, powerType = UnitPowerType "player"
  local maxPower = UnitPowerMax("player", UnitPowerType "player")

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
  self:SetValue(UnitPower "player")

  local limit = 30 / GetFramerate()

  for bar, value in pairs(smoothing) do
    local cur = bar:GetValue()
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

energyBar:RegisterEvent "PLAYER_ENTERING_WORLD"
energyBar:RegisterEvent "PLAYER_SPECIALIZATION_CHANGED"
energyBar:RegisterEvent "UNIT_AURA"
energyBar:RegisterEvent "UNIT_POWER_FREQUENT"
energyBar:RegisterEvent "TRAIT_CONFIG_UPDATED"
energyBar:SetScript("OnEvent", function()
  local powerColor = L.cfg.colors[UnitPowerType "player"]
  energyBar:SetStatusBarColor(unpack(powerColor))
  energyBarText:SetText(UnitPower "player")
end)
