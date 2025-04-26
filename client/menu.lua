local QBCore = exports['qb-core']:GetCoreObject()
-- QBCore Menu Configuration
if Config.menu == "qbcore" then
    RegisterNetEvent('txm-lumberjack:client:crafting', function()
        if HasPlayerGotChoppedLogs() then
            exports['qb-menu']:openMenu({
                {
                    header = string.format(Lang.craftingMenu, ChoppedLogs),
                    icon = 'fa-solid fa-tree',
                },
                {
                    header = Lang.craftPlanks,
                    txt = Lang.craftPlanksAmount,
                    icon = 'fa-solid fa-gear',
                    params = {
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 1,
                        }
                    }
                },
                {
                    header = Lang.craftHandles,
                    txt = Lang.craftHandlesAmount,
                    icon = 'fa-solid fa-gear',
                    params = {
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 2,
                        }
                    }
                },
                {
                    header = Lang.craftFirewood,
                    txt = Lang.craftFirewoodAmount,
                    icon = 'fa-solid fa-gear',
                    params = {
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 3,
                        }
                    }
                },
                {
                    header = Lang.craftWoodenToySets,
                    txt = Lang.craftWoodenToySetsAmount,
                    icon = 'fa-solid fa-gear',
                    params = {
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 4,
                        }
                    }
                }
            })
        end
    end)
    local function openSellMenu(itemList, eventPrefix)
        local menuItems = {}

        for _, item in pairs(itemList) do
            local itemCount = exports.ox_inventory:Search('count', item.name)
            local itemAvailable = itemCount > 0
            table.insert(menuItems, {
                header = string.format(item.header, itemCount),
                icon = 'fa-solid fa-gear',
                params = {
                    event = eventPrefix .. ':server:sellitem',
                    isServer = true,
                    args = {
                        number = itemCount,
                        itemType = item.name
                    }
                },
                disabled = not itemAvailable
            })
        end

        exports['qb-menu']:openMenu(menuItems)
    end
    RegisterNetEvent('txm-lumberjack:client:sell2', function()
        openSellMenu({
            {name = 'tr_woodhandles', header = Lang.sellHandles},
            {name = 'tr_toyset', header = Lang.sellToy},
            {name = 'tr_woodplank', header = Lang.sellPlanks},
            {name = 'tr_firewood', header = Lang.sellFirewood},
    
            -- Thêm 5 loại gỗ mới vào menu bán
            {name = 'txm_tramhuong', header = Lang.sellTramhuong},  -- Gỗ Trầm Hương
            {name = 'txm_hoangdan', header = Lang.sellHoangdan},    -- Gỗ Hoàng Đàn
            {name = 'txm_danhuong', header = Lang.sellDanhuong},    -- Gỗ Đàn Hương
            {name = 'txm_mun', header = Lang.sellMun},              -- Gỗ Mun
            {name = 'txm_suado', header = Lang.sellSuado},          -- Gỗ Sưa Đỏ
        }, 'txm-lumberjack')
    end)


-- Ox Menu Configuration
elseif Config.menu == "ox" then
    RegisterNetEvent('txm-lumberjack:client:crafting', function()
        if HasPlayerGotChoppedLogs() then
            lib.registerContext({
                id = 'lumberjack_crafting',
                title = string.format(Lang.craftingMenu, ChoppedLogs),
                options = {
                    {
                        title = Lang.craftPlanks,
                        description = Lang.craftPlanksAmount,
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 1,
                        }
                    },
                    {
                        title = Lang.craftHandles,
                        description = Lang.craftHandlesAmount,
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 2,
                        }
                    },
                    {
                        title = Lang.craftFirewood,
                        description = Lang.craftFirewoodAmount,
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 3,
                        }
                    },
                    {
                        title = Lang.craftWoodenToySets,
                        description = Lang.craftWoodenToySetsAmount,
                        event = 'txm-lumberjack:client:craftinginput',
                        args = {
                            number = 4,
                        }
                    },
                }
            })
            lib.showContext('lumberjack_crafting')
        end
    end)
    local function openSellMenu(itemList, eventPrefix)
        local menuItems = {}

        for _, item in pairs(itemList) do
            local itemCount = exports.ox_inventory:Search('count', item.name)
            local itemAvailable = itemCount > 0
            table.insert(menuItems, {
                title = string.format(item.header, itemCount), -- Title with item count
                serverEvent = eventPrefix .. ':server:sellitem',
                args = {
                    number = itemCount,
                    itemType = item.name
                },
                disabled = not itemAvailable -- Disable if no items available
            })
        end
        lib.registerContext({
            id = 'sell_menu',
            title = Lang.interact7,
            options = menuItems
        })

        lib.showContext('sell_menu')
    end
    RegisterNetEvent('txm-lumberjack:client:sell2', function()
        openSellMenu({
            {name = 'tr_woodhandles', header = Lang.sellHandles},
            {name = 'tr_toyset', header = Lang.sellToy},
            {name = 'tr_woodplank', header = Lang.sellPlanks},
            {name = 'tr_firewood', header = Lang.sellFirewood},
    
            -- Thêm 5 loại gỗ mới vào menu bán
            {name = 'txm_tramhuong', header = Lang.sellTramhuong},  -- Gỗ Trầm Hương
            {name = 'txm_hoangdan', header = Lang.sellHoangdan},    -- Gỗ Hoàng Đàn
            {name = 'txm_danhuong', header = Lang.sellDanhuong},    -- Gỗ Đàn Hương
            {name = 'txm_mun', header = Lang.sellMun},              -- Gỗ Mun
            {name = 'txm_suado', header = Lang.sellSuado},          -- Gỗ Sưa Đỏ
        }, 'txm-lumberjack')
    end)
end
