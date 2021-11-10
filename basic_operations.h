#pragma once
#if !defined(_BASIC_OPERATIONS_H_)
#define _BASIC_OPERATIONS_H_

namespace __packed_avx2_
{
// Packed single-precision floating-point add
extern "C" bool add_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point add
extern "C" bool add_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point add broadcast
extern "C" bool add_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point add broadcast
extern "C" bool add_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

// Packed single-precision floating-point subtract
extern "C" bool sub_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point subtract
extern "C" bool sub_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point subtraction broadcast
extern "C" bool sub_broad1_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point subtraction broadcast
extern "C" bool sub_broad1_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

// Packed single-precision floating-point subtraction broadcast
extern "C" bool sub_broad2_avx2_ps(float const in1, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point subtraction broadcast
extern "C" bool sub_broad2_avx2_pd(double const in1, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point multiply
extern "C" bool mul_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point multiply
extern "C" bool mul_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point broadcast multiply
extern "C" bool mul_broad_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point broadcast multiply
extern "C" bool mul_broad_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

// Packed single-precision floating-point division
extern "C" bool div_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point division
extern "C" bool div_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point broadcast division
extern "C" bool div_broad1_avx2_ps(float const *in1_aligned_32, float const in2, int n, float *out_aligned_32);

// Packed double-precision floating-point broadcast division
extern "C" bool div_broad1_avx2_pd(double const *in1_aligned_32, double const in2, int n, double *out_aligned_32);

// Packed single-precision floating-point broadcast division
extern "C" bool div_broad2_avx2_ps(float const in1, float const *in2_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point broadcast division
extern "C" bool div_broad2_avx2_pd(double const in1, double const *in2_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point negation
extern "C" bool neg_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point negation
extern "C" bool neg_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);

// Packed single-precision floating-point inverse
extern "C" bool inv_avx2_ps(float const *in_aligned_32, int n, float *out_aligned_32);

// Packed double-precision floating-point inverse
extern "C" bool inv_avx2_pd(double const *in_aligned_32, int n, double *out_aligned_32);
} // namespace __packed_avx2_

namespace avx2_math
{
/**
 * Packed single-precision floating-point addition function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool add_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::add_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point addition function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool add_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::add_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point addition broadcast function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool add_broad_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::add_broad_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point addition broadcast function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool add_broad_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::add_broad_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point subtraction function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sub_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point subtraction function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sub_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point broadcast subtraction function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_broad_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::sub_broad1_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point broadcast subtraction function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_broad_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::sub_broad1_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point broadcast subtraction function
 *
 * \param in1
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_broad_avx2_packed(float const in1, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::sub_broad2_avx2_ps(in1, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point broadcast subtraction function
 *
 * \param in1
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool sub_broad_avx2_packed(double const in1, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::sub_broad2_avx2_pd(in1, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point multiplication function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool mul_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::mul_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point multiplication function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool mul_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::mul_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point broadcast multiplication function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool mul_broad_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::mul_broad_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point broadcast multiplication function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool mul_broad_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::mul_broad_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point division function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::div_avx2_ps(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point division function
 *
 * \param in1_aligned_32
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::div_avx2_pd(in1_aligned_32, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point broadcast division function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_broad_avx2_packed(float const *in1_aligned_32, float const in2, int size, float *out_aligned_32)
{
    return __packed_avx2_::div_broad1_avx2_ps(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point broadcast division function
 *
 * \param in1_aligned_32
 * \param in2
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_broad_avx2_packed(double const *in1_aligned_32, double const in2, int size, double *out_aligned_32)
{
    return __packed_avx2_::div_broad1_avx2_pd(in1_aligned_32, in2, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point broadcast division function
 *
 * \param in1
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_broad_avx2_packed(float const in1, float const *in2_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::div_broad2_avx2_ps(in1, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point broadcast division function
 *
 * \param in1
 * \param in2_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool div_broad_avx2_packed(double const in1, double const *in2_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::div_broad2_avx2_pd(in1, in2_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point inversion
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool inv_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::inv_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point inversion
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool inv_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::inv_avx2_pd(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed single-precision floating-point negation
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool neg_avx2_packed(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return __packed_avx2_::neg_avx2_ps(in_aligned_32, size, out_aligned_32);
}

/**
 * Packed double-precision floating-point negation
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool neg_avx2_packed(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return __packed_avx2_::neg_avx2_pd(in_aligned_32, size, out_aligned_32);
}

} // namespace avx2_math

#endif ////_BASIC_OPERATIONS_H_
