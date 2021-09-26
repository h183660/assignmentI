#! /bin/bash
# Subtask 1 Automatise compilation
javac MatMulASCII.java
gcc -o toBinary toBinary.c
# Subtask 2 Execution and data input
function run(){ # Function to run the java program, with a timer
        let start=$(($(date +%s%N)/1000000)) # Saves the start time in ms
        cat $1 $2 | java MatMulASCII
        let timing=$(($(date +%s%N)/1000000))-start # Delta time 
        echo "Time to complete the matrix multiplication was $timing ms"
}
function error(){ # Error message
    echo "Use 0 arguments to loop trough all the valid Matrix Multiplications in the current directory."
    echo "Use 2 .mat files as arguments, one A*.mat and one B*.mat (where * is a number), like these ones from the current dir:"
    ls *.mat
    exit $1
}
case $# in # Check number of arguments
    2)
        if [[ $1 == *A*.mat ]] && [[ $2 == *B*.mat ]]; then # A*.mat file first arg, B*.mat file second arg
            arg1=$1 # Adding the file exstention to the arguments
            arg2=$2
        elif [[ $1 == *B*.mat ]] && [[ $2 == *A*.mat ]]; then # B*.mat file first arg, A*.mat file second arg
            arg1=$2
            arg2=$1
        elif [[ $1 -ge 0 ]] && [[ $2 -ge 0 ]]; then # Numbers as arguments
            arg1=A$1.mat
            arg2=B$2.mat
        else
            echo "Error 3: Both arguments $1 and $2 need to be .mat files, one A*.mat file and one B*.mat file, the numbers also work as arguments"
            error 3
        fi
        if [ -f $arg1 ] && [ -f $arg2 ]; then # Does the arguments exist as files?
            run $arg1 $arg2
        else
            echo "Error 2: Both $1 and $2 have to exist as one A and one B .mat file"
            error 2
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
                if [[ $arg1 == A* ]] && [[ $arg2 == B* ]]; then # Select every valid combination for matrix multiplication
                    echo "Multiplying $arg1 by $arg2"
                    run $arg1 $arg2
                    totalTime=$((totalTime+$timing))
                fi
            done
        done
        if [[ $totalTime -gt 0 ]]; then # Prints the time if it is greater than 0
            echo "Time to complete all matrix multiplications from current dir is $totalTime ms"
        fi
        ;;
    *)
        echo "ERROR 1: not 2 or 0 arguments"
        error 1
        ;;
esac