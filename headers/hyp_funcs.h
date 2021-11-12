#pragma once
#if !defined(_HYP_FUNCS_H_)
#define _HYP_FUNCS_H_

namespace __packed_avx2_
{
// packed double-precision floating-point hyperbolic cosine
extern "C" bool __vectorcall cosh_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point hyperbolic cosine
extern "C" bool __vectorcall cosh_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point hyperbolic sine
extern "C" bool __vectorcall sinh_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point hyperbolic sine
extern "C" bool __vectorcall sinh_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point hyperbolic tangens
extern "C" bool __vectorcall tanh_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point hyperbolic tangens
extern "C" bool __vectorcall tanh_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

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
bool __vectorcall cosh_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::cosh_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall cosh_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::cosh_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sinh_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::sinh_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sinh_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::sinh_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall tanh_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::tanh_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall tanh_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::tanh_avx2_ps(in_aligned_32, out_aligned_32, size);
}

} // namespace avx2_math

#endif ///_HYP_FUNCS_H_
