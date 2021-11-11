#pragma once
#if !defined(_BASIC_FUNCS_H_)
#define _BASIC_FUNCS_H_

namespace __packed_avx2_
{
// Packed single-precision floating-point absolute value
extern "C" bool abs_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point absolute value
extern "C" bool abs_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point square root value
extern "C" bool sqrt_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point square root value
extern "C" bool sqrt_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point square power value
extern "C" bool sqrp_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point square power value
extern "C" bool sqrp_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point min value
extern "C" bool min_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point min value
extern "C" bool min_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point min value
extern "C" bool min_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point min value
extern "C" bool min_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

// Packed single-precision floating-point max value
extern "C" bool max_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point max value
extern "C" bool max_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point max value
extern "C" bool max_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point max value
extern "C" bool max_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

} // namespace __packed_avx2_

namespace avx2_math
{
/**
 * Packed single-precision floating-point absolute value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool abs_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::abs_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point absolute value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool abs_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::abs_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point square root value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sqrt_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sqrt_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point square root value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sqrt_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sqrt_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point square power value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sqrp_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sqrp_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point square power value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sqrp_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sqrp_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point min function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool min_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::min_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point min function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool min_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::min_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point min function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool min_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::min_broad_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point min function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool min_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::min_broad_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point max function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool max_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::max_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point max function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool max_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::max_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point max function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool max_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::max_broad_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point max function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool max_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::max_broad_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

} // namespace avx2_math

#endif ////_BASIC_OPERATIONS_H_
