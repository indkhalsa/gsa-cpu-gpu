/*
    Get gravitational and inertia masses.

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

void get_inertia_masses( int n_pop, double best, double worst, double *fitness, double *mass, double *inertia_mass )
{
    int p;
    double sum=0.0;

    // Mass
    for( p=0; p<n_pop; p++)
    {
        if( best == worst )
            mass[p] = 1.0;
        else
            mass[p] = (fitness[p] - worst) / (best - worst);

        sum = sum + mass[p];
    }

    // Inertia mass
    for( p=0; p<n_pop; p++)
    {
        inertia_mass[p] = mass[p] / sum;
    }
}
