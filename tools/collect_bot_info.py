import vdf
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
                if 'Loadout' not in data['Bot']:
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
