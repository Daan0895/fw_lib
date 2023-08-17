local menu = false
local belt = false

Citizen.CreateThread(function()
    if Config.carhud.enable then
        while true do
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local pedVehicle = GetVehiclePedIsIn(ped, false)
                local vehicleSpeed = "invalid"
                if Config.carhud.unit == "kph" then
                    vehicleSpeed = math.ceil(GetEntitySpeed(pedVehicle) * 3.6)
                elseif Config.carhud.unit == "mph" then
                    vehicleSpeed = math.ceil(GetEntitySpeed(pedVehicle) * 2.236936)
                end
                if vehicleSpeed <= 2 then vehicleSpeed = 0 end
                if vehicleSpeed ~= "invalid" then
                    SendNUIMessage({
                        showhud = true,
                        speed = vehicleSpeed,
                        unit = Config.carhud.unit,
                        belt = belt,
                        beltEnabled = Config.carhud.seatbelt
                    })
                    menu = true
                end
            else
                if menu then
                    SendNUIMessage({
                        showhud = false,
                        speed = "invalid",
                        Config.carhud.unit,
                        belt = belt,
                        beltEnabled = Config.carhud.seatbelt
                    })
                    menu = false
                    belt = false
                end
            end
            Citizen.Wait(Config.carhud.delay)
        end
    end
end)

Citizen.CreateThread(function()
    if Config.carhud.seatbelt then
        while true do
            if IsControlJustPressed(0, Config.carhud.seatbeltKey) then belt = not belt end
            if belt then DisableControlAction(27, 75, true) DisableControlAction(0, 75, true) end
            Citizen.Wait(0)
        end
    end
end)
