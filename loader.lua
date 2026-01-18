-- Fish It Delta 2026 Loader
-- Author : Chikal Delta
-- Executor : Delta (Mobile)

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local url = "https://raw.githubusercontent.com/chikalgaming212/FishIt-Delta-2026/main/src/main.lua"

loadstring(game:HttpGet(url))()
