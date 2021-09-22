#! /bin/bash
# Subtask 1 Automatise compilation
javac MatMulASCII.java
gcc -o toBinary toBinary.c
# Subtask 2 Execution and data input
function run(){ # Function to run the java program, with a timer
    if [ -f $arg1 ] && [ -f $arg2 ] # Does the arguments exist as files?
    then
        let start=$(($(date +%s%N)/1000000)) # Saves the start time in ms
        cat $arg1 $arg2 | java MatMulASCII
        let end=$(($(date +%s%N)/1000000)) # End time
        let timing=end-start # Delta time 
        echo "Time to complete the matrix multiplication was $timing ms"
    fi
}
function error(){ # Error 
    echo "Use 0 arguments to loop trough all the valid Matrix Multiplications in the current directory."
    echo "Use 2 .mat files as arguments, one A*.mat and one B*.mat (where * is a number), like theese ones from current dir:"
    ls *.mat
}
case $# in # Check number of arguments
    2)
        DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd) # Current dir
        arg1=${DIR}/${1} # Adding the file exstention to the arguments
        arg2=${DIR}/${2}
        if [[ $arg1 == */*A*.mat ]] && [[ $arg2 == */*B*.mat ]] # A*.mat file first arg, B*.mat file second arg, and they both exist
        then
            run
        elif [[ $arg1 == */*B*.mat ]] && [[ $arg2 == */*A*.mat ]] # B*.mat file first arg, A*.mat file second arg, and they both exist
        then
            arg1=$arg2
            arg2=${DIR}/${1}
            run
        elif [[ $1 =~ [0-9] ]] && [[ $2 =~ [0-9] ]] # Numbers as arguments
        then
            arg1=A$1.mat
            arg2=B$2.mat
            run
        else
            echo "Error 2: At least one invalid argument, $1 or $2 "
            error
        fi
        ;;
    0)
        echo "Looping through all the valid combinations of .mat files for Matrix Multiplication in current directory:"
        set -- *.mat # Sets every .mat file as an entry in the arguments
        let totalTime=0 # Variable to time the running of the java program
        for arg1 in $@ # Nested for loops to get every combination
        do
            for arg2 in $@
            do
                if [[ $arg1 == A* ]] && [[ $arg2 == B* ]] # Select every valid combination for matrix multiplication
                then
                    echo "Multiplying $arg1 by $arg2"
                    run
                    totalTime=$((totalTime+$timing))
                fi
            done
        done
        if [[ $totalTime -gt 0 ]] # Prints the time if it is greater than 0
        then
            echo "Time to complete all matrix multiplications from current dir is $totalTime ms"
        fi
        ;;
    *)
        echo "ERROR 1: not 2 or 0 arguments"
        error
        ;;
esac