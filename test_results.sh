#!/bin/bash

# Path to the codebase
codebase_dir="/path/to/codebase"

# Command to run tests
test_command="./run_tests.sh"

# File to save test results
results_file="test_results.txt"

# Navigate to the codebase directory
cd "$codebase_dir"

# Run tests and capture the output
test_output=$($test_command)

# Save test results to a file
echo "$test_output" > "$results_file"

# Check if tests passed or failed
if grep -q "All tests passed" "$results_file"; then
    echo "Tests passed!"
else
    echo "Tests failed. Check $results_file for details."
fi