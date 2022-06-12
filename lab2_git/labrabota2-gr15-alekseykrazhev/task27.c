#include <stdio.h>
#include <math.h>

int main(){
	double h;
	printf ("Enter h:\n");
	scanf ("%lf", &h);
	if (h <= 0) {
		printf("H can't be <= 0");
		return 1;
	}
	double a = sqrt(2*h*h); //formula
	printf("a, b = %f%s%f%s", a,", c = ", 2*h, "\n");
	return 0;
}
//check for new content
//stay updated!!!
