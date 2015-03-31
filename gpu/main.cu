/*
    Copyright (C) 2011  Edgard Nikitiuk <edgnik@gmail.com>
 
    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.
 
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
 
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

#include "gsa.h"

int main( int argc, char **argv )
{
    // Host variables
    int d, p;
    int n_pop=5, n_dim=2, i=0, max_i=100, func=1;
    float min=0.0, max=0.0, alpha=20, g0=100, epsilon=0.1;
    float *x, *z;
    struct timeval tvBegin, tvEnd, tvDiff;

    // Device variables
    curandState *devState;
    float *sum, *g, *best, *worst;  
    float *position, *velocity, *acceleration, *x_min, *x_max, *fitness, *mass, *inertia_mass, *force;

    // Initialize
    init_params( argc, argv, &n_pop, &n_dim, &min, &max, &max_i, &alpha, &g0, &epsilon, &func );

    cudaMalloc( (void **)&devState, n_pop * sizeof(curandState) );

    cudaMalloc( (void **)&sum, sizeof(float) );
    cudaMalloc( (void **)&g, sizeof(float) );
    cudaMalloc( (void **)&best, sizeof(float) );
    cudaMalloc( (void **)&worst, sizeof(float) );

    cudaMalloc( (void **)&position, n_pop * n_dim * sizeof(float) );
    cudaMalloc( (void **)&velocity, n_pop * n_dim * sizeof(float) );
    cudaMalloc( (void **)&acceleration, n_pop * n_dim * sizeof(float) );
    cudaMalloc( (void **)&x_min, n_dim * sizeof(float) );
    cudaMalloc( (void **)&x_max, n_dim * sizeof(float) );
    cudaMalloc( (void **)&fitness, n_pop * sizeof(float) );
    cudaMalloc( (void **)&mass, n_pop * sizeof(float) );
    cudaMalloc( (void **)&inertia_mass, n_pop * sizeof(float) );
    cudaMalloc( (void **)&force, n_pop * n_dim * sizeof(float) );

    x = (float *)calloc( n_pop * n_dim, sizeof(float) );
    z = (float *)calloc( n_pop, sizeof(float) );

    gettimeofday(&tvBegin, NULL);

    init_gsa<<<n_pop, 1>>>( n_dim, min, max, x_min, x_max, position, velocity, devState, (unsigned int)time(NULL) );

    // Start
    while( i<max_i )
    {
        get_fitness<<<n_pop, 1>>>( func, n_dim, position, fitness );
        get_gconst<<<1, 1>>>( i, max_i, alpha, g0, g );
        get_best_worst<<<1, 1>>>( n_pop, fitness, best, worst );
        get_mass<<<n_pop, 1>>>( best, worst, fitness, mass );
        get_sum_masses<<<1, 1>>>( n_pop, mass, sum );
        get_inertia_mass<<<n_pop, 1>>>( mass, sum, inertia_mass );
        get_forces<<<n_pop, 1>>>( n_pop, n_dim, epsilon, position, inertia_mass, force, devState );
        update_agents<<<n_pop, 1>>>( n_dim, g, force, x_min, x_max, velocity, position, devState );

        i++;
    }

    gettimeofday(&tvEnd, NULL);
    timeval_subtract(&tvDiff, &tvEnd, &tvBegin);

    cudaMemcpy( x, position, n_pop * n_dim * sizeof(float), cudaMemcpyDeviceToHost );
    cudaMemcpy( z, fitness, n_pop * sizeof(float), cudaMemcpyDeviceToHost );

    // Get best solution
    p = get_best_solution( n_pop, z );

    // Show solution  
    printf( "\nAfter %d iterations...\n\n", max_i );

    for( d=0; d<n_dim; d++ )
    {
        printf( "x(%d): %f\n", d+1, x[d+p*n_dim] );
    }

    printf( "\nz: %f\n\n", z[p] );

    printf("t: %ld.%06ld s\n\n", tvDiff.tv_sec, tvDiff.tv_usec);

    // Free memory  
    cudaFree( devState ); cudaFree( sum ); cudaFree( g ); cudaFree( best ); cudaFree( worst );
    cudaFree( position ); cudaFree( velocity ); cudaFree( acceleration ); cudaFree( x_min ); cudaFree( x_max );
    cudaFree( fitness ); cudaFree( mass ); cudaFree( inertia_mass ); cudaFree( force ); free( x ); free( z );

    return 0;
}
