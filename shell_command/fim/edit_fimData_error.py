import sys
import json
import os

class edit_fimData:
    def __init__(self):
        self.fimData = {}

    def update_fimData(self, argv):
        args = argv
        print(args)
        if '--input-fimData' in args:
            fimData_path = args[args.index('--input-fimData') + 1]
            if os.path.exists(fimData_path):
                with open(fimData_path, 'r') as json_file:
                    json_data = json.load(json_file)
                    self.fimData.update(json_data)
                    print("a")
            else:
                self._set_default_args()
                print("b")
        else:
            self._set_default_args()
            print("c")
        i = 0
        while i < len(args):
            arg = args[i]
            print(arg)
            if arg in ('--up',): self.fimData['up'] = True
            elif arg in ('-d', '--maxdepth'): i += 1; self.fimData['maxdepth'] = int(args[i])
            elif arg in ('--pg', '--pgrep'): i += 1; self.fimData['pgrep'] = args[i]
            # elif arg in ('--input-fimData'): i += 1; self.fimData['input_fimData_path'] = args[i]
            elif arg in ('--input-fimData'): i += 1; self.fimData['input_fimData_path'] = "hoge"
            elif arg in ('-g', '--grep-dir'): 
                i += 1
                self.fimData['grep_dir'].append(args[i])
                self.fimData['grep_dir'] = list(set(self.fimData['grep_dir']))
            elif arg in ('-e', '--grep_e-dir'):
                i += 1
                self.fimData['grep_e_dir'].append(args[i])
                self.fimData['grep_e_dir'] = list(set(self.fimData['grep_e_dir']))
            elif arg in ('-c', '--cut'):
                i += 1
                self.fimData['cut'].append(args[i])
                self.fimData['cut'] = list(set(self.fimData['cut']))
            elif arg in ('--fp', '--fullpath'): self.fimData['fullpath'] = True
            elif arg in ('--cmd',): self.fimData['cmd'] = True
            elif arg in ('--dir',): self.fimData['dir'] = True
            elif arg in ('--file',): self.fimData['file'] = True
            elif arg in ('--opt',): self.fimData['show_options'] = True
            
            else:
                self.fimData['input'].append(arg)
                self.fimData['input'] = list(set(self.fimData['input']))
            i += 1

        if '--clear' in args:
            self._set_default_args()
            self.fimData['clear_flag'] = True
        else:
            self.fimData['clear_flag'] = False

        return self.fimData
        
    def _set_default_args(self):
        self.fimData = {
            'up': False,
            'maxdepth': None,
            'input_fimData_path': None,
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


    def _reset_config_data(self):
        self.fimData = {
            'up': False,
            'fullpath': False,
            'cmd': False,
            'dir': False,
            'file': False,
            'show_options': False,
        }


    def _save_fimData(self):
        if self.fimData['input_fimData_path']:
            with open(self.fimData['input_fimData_path'], 'w') as json_file:
                json.dump(self.fimData, json_file)
        else:
            print("No input_fimData_path provided")

# Usage
# parser = ArgumentParser()
# parser.parse_arguments()
# print(parser.parsed_args, parser.ijson_file, parser.CLEAR_FLAG)