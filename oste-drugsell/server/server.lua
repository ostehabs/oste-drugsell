local QBCore = exports['qb-core']:GetCoreObject() 




RegisterServerEvent('oste-drugsell:server:weed:remove', function ()
    local src = source
	local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= Config.StartCost then
        Player.Functions.RemoveMoney('cash', Config.StartCost)

        Player.Functions.RemoveItem("packagedweed", Config.Weedamount)
        TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["packagedweed"], "remove")
        TriggerClientEvent('oste-drugsell:client:weed:delivery:start', src)
    else
        TriggerClientEvent('QBCore:Notify', src, Lang:t('weed.need_money'), "error")
    end
end)


RegisterServerEvent('oste-drugsell:server:weed:remove:continueselling', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.RemoveItem("packagedweed", Config.Weedamount)
    TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["packagedweed"], "remove")
    TriggerClientEvent('oste-drugsell:client:remove:Blip:continueselling', src)
end)




RegisterServerEvent('oste-drugsell:server:weed:collect', function ()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.AddMoney('cash', Config.Payout)
    TriggerClientEvent('oste-drugsell:client:remove:Blip', src)
    TriggerClientEvent('oste-drugsell:client:continueselling', src)
end)



RegisterNetEvent('oste-drugsell:Server:RemoveItem', function(item, amount)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem(item, amount)
end)


