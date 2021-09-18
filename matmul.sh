#! /bin/bash

# Subtask 1
javac MatMulASCII.java
gcc -o toBinary toBinary.c

cat /dev/urandom | od | sed "s/\(.\)/\1 /g" | java MatMulASCII
./toBinary <<< "79 107 44 32 72 101 108 108 111 10"

# Subtask 2A
