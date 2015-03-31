/*
    Usage.

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

#ifndef _USAGE_
#define _USAGE_

#include "gsa.h"

void usage( void )
{
    printf( "\nGSA usage: -a NumberOfAgents -d Dimension -x Min -X Max -i Iterations -A [Alpha] -G [Gravity] -e [Epsilon] -f Function\n" );
    printf( "\n\tFunctions:\n" );
    printf( "\t\t1. De Jong\n" );
    printf( "\t\t2. Sphere\n" );
    printf( "\t\t3. Rotated hyper-ellipsoid\n" );
    printf( "\t\t4. Rosenbrock\n" );
    printf( "\t\t5. Rastrigin\n" );
    printf( "\t\t6. Schwefel\n" );
    printf( "\t\t7. Griewangk\n" );
    printf( "\t\t8. Ackley\n" );
    printf( "\t\t9. Michalewicz\n\n" );
}

#endif
