_G._savedEnv = getfenv()
module("hero_bot_data", package.seeall)

DOTA_BOT_NUKER = 1
DOTA_BOT_STUN_SUPPORT = 2
DOTA_BOT_HARD_CARRY = 4
DOTA_BOT_GANKER = 8
DOTA_BOT_PURE_SUPPORT = 16
DOTA_BOT_TANK = 32
DOTA_BOT_SEMI_CARRY = 64
DOTA_BOT_PUSH_SUPPORT = 128

heroes = {
    ['npc_dota_hero_oracle'] = {['HeroType'] = 17, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_sven'] = {['HeroType'] = 98, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_skeleton_king'] = {['HeroType'] = 96, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 0, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_bounty_hunter'] = {['HeroType'] = 72, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 2, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_death_prophet'] = {['HeroType'] = 128, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 2, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_drow_ranger'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_nevermore'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 2, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_vengefulspirit'] = {['HeroType'] = 10, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_bristleback'] = {['HeroType'] = 96, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 1, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_razor'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_tiny'] = {['HeroType'] = 42, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_bloodseeker'] = {['HeroType'] = 72, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 2, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_bane'] = {['HeroType'] = 10, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 2, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_necrolyte'] = {['HeroType'] = 224, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 2, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_sniper'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_lich'] = {['HeroType'] = 16, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_lion'] = {['HeroType'] = 11, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 2, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_kunkka'] = {['HeroType'] = 224, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_viper'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 0, ['SoloDesire'] = 2, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_luna'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 2, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_axe'] = {['HeroType'] = 34, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 2, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_earthshaker'] = {['HeroType'] = 2, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_juggernaut'] = {['HeroType'] = 72, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 2, ['RequiresSetup'] = 2, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_chaos_knight'] = {['HeroType'] = 104, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 2, ['RequiresSetup'] = 0, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_jakiro'] = {['HeroType'] = 130, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_skywrath_mage'] = {['HeroType'] = 9, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 1, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_pudge'] = {['HeroType'] = 40, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 2, ['SoloDesire'] = 2, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_omniknight'] = {['HeroType'] = 16, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_warlock'] = {['HeroType'] = 144, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_zuus'] = {['HeroType'] = 9, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 1, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_dazzle'] = {['HeroType'] = 16, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_dragon_knight'] = {['HeroType'] = 98, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 1, ['RequiresSetup'] = 1, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_phantom_assassin'] = {['HeroType'] = 4, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 2, ['RequiresSetup'] = 2, ['RequiresFarm'] = 2}},
    ['npc_dota_hero_windrunner'] = {['HeroType'] = 10, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_tidehunter'] = {['HeroType'] = 34, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 2, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_witch_doctor'] = {['HeroType'] = 10, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_sand_king'] = {['HeroType'] = 10, ['LaningInfo'] = {['ProvidesSetup'] = 2, ['SurvivalRating'] = 2, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 0, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 0}},
    ['npc_dota_hero_lina'] = {['HeroType'] = 9, ['LaningInfo'] = {['ProvidesSetup'] = 0, ['SurvivalRating'] = 0, ['SoloDesire'] = 1, ['ProvidesBabysit'] = 1, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 2, ['RequiresFarm'] = 1}},
    ['npc_dota_hero_crystal_maiden'] = {['HeroType'] = 16, ['LaningInfo'] = {['ProvidesSetup'] = 1, ['SurvivalRating'] = 1, ['SoloDesire'] = 0, ['ProvidesBabysit'] = 2, ['RequiresBabysit'] = 0, ['RequiresSetup'] = 0, ['RequiresFarm'] = 1}},
}

for k,v in pairs(hero_bot_data) do _G._savedEnv[k] = v end
