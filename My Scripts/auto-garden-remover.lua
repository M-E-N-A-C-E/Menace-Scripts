--[[
W deepseek
join our discord server for giveaways:
https://discord.gg/3T6a6dz2AZ

this script will auto remove yo ahh garden including the other players' gardens. so use it if u want and simply leave for auto execute to stop.
happy scripting sonions!
]]

print("[Plot Remover] Starting...")

if not game:IsLoaded() then game.Loaded:Wait() end

local placeId = game.PlaceId
if placeId ~= 97598239454123 then
    print("[Plot Remover] Wrong game – this only works in Grow a Garden 2.")
    return
end

local function deleteAllPlots()
    local Gardens = workspace:FindFirstChild("Gardens")
    if not Gardens then
        print("[Plot Remover] Gardens folder not found.")
        return
    end

    local count = 0
    for _, child in ipairs(Gardens:GetChildren()) do
        if child:IsA("Model") and child.Name:match("^Plot%d+$") then
            child:Destroy()
            count = count + 1
        end
    end
    print("[Plot Remover] Deleted " .. count .. " garden plot(s).")
end

deleteAllPlots()

local queueFunc = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end
local loaderCode = [[
-- Plot Remover loader (auto-queued after teleport)
if not game:IsLoaded() then game.Loaded:Wait() end

local placeId = game.PlaceId
if placeId ~= 97598239454123 then return end

local Gardens = workspace:FindFirstChild("Gardens")
if Gardens then
    for _, child in ipairs(Gardens:GetChildren()) do
        if child:IsA("Model") and child.Name:match("^Plot%d+$") then
            child:Destroy()
        end
    end
end

-- Re-queue itself for the next hop
local queueFunc = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport) or function() end
local loaderContent = readfile("menace_plot_remover_loader.lua")
if loaderContent then
    queueFunc(loaderContent)
end
]]

writefile("menace_plot_remover_loader.lua", loaderCode)

queueFunc(loaderCode)

print("[Plot Remover] Done! Plots will be deleted after every server hop as well.")
