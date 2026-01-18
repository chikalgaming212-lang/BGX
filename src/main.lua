--==================================================
-- Executor : Delta (Mobile)
-- Author   : BGX
--==================================================

if not game:IsLoaded() then game.Loaded:Wait() end

--================ CONFIG =================
getgenv().CFG = {
    AutoPerfect = true,
    AutoFish    = true,
    AutoReel    = true,
    AutoSell    = false,
    Blatant     = false,

    AutoFavorite = true,
    FavRarity = {
        Common=false, Uncommon=false, Rare=true,
        Epic=true, Legendary=true, Myth=true, Secret=true
    },

    LockWeather = false,
    WeatherName = "Clear",
    LockTime    = false,
    TimeOfDay   = 12,

    CastDelay   = 0.25,
    ToggleUIKey = Enum.KeyCode.RightShift,
    AntiLag     = true
}

--================ SERVICES ================
local Players = game:GetService("Players")
local RS      = game:GetService("ReplicatedStorage")
local UIS     = game:GetService("UserInputService")
local VU      = game:GetService("VirtualUser")
local TS      = game:GetService("TweenService")
local HS      = game:GetService("HttpService")
local LP      = Players.LocalPlayer
local Camera  = workspace.CurrentCamera
local PlayerGui = LP:WaitForChild("PlayerGui")

--================ SAVE / LOAD ==============
local CONFIG_KEY = "FishItDelta_Config_V1"

local function SaveCFG()
    if writefile then
        writefile(CONFIG_KEY..".json", HS:JSONEncode(CFG))
    end
end

local function LoadCFG()
    if readfile and isfile and isfile(CONFIG_KEY..".json") then
        local data = HS:JSONDecode(readfile(CONFIG_KEY..".json"))
        for k,v in pairs(data) do CFG[k] = v end
    end
end
LoadCFG()

--================ UTILS ===================
local function getRod()
    local c = LP.Character
    if not c then return end
    for _,v in ipairs(c:GetChildren()) do
        if v:IsA("Tool") and v.Name:lower():find("rod") then
            return v
        end
    end
end

local function findDeep(p,n)
    return p:FindFirstChild(n,true)
end

--================ ANTI LAG =================
if CFG.AntiLag then
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
        for _,v in ipairs(workspace:GetDescendants()) do
            if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Beam") then
                v.Enabled = false
            end
        end
        Camera.FieldOfView = 70
    end)
end

--================ GUI =====================
local gui = Instance.new("ScreenGui", PlayerGui)
gui.Name = "FishItDeltaGUI"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.fromScale(0.56,0.62)
main.Position = UDim2.fromScale(0.22,0.19)
main.BackgroundColor3 = Color3.fromRGB(14,14,14)
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,14)

-- HEADER
local header = Instance.new("TextLabel", main)
header.Size = UDim2.new(1
