#pragma once
#if !defined(_AVX2_MATH_X86_EXPORTS)
#define _AVX2_MATH_X86_EXPORTS

#include <typeinfo>

#include "avx2_utilities.h"

#ifdef AVX2_MATH_X86_EXPORTS
#define AVX2_MATH_X86_API __declspec(dllexport)
#else
#define AVX2_MATH_X86_API __declspec(dllimport)
#endif // AVX2_MATH_X86_EXPORTS

/// <summary>
///  ====================================================================================================
///  ====================================== avx2_constants ==============================================
///  ====================================================================================================
/// </summary>

namespace avx2_constants
{

template <typename Type> const Type pi();

/**
 * Double-precision floating-point pi value
 *
 * \return math constant of PI
 */
template <> AVX2_MATH_X86_API const double pi();

/**
 * Single-precision floating-point pi value
 *
 * \return math constant of PI
 */
template <> AVX2_MATH_X86_API const float pi();

} // namespace avx2_constants

/// <summary>
///  ====================================================================================================
///  ======================================= avx2_basics ================================================
///  ====================================================================================================
/// </summary>

namespace avx2_basics
{

///// basic operations:
/////
// template <typename Type> bool mul_br_sse(Type const *x_aligned_16, Type const y, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast multiplication
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mul_br_sse(double const *x_aligned_16, double const y, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast multiplication
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mul_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16);
//
// template <typename Type>
// bool mul_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point multiplication
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mul_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                               double *out_aligned_16);
//
///**
// * Packed single-precision floating-point multiplication
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mul_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
// template <typename Type> bool div_br_sse(Type const *x_aligned_16, Type const y, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast division
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_br_sse(double const *x_aligned_16, double const y, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast division
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16);
//
// template <typename Type> bool div_br_s_sse(Type const x, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast division
// *
// * \param x
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_br_s_sse(double const x, double const *y_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast division
// *
// * \param x
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_br_s_sse(float const x, float const *y_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type>
// bool div_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point division
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                               double *out_aligned_16);
//
///**
// * Packed single-precision floating-point division
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool div_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
// template <typename Type> bool add_br_sse(Type const *x_aligned_16, Type const y, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast addition
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool add_br_sse(double const *x_aligned_16, double const y, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast addition
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool add_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16);
//
// template <typename Type>
// bool add_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point addition
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool add_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                               double *out_aligned_16);
//
///**
// * Packed single-precision floating-point addition
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool add_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
// template <typename Type> bool sub_br_sse(Type const *x_aligned_16, Type const y, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast subtraction
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_br_sse(double const *x_aligned_16, double const y, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast subtraction
// *
// * \param x_aligned_16
// * \param y
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16);
//
// template <typename Type> bool sub_br_s_sse(Type const x, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point broadcast subtraction
// *
// * \param x
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_br_s_sse(double const x, double const *y_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point broadcast subtraction
// *
// * \param x
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_br_s_sse(float const x, float const *y_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type>
// bool sub_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point subtraction
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                               double *out_aligned_16);
//
///**
// * Packed single-precision floating-point subtraction
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool sub_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
// template <typename Type> bool neg_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point negative value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool neg_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point negative value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool neg_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type> bool inv_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point inverse(=inverted) value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool inv_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point inverse(=inverted) value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool inv_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
///// basic functions:
//
// template <typename Type> bool abs_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point absolute value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool abs_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point absolute value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool abs_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type> bool sqrt_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point square root value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool sqrt_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * packed single-precision floating-point square root value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool sqrt_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type> bool sqrpow_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point square power value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool sqrpow_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point square power value
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool sqrpow_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type>
// bool mins_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed single-precision floating-point minimum values from a pair of
// * allocated aligned memory blocks
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mins_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
///**
// * Packed double-precision floating-point minimum values from a pair of
// * allocated aligned memory blocks
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool mins_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                                double *out_aligned_16);
//
// template <typename Type>
// bool maxs_sse(Type const *x_aligned_16, Type const *y_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed single-precision floating-point maximum values from a pair of
// * allocated aligned memory blocks
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool maxs_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float
// *out_aligned_16);
//
///**
// * Packed double-precision floating-point maximum values from a pair of
// * allocated aligned memory blocks
// *
// * \param x_aligned_16
// * \param y_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <>
// AVX2_MATH_X86_API bool maxs_sse(double const *x_aligned_16, double const *y_aligned_16, int size,
//                                double *out_aligned_16);
//
///// exponential functions:

template <typename Type> bool exp_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool exp_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool exp_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

/// logaritmhmic functions:

template <typename Type> bool log_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed single-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool log_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

/**
 * Packed double-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool log_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/// trig functions:

template <typename Type> bool cos_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cos_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cos_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool sin_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool sin_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool sin_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool tan_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool tan_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool tan_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool cot_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cot_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cot_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool acos_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool acos_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool acos_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool asin_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool asin_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool asin_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool atan_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool atan_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool atan_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

/// hyperbolic functions:

template <typename Type> bool cosh_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cosh_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool cosh_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool sinh_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool sinh_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool sinh_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

template <typename Type> bool tanh_avx2(Type const *in_aligned_32, int size, Type *out_aligned_32);

/**
 * Packed double-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool tanh_avx2(double const *in_aligned_32, int size, double *out_aligned_32);

/**
 * Packed single-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool tanh_avx2(float const *in_aligned_32, int size, float *out_aligned_32);

} // namespace avx2_basics

/// <summary>
///  ====================================================================================================
///  ============================ avx2_normal_distribution ==============================================
///  ====================================================================================================
/// </summary>

// namespace avx2_normal_distribution
//{
//
// template <typename Type> bool norm_cdf_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed single-precision floating-point normal CDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_cdf_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
///**
// * Packed double-precision floating-point normal CDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_cdf_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
// template <typename Type> bool norm_pdf_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed single-precision floating-point normal PDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_pdf_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
///**
// * Packed double-precision floating-point normal PDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_pdf_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
// template <typename Type> bool norm_inv_cdf_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed single-precision floating-point inverse normal CDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_inv_cdf_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
///**
// * Packed double-precision floating-point inverse normal CDF
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool norm_inv_cdf_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
//} // namespace avx2_normal_distribution
//
///// <summary>
/////  ====================================================================================================
/////  ======================================= avx2_specials  =============================================
/////  ====================================================================================================
///// </summary>
//
// namespace avx2_specials
//{
//
// template <typename Type> bool erf_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point error function
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool erf_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point error function
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool erf_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//
// template <typename Type> bool erfc_sse(Type const *in_aligned_16, int size, Type *out_aligned_16);
//
///**
// * Packed double-precision floating-point complementary error function
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool erfc_sse(double const *in_aligned_16, int size, double *out_aligned_16);
//
///**
// * Packed single-precision floating-point complementary error function
// *
// * \param in_aligned_16
// * \param size
// * \param out_aligned_16
// * \return boolean indicating success or failure
// */
// template <> AVX2_MATH_X86_API bool erfc_sse(float const *in_aligned_16, int size, float *out_aligned_16);
//} // namespace avx2_specials

/// <summary>
///  ====================================================================================================
///  ====================================== avx2_utilities ==============================================
///  ====================================================================================================
/// </summary>

namespace avx2_utility
{

template <typename Type> void aligned_free(Type *x);

template <typename Type> Type *aligned_alloc(std::size_t size, std::size_t alignment);

/**
 * Aligned allocation for single-precision floating point
 *
 * \param size
 * \param alignment
 * \return pointer to allocated aligned single-precision floating point memory
 * block
 */
template <> AVX2_MATH_X86_API float *aligned_alloc<float>(std::size_t size, std::size_t alignment);

/**
 * Aligned allocation for double-precision floating point
 *
 * \param size
 * \param alignment
 * \return pointer to allocated aligned double-precision floating point memory
 * block
 */
template <> AVX2_MATH_X86_API double *aligned_alloc<double>(std::size_t size, std::size_t alignment);

/**
 * Aligned free for single-precision floating point memory block
 *
 * \param x
 *
 */
template <> AVX2_MATH_X86_API void aligned_free(float *x);

/**
 * Aligned free for double-precision floating point memory block
 *
 * \param x
 *
 */
template <> AVX2_MATH_X86_API void aligned_free(double *x);

} // namespace avx2_utility

#endif ///_AVX2_MATH_X86_EXPORTS
