#! /bin/bash

# Subtask 1
javac MatMulASCII.java
gcc -o toBinary toBinary.c

cat /dev/urandom | od | sed "s/\(.\)/\1 /g" | java MatMulASCII
./toBinary <<< "79 107 44 32 72 101 108 108 111 10"

# Subtask 2A
case $# in
    2)
        echo "2 arguments"
        ;;
    0)
        echo "0 arguments, Looping through all the valid options for Matrix Multiplication in current directory:"
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
        echo "Use 2 .mat files as arguments, one A?.mat and one B?.mat, either from this directory, or another,"
        ;;
esac

echo "End of program..."