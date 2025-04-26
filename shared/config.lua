-- Configuration settings
Config = Config or {}
Config.debug = false

-- Notification System
Config.notification = "ox"  -- Options: qbcore, ox

-- Progress Bar
Config.progress = "ox"  -- Options: qbcore, ox

-- Menu System
Config.menu = "ox"  -- Options: qbcore, ox

-- Fuel System
Config.fuel = "cdn-fuel" -- Export for fuel script (if using ox just put "ox")

-- Blips
Config.useBlips = true  -- true = Enabled, false = Disabled

-- ProgressBar Timers
Config.progressTime = {
    sellingLog = 1,
    chopping = 10,
    crafting = 10, 
}

-- Cool Downs
Config.coolDowns = { -- In minutes
    chopping = 3,
}

-- Ped Model
Config.lumberModel = 'a_m_m_hasjew_01'
Config.lumberMillModel = 's_m_y_construct_01'

-- Crafting Models
Config.craftingTable = GetHashKey("prop_tablesaw_01")

-- Crafting Bench Location (sử dụng cho target và crafting)
Config.craftingBench = vector4(-493.37, 5342.92, 81.58, 70.09)
Config.craftingBench2 = vector4(-491.37, 5348.28, 81.58, 70.09)
-- Seller Location
Config.seller2 = vector4(925.812, -1560.319, 29.74, 95.023)

-- Crafting Output Amounts
Config.receive = {
    tr_woodplank = 4,
    tr_woodhandles = 2,
    tr_firewood = 6,
    tr_toyset = 1,

    -- Gỗ mới
    txm_tramhuong = 1,
    txm_hoangdan = 1,
    txm_danhuong = 1,
    txm_mun = 1,
    txm_suado = 1,

    -- Vụn gỗ
    txm_woodscrap = 1,
}

-- Selling Prices
Config.sell = {
    deliveryPerLog = {65, 80},
    tr_woodplank = {100, 120},
    tr_firewood  = {90, 110},
    tr_woodhandles  = {50, 65},
    tr_toyset  = {95, 100},

    txm_tramhuong = {250, 300},
    txm_hoangdan = {220, 270},
    txm_danhuong = {240, 290},
    txm_mun = {210, 260},
    txm_suado = {300, 350},
}
