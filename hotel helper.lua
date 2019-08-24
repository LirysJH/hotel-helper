script_name("Hotel Helper")
script_author("James Hawk")
script_version("002")

local sampev = require "lib.samp.events"
local state = true
local anim_off = true

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
	wait(-1)
end

function sampev.onShowDialog(id, style, title, button1, button2, text)
	lua_thread.create(function()
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
		if id == 1366 and state then
			sampSendDialogResponse(id, 1, 3, -1)
			wait(20)
			sampCloseCurrentDialogWithButton(0)
			wait(200)
			if anim_off then
				clearCharTasksImmediately(PLAYER_PED)
			end
			wait(1000)
			anim_off = true
		end
	end)
end

function sampev.onServerMessage(color,text)
	if text:find("Вы не голодны") and state then
		anim_off = false
	end
end
