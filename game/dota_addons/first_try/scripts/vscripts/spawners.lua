-- Custom timer, repeat every 5 seconds
function GameMode:OnGameInProgress()
    local repeat_interval = 5 -- Rerun this timer every *repeat_interval* game-time seconds
    local start_after = 30 -- Start this timer *start_after* game-time seconds later

    Timers:CreateTimer(start_after, function()
        SpawnCreeps()
        return repeat_interval
    end)
end

-- Spawner Function
function SpawnCreeps()
    local point = Entities:FindByName( nil, "spawner"):GetAbsOrigin()
    local unit = CreateUnitByName("npc_dota_neutral_satyr_trickster", point, true, nil, nil, DOTA_TEAM_NEUTRALS)
end