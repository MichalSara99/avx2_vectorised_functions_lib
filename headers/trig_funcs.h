#pragma once
#if !defined(_TRIG_FUNCS_H_)
#define _TRIG_FUNCS_H_

namespace __packed_avx2_
{
// packed double-precision floating-point cosine
extern "C" bool __vectorcall cos_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point cosine
extern "C" bool __vectorcall cos_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point sine
extern "C" bool __vectorcall sin_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point sine
extern "C" bool __vectorcall sin_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point tangens
extern "C" bool __vectorcall tan_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point tangens
extern "C" bool __vectorcall tan_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point cotangens
extern "C" bool __vectorcall cot_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point cotangens
extern "C" bool __vectorcall cot_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point arcus cosine
extern "C" bool __vectorcall acos_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point arcus cosine
extern "C" bool __vectorcall acos_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point arcus sine
extern "C" bool __vectorcall asin_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point arcus sine
extern "C" bool __vectorcall asin_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

// packed double-precision floating-point arcus tangens
extern "C" bool __vectorcall atan_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int size);

// packed single-precision floating-point arcus tangens
extern "C" bool __vectorcall atan_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int size);

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
bool __vectorcall cos_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::cos_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall cos_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::cos_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sin_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::sin_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sin_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::sin_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall tan_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::tan_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall tan_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::tan_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall cot_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::cot_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall cot_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::cot_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall acos_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::acos_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall acos_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::acos_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall asin_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::asin_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall asin_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::asin_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall atan_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::atan_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall atan_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::atan_avx2_ps(in_aligned_32, out_aligned_32, size);
}

} // namespace avx2_math

#endif ///_TRIG_FUNCS_H_
