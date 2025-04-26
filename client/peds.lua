
local Swiper = Config.craftingBench
local Ban2 = Config.craftingBench2
local lumberModelHash = GetHashKey(Config.lumberModel)
local constructionWorkerModel = GetHashKey(Config.lumberMillModel)
local bingBong = Config.seller1
local fuckYourLife = Config.seller2
local benchModelHash = Config.craftingTable
local benchProp = nil

local function LoadModel(modelHash)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
end

local function CreateLumberPed(coords, isConstructionWorker)
    local pedModel = isConstructionWorker and constructionWorkerModel or lumberModelHash
    LoadModel(pedModel)

    local ped = CreatePed(1, pedModel, coords, false, true)
    SetEntityInvincible(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    return ped
end

local function CreateBenchProp(coords)
    local modelHash = benchModelHash

if not HasModelLoaded(modelHash) then
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Wait(1)
    end
end

local benchProp = CreateObject(modelHash, coords.x, coords.y, coords.z, false)
    SetEntityHeading(benchProp, coords.w)
    FreezeEntityPosition(benchProp, true)
    return benchProp
end

local function DeleteBenchProp()
    if benchProp and DoesEntityExist(benchProp) then
        DeleteObject(benchProp)
        benchProp = nil
    end
end

CreateThread(function()
    Wait(1000)
    local lumberjack3 = CreateLumberPed(fuckYourLife, false)

    local benchCoords = Swiper
    local BanXeGo2 = Ban2
    LoadModel(benchModelHash)

    if HasModelLoaded(benchModelHash) then
        CreateBenchProp(benchCoords)
        CreateBenchProp(BanXeGo2)
        
    else return end
end)



AddEventHandler('onResourceStop', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        DeleteBenchProp()
    end
end)
