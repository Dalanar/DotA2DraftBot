import vdf
implemented_bots = set([
    'npc_dota_hero_axe',
    'npc_dota_hero_bane',
    'npc_dota_hero_bounty_hunter',
    'npc_dota_hero_bloodseeker',
    'npc_dota_hero_bristleback',
    'npc_dota_hero_chaos_knight',
    'npc_dota_hero_crystal_maiden',
    'npc_dota_hero_dazzle',
    'npc_dota_hero_death_prophet',
    'npc_dota_hero_dragon_knight',
    'npc_dota_hero_drow_ranger',
    'npc_dota_hero_earthshaker',
    'npc_dota_hero_jakiro',
    'npc_dota_hero_juggernaut',
    'npc_dota_hero_kunkka',
    'npc_dota_hero_lich',
    'npc_dota_hero_lina',
    'npc_dota_hero_lion',
    'npc_dota_hero_luna',
    'npc_dota_hero_necrolyte',
    'npc_dota_hero_omniknight',
    'npc_dota_hero_oracle',
    'npc_dota_hero_phantom_assassin',
    'npc_dota_hero_pudge',
    'npc_dota_hero_razor',
    'npc_dota_hero_sand_king',
    'npc_dota_hero_nevermore',
    'npc_dota_hero_skywrath_mage',
    'npc_dota_hero_sniper',
    'npc_dota_hero_sven',
    'npc_dota_hero_tidehunter',
    'npc_dota_hero_tiny',
    'npc_dota_hero_vengefulspirit',
    'npc_dota_hero_viper',
    'npc_dota_hero_warlock',
    'npc_dota_hero_windrunner',
    'npc_dota_hero_witch_doctor',
    'npc_dota_hero_skeleton_king',
    'npc_dota_hero_zuus',    
])
heroes = vdf.load(open(r'D:\games\steamapps\common\dota 2 beta\game\dota\scripts\npc\npc_heroes.txt'))
with open('hero_bot_data.lua', 'w') as output:
    # Write module exporting stuff #1
    output.write('_G._savedEnv = getfenv()\n')
    output.write('module("hero_bot_data", package.seeall)\n')
    output.write('\n')
    
    # Collect all hero types
    hero_types = set()
    hero_type_ids = {}
    for name, data in heroes['DOTAHeroes'].iteritems():
        if isinstance(data, dict) and 'Bot' in data:
            this_hero_type = data['Bot']['HeroType'].split('|')
            for hero_type in this_hero_type:
                hero_types.add(hero_type.strip())
    idx = 1
    for hero_type in hero_types:
        hero_type_ids[hero_type] = idx
        output.write('%s = %d\n' % (hero_type, idx))
        idx *= 2
    output.write('\n')
    
    # Fill LaningInfo and HeroType
    output.write('heroes = {\n')
    supported_list = []
    not_supported_list = []
    for name, data in heroes['DOTAHeroes'].iteritems():
        if isinstance(data, dict) and data.get('CMEnabled', '0') == '1':
            human_name = data['url'].replace('_', ' ')
            if 'Bot' not in data:
                not_supported_list.append(human_name)
                continue
            laning_info = []
            try:
                for key, value in data['Bot']['LaningInfo'].iteritems():
                    laning_info.append('[\'%s\'] = %s' % (key, value))
                this_hero_type = 0
                this_hero_type_raw = data['Bot']['HeroType'].split('|')
                for hero_type in this_hero_type_raw:
                    this_hero_type |= hero_type_ids[hero_type.strip()]
                if ('Loadout' not in data['Bot']) or (name not in implemented_bots):
                    not_supported_list.append(human_name)
                else:
                    output.write('    [\'%s\'] = {[\'HeroType\'] = %s, [\'LaningInfo\'] = {%s}},\n' % (name, this_hero_type, ', '.join(laning_info)))
                    supported_list.append(human_name)
            except KeyError as ex:
                not_supported_list.append(human_name)
    output.write('}\n\n')
    
    # Write module exporting stuff #2
    output.write('for k,v in pairs(hero_bot_data) do _G._savedEnv[k] = v end\n')
    
    supported_list.sort()
    print 'Fully operational:'
    for hero in supported_list:
        print ' - %s' % hero
    not_supported_list.sort()
    print '\nNot supported:'
    for hero in not_supported_list:
        print ' - %s' % hero
