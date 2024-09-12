local frame_name = 'ResetYourMap'
local opt = CreateFrame('FRAME',frame_name,InterfaceOptionsFramePanelContainer)
opt = ResetYourMap
opt.Initialized = false
opt.name = 'Reset Your Map'
opt.ShouldResetFrames = false
opt.UpdateInterval = 1.0
opt.TimeSinceLastUpdate = 0

local function ResetMap()

    BattlefieldMapTab:SetPoint('CENTER', UIParent, 'CENTER', 0, 0)
    BattlefieldMapTab:SetAlpha(1)
    BattlefieldMapFrame:SetAlpha(1)

    BattlefieldMapOptions.locked = false
    BattlefieldMapOptions.opacity = 0
    BattlefieldMapOptions.showPlayers = false
    BattlefieldMapOptions.position.x = 0
    BattlefieldMapOptions.position.y = 0

    BattlefieldMapOptions.opacity = 0;
	BattlefieldMapFrame:RefreshAlpha();
end

local function PrintInfo()

    print('-------------------')
    print('BattlefieldMapFrame')
    if BattlefieldMapFrame:IsShown() then
        print('Map Showing: True')
    else
        print('Map Showing: False')
    end

    local point, relativeTo, relativePoint, xOfs, yOfs = BattlefieldMapFrame:GetPoint(1)
    local alpha = BattlefieldMapFrame:GetAlpha()
    print('Point: ' .. point)
    if relativeTo then
        print('relativeTo: ' .. relativeTo:GetName())
    end
    print('relativePoint: ' .. relativePoint)
    print('xOfs: ' .. xOfs)
    print('yOfs: ' .. yOfs)
    print('alpha:' .. alpha)

    print('')
    print('-------------------')
    print('BattlefieldMapTab')
    if BattlefieldMapTab:IsShown() then
        print('Map Tab Showing: True')
    else
        print('Map Tab: False')
    end

    point, relativeTo, relativePoint, xOfs, yOfs = BattlefieldMapTab:GetPoint(1)
    alpha = BattlefieldMapTab:GetAlpha()
    print('Point: ' .. point)
    if relativeTo then
    print('relativeTo: ' .. relativeTo:GetName())
    end
    print('relativePoint: ' .. relativePoint)
    print('xOfs: ' .. xOfs)
    print('yOfs: ' .. yOfs)
    print('alpha:' .. alpha)

    print('')
    print('-------------------')
    print('BattlefieldMapOptions')
    DevTools_Dump(BattlefieldMapOptions)
end

function ShowMap()
    BattlefieldMapTab:Show()
    BattlefieldMapFrame:Show()
end

function HideMap()
    BattlefieldMapTab:Show()
    BattlefieldMapFrame:Show()
end

SLASH_Map1 = '/map';
function SlashCmdList.Map(msg, editbox)

	local args = {}
	for word in msg:gmatch("%S+") do
		table.insert(args, word)
	end

	if args == nil then
		return
	end

	local count = #args

	-- 1 param actions
	if (count == 1) then
		if (args[1] == "reset") then
			ResetMap()
			return
		elseif (args[1] == "info") then
			PrintInfo()
			return
        elseif (args[1] == "show") then
			ShowMap()
			return
        elseif (args[1] == "hide") then
			HideMap()
			return
		end
	-- 2 param actions
	elseif (count == 2) then
	end
end

local function OnLogin()
    opt.env = FixYourMapSettings
end

local function OnLogout()
    FixYourMapSettings = opt.env
end

opt:RegisterEvent("PLAYER_LOGIN")
opt:RegisterEvent("PLAYER_LOGOUT")

local function ResetMap_EventHandler(self, event, ...)
    if event == "PLAYER_LOGIN" then
        OnLogin()
    elseif event == "PLAYER_LOGOUT" then
        OnLogout()
    end
end

opt:SetScript("OnEvent", ResetMap_EventHandler)