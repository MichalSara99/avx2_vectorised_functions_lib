#pragma once
#if !defined(_BASIC_FUNCS_H_)
#define _BASIC_FUNCS_H_

namespace __packed_avx2_
{

// Packed single-precision floating-point absolute value
extern "C" bool __vectorcall abs_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point absolute value
extern "C" bool __vectorcall abs_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point square root value
extern "C" bool __vectorcall sqrt_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point square root value
extern "C" bool __vectorcall sqrt_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point square power value
extern "C" bool __vectorcall sqrp_avx2_ps(float const *in_aligned_32, float *out_aligned_32, int n);

// Packed double-precision floating-point square power value
extern "C" bool __vectorcall sqrp_avx2_pd(double const *in_aligned_32, double *out_aligned_32, int n);

// Packed single-precision floating-point min value
extern "C" bool __vectorcall min_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point min value
extern "C" bool __vectorcall min_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point min value
extern "C" bool __vectorcall min_broad_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                               int n);

// Packed double-precision floating-point min value
extern "C" bool __vectorcall min_broad_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                               int n);

// Packed single-precision floating-point max value
extern "C" bool __vectorcall max_avx2_ps(float const *in1_aligned_32, float const *in2_aligned_32,
                                         float *out_aligned_32, int n);

// Packed double-precision floating-point max value
extern "C" bool __vectorcall max_avx2_pd(double const *in1_aligned_32, double const *in2_aligned_32,
                                         double *out_aligned_32, int n);

// Packed single-precision floating-point max value
extern "C" bool __vectorcall max_broad_avx2_ps(float const *in1_aligned_32, float const in2, float *out_aligned_32,
                                               int n);

// Packed double-precision floating-point max value
extern "C" bool __vectorcall max_broad_avx2_pd(double const *in1_aligned_32, double const in2, double *out_aligned_32,
                                               int n);

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
bool __vectorcall abs_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::abs_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point absolute value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall abs_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::abs_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point square root value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sqrt_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::sqrt_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point square root value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sqrt_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::sqrt_avx2_pd(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed single-precision floating-point square power value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sqrp_avx2_packed(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return __packed_avx2_::sqrp_avx2_ps(in_aligned_32, out_aligned_32, size);
}

/**
 * Packed double-precision floating-point square power value
 *
 * \param in1_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
bool __vectorcall sqrp_avx2_packed(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return __packed_avx2_::sqrp_avx2_pd(in_aligned_32, out_aligned_32, size);
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
bool __vectorcall min_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::min_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall min_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::min_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall min_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::min_broad_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall min_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32, int size)
{
    return __packed_avx2_::min_broad_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall max_avx2_packed(float const *in1_aligned_32, float const *in2_aligned_32, float *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::max_avx2_ps(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall max_avx2_packed(double const *in1_aligned_32, double const *in2_aligned_32, double *out_aligned_32,
                                  int size)
{
    return __packed_avx2_::max_avx2_pd(in1_aligned_32, in2_aligned_32, out_aligned_32, size);
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
bool __vectorcall max_avx2_packed(float const *in1_aligned_32, float const in2, float *out_aligned_32, int size)
{
    return __packed_avx2_::max_broad_avx2_ps(in1_aligned_32, in2, out_aligned_32, size);
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
bool __vectorcall max_avx2_packed(double const *in1_aligned_32, double const in2, double *out_aligned_32, int size)
{
    return __packed_avx2_::max_broad_avx2_pd(in1_aligned_32, in2, out_aligned_32, size);
}

} // namespace avx2_math

#endif ////_BASIC_OPERATIONS_H_
