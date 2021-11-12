#pragma once
#if !defined(_BASIC_OPERATIONS_H_)
#define _BASIC_OPERATIONS_H_

namespace __packed_avx2_
{
// Packed single-precision floating-point add
extern "C" bool __vectorcall add_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point add
extern "C" bool __vectorcall add_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point add broadcast
extern "C" bool __vectorcall add_broad_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                               int n);

// Packed double-precision floating-point add broadcast
extern "C" bool __vectorcall add_broad_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                               int n);

// Packed single-precision floating-point subtract
extern "C" bool __vectorcall sub_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point subtract
extern "C" bool __vectorcall sub_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point subtraction broadcast
extern "C" bool __vectorcall sub_broad1_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                                int n);

// Packed double-precision floating-point subtraction broadcast
extern "C" bool __vectorcall sub_broad1_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                                int n);

// Packed single-precision floating-point subtraction broadcast
extern "C" bool __vectorcall sub_broad2_avx2_ps(float const in1, float const *in2_aligned_32, float *out_aligned_32,
                                                int n);

// Packed double-precision floating-point subtraction broadcast
extern "C" bool __vectorcall sub_broad2_avx2_pd(double const in1, double const *in2_aligned_32, double *out_aligned_32,
                                                int n);

// Packed single-precision floating-point multiply
extern "C" bool __vectorcall mul_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point multiply
extern "C" bool __vectorcall mul_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point broadcast multiply
extern "C" bool __vectorcall mul_broad_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                               int n);

// Packed double-precision floating-point broadcast multiply
extern "C" bool __vectorcall mul_broad_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                               int n);

// Packed single-precision floating-point division
extern "C" bool __vectorcall div_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point division
extern "C" bool __vectorcall div_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point broadcast division
extern "C" bool __vectorcall div_broad1_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                                int n);

// Packed double-precision floating-point broadcast division
extern "C" bool __vectorcall div_broad1_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                                int n);

// Packed single-precision floating-point broadcast division
extern "C" bool __vectorcall div_broad2_avx2_ps(float const in1, float const *in2_aligned_32, float *out_aligned_32,
                                                int n);

// Packed double-precision floating-point broadcast division
extern "C" bool __vectorcall div_broad2_avx2_pd(double const in1, double const *in2_aligned_32, double *out_aligned_32,
                                                int n);

// Packed single-precision floating-point negation
extern "C" bool __vectorcall neg_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point negation
extern "C" bool __vectorcall neg_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point inverse
extern "C" bool __vectorcall inv_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point inverse
extern "C" bool __vectorcall inv_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);
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
bool __vectorcall add_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::add_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall add_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::add_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall add_broad_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::add_broad_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall add_broad_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::add_broad_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall sub_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::sub_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall sub_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::sub_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall sub_broad_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::sub_broad1_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall sub_broad_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::sub_broad1_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall sub_broad_avx2_packed(float const in1, float const *in2_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::sub_broad2_avx2_ps(in1, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall sub_broad_avx2_packed(double const in1, double const *in2_aligned_32, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::sub_broad2_avx2_pd(in1, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall mul_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::mul_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall mul_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::mul_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall mul_broad_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::mul_broad_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall mul_broad_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::mul_broad_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall div_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::div_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall div_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::div_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall div_broad_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::div_broad1_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall div_broad_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::div_broad1_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall div_broad_avx2_packed(float const in1, float const *in2_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::div_broad2_avx2_ps(in1, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall div_broad_avx2_packed(double const in1, double const *in2_aligned_32, double *out_aligned_32,
                                        int size)
{
    return __packed_avx2_::div_broad2_avx2_pd(in1, in2_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point inversion
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall inv_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::inv_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point inversion
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall inv_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::inv_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point negation
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall neg_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::neg_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point negation
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall neg_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::neg_avx2_pd(in_aligned_32, out_aligned_32, size);
}

} // namespace avx2_math

#endif ////_BASIC_OPERATIONS_H_
