-- Partial Code by Murtaza

-- Serverside

------ CONFIG ------

local everyoneAllowed = true -- If true, everyone is allowed and you do not need to add steam/ip identifiers. If false, you need to add steam/ip identifiers so they can use the command.

local allowed =  
{
	"steam:000000000000000", -- Enter your steam ids and ips as such. DO NOT forget the commas and do not add a comma at the end.
	"steam:000000000000001",
	"ip:192.168.1.1",
	"ip:192.168.1.2",
	"steam:000000000000003"
}

------ CODE DO NOT TOUCH UNLESS YOU KNOW WHAT YOU ARE DOING :) ------

AddEventHandler('chatMessage', function(source, n, msg)
	local msg = string.lower(msg)
	local identifier = GetPlayerIdentifiers(source)[1]
	
	if msg == '/bag' then
		CancelEvent()
		
		if everyoneAllowed then
			TriggerClientEvent('bomb:bag', source)
		else
			if checkAllowed(identifier) then
				TriggerClientEvent('bomb:bag', source)
			else
				TriggerClientEvent('bomb:insuffPerms', source)	
			end
		end
		
	end
end)

function checkAllowed(id)
	for k, v in pairs(allowed) do
		if id == v then
			return true
		end
	end
	
	return false
end