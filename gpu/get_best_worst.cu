/*
    Get the best and worst fitness value.

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

#ifndef _GET_BEST_WORST_
#define _GET_BEST_WORST_

#include "gsa.h"

__global__ void get_best_worst( int n_pop, float *fitness, float *best, float *worst )
{
    int p;
    float fmin = fitness[0], fmax = fitness[0];

    for( p=1; p<n_pop; p++ )
    {
        if( fitness[p] < fmin )
            fmin = fitness[p];

        if( fitness[p] > fmax )
            fmax = fitness[p];
    }

  *best = fmin; *worst = fmax;
}

#endif
