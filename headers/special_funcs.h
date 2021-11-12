#pragma once
#if !defined(_ERF_FUNCS_H_)
#define _ERF_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point error function
extern "C" bool __vectorcall erf_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point error function
extern "C" bool __vectorcall erf_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point complementary error function
extern "C" bool __vectorcall erfc_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point complementary error function
extern "C" bool __vectorcall erfc_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point exponential integral function
extern "C" bool __vectorcall expint_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point exponential integral function
extern "C" bool __vectorcall expint_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

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
bool __vectorcall erf_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::erf_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall erf_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::erf_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall erfc_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::erfc_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall erfc_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::erfc_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point exponential integral function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall expint_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::expint_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed fast single-precision floating-point exponential integral function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall expint_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::expint_avx2_ps(in_aligned_32, out_aligned_32, size);
}

} // namespace avx2_math

#endif ///_ERF_FUNCS_H_
