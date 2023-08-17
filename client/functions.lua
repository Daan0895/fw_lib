function FW.createTemporaryVehicle(vehicle, plate)
    TriggerServerEvent("fw:add:temp:vehicle", vehicle, plate)
end

function FW.notification(text, type, duration)
    SendNUIMessage({action = 'open', text = text, type = type, duration = duration})
end

function FW.createBlip(x, y, z, name, sprite, colour, display, scale, route)
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
end

local peds = {}

function FW.createPed(x, y, z, heading, ped, animDict, animName)
    RequestModel(ped)
    while not HasModelLoaded(ped) do
        Wait(0)
    end
    local createdPed = CreatePed(0, ped, x, y, z - 1, heading, true, false)
    table.insert(peds, createdPed)
    FreezeEntityPosition(createdPed, true)
    SetEntityInvincible(createdPed, true)
    PlaceObjectOnGroundProperly(createdPed)
    SetBlockingOfNonTemporaryEvents(createdPed, true)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Wait(0)
    end
    TaskPlayAnim(createdPed, animDict, animName, 8.0, 0.0, -1, 1, 0, 0, 0, 0)
end

function FW.createEffect(x, y, z, effectDict, effectName, scale)
    if not effectDict then effectDict = "scr_paintnspray" end
    if not effectName then effectName = "scr_respray_smoke" end
    if not scale then scale = 1.0 end
    RequestNamedPtfxAsset(effectDict)
    while not HasNamedPtfxAssetLoaded(effectDict) do
        Citizen.Wait(1)
    end
    UseParticleFxAssetNextCall(effectDict)
    local effect = StartParticleFxNonLoopedAtCoord(effectName, x, y, z, 0.0, 0.0, 0.0, scale, false, false, false, false)
end

function FW.createVehicle(x, y, z, heading, vehicleName, makeTemporary, cb)
    if not vehicleName then vehicleName = "adder" end
    RequestModel(vehicleName)
    while not HasModelLoaded(vehicleName) do
        Wait(0)
    end
    local vehicle = CreateVehicle(vehicleName, x, y, z, heading, false, false)
    SetVehicleHasBeenOwnedByPlayer(vehicle, true)
    SetVehicleNeedsToBeHotwired(vehicle, false)
    SetVehRadioStation(vehicle, "OFF")
    SetModelAsNoLongerNeeded(vehicleName)
    if makeTemporary then
        FW.createTemporaryVehicle(vehicle, GetVehicleNumberPlateText(vehicle))
    end
    if cb then
        cb(vehicle)
    end
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() == resourceName) then
        for k,v in pairs(peds) do
            DeletePed(v)
        end
    end
end)
