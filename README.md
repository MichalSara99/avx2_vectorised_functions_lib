# AVX2 Vectorised Functions 32-bit library
DLL library consisting of vectorised math functions written in Assembly x86-32 (using AVX2 technology) and calling in C++.
Most of the functions are motivated by [Cephes](https://www.netlib.org/cephes/) library or 
[Handbook of Mathematical Functions: with Formulas, Graphs, and Mathematical Tables](https://www.amazon.com/Handbook-Mathematical-Functions-Formulas-Mathematics/dp/0486612724)

## List of available functions
* sin, cos (SPFP,DPFP)
* tan, cot (SPFP,DPFP)
* exp, expm (SPFP,DPFP)
* natural log (SPFP,DPFP)
* asin, acos, atan (SPFP,DPFP)
* cosh, sinh, tanh (SPFP,DPFP)
* erf, erfc, expint (SPFP,DPFP)
* pow2n (SPFP,DPFP)
* basic math operation (add,sub,mul,div,plus broadcast versions of these...) (SPFP,DPFP)
* basic math functions (abs,sqrt,sqrp,min,max,plus broadcast vesions of these...) (SPFP,DPFP)
* other probability functions coming up....

** SPFP = single-precision floating-point, DPFP = double-precision floating-point

## Usage
Include avx2_vectorised_functions_x86_lib.dll in your project and include <avx2_math_x86_lib.h> header file.
See repo avx2_vectorised_functions_x86_tests, for example.
