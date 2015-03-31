/*
    Parameters initialization.

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

#ifndef _INIT_PARAMS_
#define _INIT_PARAMS_

#include "gsa.h"

void init_params( int argc, char **argv, int *n_pop, int *n_dim, float *min, float *max, int *max_i, float *alpha, float *g0, float *epsilon, int *func )
{
    char c;

    while( (c = getopt(argc, argv, "a:d:x:X:i:A:G:e:f:h")) != -1 )
    {
        switch( c )
        {
            case 'a':
                *n_pop = atoi(optarg);
	            break;
            case 'd':
                *n_dim = atoi(optarg);
                break;
            case 'x':
                *min = atof(optarg);
                break;
            case 'X':
	            *max = atof(optarg);
                break;
            case 'i':
                *max_i = atoi(optarg);
                break;
            case 'A':
                *alpha = atof(optarg);
                break;
            case 'G':
                *g0 = atof(optarg);
                break;
            case 'e':
                *epsilon = atof(optarg);
                break;
            case 'f':
                *func = atoi(optarg);
                break;
            case 'h':
                usage();
                break;
            default:
                usage();
                break;
        }
    }

    if( argc < 8 )
    {
        exit(EXIT_FAILURE);
    }
}

#endif
