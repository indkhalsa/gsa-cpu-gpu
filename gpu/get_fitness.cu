/*
    Get the fitness value of each agent according to their position.

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

#ifndef _GET_FITNESS_
#define _GET_FITNESS_

#include "gsa.h"

__global__ void get_fitness( int func, int n_dim, float *position, float *fitness )
{
    int i, j, d, m=10, p=blockIdx.x;
    float pi = 3.141592654f, a=20.0f, b=0.2f, c=2*pi;
    float sum=0.0f, sum_i=0.0f, sum_j=0.0f, sum_pow=0.0f, sum_cos=0.0f, prod_cos=0.0f;

    switch( func )
    {
        // De Jong
        case 1:
            for( d=0; d<n_dim; d++ )
            {
                sum = sum + powf(position[d+p*n_dim], 2);
            }

            fitness[p] = sum;
            break;

        // Sphere
        case 2:
            for( d=0; d<n_dim; d++ )
            {
                sum = sum + ( (d+1) * powf(position[d+p*n_dim], 2) );
            }

            fitness[p] = sum;
            break;

        // Rotated hyper-ellipsoid
        case 3:
            for( i=0; i<n_dim; i++ )
            {
                sum_j = 0.0;

                for( j=0; j<(i+1); j++ )
                {
                    sum_j = sum_j + powf(position[j+p*n_dim], 2);
                }

                sum_i = sum_i + sum_j;
            }

            fitness[p] = sum_i;
            break;

        // Rosenbrock
        case 4:
            for( d=0; d<(n_dim-1); d++ )
            {
                sum = sum + ( powf((1.0f - position[d+p*n_dim]), 2) + (100.0f * powf((position[d+p*n_dim+1] - powf(position[d+p*n_dim], 2)), 2)) );
            }

            fitness[p] = sum;
            break;

        // Rastrigin
        case 5:
            for( d=0; d<n_dim; d++ )
            {
                sum = sum + ( powf(position[d+p*n_dim], 2) - (10.0f * cos(2 * pi * position[d+p*n_dim])) );
            }

            fitness[p] = (10.0f * n_dim) + sum;
            break;

        // Schwefel
        case 6:
            for( d=0; d<n_dim; d++ )
            {
                sum = sum + ( -position[d+p*n_dim] * sin(powf(fabs(position[d+p*n_dim]), 0.5)) );
            }

            fitness[p] = sum;
            break;

        // Griewangk
        case 7:
            sum_pow = pow(position[p*n_dim], 2); prod_cos = cos(position[p*n_dim]/sqrtf(1));

            for( d=1; d<n_dim; d++ )
            {
                sum_pow = sum_pow + powf(position[d+p*n_dim], 2);
                prod_cos = prod_cos * cos(position[d+p*n_dim]/sqrtf(d+1));
            }

            fitness[p] = (sum_pow/4000) - prod_cos + 1;
            break;

        // Ackley
        case 8:
            for( d=0; d<n_dim; d++ )
            {
                sum_pow = sum_pow + powf(position[d+p*n_dim], 2);
                sum_cos = sum_cos + cos(c*position[d+p*n_dim]);
            }

            fitness[p] = -a * expf(-b * sqrtf(sum_pow/n_dim) - expf(sum_cos/n_dim)) + a + expf(1);
            break;

        // Michalewicz
        case 9:
            for( d=0; d<n_dim; d++ )
            {
                sum = sum + ( sin(position[d+p*n_dim]) * powf(sin((d+1) * powf(position[d+p*n_dim], 2) / pi), 2*m) );
            }

            fitness[p] = -sum;
            break;
    }
}

#endif
