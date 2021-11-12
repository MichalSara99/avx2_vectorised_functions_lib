#pragma once
#if !defined(_EXP_FUNCS_H_)
#define _EXP_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point exp
extern "C" bool __vectorcall exp_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point exp
extern "C" bool __vectorcall exp_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point expm
extern "C" bool __vectorcall expm_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point expm
extern "C" bool __vectorcall expm_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point 2^n
extern "C" bool __vectorcall pow2n_avx2_pd(long long const *in_aligned_32, double *out_aligned_32, int size);

// Packed double-precision floating-point 2^n
extern "C" bool __vectorcall pow2n_avx2_ps(int const *in_aligned_32, float *out_aligned_32, int size);

} // namespace __packed_avx2_

namespace avx2_math
{

/**
 * Packed double-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall exp_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::exp_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall exp_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::exp_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall expm_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::expm_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall expm_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::expm_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point 2^n
 * function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall pow2n_avx2_packed(long long const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::pow2n_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point 2^n
 * function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall pow2n_avx2_packed(int const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::pow2n_avx2_ps(in_aligned_32, out_aligned_32, size);
}

} // namespace avx2_math

#endif ///_EXP_FUNCS_H_
