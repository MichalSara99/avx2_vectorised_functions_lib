#pragma once
#if !defined(_TRIG_FUNCS_H_)
#define _TRIG_FUNCS_H_

namespace __packed_avx2_
{
// packed double-precision floating-point cosine
extern "C" bool cos_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point cosine
extern "C" bool cos_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point sine
extern "C" bool sin_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point sine
extern "C" bool sin_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point tangens
extern "C" bool tan_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point tangens
extern "C" bool tan_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point cotangens
extern "C" bool cot_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point cotangens
extern "C" bool cot_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point arcus cosine
extern "C" bool acos_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point arcus cosine
extern "C" bool acos_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point arcus sine
extern "C" bool asin_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point arcus sine
extern "C" bool asin_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

// packed double-precision floating-point arcus tangens
extern "C" bool atan_avx2_pd(double const *in_aligned_32, int size, double *out_aligned_32);

// packed single-precision floating-point arcus tangens
extern "C" bool atan_avx2_ps(float const *in_aligned_32, int size, float *out_aligned_32);

} // namespace __packed_avx2_

namespace avx2_math
{

/**
 * Packed double-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cos_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::cos_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cos_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::cos_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sin_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sin_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sin_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sin_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool tan_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::tan_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool tan_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::tan_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cot_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::cot_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool cot_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::cot_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool acos_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::acos_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool acos_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::acos_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool asin_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::asin_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool asin_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::asin_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool atan_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::atan_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool atan_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::atan_avx2_ps(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ///_TRIG_FUNCS_H_
