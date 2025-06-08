#! /usr/bin/python3

import sys
import argparse
import subprocess
import shlex
import json
from persed_args import parse_arguments

def main():
    #################################
    ### initialize the arguments
    #################################
    parsed_args, _, CLEAR_FLAG = parse_arguments()

    #################################
    ### Build the command
    #################################
    if parsed_args['maxdepth']: command_depth = f"-maxdepth {parsed_args['maxdepth']}"
    else: 
        if parsed_args['up']: command_depth = "-maxdepth 1"
        else: command_depth = ""

    if parsed_args['cut']: command_cut = " ".join([f"| grep -iv '{pattern}'" for pattern in parsed_args['cut']])
    else: command_cut = ""

    if parsed_args['grep_dir']: command_grep = " ".join([f"| grep -i '{pattern}'" for pattern in parsed_args['grep_dir']])
    else: command_grep = ""
    
    if parsed_args['grep_e_dir']: command_grep_e = " ".join([f"| grep -iE '{pattern}'" for pattern in parsed_args['grep_e_dir']])
    else: command_grep_e = ""

    if parsed_args['dir']: command_output_dir = "-type d"
    else: command_output_dir = ""

    if parsed_args['file']: command_output_file = "-type f"
    else: command_output_file = ""

    if parsed_args['pgrep']: command_pgrep = f"| xargs grep -iE '{parsed_args['pgrep']}'"
    else: command_pgrep = ""

    if parsed_args['input']:
        command_names = f" -iname '*{parsed_args['input'][0]}*'"
        command_names += " ".join([f" -a -iname '*{arg}*'" for arg in parsed_args['input'][1:]])
    else: command_names = ""

    run_command = f"find -L {command_depth} {command_output_dir} {command_output_file} {command_names} {command_cut} {command_grep} {command_grep_e} {command_pgrep}"
    
    #################################
    ### Execute the command
    #################################
    subprocess.run(run_command, shell=True)

    # print(parsed_args)

    #################################
    ### Print
    #################################
    if parsed_args['cmd']:
        print(f"cmd :: {run_command}")
    
    if parsed_args['show_options']:
        for key, value in parsed_args.items():
            print(f"{key} :: {value}")

if __name__ == "__main__":
    main()