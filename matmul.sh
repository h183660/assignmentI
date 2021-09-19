#! /bin/bash

# Subtask 1
javac MatMulASCII.java
gcc -o toBinary toBinary.c

cat /dev/urandom | od | sed "s/\(.\)/\1 /g" | java MatMulASCII
./toBinary <<< "79 107 44 32 72 101 108 108 111 10"

# Subtask 2A

# Current dir in a string (used for running .mat files from other directories)
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd)

case $# in
    2)
        echo "2 Arguments"
        if [[ $1 == A*.mat ]] && [[ $2 == B*.mat ]] && [ -f $1 ] && [ -f $2 ]
        then
            echo "A*.mat first arg, B*.mat second arg, and both exist in current directory"
            cat $* | java MatMulASCII
        elif [[ $1 == B*.mat ]] && [[ $2 == A*.mat ]] && [ -f $1 ] && [ -f $2 ]
        then
            echo "B*.mat first arg, A*.mat second arg, and both exist in current directory"
            cat $2 $1 | java MatMulASCII
        elif [[ $1 =~ [0-9] ]] && [[ $2 =~ [0-9] ]] && [ -f A$1.mat ] && [ -f B$2.mat ]
        then
            echo "Numbers as arguments and files exist in current directory"
            cat A$1.mat B$2.mat | java MatMulASCII
        elif [[ $1 == */*A*.mat ]] && [[ $2 == */*B*.mat ]]
        then
            arg1="${DIR}/${1}"
            arg2="${DIR}/${2}"
            echo "A*.mat first arg, B*.mat second arg, files in different directory and they exist"
            cat $arg1 $arg2 | java MatMulASCII
        elif [[ $1 == */*B*.mat ]] && [[ $2 == */*A*.mat ]]
        then
            arg1="${DIR}/${1}"
            arg2="${DIR}/${2}"
            echo "B*.mat first arg, A*.mat second arg, files in different directory and they exist"
            cat $arg2 $arg1 | java MatMulASCII
        fi
        ;;
    0)
        echo "0 Arguments, Looping through all the valid options for Matrix Multiplication in current directory:"
        ls *.mat
        set -- *.mat
        
        for arg1 in $@
        do
            for arg2 in $@
            do
                if [[ $arg1 == A* ]] && [[ $arg2 == B* ]]
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


# Timing start counter
let start=$(($(date +%s%N)/1000000))
let end=$(($(date +%s%N)/1000000))
let timing=end-start
echo "Time to complete: $timing ms"