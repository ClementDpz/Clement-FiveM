QBCore = exports['qb-core']:GetCoreObject()
allBlips = {}

Citizen.CreateThread(function()
    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(200)
    end

    TriggerEvent("LIL-BLIPS:RefreshMarkers")
    TriggerEvent("LIL-BLIPS:RefreshBlips")
end)

RegisterNetEvent("LIL-BLIPS:RefreshMarkers")
AddEventHandler("LIL-BLIPS:RefreshMarkers", function ()
    for k in pairs(Config.Blips) do
        local markerInfos
        local infos = Config.Blips[k]

        for k in pairs (infos) do
            if k == "markerInfo" then
                markerInfos = infos.markerInfo
            end
        end

        if markerInfos then
            local condition
            Citizen.CreateThread(function() 
                while true do
                    condition = true
                    if markerInfos.jobCondition then
                        condition = false
                        for k, v in pairs(markerInfos.jobCondition) do
                            if QBCore.Functions.GetPlayerData().job.name == v then condition = true end
                        end
                    end

                    if markerInfos.gangCondition and condition then
                        condition = false
                        for k, v in pairs(markerInfos.gangCondition) do
                            if QBCore.Functions.GetPlayerData().gang.name == v then condition = true end
                        end
                    end

                    if condition then
                        local interval  = 1
                        local playerPos = GetEntityCoords(PlayerPedId())
                        local markerPos = vector3( infos.x, infos.y, infos.z )
                        local distance  = GetDistanceBetweenCoords(playerPos, markerPos, true)

                        if distance > 30 then
                            interval = 1000
                        else
                            interval = 1
                            DrawMarker(markerInfos.id, infos.x, infos.y, infos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, markerInfos.red, markerInfos.green, markerInfos.blue, markerInfos.alpha, 0, 1, 2, 0, nil, nil, 0)

                            if distance < 1 then
                                AddTextEntry("HELP", markerInfos.message)
                                DisplayHelpTextThisFrame("HELP", false)
                                if IsControlJustPressed(1, 51) then
                                    local f = assert(load( markerInfos.action ))
                                    f()
                                end
                            end
                        end

                        Citizen.Wait(interval)
                    else
                        Citizen.Wait(1000)
                    end
                end
            end)
        end
    end
end)

RegisterNetEvent("LIL-BLIPS:RefreshBlips")
AddEventHandler("LIL-BLIPS:RefreshBlips", function ()

    for k,v in pairs(allBlips) do
        RemoveBlip(v)
    end

    for k in pairs(Config.Blips) do
        local blipInfos

        local infos = Config.Blips[k]

        for k in pairs (infos) do
            if k == "blipInfo" then
                blipInfos = infos.blipInfo
            end
        end

        while QBCore.Functions.GetPlayerData().job == nil do
            Citizen.Wait(200)
        end

        local jobName = QBCore.Functions.GetPlayerData().job.name

        if blipInfos then
            local conditon

            condition = true
            if blipInfos.jobCondition then
                condition = false
                for k, v in pairs(blipInfos.jobCondition) do
                    if QBCore.Functions.GetPlayerData().job.name == v then condition = true end
                end
            end

            if blipInfos.gangCondition and condition then
                condition = false
                for k, v in pairs(blipInfos.gangCondition) do
                    if QBCore.Functions.GetPlayerData().gang.name == v then condition = true end
                end
            end

            if condition then
                local blip = AddBlipForCoord( infos.x , infos.y ,  infos.z )
                table.insert(allBlips, blip)
                SetBlipSprite(blip, blipInfos.id)
                SetBlipDisplay(blip, 4)
                SetBlipScale(blip, blipInfos.scale)
                SetBlipAsShortRange(blip, true)
                SetBlipColour(blip, blipInfos.color)
                SetBlipAlpha(blip, 255)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentSubstringPlayerName( blipInfos.title )
                EndTextCommandSetBlipName(blip)
            end
        end
    end
end)