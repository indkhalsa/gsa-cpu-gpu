/*
    Gravitational search algorithm initialization.

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

#ifndef _INIT_GSA_
#define _INIT_GSA_

#include "gsa.h"

__global__ void init_gsa( int n_dim, float min, float max, float *x_min, float *x_max, float *position, float *velocity, curandState *devState, unsigned int seed )
{
    int d, p=blockIdx.x;

    curand_init( seed, p, 0, &devState[p] );

    if( p == 0 )
    {
        // Boundaries
        for( d=0; d<n_dim; d++ )
        {
            x_min[d] = min;
            x_max[d] = max;
        }
    }

    for( d=0; d<n_dim; d++ )
    {
        // Position
        position[d+p*n_dim] = curand_uniform(&devState[p]) * (x_max[d] - x_min[d]) + x_min[d];

        // Velocity
        velocity[d+p*n_dim] = 0.0f;
    }
}

#endif
