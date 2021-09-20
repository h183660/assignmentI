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


function error(){
        echo "Use 0 arguments to loop trough all the valid Matrix Multiplications in the current directory."
        echo "Use 2 .mat files as arguments, one A*.mat and one B*.mat (where * is a number), like theese ones:"
        ls *.mat
}

case $# in
    2)
        if [[ $arg1 == */*A*.mat ]] && [[ $arg2 == */*B*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ] # A*.mat file first arg, B*.mat file second arg, and they both exist
        then
            let start=$(($(date +%s%N)/1000000))
            cat $arg1 $arg2 | java MatMulASCII
            let end=$(($(date +%s%N)/1000000))
        elif [[ $arg1 == */*B*.mat ]] && [[ $arg2 == */*A*.mat ]] && [ -f $arg1 ] && [ -f $arg2 ] # B*.mat file first arg, A*.mat file second arg, and they both exist
        then
            let start=$(($(date +%s%N)/1000000))
            cat $arg2 $arg1 | java MatMulASCII
            let end=$(($(date +%s%N)/1000000))
        elif [[ $1 =~ [0-9] ]] && [[ $2 =~ [0-9] ]] && [ -f A$1.mat ] && [ -f B$2.mat ] # Numbers as arguments and files exist in current directory
        then
            let start=$(($(date +%s%N)/1000000))
            cat A$1.mat B$2.mat | java MatMulASCII 
            let end=$(($(date +%s%N)/1000000))
        else
            echo "Invalid argument, $1 or $2 "
            error
        fi

        let timing=end-start
        if [[ $timing -gt 0 ]]
        then
            echo "Time to complete the matrix multiplication of $1 and $2 was $timing ms"
        fi
        ;;
    0)
        echo "Looping through all the valid combinations of .mat files for Matrix Multiplication in current directory:"

        ls *.mat # Prints every .mat file in the current directory
        set -- *.mat # Sets every .mat file as an entry in the arguments
        let totalTime=0

        for arg1 in $@ # Nested for loops to get every combination
        do
            for arg2 in $@
            do
                if [[ $arg1 == A* ]] && [[ $arg2 == B* ]] # Select every valid combination for matrix multiplication
                then
                    echo $arg1 $arg2
                    let start=$(($(date +%s%N)/1000000))
                    cat $arg1 $arg2 | java MatMulASCII
                    let end=$(($(date +%s%N)/1000000))
                    let timing=end-star
                    totalTime=$(($totaltime+$timing))
                fi
            done
        done

        if [[ $totalTime -gt 0 ]]
        then
            echo "Time to complete all matrix multiplications from current dir is $totalTime ms"
        fi
        ;;
    *)
        echo "ERROR 1: not 2 or 0 arguments"
        error
        ;;
esac