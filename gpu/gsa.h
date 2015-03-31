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

#ifndef gsa_h
#define gsa_h

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <time.h>
#include <sys/time.h>
#include <cuda.h>
#include <curand_kernel.h>

__global__ void init_gsa( int, float, float, float *, float *, float *, float *, curandState *, unsigned int );
__global__ void get_fitness( int, int, float *, float * );
__global__ void get_gconst( int, int, float, float, float * );
__global__ void get_best_worst( int, float *, float *, float * );
__global__ void get_mass( float *, float *, float *, float * );
__global__ void get_sum_masses( int, float *, float * );
__global__ void get_inertia_mass( float *, float *, float * );
__global__ void get_forces( int, int, float, float *, float *, float *, curandState * );
__global__ void update_agents( int, float *, float *, float *, float *, float *, float *, curandState * );
int timeval_subtract( struct timeval *, struct timeval *, struct timeval * );
void init_params( int, char **, int *, int *, float *, float *, int *, float *, float *, float *, int * );
void usage( void );
int get_best_solution( int, float * );

#endif
