local VodkaFlyers = {}
local VodkaFlyersText = {}
local VodkaFlyers_DEBUGING = false;

function VodkaFlyers_Debug_Feedback(msg)
	if ( VodkaFlyers_DEBUGING) then
		DEFAULT_CHAT_FRAME:AddMessage("VodkaFlyers:"..msg);
	end
end


function VodkaFlyers:Initialise()
	local mainFrame = CreateFrame("Frame", "VodkaFlyersFrame", UIParent)
	local textFrame = CreateFrame("Frame", "VodkaFlyersTextFrame", UIParent)
	
	VodkaFlyers_Debug_Feedback("start")
	
	mainFrame:SetScript("OnUpdate", function() if ( IsFlying() or (IsSwimming() and IsMounted()) ) then VodkaFlyersTextFrame:Show() else VodkaFlyersTextFrame:Hide() end end)
	mainFrame:SetFrameLevel(0)
	textFrame:SetScript("OnUpdate", function(self, elapsed) VodkaFlyersTextFrameText:SetText(format("%.1f", VehicleAimGetAngle() * 360 / (2 * math.pi))) end)
	textFrame:SetWidth(50)
	textFrame:SetHeight(50)
	textFrame:SetPoint("CENTER", UIParent, "CENTER")
	textFrame:SetFrameLevel(5)
	textFrameText = textFrame:CreateFontString("VodkaFlyersTextFrameText", "OVERLAY", "GameFontNormalSmall")
	textFrameText:SetWidth(50)
	textFrameText:SetHeight(10)
	textFrameText:SetPoint("CENTER", textFrame, "CENTER")
	
	
	textFrame:SetMovable(true)
	textFrame:EnableMouse(true)
	textFrame:SetScript("OnMouseDown", function(self, button) if button == "LeftButton" and IsAltKeyDown() and not self.isMoving then self:StartMoving(); self.isMoving = true; end end)
	textFrame:SetScript("OnMouseUp", function(self, button) if button == "LeftButton" and self.isMoving then self:StopMovingOrSizing(); self.isMoving = false; end end)
	textFrame:SetScript("OnHide", function(self) if ( self.isMoving ) then self:StopMovingOrSizing(); self.isMoving = false; end end) end

VodkaFlyers.Initialise()
