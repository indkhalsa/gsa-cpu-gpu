/*
    Get the total force in different directions.

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

#ifndef _GET_FORCES_
#define _GET_FORCES_

#include "gsa.h"

__global__ void get_forces( int n_pop, int n_dim, float epsilon, float *position, float *inertia_mass, float *force, curandState *devState )
{
    int d, l, k, p=blockIdx.x;
    float r, sum;

    for( d=0; d<n_dim; d++ )
    {
        force[d+p*n_dim] = 0.0f;

        for( k=0; k<n_pop; k++ )
        {
            if( k != p )
            {
                sum = 0.0f;

                for( l=0; l<n_dim; l++ )
                {
                    sum = sum + powf( (position[l+k*n_dim] - position[l+p*n_dim]), 2 );
                }

                r = powf( sum, 0.5 );

                force[d+p*n_dim] = force[d+p*n_dim] + ( curand_uniform(&devState[p]) * inertia_mass[k] * (position[d+k*n_dim] - position[d+p*n_dim]) / (r + epsilon) );
            }
        }
    }
}

#endif
