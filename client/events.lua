RegisterNetEvent("fw:createblip")
AddEventHandler("fw:createblip", function(x, y, z, name, sprite, colour, display, scale, route)
    blipName = tostring(name)
    local blipName = AddBlipForCoord(x, y, z)
    SetBlipSprite (blipName, sprite)
    SetBlipColour(blipName, colour)
    SetBlipDisplay(blipName, display)
    SetBlipScale  (blipName, scale)
    SetBlipAsShortRange(blipName, true)
    SetBlipRoute(blipName, route)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blipName)
end)

RegisterNetEvent("fw:notification")
AddEventHandler("fw:notification", function(text, type, duration)
    SendNUIMessage({action = 'open', text = text, type = type, duration = duration})
end)
