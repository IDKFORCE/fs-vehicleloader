local Vehicles = {}

CreateThread(function()
	TriggerServerEvent('fs-vehicleloader:GetVehicles')
end)

RegisterNetEvent('fs-vehicleloader:VehicleIntoTable')
AddEventHandler('fs-vehicleloader:VehicleIntoTable', function(name)
	table.insert(Vehicles, name)
end)

RegisterNetEvent('fs-vehicleloader:LoadVehicles')
AddEventHandler('fs-vehicleloader:LoadVehicles', function()
    
    for i, v in pairs(Config.ExtraVehicles) do
        TriggerEvent('fs-vehicleloader:VehicleIntoTable', v)
	end

	if Config.GivingInformation then
		print("Loading Vehicles...\n")
	end
	for i, vehicle in ipairs(Vehicles) do
		if not IsModelInCdimage(vehicle) or not IsModelAVehicle(vehicle) then
			if Config.GivingInformation then
				print(vehicle .. " has Not Been Found (Model Name Isn't The Same As The Folder Name Or Mispelled In \"Config.ExtraVehicles\").")
			end
		else
			RequestModel(vehicle)
			
			repeat
				if Config.GivingInformation then
					print("Loading " .. vehicle.."...")
				end
				Wait(500)
			until HasModelLoaded(vehicle)

			if HasModelLoaded(vehicle) then
				if Config.GivingInformation then
					print(vehicle .. " is loaded.\n")
				end
			end
			SetModelAsNoLongerNeeded(vehicle)
		end
	end
	if Config.GivingInformation then
		print("Everything In \"Config.VehicleFolderPack \" Aad \"Config.ExtraVehicles\" Has Been Loaded!")
	end

end)
