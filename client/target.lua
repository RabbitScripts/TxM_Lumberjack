local oxTarget = exports['ox_target']

local boxZones = {
    {
        --Log Crafting Menu Location
        coords = vector3(-493.21, 5342.85, 82.62),
        length = 2,
        width = 2,
        heading = 80,
        name = 'zone5',
        label = Lang.interact6,
        icon = 'fa-solid fa-hand',
        event = 'txm-lumberjack:client:crafting'
    },
    {
        -- Log Crafting Menu Location (Bench 2)
        coords = vector3(-491.21, 5348.21, 82.62),
        length = 2,
        width = 2,
        heading = 169,
        name = 'zone3',
        label = Lang.interact6,
        icon = 'fa-solid fa-hand',
        event = 'txm-lumberjack:client:crafting'
    },
    {
        --Seller 
        coords = vector3(925.812, -1560.319, 29.74),
        length = 2,
        width = 2,
        heading = 80,
        name = 'zone5',
        label = Lang.interact7,
        icon = 'fa-solid fa-hand',
        event = 'txm-lumberjack:client:sell2'
    }
}

local logProps = {
    'prop_logpile_03',
}

local treeZones = {
    { coords = vector3(-456.6101, 5408.726, 78.69884), length = 2, width = 2, heading = 0.0, name = 'tree1', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-457.2242, 5398.11, 80.54485), length = 2, width = 2, heading = 0.0, name = 'tree2', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-447.163, 5396.568, 80.69884), length = 2, width = 2, heading = 0.0, name = 'tree3', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-492.91, 5396.01, 77.13), length = 2, width = 2, heading = 0.0, name = 'tree4', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-500.736, 5401.574, 75.01296), length = 2, width = 2, heading = 0.0, name = 'tree5', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-510.5032, 5389.506, 72.95892), length = 2, width = 2, heading = 0.0, name = 'tree6', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-504.5997, 5391.875, 75.36236), length = 2, width = 2, heading = 0.0, name = 'tree7', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-558.7664, 5419.209, 62.34554), length = 2, width = 2, heading = 0.0, name = 'tree8', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-561.658, 5420.319, 62.52522), length = 2, width = 2, heading = 0.0, name = 'tree9', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-476.1692, 5468.564, 86.10078), length = 2, width = 2, heading = 0.0, name = 'tree10', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-419.854, 5437.376, 76.01779), length = 2, width = 2, heading = 0.0, name = 'tree11', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-422.3033, 5447.007, 75.73431), length = 2, width = 2, heading = 0.0, name = 'tree12', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-421.3751, 5454.29, 78.03955), length = 2, width = 2, heading = 0.0, name = 'tree13', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-578.8257, 5427.048, 58.92018), length = 2, width = 2, heading = 0.0, name = 'tree14', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-586.3552, 5447.37, 60.59866), length = 2, width = 2, heading = 0.0, name = 'tree15', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-595.0001, 5451.043, 59.29848), length = 2, width = 2, heading = 0.0, name = 'tree16', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-591.8429, 5448.774, 60.37492), length = 2, width = 2, heading = 0.0, name = 'tree17', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-615.4167, 5432.851, 53.75421), length = 2, width = 2, heading = 0.0, name = 'tree18', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-616.3025, 5424.165, 48.93402), length = 2, width = 2, heading = 0.0, name = 'tree19', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-620.4484, 5428.12, 51.35571), length = 2, width = 2, heading = 0.0, name = 'tree20', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-600.2048, 5397.276, 53.69012), length = 2, width = 2, heading = 0.0, name = 'tree21', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-614.0487, 5399.306, 50.0063), length = 2, width = 2, heading = 0.0, name = 'tree22', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-616.1387, 5403.191, 48.84934), length = 2, width = 2, heading = 0.0, name = 'tree23', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-655.0473, 5424.245, 45.85096), length = 2, width = 2, heading = 0.0, name = 'tree24', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-661.5078, 5425.615, 45.43542), length = 2, width = 2, heading = 0.0, name = 'tree25', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
    { coords = vector3(-511.442, 5449.702, 75.19167), length = 2, width = 2, heading = 0.0, name = 'tree26', label = Lang.chopTree, icon = 'fa-solid fa-tree', event = 'txm-lumberjack:client:choptreecheck' },
}

CreateThread(function()
    for _, zone in ipairs(boxZones) do
        oxTarget:addBoxZone({
            coords = zone.coords,
            length = zone.length,
            width = zone.width,
            heading = zone.heading,
            debug = Config.debug,
            options = {
                {
                    name = zone.name,
                    event = zone.event,
                    icon = zone.icon,
                    label = zone.label,
                    canInteract = function()
                        return true
                    end
                }
            }
        })
    end
    for _, zone in ipairs(treeZones) do
        oxTarget:addBoxZone({
            coords = zone.coords,
            length = zone.length,
            width = zone.width,
            heading = zone.heading,
            debug = Config.debug,
            options = {
                {
                    name = zone.name,
                    event = zone.event,
                    icon = zone.icon,
                    label = zone.label,
                }
            }
        })
    end

end)