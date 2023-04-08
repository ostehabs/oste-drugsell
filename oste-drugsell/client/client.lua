local QBCore = exports['qb-core']:GetCoreObject() 
local DeliveryPed = nil
local Ongoing = true


--- Weed Delivery
RegisterNetEvent('oste-drugsell:client:weed:delivery', function ()
    local hasItem = QBCore.Functions.HasItem("packagedweed", Config.Weedamount)
    if hasItem then
        if Ongoing then
            TriggerEvent('animations:client:EmoteCommandStart', {"wait"})
            QBCore.Functions.Progressbar("weed_delivery", Lang:t('weed.wait_weed_start'), 4500, false, true, {
                disableMovement = true,
                disableCarMovement = true,
                disableMouse = false,
                disableCombat = true,
                    }, {
                    }, {}, {}, function() -- Done
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    TriggerServerEvent('oste-drugsell:server:weed:remove')
                end, function() -- Cancel
                    TriggerEvent('animations:client:EmoteCommandStart', {"c"})
                    QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
                end)
            else
                QBCore.Functions.Notify(Lang:t("weed.ongoing"), 'error')
        end
    else
        QBCore.Functions.Notify(Lang:t("weed.enough_weed"), 'error')
    end
end)

RegisterNetEvent('oste-drugsell:client:weed:delivery:start', function ()
    TriggerEvent('qb-phone:client:CustomNotification', (Lang:t("weed.quick_got_the_route")), (Lang:t("weed.got_the_route")), 'fas fa-cannabis', '#71cb71', 5500)
    Ongoing = false
    CreateDeliveryPed()
end)



function CreateDeliveryPed()
    QBCore.Functions.LoadModel(Config.DeliveryPed)
    DeliveryPedLocations = Config.DeliveryPedLocations[math.random(#Config.DeliveryPedLocations)]

    DeliveryPed = CreatePed(0,Config.DeliveryPed, DeliveryPedLocations.x, DeliveryPedLocations.y, DeliveryPedLocations.z, DeliveryPedLocations.w, true, true)
    if DoesEntityExist(DeliveryPed) then
        CollectPointBlip = AddBlipForEntity(DeliveryPed)
        SetBlipSprite(CollectPointBlip, 469)
        SetBlipScale(CollectPointBlip, 0.75)
        SetBlipColour(CollectPointBlip, 11)
        SetBlipRoute(CollectPointBlip, true)
        SetBlipRouteColour(CollectPointBlip, 11)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Opsamlings Punkt")
        EndTextCommandSetBlipName(CollectPointBlip)
        SetEntityAsMissionEntity(DeliveryPed)

        CreateThread( function ()
            exports['qb-target']:AddTargetEntity(DeliveryPed, {
                options = {
                    {
                        invincible = true,
                        blockevents = true,
                        minusOne = true,
                        freeze = true,
                        icon = 'fas fa-handshake',
                        label = 'Collect Money',
                        canInteract = function(entity)
                            return entity == DeliveryPed
                        end,
                        action = function()
                            CollectMoney()
                        end,
                    }
                },
                distance = 2.0
            })
        end)
    end
end




function CollectMoney()
TriggerEvent('animations:client:EmoteCommandStart', {"think5"})
QBCore.Functions.Progressbar("weed_delivery", Lang:t('weed.wait_weed_collect_money'), 3000, false, true, {
    disableMovement = true,
    disableCarMovement = true,
    disableMouse = false,
    disableCombat = true,
        }, {
        }, {}, {}, function() -- Done
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        TriggerServerEvent('oste-drugsell:server:weed:collect')
    end, function() -- Cancel
        TriggerEvent('animations:client:EmoteCommandStart', {"c"})
        QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
    end)
end


RegisterNetEvent('oste-drugsell:client:remove:Blip', function ()
    RemoveCollectPointBlip()
    exports['ps-dispatch']:SuspiciousActivity()
    exports['qb-target']:RemoveTargetEntity(DeliveryPed, 'Modtag betaling')
    Ongoing = true
end)


function RemoveCollectPointBlip()
    if DoesBlipExist(CollectPointBlip) then
        RemoveBlip(CollectPointBlip)
        if DoesEntityExist(DeliveryPed) then
            Wait(Config.PedTime)
            DeleteEntity(DeliveryPed)
        end
    end
end


RegisterNetEvent('oste-drugsell:client:continueselling', function()
	local success = exports['qb-phone']:PhoneNotification((Lang:t("weed.quick_continue")), (Lang:t("weed.continue")), 'fas fa-cannabis', '#71cb71', "NONE", 'fas fa-check-circle', 'fas fa-times-circle')
    local hasItem = QBCore.Functions.HasItem("packagedweed", Config.Weedamount)

    if success then
        if hasItem then
            TriggerEvent('qb-phone:client:CustomNotification', (Lang:t("weed.quick_deliver_again")), (Lang:t("weed.deliver_again")), 'fas fa-cannabis', '#71cb71', 5500)
            CreatePickUpPed()
        else
            QBCore.Functions.Notify(Lang:t("weed.enough_weed"), 'error')
        end
    else
        TriggerEvent('qb-phone:client:CustomNotification', (Lang:t("weed.quick_stop_sell")), (Lang:t("weed.stop_sell")), 'fas fa-cannabis', '#71cb71', 5500)
        TriggerEvent('animations:client:EmoteCommandStart', {"wait"})
    end
end)


function CreatePickUpPed()
    QBCore.Functions.LoadModel(Config.DeliveryPed)
    PickUpPedLocations = Config.DeliveryPedLocations[math.random(#Config.DeliveryPedLocations)]

    PickUpPed = CreatePed(0,Config.DeliveryPed, PickUpPedLocations.x, PickUpPedLocations.y, PickUpPedLocations.z, PickUpPedLocations.w, true, true)
    if DoesEntityExist(PickUpPed) then
        PickupBlip = AddBlipForEntity(PickUpPed)
        SetBlipSprite(PickupBlip, 469)
        SetBlipScale(PickupBlip, 0.75)
        SetBlipColour(PickupBlip, 11)
        SetBlipRoute(PickupBlip, true)
        SetBlipRouteColour(PickupBlip, 11)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Afleverings Punkt")
        EndTextCommandSetBlipName(PickupBlip)
        SetEntityAsMissionEntity(PickUpPed)

        CreateThread( function ()
            exports['qb-target']:AddTargetEntity(PickUpPed, {
                options = {
                    {
                        invincible = true,
                        blockevents = true,
                        minusOne = true,
                        freeze = true,
                        icon = 'fas fa-handshake',
                        label = 'Deliver product',
                        canInteract = function(entity)
                            return entity == PickUpPed
                        end,
                        action = function()
                            local hasItem = QBCore.Functions.HasItem("packagedweed", Config.Weedamount)
                            if hasItem then
                                GiveProduct()
                            else
                                QBCore.Functions.Notify(Lang:t("weed.enough_weed"), 'error')
                            end
                        end,
                    }
                },
                distance = 2.0
            })
        end)
    end
end

function GiveProduct()
    TriggerEvent('animations:client:EmoteCommandStart', {"think3"})
    QBCore.Functions.Progressbar("weed_delivery", Lang:t('weed.wait_weed_give_product'), 3000, false, true, {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
            }, {
            }, {}, {}, function() -- Done
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            TriggerServerEvent('oste-drugsell:server:weed:remove:continueselling')
        end, function() -- Cancel
            TriggerEvent('animations:client:EmoteCommandStart', {"c"})
            QBCore.Functions.Notify(Lang:t("error.canceled"), 'error')
        end)
    end


RegisterNetEvent('oste-drugsell:client:remove:Blip:continueselling', function ()
    RemovePickupBlip()
    exports['ps-dispatch']:SuspiciousActivity()
    exports['qb-target']:RemoveTargetEntity(PickUpPed, 'Aflever produkt')
    Ongoing = true
    CreateDeliveryPed()
end)


function RemovePickupBlip()
    if DoesBlipExist(PickupBlip) then
        RemoveBlip(PickupBlip)
        if DoesEntityExist(PickUpPed) then
            Wait(Config.PedTime)
            DeleteEntity(PickUpPed)
        end
    end
end