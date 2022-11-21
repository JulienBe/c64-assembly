#!/bin/bash

# Build with kick assembler located in the toolchain directory.
# Requires Java 11 or higher.
#
# Run the project using Vice, which is expected to be available in the path under x64sc.

filename=$(basename "$1" .asm)

rm -f "$filename".prg
rm -f "$filename".sym

echo "###################### Compiling $1 ######################"
java -jar toolchain/KickAss.jar "$filename".asm

echo "###################### Running $filename ######################"
x64sc "$filename".prg