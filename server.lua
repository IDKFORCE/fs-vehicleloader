local VehTable = {}
AlreadyGotAllVeh = false

RegisterServerEvent('fs-vehicleloader:GetVehicles')
AddEventHandler('fs-vehicleloader:GetVehicles', function()

	if not AlreadyGotAllVeh and (string.len(Config.VehicleFolderPack) >= 1) then
		VehicleFolder = string.gsub(Config.VehicleFolderPack, "%[", "%%["):gsub("%]", "%%]")

		local Resources = GetNumResources()

		for i=0, Resources, 1 do
			local resource = GetResourceByFindIndex(i)
			if resource then
				local resourcePath = GetResourcePath(resource)
				if string.find(resourcePath, VehicleFolder) then
					table.insert(VehTable, resource)
				end
			end
		end

	end

	AlreadyGotAllVeh = true
	if next(VehTable) then
		for i, v in pairs(VehTable) do
			TriggerClientEvent('fs-vehicleloader:VehicleIntoTable', source, v)
		end
	end
    
    TriggerClientEvent('fs-vehicleloader:LoadVehicles', source)

end)



