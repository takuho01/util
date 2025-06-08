#! /usr/bin/python3

import sys
import argparse
import subprocess
import shlex
import json
import os
from persed_args import parse_arguments

def main():
    #################################
    ### initialize the arguments
    #################################
    parsed_args, ijson_file, CLEAR_FLAG = parse_arguments()

    print(ijson_file)
    #################################
    ### gen input json file
    #################################
    if CLEAR_FLAG:
        if os.path.exists(ijson_file):
            os.remove(ijson_file)
        print("CLEAR")
    else:
        with open(ijson_file, 'w') as json_file:
            json.dump(parsed_args, json_file, indent=4)

if __name__ == "__main__":
    main()