/*
    Print the solution.

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

void show_solution( int n_dim, double best_z, double *best_x )
{
    int d;

    for( d=0; d<n_dim; d++ )
    {
        printf( "x(%d): %f\n", d+1, best_x[d] );
    }

    printf( "\nz: %f\n\n", best_z );
}
