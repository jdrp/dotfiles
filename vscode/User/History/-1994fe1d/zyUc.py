# make_compile_commands_relative.py

import json
import os
import sys

def make_paths_relative(compile_commands_path, project_root):
    with open(compile_commands_path, 'r') as f:
        data = json.load(f)

    for entry in data:
        # Make 'directory' relative
        entry_dir = os.path.relpath(entry['directory'], project_root)
        entry['directory'] = entry_dir

        # Make 'file' relative
        entry_file = os.path.relpath(entry['file'], project_root)
        entry['file'] = entry_file

        # Modify 'command' to have relative paths
        # Split the command into parts
        command_parts = entry['command'].split()
        # Replace absolute file path with relative path
        abs_file_path = entry['file']
        rel_file_path = entry_file
        try:
            index = command_parts.index(abs_file_path)
            command_parts[index] = rel_file_path
        except ValueError:
            pass  # File path not found in command

        # Reconstruct the command
        entry['command'] = ' '.join(command_parts)

    # Write back to the file
    with open(compile_commands_path, 'w') as f:
        json.dump(data, f, indent=2)

if __name__ == "__main__":
    if len(sys.argv) != 3:
        print("Usage: python make_compile_commands_relative.py <compile_commands.json> <project_root>")
        sys.exit(1)

    compile_commands_path = sys.argv[1]
    project_root = sys.argv[2]

    make_paths_relative(compile_commands_path, project_root)
    print(f"Updated {compile_commands_path} with relative paths.")
