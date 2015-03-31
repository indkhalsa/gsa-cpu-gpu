/*
    Rosenbrock function.

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

double rosenbrock( int n_dim, double *x )
{
    int d;
    double sum=0.0;

    for( d=0; d<(n_dim-1); d++ )
    {
        sum = sum + ( pow((1.0 - x[d]), 2) + (100.0 * pow((x[d+1] - pow(x[d], 2)), 2)) );
    }

    return sum;
}
