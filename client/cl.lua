local QBCore = exports['qb-core']:GetCoreObject()

-- Cấu hình cơ bản cho hệ thống chặt cây
local choppedTrees = {}
local chopRadius = 5.0
local cooldownTime = Config.coolDowns.chopping * 60 * 1000


-- LogProp = nil
-- ChoppingEffect = nil
-- TrailerFull = false
-- TaskInProgress = false
-- IsDeliveryTruckSelected = false

-- Notification function to handle both qbcore and ox notification systems
function NotifyPlayer(message, type)
    if Config.notification == "qbcore" then
        QBCore.Functions.Notify(message, type, 5000)
    elseif Config.notification == "ox" then
        lib.notify({ title = message, type = type })
    end
end


function HasPlayerGotChoppedLogs()
    ChoppedLogs = exports.ox_inventory:Search('count', 'tr_choppedlog')
    return ChoppedLogs > 0
end

-- Function to check if the tree is within the chopped radius and still on cooldown (Do not touch this at all! I warned you)
-- Start of tree chopping events
local function isTreeChopped(treeCoords)
    local currentTime = GetGameTimer()

    for index, treeData in pairs(choppedTrees) do
        local distance = #(vector3(treeData.coords.x, treeData.coords.y, treeData.coords.z) - vector3(treeCoords.x, treeCoords.y, treeCoords.z))
        if distance <= chopRadius then
            if currentTime - treeData.time < cooldownTime then
                if Config.debug then
                    print(json.encode({ currentTime = currentTime, choppedTime = treeData.time }))
                end
                return true
            else
                table.remove(choppedTrees, index)
            end
        end
    end
    return false
end

RegisterNetEvent('txm-lumberjack:client:choptreecheck', function()
    local playerPed = PlayerPedId()
    local treeCoords = GetEntityCoords(playerPed)

    local weaponHash = GetSelectedPedWeapon(playerPed)
    if weaponHash ~= GetHashKey('weapon_battleaxe') then
        NotifyPlayer(Lang.errorNoAxe, 'error')
        return
    end

    if isTreeChopped(treeCoords) then
        NotifyPlayer(Lang.alreadyChopped, 'error')
        return
    end

    local roundedCoords = { x = math.floor(treeCoords.x), y = math.floor(treeCoords.y), z = math.floor(treeCoords.z) }
    table.insert(choppedTrees, { coords = roundedCoords, time = GetGameTimer() })

    local choppingAnimation = {
        dict = "melee@hatchet@streamed_core",
        name = "plyr_rear_takedown_b"
    }

    RequestAnimDict(choppingAnimation.dict)
    while not HasAnimDictLoaded(choppingAnimation.dict) do
        Citizen.Wait(100)
    end

    TaskPlayAnim(playerPed, choppingAnimation.dict, choppingAnimation.name, 8.0, -8.0, -1, 1, 0, false, false, false)

    if Config.progress == "qbcore" then
        QBCore.Functions.Progressbar('chopping_tree', Lang.choppingDownTree, Config.progressTime.chopping * 1000, false, true, {
            disableMovement = true,
            disableCarMovement = true,
            disableMouse = false,
            disableCombat = true
        }, {}, {}, {}, function()
            ClearPedTasks(playerPed)
            TriggerServerEvent('txm-lumberjack:server:choptree')
        end, function()
            ClearPedTasks(playerPed)
            NotifyPlayer(Lang.cancelledProgress, 'error')
        end)

    elseif Config.progress == "ox" then
        if lib.progressBar({
            duration = Config.progressTime.chopping * 1000,
            label = Lang.choppingDownTree,
            useWhileDead = false,
            canCancel = true,
            disable = { move = true }
        }) then
            ClearPedTasks(playerPed)
            TriggerServerEvent('txm-lumberjack:server:choptree')
        else
            ClearPedTasks(playerPed)
            NotifyPlayer(Lang.cancelledProgress, 'error')
        end
    end
end)

-- RegisterNetEvent('txm-lumberjack:client:craftinginput', function()
--     if Config.menu == "qbcore" then
--         local dialog = exports['qb-input']:ShowInput({
--             header = string.format(Lang.choppedLogAmount, ChoppedLogs),
--             submitText = Lang.submit,
--             inputs = {
--                 {
--                     text = Lang.menuText,
--                     name = "loginput",
--                     type = "number",
--                     isRequired = true,
--                 },
--             },
--         })

--         if dialog then
--             local logAmount = tonumber(dialog.loginput)
--             if not logAmount or logAmount <= 0 or logAmount > ChoppedLogs then
--                 NotifyPlayer(Lang.invalidNumber, 'error')
--                 return
--             end

--             local labelPreview = Lang.previewCrafting -- hoặc random từ Lang.craftingPlanks... (nếu bạn muốn mô phỏng item)
--             local duration = Config.progressTime.crafting * 1000 * logAmount

--             local function sendToServer()
--                 TriggerServerEvent('txm-lumberjack:server:craftinginput', logAmount)
--             end

--             if Config.progress == "qbcore" then
--                 QBCore.Functions.Progressbar('crafting_progress', labelPreview, duration, false, true, {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true
--                 }, {}, {}, {}, sendToServer, function()
--                     NotifyPlayer(Lang.cancelledProgress, 'error')
--                 end)

--             elseif Config.progress == "ox" then
--                 if lib.progressBar({
--                     duration = duration,
--                     label = labelPreview,
--                     useWhileDead = false,
--                     canCancel = true,
--                     disable = { move = true }
--                 }) then
--                     sendToServer()
--                 else
--                     NotifyPlayer(Lang.cancelledProgress, 'error')
--                 end
--             end
--         end

--     elseif Config.menu == "ox" then
--         local input = lib.inputDialog(string.format(Lang.choppedLogAmount, ChoppedLogs), {
--             {type = 'number', label = Lang.menuText, icon = 'hashtag'}
--         })

--         if input then
--             local logAmount = tonumber(input[1])
--             if not logAmount or logAmount <= 0 or logAmount > ChoppedLogs then
--                 NotifyPlayer(Lang.invalidNumber, 'error')
--                 return
--             end

--             local labelPreview = Lang.previewCrafting
--             local duration = Config.progressTime.crafting * 1000 * logAmount

--             local function sendToServer()
--                 TriggerServerEvent('txm-lumberjack:server:craftinginput', logAmount)
--             end

--             if Config.progress == "qbcore" then
--                 QBCore.Functions.Progressbar('crafting_progress', labelPreview, duration, false, true, {
--                     disableMovement = true,
--                     disableCarMovement = true,
--                     disableMouse = false,
--                     disableCombat = true
--                 }, {}, {}, {}, sendToServer, function()
--                     NotifyPlayer(Lang.cancelledProgress, 'error')
--                 end)

--             elseif Config.progress == "ox" then
--                 if lib.progressBar({
--                     duration = duration,
--                     label = labelPreview,
--                     useWhileDead = false,
--                     canCancel = true,
--                     disable = { move = true }
--                 }) then
--                     sendToServer()
--                 else
--                     NotifyPlayer(Lang.cancelledProgress, 'error')
--                 end
--             end
--         end
--     end
-- end)


RegisterNetEvent('txm-lumberjack:client:craftinginput', function(args)
    local argsNumber = tonumber(args.number)
    local craftingItemName

    if argsNumber == 1 then
        craftingItemName = Lang.craftingPlanks or "Planks"
    elseif argsNumber == 2 then
        craftingItemName = Lang.craftingHandles or "Handles"
    elseif argsNumber == 3 then
        craftingItemName = Lang.craftingFirewood or "Firewood"
    elseif argsNumber == 4 then
        craftingItemName = Lang.craftingToysets or "Toy Sets"
    else
        NotifyPlayer(Lang.invalidCraftingItem, 'error')
        return
    end

    if Config.menu == "qbcore" then
        local dialog = exports['qb-input']:ShowInput({
            header = string.format(Lang.choppedLogAmount, ChoppedLogs),
            submitText = Lang.submit,
            inputs = {
                {
                    text = Lang.menuText,
                    name = "loginput",
                    type = "number",
                    isRequired = true,
                },
            },
        })

        if dialog then
            local logAmount = tonumber(dialog.loginput)
            if logAmount and (logAmount < 0 or logAmount > ChoppedLogs) then
                NotifyPlayer(Lang.invalidNumber, 'error')
                return
            end
            if Config.progress == "qbcore" then
                QBCore.Functions.Progressbar('crafting_progress', craftingItemName, Config.progressTime.crafting * 1000 * logAmount, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {}, {}, {}, function()
                    TriggerServerEvent('txm-lumberjack:server:craftinginput', argsNumber, logAmount)
                end, function()
                    NotifyPlayer(Lang.cancelledProgress, 'error')
                end)

            elseif Config.progress == "ox" then
                if lib.progressBar({
                    duration = Config.progressTime.crafting * 1000 * logAmount,
                    label = craftingItemName,
                    useWhileDead = false,
                    canCancel = true,
                    disable = { move = true }
                }) then
                    TriggerServerEvent('txm-lumberjack:server:craftinginput', argsNumber, logAmount)
                else
                    NotifyPlayer(Lang.cancelledProgress, 'error')
                end
            end
        else
            return
        end

    elseif Config.menu == "ox" then
        local input = lib.inputDialog(string.format(Lang.choppedLogAmount, ChoppedLogs), {
            {type = 'number', label = Lang.menuText, icon = 'hashtag'}
        })

        if input then
            local logAmount = tonumber(input[1])
            if logAmount and (logAmount < 0 or logAmount > ChoppedLogs) then
                NotifyPlayer(Lang.invalidNumber, 'error')
                return
            end
            if Config.progress == "qbcore" then
                QBCore.Functions.Progressbar('crafting_progress', craftingItemName, Config.progressTime.crafting * 1000 * logAmount, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true
                }, {}, {}, {}, function()
                    TriggerServerEvent('txm-lumberjack:server:craftinginput', argsNumber, logAmount)
                end, function()
                    NotifyPlayer(Lang.cancelledProgress, 'error')
                end)

            elseif Config.progress == "ox" then
                if lib.progressBar({
                    duration = Config.progressTime.crafting * 1000 * logAmount,
                    label = craftingItemName,
                    useWhileDead = false,
                    canCancel = true,
                    disable = { move = true }
                }) then
                    TriggerServerEvent('txm-lumberjack:server:craftinginput', argsNumber, logAmount)
                else
                    NotifyPlayer(Lang.cancelledProgress, 'error')
                end
            end
        else
            return
        end
    end
end)

