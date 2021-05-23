#pragma once
#if !defined(_ERF_FUNCS_H_)
#define _ERF_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point error function
extern "C" bool erf_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point error function
extern "C" bool erf_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point complementary error function
extern "C" bool erfc_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point complementary error function
extern "C" bool erfc_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

} // namespace __packed_avx2_

namespace avx2_math
{

/**
 * Packed double-precision floating-point error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool erf_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::erf_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed fast single-precision floating-point error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool erf_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::erf_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool erfc_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::erfc_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed fast single-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool erfc_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::erfc_avx2_ps(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ///_ERF_FUNCS_H_
