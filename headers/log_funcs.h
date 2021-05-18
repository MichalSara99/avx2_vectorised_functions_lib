#pragma once
#if !defined(_LOG_FUNCS_H_)
#define _LOG_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point natural log
extern "C" bool log_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);
// Packed double-precision floating-point natural log
extern "C" bool log_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

} // namespace __packed_avx2_

namespace avx2_math
{

/**
 * Packed single-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool log_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::log_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool log_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::log_avx2_pd(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ///_LOG_FUNCS_H_
