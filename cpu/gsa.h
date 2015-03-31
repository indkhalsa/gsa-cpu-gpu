/*
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

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <math.h>
#include <time.h>

double (*objective_function)( int n_dim, double *x );

void init_params( int , char **, int *, int *, double *, double *, int *, double *, double *, double *, int * );

void usage( void );

double get_rand( void );

void init_gsa( int, int, double, double, double *, double *, double *, double * );

void get_fitness( int, int, double *, double * );

int get_best_worst( int, double *, double *, double * );

double get_gconst( double, double, int, int );

void get_inertia_masses( int, double, double, double *, double *, double * );

void get_forces( int, int, double, double *, double *, double * );

double p_norm_distance( int, double *, double * );

void update_agents( int, int, double, double *, double *, double *, double *, double * );

void show_solution( int, double, double * );

void save_solution( int, double *, int, double * );

int timeval_subtract(struct timeval *, struct timeval *, struct timeval *);

double de_jong( int, double * );

double sphere( int, double * );

double rotated_hyper_ellipsoid( int, double * );

double rosenbrock( int, double * );

double rastrigin( int, double * );

double schwefel( int, double * );

double griewangk( int, double * );

double ackley( int, double * );

double michalewicz( int, double * );
