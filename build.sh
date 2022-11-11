#!/bin/bash

# Pass only the name of the file without extension.
#
# Build with kick assembler located in the toolchain directory.
# Requires Java 11 or higher.
#
# Run the project using Vice, which is expected to be available in the path under x64sc.

echo "Compiling $1"
java -jar toolchain/KickAss.jar "$1".asm

echo "Running $1"
x64sc "$1".prg