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

#include "gsa.h"

void get_forces( int n_pop, int n_dim, double epsilon, double *position, double *intertia_mass, double *force )
{
    int d, p, k;
    double r;

    for( p=0; p<n_pop; p++ )
    {
        for( d=0; d<n_dim; d++ )
        {
            force[d+p*n_dim] = 0.0;

            for( k=0; k<n_pop; k++ )
            {
                if( k != p )
                {
                    r = p_norm_distance( n_dim, &position[k*n_dim], &position[p*n_dim] );

                    force[d+p*n_dim] = force[d+p*n_dim] + ( get_rand() * intertia_mass[k] * (position[d+k*n_dim] - position[d+p*n_dim]) / (r + epsilon) );
                }
            }
        }
    }
}
