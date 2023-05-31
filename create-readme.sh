#!/bin/bash

# Function to recursively create README.md in all subdirectories
create_readme() {
    for dir in $(find . -type d)
    do
        # Extract the base directory name from the directory path
        base_dir=$(basename "$dir")
        readme_content="This is the README file for ${base_dir}."
        echo "$readme_content" > "$dir/README.md"
    done
}

# Call the function
create_readme
