#pragma once
#if !defined(_EXP_FUNCS_H_)
#define _EXP_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point exp
extern "C" bool exp_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point exp
extern "C" bool exp_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point expm
extern "C" bool expm_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point expm
extern "C" bool expm_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

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
bool exp_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::exp_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed fast single-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool exp_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::exp_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool expm_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::expm_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed fast single-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool expm_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::expm_avx2_ps(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ///_EXP_FUNCS_H_
