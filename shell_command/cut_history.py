def edit_command_history(history_file_path, except_cmds):
    """
    Edit the command history file by removing duplicate commands and 
    commands listed in except_cmds.
    
    :param history_file_path: Path to the command history file.
    :param except_cmds: List of commands to be excluded.
    """
    try:
        # Read the history file
        with open(history_file_path, 'r') as file:
            commands = file.readlines()

        # Reverse the list to start from the last command
        commands.reverse()

        # print(commands)
        # print("hoge")

        # Process commands
        unique_commands = []
        for cmd in commands:
            cmd = cmd.strip()
            if cmd not in unique_commands and cmd not in except_cmds:
                unique_commands.append(cmd)

        # Reverse again to maintain the order
        unique_commands.reverse()

        # Write the processed commands back to the file
        with open(history_file_path, 'w') as file:
            for cmd in unique_commands:
                file.write(cmd + '\n')

        return "History file edited successfully."
    
    except Exception as e:
        return f"An error occurred: {e}"

# Example usage
history_file = '/home/takuho/history.txt'  # Replace with the actual path to your history file
except_commands = ['cd', 'less', 'ls', 'history', 'tcsh']
edit_command_history(history_file, except_commands)