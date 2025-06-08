import sys
import json
import os

def parse_arguments():
    args = sys.argv[1:]
    parsed_args = {}

    if '--ijson_update' in args:
        ijson_file = args[args.index('--ijson_update') + 1]
        if os.path.exists(ijson_file):
            with open(ijson_file, 'r') as json_file:
                json_data = json.load(json_file)
                parsed_args.update(json_data)
                # options should not be updated.
                parsed_args['up'] = False
                parsed_args['cmd'] = False
                parsed_args['dir'] = False
                parsed_args['file'] = False
                parsed_args['show_options'] = False
                parsed_args['fullpath'] = False
        else:
            parsed_args = {
                'up': False,
                'maxdepth': None,
                'grep_dir': [],
                'grep_e_dir': [],
                'cut': [],
                'fullpath': False,
                'cmd': False,
                'dir': False,
                'file': False,
                'pgrep': None,
                'input': [],
                'show_options': False,
            }
    elif '--ijson' in args:
        ijson_file = args[args.index('--ijson') + 1]
        if os.path.exists(ijson_file):
            with open(ijson_file, 'r') as json_file:
                json_data = json.load(json_file)
                parsed_args.update(json_data)
        else:
            parsed_args = {
                'up': False,
                'maxdepth': None,
                'grep_dir': [],
                'grep_e_dir': [],
                'cut': [],
                'fullpath': False,
                'cmd': False,
                'dir': False,
                'file': False,
                'pgrep': None,
                'input': [],
                'show_options': False,
            }
    else:
        parsed_args = {
            'up': False,
            'maxdepth': None,
            'grep_dir': [],
            'grep_e_dir': [],
            'cut': [],
            'fullpath': False,
            'cmd': False,
            'dir': False,
            'file': False,
            'pgrep': None,
            'input': [],
            'show_options': False,
        }

    if '--clear' in args: CLEAR_FLAG = True
    else: CLEAR_FLAG = False
    
    i = 0
    while i < len(args):
        arg = args[i]
        if arg in ('--up',): parsed_args['up'] = True
        elif arg in ('-d', '--maxdepth'): i += 1; parsed_args['maxdepth'] = int(args[i])
        elif arg in ('--pg', '--pgrep'): i += 1; parsed_args['pgrep'] = args[i]
        
        elif arg in ('-g', '--grep-dir'): i += 1; parsed_args['grep_dir'].append(args[i]); parsed_args['grep_dir'] = list(set(parsed_args['grep_dir']))
        elif arg in ('-e', '--grep_e-dir'): i += 1; parsed_args['grep_e_dir'].append(args[i]); parsed_args['grep_e_dir'] = list(set(parsed_args['grep_e_dir']))
        elif arg in ('-c', '--cut'): i += 1; parsed_args['cut'].append(args[i]); parsed_args['cut'] = list(set(parsed_args['cut']))
        
        elif arg in ('--fp', '--fullpath'): parsed_args['fullpath'] = True
        elif arg in ('--cmd',): parsed_args['cmd'] = True
        elif arg in ('--dir',): parsed_args['dir'] = True
        elif arg in ('--file',): parsed_args['file'] = True
        elif arg in ('--opt',): parsed_args['show_options'] = True
        
        elif arg in ('--ijson',): i += 1;
        elif arg in ('--ijson_update',): i += 1;
        
        else: parsed_args['input'].append(arg); parsed_args['input'] = list(set(parsed_args['input']))
        i += 1

    return parsed_args, ijson_file if '--ijson' or '--ijson_update' in args else None, CLEAR_FLAG
