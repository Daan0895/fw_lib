RegisterNetEvent("fw:add:temp:vehicle")
AddEventHandler("fw:add:temp:vehicle", function(model, plate)
    local license = false
    if not plate then plate = false end
    for k,v in pairs(GetPlayerIdentifiers(source))do 
        if string.sub(v, 1, string.len("license:")) == "license:" then
            license = string.gsub(v, 'license:', '')
            license = "char1:" .. license
        end
    end
    if not license then
        print("[ERROR] License not found when adding temporary vehicle")
    end
    if not plate then
        print("[ERROR] Plate not found when adding temporary vehicle")
    end
    if license ~= false then
		MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type) VALUES (?, ?, ?, ?)', {license, plate, json.encode({plate = plate, model = joaat(model)}), "temp"}, function(data) end)
    end
end)

Citizen.CreateThread(function()
    MySQL.update('DELETE FROM owned_vehicles WHERE type = "temp"')
end)
