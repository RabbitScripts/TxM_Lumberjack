local QBCore = exports['qb-core']:GetCoreObject()
local playerLogSales = {}

local function notifyPlayer(source, message, type)
    if Config.notification == "qbcore" then
        TriggerClientEvent('QBCore:Notify', source, message, type)
    elseif Config.notification == "ox" then
        TriggerClientEvent('ox_lib:notify', source, { type = type, description = message })
    end
end


RegisterServerEvent('txm-lumberjack:server:choptree', function()
    local source = source
    -- Because you are going to be able to carry till your inventory is full (Don't ask why because Im stupid alright)
    if exports.ox_inventory:CanCarryItem(source, 'tr_choppedlog', 1) then
        if exports.ox_inventory:AddItem(source, 'tr_choppedlog', 1) then
            notifyPlayer(source, Lang.chopAdded, 'success')
        end
    else
        notifyPlayer(source, Lang.carryingWeight, 'error')
    end
end)

RegisterServerEvent('txm-lumberjack:server:craftinginput', function(argsNumber, logAmount)
    local source = source
    local slot = tonumber(argsNumber)
    local itemCount = tonumber(logAmount)
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)

    local bench1 = vector3(Config.craftingBench.x, Config.craftingBench.y, Config.craftingBench.z)
    local bench2 = vector3(Config.craftingBench2.x, Config.craftingBench2.y, Config.craftingBench2.z)
    local playerCoords = GetEntityCoords(GetPlayerPed(source)) 
    
    local distanceToBench1 = #(playerCoords - bench1)
    local distanceToBench2 = #(playerCoords - bench2)
    
    if distanceToBench1 > 5.0 and distanceToBench2 > 5.0 then
        notifyPlayer(source, Lang.tooFarFromCraftingBench, 'error')
        return
    end
    

    if itemCount < 0 then
        if Config.debug then
            print("Invalid item count:", itemCount)
        end
        return
    end

    local itemToReceive
    local totalItems

    if slot == 1 then
        itemToReceive = 'tr_woodplank'
        totalItems = itemCount * Config.receive.tr_woodplank
    elseif slot == 2 then
        itemToReceive = 'tr_woodhandles'
        totalItems = itemCount * Config.receive.tr_woodhandles
    elseif slot == 3 then
        itemToReceive = 'tr_firewood'
        totalItems = itemCount * Config.receive.tr_firewood
    elseif slot == 4 then
        itemToReceive = 'tr_toyset'
        totalItems = itemCount * Config.receive.tr_toyset
    else
        if Config.debug then
            print("Invalid crafting type.")
        end
        return
    end

    if exports.ox_inventory:CanCarryItem(source, itemToReceive, totalItems) then
        if exports.ox_inventory:RemoveItem(source, 'tr_choppedlog', itemCount) then
            Wait(7)
            exports.ox_inventory:AddItem(source, itemToReceive, totalItems)
            notifyPlayer(source, string.format(Lang.craftedItems, totalItems, itemToReceive), 'success')
        else
            notifyPlayer(source, Lang.noItemsToCraft, 'error')
        end
    else
        notifyPlayer(source, Lang.carryingWeight, 'error')
    end

    if Config.debug then
        print(string.format("Player %d crafted %d %s.", source, totalItems, itemToReceive))
    end
end)

-- RegisterServerEvent('txm-lumberjack:server:craftinginput', function(logAmount)
--     local source = source
--     local itemCount = tonumber(logAmount)

--     if itemCount < 1 then
--         if Config.debug then
--             print("Invalid item count:", itemCount)
--         end
--         return
--     end

--     local baseItems = {
--         { name = 'tr_woodplank',   amount = Config.receive.tr_woodplank },
--         { name = 'tr_woodhandles', amount = Config.receive.tr_woodhandles },
--         { name = 'tr_firewood',    amount = Config.receive.tr_firewood },
--         { name = 'tr_toyset',      amount = Config.receive.tr_toyset },
--     }

--     local rareWoods = {
--         "txm_tramhuong",
--         "txm_hoangdan",
--         "txm_danhuong",
--         "txm_mun",
--         "txm_suado"
--     }

--     local woodScrap = "txm_woodscrap"

--     local selected = baseItems[math.random(#baseItems)]
--     local itemToReceive = selected.name
--     local totalItems = itemCount * selected.amount
--     local extraRewards = {}

--     if exports.ox_inventory:CanCarryItem(source, itemToReceive, totalItems) then
--         if exports.ox_inventory:RemoveItem(source, 'tr_choppedlog', itemCount) then
--             Wait(7)
--             exports.ox_inventory:AddItem(source, itemToReceive, totalItems)

--             -- Tự động thêm vụn gỗ theo số lượng log
--             exports.ox_inventory:AddItem(source, woodScrap, itemCount)
--             table.insert(extraRewards, {label = "Vụn gỗ", count = itemCount})

--             -- Cơ hội rơi gỗ quý (ví dụ 25% mỗi log)
--             for i = 1, itemCount do
--                 if math.random(100) <= 25 then
--                     local rare = rareWoods[math.random(#rareWoods)]
--                     exports.ox_inventory:AddItem(source, rare, 1)
--                     table.insert(extraRewards, {label = rare, count = 1})
--                 end
--             end

--             local rewardText = string.format(Lang.craftedItems, totalItems, itemToReceive)
--             if #extraRewards > 0 then
--                 for _, reward in ipairs(extraRewards) do
--                     rewardText = rewardText .. string.format("\n+ %dx %s", reward.count, reward.label)
--                 end
--             end

--             notifyPlayer(source, rewardText, 'success')
--         else
--             notifyPlayer(source, Lang.noItemsToCraft, 'error')
--         end
--     else
--         notifyPlayer(source, Lang.carryingWeight, 'error')
--     end

--     if Config.debug then
--         print(string.format("Player %d crafted %d %s.", source, totalItems, itemToReceive))
--     end
-- end)



RegisterServerEvent('txm-lumberjack:server:sellitem', function(args)
    local source = source
    local itemCount = tonumber(args.number)
    local itemType = args.itemType
    local playerPed = GetPlayerPed(source)
    local playerCoords = GetEntityCoords(playerPed)

    local sellingLocation = nil
    if itemType == 'tr_firewood' or itemType == 'tr_woodplank' then
        sellingLocation = vector3(Config.seller2.x, Config.seller2.y, Config.seller2.z)
    elseif itemType == 'tr_toyset' or itemType == 'tr_woodhandles' then
        sellingLocation = vector3(Config.seller2.x, Config.seller2.y, Config.seller2.z)
    else
        notifyPlayer(source, Lang.invalidItem, 'error')
        return
    end

    if #(playerCoords - sellingLocation) > 10 then
        notifyPlayer(source, Lang.tooFarFromSellPoint, 'error')
        return
    end

    if itemCount > 0 then
        local sellPriceRange = Config.sell[itemType]
        if sellPriceRange then
            local sellPrice = math.random(sellPriceRange[1], sellPriceRange[2]) * itemCount
            if exports.ox_inventory:AddItem(source, 'cash', sellPrice) and exports.ox_inventory:RemoveItem(source, itemType, itemCount) then
                notifyPlayer(source, string.format(Lang.soldItems, itemCount, sellPrice), 'success')
            end
        else
            notifyPlayer(source, Lang.invalidItem, 'error')
        end
    else
        notifyPlayer(source, Lang.noItemsToSell, 'error')
    end
end)
