#! /bin/bash

# Subtask 1
javac MatMulASCII.java
gcc -o toBinary toBinary.c

cat /dev/urandom | od | sed "s/\(.\)/\1 /g" | java MatMulASCII
./toBinary <<< "79 107 44 32 72 101 108 108 111 10"

# Subtask 2A

# Current dir 
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

# Filepath for the arguments
arg1="${DIR}/${1}"
arg2="${DIR}/${2}"

# Timing start counter
let start=$(($(date +%s%N)/1000000))

case $# in
    2)
        echo "2 Arguments"
        if [[ $1 == A*.mat ]] && [[ $2 == B*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ]
        then
            echo "A*.mat first arg, B*.mat second arg, and both exist in current directory"
            cat $* | java MatMulASCII
             cat $arg1 $arg2 | java MatMulASCII
        elif [[ $1 == B*.mat ]] && [[ $2 == A*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ]
        then
            echo "B*.mat first arg, A*.mat second arg, and both exist in current directory"
            cat $2 $1 | java MatMulASCII
        elif [[ $1 =~ [0-9] ]] && [[ $2 =~ [0-9] ]] && [ -f A$1.mat ] && [ -f B$2.mat ]
        then
            echo "Numbers as arguments and files exist in current directory"
            cat A$1.mat B$2.mat | java MatMulASCII
        elif [[ $arg1 == */*A*.mat ]] && [[ $arg2 == */*B*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ]
        then
            echo "A*.mat first arg, B*.mat second arg, at least one file in different directory and they both exist"
            cat $arg1 $arg2 | java MatMulASCII
        elif [[ $arg1 == */*B*.mat ]] && [[ $arg2 == */*A*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ]
        then
            echo "B*.mat first arg, A*.mat second arg, at least one file in different directory and they both exist"
            cat $arg2 $arg1 | java MatMulASCII
        else
            echo "Error $arg1 or $arg2 is not valid file paths"
            echo "Valid files from this directory:"
            ls *.mat
            echo "Use one A and one B file as arguments..."
            echo "Also works with files from different directories, like otherdir/A7.mat or ../B3.mat"
            echo "You can even use numbers as arguments where the first number is the A file and the second number is the B file, both from this directory..."
        fi
        ;;
    0)
        echo "Looping through all the valid combinations of .mat files for Matrix Multiplication in current directory:"

        ls *.mat # Prints every .mat file in the current directory
        set -- *.mat # Sets every .mat file as an entry in the arguments
        
        for arg1 in $@ # Nested for loops to get every combination
        do
            for arg2 in $@
            do
                if [[ $arg1 == A* ]] && [[ $arg2 == B* ]] # Select every valid combination for matrix multiplication
                then
                    echo $arg1 $arg2
                    cat $arg1 $arg2 | java MatMulASCII
                fi
            done
        done
        ;;
    *)
        echo "ERROR: not 2 or 0 arguments"
        echo "Use 0 arguments to loop trough all the valid Matrix Multiplications in the current directory."
        echo "Use 2 .mat files as arguments, one A?.mat and one B?.mat (where ? is a number), like theese ones:"
        ls A*.mat
        echo "and"
        ls B*.mat
        echo "You can also use files from different directories by using .. , /otherdir/ and so on..."
        ;;
esac

let end=$(($(date +%s%N)/1000000))
let timing=end-start
echo "Time to complete: $timing ms"