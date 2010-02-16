/**

	nrand.c
	flakeysaver

	The MIT License

	Copyright (c) 2010 Noah Paessel

	Permission is hereby granted, free of charge, to any person obtaining a copy
	of this software and associated documentation files (the "Software"), to deal
	in the Software without restriction, including without limitation the rights
	to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
	copies of the Software, and to permit persons to whom the Software is
	furnished to do so, subject to the following conditions:

	The above copyright notice and this permission notice shall be included in
	all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
	IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
	FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
	AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
	LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
	OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
	THE SOFTWARE.

**/

#include "nrand.h"
#include <limits.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>

void seed() {
	srandomdev();
}

double rand_double () {
	double rand_double = (double) random()/(double)RAND_MAX;
	rand_double = rand_double < 0.0 ? rand_double * -1.0 : rand_double;
	return rand_double;
}


int rand_int (int range) {
	double rnd = rand_double();
	double rvalue = (rnd * range) + 1;
	return rvalue;
	
}


float gauss () {
	double x;
	double pi,r1,r2;
	
	pi =  4*atan(1);
	r1 = -log(1-double_between(0.0f,1.0f));
	r2 =  2 * pi * double_between(0.0f,1.0f);
	r1 =  sqrt(2*r1);
	x  = r1 * cos(r2);
	// y  = r1 * sin(r2);
	return (x - 0.5f) * 2;
		return 0.5f;
}

double double_between(double min, double max) {
	double rnd = rand_double();
	rnd = rnd * (max - min);
	rnd = rnd + min;
	return rnd;
}
