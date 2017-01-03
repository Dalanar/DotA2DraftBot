require(GetScriptDirectory()..'/utils/hero_bot_data')

M = {}

local cm_draft = {
    [HEROPICK_STATE_CM_INTRO] = 'nop',
    [HEROPICK_STATE_CM_CAPTAINPICK] = function () return HandleCaptainPick() end,
    [HEROPICK_STATE_CM_BAN1] = function () return HandleBan(1) end,
    [HEROPICK_STATE_CM_BAN2] = function () return HandleBan(2) end,
    [HEROPICK_STATE_CM_BAN3] = function () return HandleBan(3) end,
    [HEROPICK_STATE_CM_BAN4] = function () return HandleBan(4) end,
    [HEROPICK_STATE_CM_BAN5] = function () return HandleBan(5) end,
    [HEROPICK_STATE_CM_BAN6] = function () return HandleBan(6) end,
    [HEROPICK_STATE_CM_BAN7] = function () return HandleBan(7) end,
    [HEROPICK_STATE_CM_BAN8] = function () return HandleBan(8) end,
    [HEROPICK_STATE_CM_BAN9] = function () return HandleBan(9) end,
    [HEROPICK_STATE_CM_BAN10] = function () return HandleBan(10) end,
    [HEROPICK_STATE_CM_SELECT1] = function () return HandlePick(1) end,
    [HEROPICK_STATE_CM_SELECT2] = function () return HandlePick(2) end,
    [HEROPICK_STATE_CM_SELECT3] = function () return HandlePick(3) end,
    [HEROPICK_STATE_CM_SELECT4] = function () return HandlePick(4) end,
    [HEROPICK_STATE_CM_SELECT5] = function () return HandlePick(5) end,
    [HEROPICK_STATE_CM_SELECT6] = function () return HandlePick(6) end,
    [HEROPICK_STATE_CM_SELECT7] = function () return HandlePick(7) end,
    [HEROPICK_STATE_CM_SELECT8] = function () return HandlePick(8) end,
    [HEROPICK_STATE_CM_SELECT9] = function () return HandlePick(9) end,
    [HEROPICK_STATE_CM_SELECT10] = function () return HandlePick(10) end,
    [HEROPICK_STATE_CM_PICK] = function () return HandleSelect() end,
}
function M.Handle()
    if (GetGameState() ~= GAME_STATE_HERO_SELECTION) then
        print('Not hero selection phase, exitting')
        return
    end
    
    local action = cm_draft[GetHeroPickState()]
    if type(action) == 'function' then
        action()
    elseif action == nil then
        print('Unknown pick state!!')
    end
end


local captain_picked = false
local use_drafter_bot = false
function HandleCaptainPick()
    if not HasHumanInTeam() or (DotaTime() > -1) then
        if not captain_picked then
            captain_picked = true
            local first_bot = GetFirstBotPlayer()
            if first_bot ~= nil then
                SetCMCaptain(first_bot)
                use_drafter_bot = true
                print(GetTeamName()..': Using drafter bot')
            end
        end
    end
end


local has_human_in_team
function HasHumanInTeam()
    if has_human_in_team ~= nil then
        return has_human_in_team
    end
    
    local players = GetTeamPlayers(GetTeam())
    for i, player_id in pairs(players) do
        if not IsPlayerBot(player_id) then
            has_human_in_team = true
            print(GetTeamName()..': Has human in team') 
            return has_human_in_team
        end
    end
    has_human_in_team = false
    print(GetTeamName()..': Hasn\'t human in team') 
    return has_human_in_team
end


local first_bot_player
local got_first_bot
function GetFirstBotPlayer()
    if got_first_bot == true then
        return first_bot_player
    end
    got_first_bot = true
    
    local players = GetTeamPlayers(GetTeam())
    for i, player_id in pairs(players) do
        if IsPlayerBot(player_id) then
            first_bot_player = player_id
            return first_bot_player
        end
    end
    first_bot_player = nil
    return first_bot_player
end


local bans = {}
local enemy_picks = {}
local my_picks = {}
local state_refreshed = {}
function RefreshDraftState()
    if state_refreshed[GetHeroPickState()] ~= nil then
        return
    end
    
    for hero, data in pairs(hero_bot_data.heroes) do
        if bans[hero] == nil then
            if IsCMBannedHero(hero) then
                bans[hero] = true
            else
                if (my_picks[hero] == nil) and (enemy_picks[hero] == nil) then
                    if IsCMPickedHero(GetEnemyTeam(), hero) then
                        enemy_picks[hero] = true
                    elseif IsCMPickedHero(GetTeam(), hero) then
                        my_picks[hero] = true
                    end
                end
            end
        end
    end
end


local team_composition
local available_heroes = {}
for hero, data in pairs(hero_bot_data.heroes) do
    available_heroes[hero] = data
end
function CreateTeamComposition()
    -- Should be based on currently made picks
    local new_comp = {}
    for hero, _ in pairs(my_picks) do
        new_comp[hero] = true
    end
    
    -- Refresh available heroes
    for hero, data in pairs(hero_bot_data.heroes) do
        if (bans[hero] ~= nil) or (enemy_picks[hero] ~= nil) or (my_picks[hero] ~= nil) then
            available_heroes[hero] = nil
        else
            available_heroes[hero] = data
        end
    end
    
    -- TODO: Not so dummy team filling
    for idx = #new_comp + 1, 5 do
        local hero, data = next(available_heroes)
        if hero == nil then
            break
        end
        available_heroes[hero] = nil
        new_comp[hero] = true
    end
    
    --[[local str_comp = ''
    for hero, _ in pairs(new_comp) do
        str_comp = str_comp..hero..', '
    end
    print(string.format('%s: new composition is %s', GetTeamName(), str_comp))]]--
    return new_comp
end


function ValidateTeamComposition()
    if team_composition == nil then
        return
    end
    
    local need_invalidate = false
    for hero, _ in pairs(team_composition) do
        if (bans[hero] ~= nil) or (enemy_picks[hero] ~= nil) then
            --print(string.format('%s: hero %s is banned or stolen, invalidating composition', GetTeamName(), hero))
            need_invalidate = true
            break
        end
    end
    if need_invalidate then
        team_composition = nil
    end
end


function GetBan()
    -- TODO: Evaluate enemy strategy and do more clever bans
    for hero, data in pairs(hero_bot_data.heroes) do
        if (bans[hero] == nil) and (enemy_picks[hero] == nil) and (team_composition[hero] == nil) then
            return hero
        end
    end
end


function GetPick()
    for hero, _ in pairs(team_composition) do
        if my_picks[hero] == nil then
            my_picks[hero] = true
            return hero
        end
    end
end


function HandleBan(idx)
    RefreshDraftState()
    
    if not use_drafter_bot or not IsPlayerInHeroSelectionControl(GetCMCaptain()) then
        return
    end
    
    --print(string.format('%s: HandleBan %d', GetTeamName(), idx))
    
    ValidateTeamComposition()    
    if team_composition == nil then
        team_composition = CreateTeamComposition()
    end
    
    CMBanHero(GetBan()) 
end


function HandlePick(idx)
    RefreshDraftState()
    
    if not use_drafter_bot or not IsPlayerInHeroSelectionControl(GetCMCaptain()) then
        return
    end
    
    --print(string.format('%s: HandlePick %d', GetTeamName(), idx))
    ValidateTeamComposition()    
    if team_composition == nil then
        team_composition = CreateTeamComposition()
    end
    
    CMPickHero(GetPick())
end


function AreHumansSelectedHeroes()
    local my_boyz = GetTeamPlayers(GetTeam())
    for _, player_id in pairs(my_boyz) do
        if not IsPlayerBot(player_id) then
            local selected_hero = GetSelectedHeroName(player_id)
            if (selected_hero == nil) or (selected_hero == '') then
                return false
            end
        end
    end
    
    return true
end


local team_selected = false
function HandleSelect()
    RefreshDraftState()
    
    if (not team_selected) and (AreHumansSelectedHeroes() or (GetCMPhaseTimeRemaining() < 1)) then
        local my_boyz = GetTeamPlayers(GetTeam())
        --print(string.format('%s: Handle Select', GetTeamName()))
        local undecided_boyz = {}
        for _, player_id in pairs(my_boyz) do
            local selected_hero = GetSelectedHeroName(player_id)
            if (selected_hero ~= nil) and (selected_hero ~= '') then
                my_picks[selected_hero] = false
            else
                table.insert(undecided_boyz, player_id)
            end
        end
        local idx = 1
        for hero, is_free in pairs(my_picks) do
            if is_free then
                SelectHero(undecided_boyz[idx], hero)
                idx = idx + 1
            end
        end
        team_selected = true
    end
end


function GetEnemyTeam()
    if GetTeam() == TEAM_RADIANT then
        return TEAM_DIRE
    else
        return TEAM_RADIANT
    end
end 


local team_to_text
function GetTeamName()
    if not team_to_text then
        team_to_text = {
            [TEAM_RADIANT] = 'RADIANT',
            [TEAM_DIRE] = 'DIRE',
            [TEAM_NEUTRAL] = 'NEUTRAL',
            [TEAM_NONE] = 'NONE'
        }
    end
    return team_to_text[GetTeam()] or 'Unknown'
end


return M