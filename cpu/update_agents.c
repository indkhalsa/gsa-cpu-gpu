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

#include "gsa.h"

void update_agents( int n_pop, int n_dim, double g, double *force, double *x_min, double *x_max, double *velocity, double *position )
{
    int d, p;
  
    for( p=0; p<n_pop; p++)
    {
        for(d=0; d<n_dim; d++)
        {
            velocity[d+p*n_dim] = (get_rand() * velocity[d+p*n_dim]) + (g * force[d+p*n_dim]);
	
            if( ((position[d+p*n_dim] + velocity[d+p*n_dim]) < x_min[d]) || ((position[d+p*n_dim] + velocity[d+p*n_dim]) > x_max[d]) )
            {
                position[d+p*n_dim] = get_rand() * (x_max[d] - x_min[d]) + x_min[d];
            }
            else
            {
                position[d+p*n_dim] = position[d+p*n_dim] + velocity[d+p*n_dim];
            }
        }
    }
}
