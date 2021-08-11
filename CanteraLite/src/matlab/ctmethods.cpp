/**
*The interface between the MATLAB environment and the C++ Cantera kernel is through a single MEX file. This is the top-level driver for the MEX file.
*
* This file handles the methods of all Cantera MATLAB classes. The class * is indicated by the first parameter in the call from MATLAB.
*/

#include <string>

#include "cantera/clib/ct.h"

void ctfunctions(int nlhs, mxArray* plhs[], int nrhs,
                 const mxArray* prhs[]);

void xmlmethods(int nlhs, mxArray* plhs[], int nrhs,
                const mxArray* prhs[]);

void thermomethods(int nlhs, mxArray* plhs[], int nrhs,
                   const mxArray* prhs[]);

void phasemethods(int nlhs, mxArray* plhs[], int nrhs,
                  const mxArray* prhs[]);

void mixturemethods(int nlhs, mxArray* plhs[], int nrhs,
                    const mxArray* prhs[]);

void surfmethods(int nlhs, mxArray* plhs[], int nrhs,
                 const mxArray* prhs[]);

void kineticsmethods(int nlhs, mxArray* plhs[], int nrhs,
                     const mxArray* prhs[]);

void transportmethods(int nlhs, mxArray* plhs[], int nrhs,
                      const mxArray* prhs[]);

void reactormethods(int nlhs, mxArray* plhs[], int nrhs,
                    const mxArray* prhs[]);

void reactornetmethods(int nlhs, mxArray* plhs[], int nrhs,
                       const mxArray* prhs[]);

void wallmethods(int nlhs, mxArray* plhs[], int nrhs,
                 const mxArray* prhs[]);

void reactorsurfacemethods(int nlhs, mxArray* plhs[], int nrhs,
                           const mxArray* prhs[]);

void flowdevicemethods(int nlhs, mxArray* plhs[], int nrhs,
                       const mxArray* prhs[]);

void onedimmethods(int nlhs, mxArray* plhs[], int nrhs,
                   const mxArray* prhs[]);

void funcmethods(int nlhs, mxArray* plhs[], int nrhs,
                 const mxArray* prhs[]);

extern "C" {

    void mexFunction(int nlhs, mxArray* plhs[], 
                     int nrhs, const mxArray* prhs[])
    {

    }
     }

}