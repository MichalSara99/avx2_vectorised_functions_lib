#include "headers/avx2_math_x86_lib.h"
#include "headers/avx2_math_x86.h"
#include "headers/avx2_utilities.h"
#include "headers/math_constants.h"
#include "headers/pch.h"

using namespace avx2_math;

/// ========================== MATH CONSTANTS ==================================
template <> const double avx2_constants::pi()
{
    return avx2_math_constants::pi<double>;
}
template <> const float avx2_constants::pi()
{
    return avx2_math_constants::pi<float>;
}

/// ========================== BASIC OPERATIONS ================================

template <>
bool __vectorcall avx2_basics::mul_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                              int size)
{
    return avx2_math::mul_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::mul_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::mul_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::mul_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::mul_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::mul_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::mul_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                              int size)
{
    return avx2_math::div_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::div_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_broad_avx2(double const x, double const *y_aligned_32, double *out_aligned_32,
                                              int size)
{
    return avx2_math::div_broad_avx2_packed(x, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_broad_avx2(float const x, float const *y_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::div_broad_avx2_packed(x, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::div_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::div_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::div_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::add_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                              int size)
{
    return avx2_math::add_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::add_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::add_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::add_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::add_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::add_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::add_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_broad_avx2(double const *x_aligned_32, double const y, double *out_aligned_32,
                                              int size)
{
    return avx2_math::sub_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_broad_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::sub_broad_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_broad_avx2(double const x, double const *y_aligned_32, double *out_aligned_32,
                                              int size)
{
    return avx2_math::sub_broad_avx2_packed(x, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_broad_avx2(float const x, float const *y_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::sub_broad_avx2_packed(x, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::sub_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::sub_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::sub_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::neg_avx2(double const *x_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::neg_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::neg_avx2(float const *x_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::neg_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::inv_avx2(double const *x_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::inv_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::inv_avx2(float const *x_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::inv_avx2_packed(x_aligned_32, out_aligned_32, size);
}

///// =========================== BASIC FUNCTIONS ================================
template <> bool __vectorcall avx2_basics::abs_avx2(double const *x_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::abs_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::abs_avx2(float const *x_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::abs_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sqrt_avx2(double const *x_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::sqrt_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sqrt_avx2(float const *x_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::sqrt_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sqrp_avx2(double const *x_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::sqrp_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sqrp_avx2(float const *x_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::sqrp_avx2_packed(x_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::min_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::min_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::min_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::min_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::min_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::min_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::min_avx2(double const *x_aligned_32, double const y, double *out_aligned_32, int size)
{
    return avx2_math::min_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::max_avx2(float const *x_aligned_32, float const *y_aligned_32, float *out_aligned_32,
                                        int size)
{
    return avx2_math::max_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::max_avx2(double const *x_aligned_32, double const *y_aligned_32, double *out_aligned_32,
                                        int size)
{
    return avx2_math::max_avx2_packed(x_aligned_32, y_aligned_32, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::max_avx2(float const *x_aligned_32, float const y, float *out_aligned_32, int size)
{
    return avx2_math::max_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

template <>
bool __vectorcall avx2_basics::max_avx2(double const *x_aligned_32, double const y, double *out_aligned_32, int size)
{
    return avx2_math::max_avx2_packed(x_aligned_32, y, out_aligned_32, size);
}

/// ======================== EXPONENTIAL FUNCTIONS ============================

template <> bool __vectorcall avx2_basics::exp_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::exp_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::exp_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::exp_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::expm_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::expm_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::expm_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::expm_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::pow2n_avx2(long long const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::pow2n_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::pow2n_avx2(int const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::pow2n_avx2_packed(in_aligned_32, out_aligned_32, size);
}

/// ========================= LOGARITHMIC FUNCTIONS ===========================

template <> bool __vectorcall avx2_basics::log_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::log_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::log_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::log_avx2_packed(in_aligned_32, out_aligned_32, size);
}

/// ===================== NORMAL DISTRIBUTION FUNCTIONS =========================
// template <> bool avx2_normal_distribution::norm_cdf_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::norm_cdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_normal_distribution::norm_cdf_sse(double const *in_aligned_16, int size, double
// *out_aligned_16)
//{
//    return sse_math::norm_cdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_normal_distribution::norm_pdf_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::norm_pdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_normal_distribution::norm_pdf_sse(double const *in_aligned_16, int size, double
// *out_aligned_16)
//{
//    return sse_math::norm_pdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_normal_distribution::norm_inv_cdf_sse(float const *in_aligned_16, int size, float
// *out_aligned_16)
//{
//    return sse_math::norm_inv_cdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_normal_distribution::norm_inv_cdf_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::norm_inv_cdf_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
/// =========================== SPECIAL FUNCTIONS =============================

template <> bool __vectorcall avx2_specials::erf_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::erf_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_specials::erf_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::erf_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_specials::erfc_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::erfc_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_specials::erfc_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::erfc_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_specials::expint_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::expint_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_specials::expint_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::expint_avx2_packed(in_aligned_32, out_aligned_32, size);
}

/// ============================ TRIG FUNCTIONS ===============================

template <> bool __vectorcall avx2_basics::cos_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::cos_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::cos_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::cos_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sin_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::sin_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sin_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::sin_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::tan_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::tan_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::tan_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::tan_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::cot_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::cot_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::cot_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::cot_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::acos_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::acos_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::acos_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::acos_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::asin_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::asin_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::asin_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::asin_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::atan_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::atan_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::atan_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::atan_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::cosh_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::cosh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::cosh_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::cosh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sinh_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::sinh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::sinh_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::sinh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::tanh_avx2(double const *in_aligned_32, double *out_aligned_32, int size)
{
    return avx2_math::tanh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

template <> bool __vectorcall avx2_basics::tanh_avx2(float const *in_aligned_32, float *out_aligned_32, int size)
{
    return avx2_math::tanh_avx2_packed(in_aligned_32, out_aligned_32, size);
}

/// ========================= UTILITY FUNCTIONS ================================

template <> float *avx2_utility::aligned_alloc<float>(std::size_t size, std::size_t alignment)
{
    return avx2_utilities::aligned_alloc<float>(size, alignment);
}

template <> double *avx2_utility::aligned_alloc<double>(std::size_t size, std::size_t alignment)
{
    return avx2_utilities::aligned_alloc<double>(size, alignment);
}

template <> __int32 *avx2_utility::aligned_alloc<__int32>(std::size_t size, std::size_t alignment)
{
    return avx2_utilities::aligned_alloc<__int32>(size, alignment);
}

template <> __int64 *avx2_utility::aligned_alloc<__int64>(std::size_t size, std::size_t alignment)
{
    return avx2_utilities::aligned_alloc<__int64>(size, alignment);
}

template <> void avx2_utility::aligned_free(float *x)
{
    return avx2_utilities::aligned_free<float>(x);
}

template <> void avx2_utility::aligned_free(double *x)
{
    return avx2_utilities::aligned_free<double>(x);
}

template <> void avx2_utility::aligned_free(__int32 *x)
{
    return avx2_utilities::aligned_free<__int32>(x);
}

template <> void avx2_utility::aligned_free(__int64 *x)
{
    return avx2_utilities::aligned_free<__int64>(x);
}
