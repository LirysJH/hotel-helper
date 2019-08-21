script_name("Hotel Helper")
script_author("James Hawk")
script_version("001")

local state = true

local data = {
	av_price = 0,
	time = 0,
	sum = 0,
	id = 343
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
