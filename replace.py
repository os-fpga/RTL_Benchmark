import re

def remove_lines_with_expression(file_path, expression_to_remove):
    # try:
    # Open the file for reading
    with open(file_path, 'r') as file:
        # Read all lines into a list
        lines = file.readlines()

    # Open the file for writing, truncating it
    with open(file_path, 'w') as file:
        for line in lines:
            # Check if the expression is not present in the line
            if expression_to_remove not in line:
                # Write the line back to the file
                file.write(line)

def replace_pattern_in_file(file_path, search_pattern, replace_pattern):
    with open(file_path, 'r') as file:
        content = file.read()

    updated_content = re.sub(search_pattern, replace_pattern, content)

    with open(file_path, 'w') as file:
        file.write(updated_content)

def append_new_line(file_path, new_line):
    with open(file_path, 'a') as file:
        file.write(new_line + '\n')

def replace_write_verilog(file_path):
    with open(file_path, 'r') as file:
        lines = file.readlines()

    with open(file_path, 'w') as file:
        for line in lines:
            if "synth_rs " in line:
                file.write("synth_rs -tech ${ARCHITECTURE} ${SYNTH_SETTING}\n")
            else:
                file.write(line)

def main():
    input_file = "path_list.txt"  # File containing list of file paths line by line

    search_pattern = r"verific -vlog2k \${ROOT_PATH}"
    replace_pattern = "read_verilog  -I${ROOT_PATH}/${RTL_PATH} ${ROOT_PATH}"

    with open(input_file, 'r') as file:
        file_paths = file.readlines()

    for file_path in file_paths:
        file_path = file_path.strip()
        # try:
        #     append_new_line(file_path, "write_verilog -noexpr -nohex ${TOP}_post_synth.v")
        # except:
        #     pass
        # try:
        #     remove_lines_with_expression(file_path, "verific -import")
        # except:
        #     pass
        # try:
        #     replace_write_verilog(file_path)
        # except:
        #     pass
        try:
            replace_pattern_in_file(file_path, search_pattern, replace_pattern)
        except:
            pass

if __name__ == "__main__":
    main()