-- Created By Panda
-- Clientside

RegisterNetEvent('bomb:bag')
RegisterNetEvent('bomb:insuffPerms')

AddEventHandler('bomb:insuffPerms', function()
	notification('~r~You have insufficient permissions to place this object!')
end)

AddEventHandler('bomb:bag', function()
	local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	local heading = GetEntityHeading(GetPlayerPed(-1))
	
	RequestModel('prop_big_bag_01')
	
	while not HasModelLoaded('prop_big_bag_01') do
		Citizen.Wait(1)
	end
	
	local cone = CreateObject('prop_big_bag_01', x, y, z-2, true, true, true)
	PlaceObjectOnGroundProperly(cone)
	SetEntityHeading(cone, heading)
	notification('~g~The bag has been placed!')

	Citizen.CreateThread(function()
	
		while true do
		  if IsControlPressed(1, 184) then -- E
			exports["memorygame"]:thermiteminigame(10, 3, 3, 10,
			function() -- success
				print("Success")
				DeleteObject(cone)
			end,
			function() -- failure
				print("failure")
				TriggerServerEvent('InteractSound_SV:PlayWithinDistance', 0.5, 'bomb', 1.0)
				AddExplosion(x,y,z,10,50.0, true, false, false)
				DeleteObject(cone)
			end)
		  end
		  Citizen.Wait(0)
		end
	  end)
end)


function notification(msg)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(msg)
	DrawNotification(false, false)
end


