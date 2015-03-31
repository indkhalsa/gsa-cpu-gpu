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
    int best_idx, d;
    int n_pop=5, n_dim=2, i=0, max_i=100, func=0;
    double min=0.0, max=0.0, alpha=20, g0=100, epsilon=0.1;
    double g, best, worst, best_z;
    double *position, *velocity, *acceleration, *x_min, *x_max, *fitness, *mass, *inertia_mass, *force, *best_x;
    struct timeval tvBegin, tvEnd, tvDiff;

    // Initialize
    init_params( argc, argv, &n_pop, &n_dim, &min, &max, &max_i, &alpha, &g0, &epsilon, &func );

    if( func == 1 ) objective_function = &de_jong;
    else if( func == 2 ) objective_function = &sphere;
    else if( func == 3 ) objective_function = &rotated_hyper_ellipsoid;
    else if( func == 4 ) objective_function = &rosenbrock;
    else if( func == 5 ) objective_function = &rastrigin;
    else if( func == 6 ) objective_function = &schwefel;
    else if( func == 7 ) objective_function = &griewangk;
    else if( func == 8 ) objective_function = &ackley;
    else if( func == 9 ) objective_function = &michalewicz;
    else return -1;

    position = (double *) calloc( n_pop * n_dim, sizeof(double) );
    velocity = (double *) calloc( n_pop * n_dim, sizeof(double) );
    acceleration = (double *) calloc( n_pop * n_dim, sizeof(double) );
    x_min = (double *) calloc( n_dim, sizeof(double) );
    x_max = (double *) calloc( n_dim, sizeof(double) );
    fitness = (double *) calloc( n_pop, sizeof(double) );
    mass = (double *) calloc( n_pop, sizeof(double) );
    inertia_mass = (double *) calloc( n_pop, sizeof(double) );
    force = (double *) calloc( n_pop * n_dim, sizeof(double) );
    best_x = (double *) calloc( n_dim, sizeof(double) );

    gettimeofday(&tvBegin, NULL);

    init_gsa( n_pop, n_dim, min, max, x_min, x_max, velocity, position );

    // Start iterations
    while( i<max_i )
    {
        // Update fitness
        get_fitness( n_pop, n_dim, position, fitness );

        // Get G constant
        g = get_gconst( alpha, g0, i, max_i );

        // Get best & worst fitness    
        best_idx = get_best_worst( n_pop, fitness, &best, &worst );

        // Save best solution
        if( (i == 0) || (best < best_z) )
        {
            best_z = best;
            save_solution( n_dim, position, best_idx, best_x );
        }
    
        // Calculate inertia masses
        get_inertia_masses( n_pop, best, worst, fitness, mass, inertia_mass );

        // Calculate forces
        get_forces( n_pop, n_dim, epsilon, position, inertia_mass, force );

        // Update agents
        update_agents( n_pop, n_dim, g, force, x_min, x_max, velocity, position );

        i++;
    }

    gettimeofday(&tvEnd, NULL);
    timeval_subtract(&tvDiff, &tvEnd, &tvBegin);

    // Show best solution
    printf( "\nAfter %d iterations...\n\n", max_i );
    show_solution( n_dim, best_z, best_x );  
    printf("t: %ld.%06ld s\n\n", tvDiff.tv_sec, tvDiff.tv_usec);

    free( position ); free( velocity ); free( acceleration ); free( x_min ); free( x_max ); 
    free( fitness ); free( mass ); free( inertia_mass ); free( force ); free( best_x );
    return 0;
}
