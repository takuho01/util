#! /usr/bin/python3

import sys
import argparse
import subprocess
import shlex
import json
import os
from edit_fimData import edit_fimData

def main():
    #################################
    ### initialize the arguments
    #################################
    fim_data_editor = edit_fimData()
    print(sys.argv[1:])
    args = sys.argv[1:]
    fimData = fim_data_editor.update_fimData(args)

    print(fimData)
    #################################
    ### gen input json file
    #################################
    # if CLEAR_FLAG:
    #     if os.path.exists(ijson_file):
    #         os.remove(ijson_file)
    #     print("CLEAR")
    # else:
    #     with open(ijson_file, 'w') as json_file:
    #         json.dump(parsed_args, json_file, indent=4)

if __name__ == "__main__":
    main()