/*
This program creates 2 2-dimensional matrixes and multiplies them.
Based on code from : https://www.cs.usfca.edu/~benson/cs326/pintos/pintos/src/examples/matmult.c
Made for a gem5 simulation.

compile with: arm-linux-gnueabihf-gcc --static matrixMult.c -omatrixMult
run with gem5: ./build/ARM/gem5.opt -d matrixMult configs/example/se.py --cmd="/home/konstantinos/gem5/tests/test-progs/C_programs/matrixMult" --cpu-type=MinorCPU --caches
*/

#include <stdio.h>
#include <stdlib.h>

#define DIM 10

int main()
{
    int A[DIM][DIM];
    int B[DIM][DIM];
    int C[DIM][DIM];

    int i,j,k;
    
    /* Initialize the matrices. */
    for (i = 0; i < DIM; i++)
        for (j = 0; j < DIM; j++)
        {
            A[i][j] = rand()%101;
            B[i][j] = rand()%101;
            C[i][j] = 0;
            
        }
    
    /* Multiply matrices. */
    for (i = 0; i < DIM; i++){	
        for (j = 0; j < DIM; j++){
            for (k = 0; k < DIM; k++){
                C[i][j] += A[i][k] * B[k][j];
                
            }
            printf("%8d ",C[i][j]);
        }   
        printf("\n");     
    }

    return 0;

    
}
