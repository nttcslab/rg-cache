#include <math.h>
#include "mex.h"

void ScaledHistDouble(double *a, 
                double *g,
                int n, 
                int length, 
                double *y);

void ScaledHistDouble(double *a, 
                double *g,
                int n, 
                int length, 
                double *y) {
    int i;
    double scale;
    double z, _g;

    scale = (double) (n-1);

    for (i = 0; i < length; i++) {
        z = floor(a[i] * scale + .5);
        _g = g[i];
        if (z < 0.0) {
            y[0] += _g;
        } else if (z > (n-1)) {
            y[n-1] += _g;
        } else {
            y[(int) z] += _g;
        }
    }
}

void mexFunction(int nlhs, 
                 mxArray *plhs[], 
                 int nrhs, 
                 const mxArray *prhs[])
{
    int length;
    const mxArray *A;
    const mxArray *G;
    double n_real;
    int n;
    double *a_real;
    double *g_real;
    double *y;
    mxArray *Y;

    A = prhs[0];
    G = prhs[1];
    n_real = *((double *) mxGetPr(prhs[2]));
    n = (int) n_real;
    length = mxGetM(A) * mxGetN(A);

    Y = mxCreateDoubleMatrix(n, 1, mxREAL);
    y = (double *) mxGetPr(Y);

    a_real = (double *) mxGetPr(A);
    g_real = (double *) mxGetPr(G);
    ScaledHistDouble(a_real, g_real, n, length, y);
        
    /* Done! Give the answer back */
    plhs[0] = Y;
}
