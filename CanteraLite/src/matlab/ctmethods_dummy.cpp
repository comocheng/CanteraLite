/*
* Dummy MEX interface to test the ability to fetch class and job IDs
* from a MATLAB function call. 
*/
#include "ctmatutils.h"
#include <string>

extern "C" {
void mexFunction(int nlhs, mxArray* plhs[],
                     int nrhs, const mxArray* prhs[])
    {
        int magic_number = getInt(prhs[0]) * 100 + getInt(prhs[1]);
        // string func_name = read_func(magic_number);
        plhs[0] = mxCreateNumericMatrix(1, 1, mxDOUBLE_CLASS, mxREAL);
        mexPrintf("Magic Number is %d", magic_number);
    }
}
