#!/bin/bash

# Read input argument for number of directories to create
if [ $# -eq 0 ]
  then
    echo "Error: Number of directories not specified. Usage: create-monorepo.sh <number_of_directories>"
    exit 1
fi

# Create directories
for ((i=1;i<=$1;i++)); do
  dir_name="tf_$i"
  mkdir "$dir_name"
  cd "$dir_name"
  # Create simple Terraform configuration file
  cat > main.tf <<EOF
output "hello_message" {
  value = "Hello from directory $dir_name!"
}
EOF
  cd ..
done
