script_name("Hotel Helper")
script_author("James Hawk")
script_version("001")

require "lib.moonloader"
require "sampfuncs"
local sampev = require "lib.samp.events"
local state = true
local state_l = false

local data = {
	av_price = 0,
	time = 0,
	sum = 0
}

function main()
	if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampRegisterChatCommand("/hh", function()
		state = not state
		if state then
			sampAddChatMessage(string.format("[%s]: on",thisScript().name), 0x00CC00)
		else
			sampAddChatMessage(string.format("[%s]: off",thisScript().name), 0xFF0000)
		end
	end)
	-- sampRegisterChatCommand("/hhl", function()
		-- state_l = not state_l
		-- if state_l then
			-- sampAddChatMessage(string.format("[%s]: Line on",thisScript().name), 0x00CC00)
		-- else
			-- sampAddChatMessage(string.format("[%s]: Line off",thisScript().name), 0xFF0000)
		-- end
	-- end)	
	
	while true do
		wait(0)
		
		local _, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		nick = sampGetPlayerNickname(myid)
	end
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
	lua_thread.create(function() -- prev id 342
		if id == 343 and state then
			sampSendDialogResponse(id, 1, 1, -1)
			wait(50)
			data.av_price, data.time = string.match(text,'[^%d+]+(%d+)[^%d+]+[%d+]+[^%d+]+[%d+]+[^%d+]+(%d+)[^%d+]')
			data.time = 100 - tonumber(data.time)
			data.sum = data.time*tonumber(data.av_price)
			if data.sum > 0 then
				sampSendDialogResponse(id, 1, -1, data.sum)
			end
			wait(20)
			sampCloseCurrentDialogWithButton(0)
		end
	end)
end
