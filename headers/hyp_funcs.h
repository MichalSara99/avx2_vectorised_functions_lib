#pragma once
#if !defined(_HYP_FUNCS_H_)
#define _HYP_FUNCS_H_

namespace __packed_avx2_
{
// packed double-precision floating-point hyperbolic cosine
extern "C" bool cosh_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point hyperbolic cosine
extern "C" bool cosh_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point hyperbolic sine
extern "C" bool sinh_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point hyperbolic sine
extern "C" bool sinh_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point hyperbolic tangens
extern "C" bool tanh_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point hyperbolic tangens
extern "C" bool tanh_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

} // namespace __packed_avx2_

namespace avx2_math
{

/**
 * Packed double-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cosh_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::cosh_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cosh_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::cosh_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sinh_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sinh_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sinh_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sinh_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool tanh_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::tanh_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool tanh_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::tanh_avx2_ps(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ///_HYP_FUNCS_H_
