# AVX2 Vectorised Functions 32-bit library
DLL library consisting of vectorised math functions written in Assembly x86-32 (using AVX2 technology) and calling in C++.
Most of the functions are motivated by Cephes (https://www.netlib.org/cephes/) library

## List of available functions
* sin, cos (SPFP,DPFP)
* tan, cot (SPFP,DPFP)
* exp (SPFP,DPFP)
* natural log (SPFP,DPFP)
* asin, acos, atan (SPFP,DPFP)
* cosh, sinh, tanh (SPFP,DPFP)
* other elementary functions coming up....

** SPFP = single-precision floating-point, DPFP = double-precision floating-point

## Usage
Include avx2_vectorised_functions_x86_lib.dll in your project and include <avx2_math_x86_lib.h> header file.
See repo avx2_vectorised_functions_x86_tests, for example.
