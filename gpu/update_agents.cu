/*
    Update velocity and position of each agent.

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

#ifndef _UPDATE_AGENTS_
#define _UPDATE_AGENTS_

#include "gsa.h"

__global__ void update_agents( int n_dim, float *g, float *force, float *x_min, float *x_max, float *velocity, float *position, curandState *devState )
{
    int d, p=blockIdx.x;

    for(d=0; d<n_dim; d++)
    {
        velocity[d+p*n_dim] = ( curand_uniform(&devState[p]) * velocity[d+p*n_dim] ) + ( *g * force[d+p*n_dim] );

        if( ((position[d+p*n_dim] + velocity[d+p*n_dim]) < x_min[d]) || ((position[d+p*n_dim] + velocity[d+p*n_dim]) > x_max[d]) )
        {
            position[d+p*n_dim] = curand_uniform(&devState[p]) * ( x_max[d] - x_min[d] ) + x_min[d];
        }

        else
        {
            position[d+p*n_dim] = position[d+p*n_dim] + velocity[d+p*n_dim];
        }
    }
}

#endif
