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

/// basic operations:

template <typename Type>
bool __vectorcall mul_broad_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast multiplication
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall mul_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast multiplication
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall mul_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall mul_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point multiplication
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall mul_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point multiplication
 *
 * \param x_aligned_16
 * \param y_aligned_16
 * \param size
 * \param out_aligned_16
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall mul_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

template <typename Type>
bool __vectorcall div_broad_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast division
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast division
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall div_broad_avx2(Type const x, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast division
 *
 * \param x
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_broad_avx2(double const x, double const *y_aligned_32, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast division
 *
 * \param x
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_broad_avx2(float const x, float const *y_aligned_32, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall div_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point division
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point division
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall div_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

template <typename Type>
bool __vectorcall add_broad_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast addition
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall add_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast addition
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall add_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall add_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point addition
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall add_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point addition
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall add_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

template <typename Type>
bool __vectorcall sub_broad_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast subtraction
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast subtraction
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall sub_broad_avx2(Type const x, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point broadcast subtraction
 *
 * \param x
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_broad_avx2(double const x, double const *y_aligned_32, double *out_aligned_32,
                                                   int size);

/**
 * Packed single-precision floating-point broadcast subtraction
 *
 * \param x
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_broad_avx2(float const x, float const *y_aligned_32, float *out_aligned_32,
                                                   int size);

template <typename Type>
bool __vectorcall sub_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point subtraction
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point subtraction
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sub_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

template <typename Type> bool __vectorcall neg_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point negative value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall neg_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point negative value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall neg_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall inv_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point inverse(=inverted) value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall inv_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point inverse(=inverted) value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall inv_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

///// basic functions:

template <typename Type> bool __vectorcall abs_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point absolute value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall abs_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point absolute value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall abs_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall sqrt_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point square root value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sqrt_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * packed single-precision floating-point square root value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall sqrt_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall sqrp_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point square power value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sqrp_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point square power value
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall sqrp_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type>
bool __vectorcall min_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed single-precision floating-point minimum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall min_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

/**
 * Packed double-precision floating-point minimum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall min_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

template <typename Type>
bool __vectorcall min_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed single-precision floating-point minimum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall min_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size);

/**
 * Packed double-precision floating-point minimum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall min_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                             int size);

template <typename Type>
bool __vectorcall max_avx2(Type const *x_aligned_32, Type const *y_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed single-precision floating-point maximum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall max_avx2(float const *x_aligned_32, float const *y_aligned_32,
                                             float *out_aligned_32, int size);

/**
 * Packed double-precision floating-point maximum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall max_avx2(double const *x_aligned_32, double const *y_aligned_32,
                                             double *out_aligned_32, int size);

template <typename Type>
bool __vectorcall max_avx2(Type const *x_aligned_32, Type const y, Type *out_aligned_32, int size);

/**
 * Packed single-precision floating-point maximum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall max_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size);

/**
 * Packed double-precision floating-point maximum values from a pair of
 * allocated aligned memory blocks
 *
 * \param x_aligned_32
 * \param y
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall max_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                             int size);

///// exponential functions:

template <typename Type> bool __vectorcall exp_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall exp_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point exponential function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall exp_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type, typename IntType>
bool __vectorcall pow2n_avx2(IntType const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point 2^n
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall pow2n_avx2(long long const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point 2^n
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall pow2n_avx2(int const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall expm_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall expm_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point exponential with minus exponent function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall expm_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

/// logaritmhmic functions:

template <typename Type> bool __vectorcall log_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed single-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall log_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

/**
 * Packed double-precision floating-point natural log function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall log_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/// trig functions:

template <typename Type> bool __vectorcall cos_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall cos_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall cos_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall sin_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall sin_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall sin_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall tan_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall tan_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall tan_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall cot_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall cot_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point cotangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall cot_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall acos_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall acos_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point arcus cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall acos_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall asin_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall asin_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point arcus sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall asin_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall atan_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall atan_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point arcus tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall atan_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

/// hyperbolic functions:

template <typename Type> bool __vectorcall cosh_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall cosh_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point hyperbolic cosine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall cosh_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall sinh_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall sinh_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point hyperbolic sine
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall sinh_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall tanh_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall tanh_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point hyperbolic tangens
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall tanh_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

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
/// <summary>
///  ====================================================================================================
///  ======================================= avx2_specials  =============================================
///  ====================================================================================================
/// </summary>

namespace avx2_specials
{

template <typename Type> bool __vectorcall erf_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall erf_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall erf_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool __vectorcall erfc_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall erfc_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point complementary error function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <> AVX2_MATH_X86_API bool __vectorcall erfc_avx2(float const *in_aligned_32, float *out_aligned_32, int size);

template <typename Type> bool expint_avx2(Type const *in_aligned_32, Type *out_aligned_32, int size);

/**
 * Packed double-precision floating-point exponential integral function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall expint_avx2(double const *in_aligned_32, double *out_aligned_32, int size);

/**
 * Packed single-precision floating-point exponential integral function
 *
 * \param in_aligned_32
 * \param size
 * \param out_aligned_32
 * \return boolean indicating success or failure
 */
template <>
AVX2_MATH_X86_API bool __vectorcall expint_avx2(float const *in_aligned_32, float *out_aligned_32, int size);
} // namespace avx2_specials

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
 * Aligned allocation for 32-bit integer
 *
 * \param size
 * \param alignment
 * \return pointer to allocated aligned 32-bit integer memory
 * block
 */
template <> AVX2_MATH_X86_API __int32 *aligned_alloc<__int32>(std::size_t size, std::size_t alignment);

/**
 * Aligned allocation for 64-bit integer
 *
 * \param size
 * \param alignment
 * \return pointer to allocated aligned 64-bit integer memory
 * block
 */
template <> AVX2_MATH_X86_API __int64 *aligned_alloc<__int64>(std::size_t size, std::size_t alignment);

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

/**
 * Aligned free for 32-bit integer memory block
 *
 * \param x
 *
 */
template <> AVX2_MATH_X86_API void aligned_free(__int32 *x);

/**
 * Aligned free for 64-bit integer memory block
 *
 * \param x
 *
 */
template <> AVX2_MATH_X86_API void aligned_free(__int64 *x);

} // namespace avx2_utility

#endif ///_AVX2_MATH_X86_EXPORTS
