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

// template <> bool avx2_basics::mul_br_sse(double const *x_aligned_16, double const y, int size, double
// *out_aligned_16)
//{
//    return sse_math::mul_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::mul_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
//{
//    return sse_math::mul_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::mul_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::mul_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::mul_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::mul_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::div_br_sse(double const *x_aligned_16, double const y, int size, double
// *out_aligned_16)
//{
//    return sse_math::div_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::div_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
//{
//    return sse_math::div_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::div_br_s_sse(double const x, double const *y_aligned_16, int size, double
// *out_aligned_16)
//{
//    return sse_math::div_br_s_sse_packed(x, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::div_br_s_sse(float const x, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::div_br_s_sse_packed(x, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::div_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::div_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::div_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::div_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::add_br_sse(double const *x_aligned_16, double const y, int size, double
// *out_aligned_16)
//{
//    return sse_math::add_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::add_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
//{
//    return sse_math::add_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::add_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::add_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::add_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::add_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sub_br_sse(double const *x_aligned_16, double const y, int size, double
// *out_aligned_16)
//{
//    return sse_math::sub_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sub_br_sse(float const *x_aligned_16, float const y, int size, float *out_aligned_16)
//{
//    return sse_math::sub_br_sse_packed(x_aligned_16, y, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sub_br_s_sse(double const x, double const *y_aligned_16, int size, double
// *out_aligned_16)
//{
//    return sse_math::sub_br_s_sse_packed(x, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sub_br_s_sse(float const x, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::sub_br_s_sse_packed(x, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::sub_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::sub_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::sub_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::sub_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::neg_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::neg_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::neg_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::neg_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::inv_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::inv_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::inv_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::inv_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
///// =========================== BASIC FUNCTIONS ================================
// template <> bool avx2_basics::abs_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::abs_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::abs_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::abs_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sqrt_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::sqrt_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sqrt_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::sqrt_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sqrpow_sse(double const *in_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::sqrpow_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <> bool avx2_basics::sqrpow_sse(float const *in_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::sqrpow_sse_packed(in_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::mins_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::mins_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::mins_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::mins_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::maxs_sse(float const *x_aligned_16, float const *y_aligned_16, int size, float *out_aligned_16)
//{
//    return sse_math::maxs_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}
//
// template <>
// bool avx2_basics::maxs_sse(double const *x_aligned_16, double const *y_aligned_16, int size, double *out_aligned_16)
//{
//    return sse_math::maxs_sse_packed(x_aligned_16, y_aligned_16, size, out_aligned_16);
//}

/// ======================== EXPONENTIAL FUNCTIONS ============================

template <> bool avx2_basics::exp_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::exp_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::exp_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::exp_avx2_packed(in_aligned_32, size, out_aligned_32);
}

/// ========================= LOGARITHMIC FUNCTIONS ===========================

template <> bool avx2_basics::log_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::log_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::log_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::log_avx2_packed(in_aligned_32, size, out_aligned_32);
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

template <> bool avx2_specials::erf_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::erf_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_specials::erf_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::erf_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_specials::erfc_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::erfc_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_specials::erfc_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::erfc_avx2_packed(in_aligned_32, size, out_aligned_32);
}

/// ============================ TRIG FUNCTIONS ===============================

template <> bool avx2_basics::cos_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::cos_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::cos_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::cos_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::sin_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::sin_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::sin_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::sin_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::tan_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::tan_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::tan_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::tan_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::cot_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::cot_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::cot_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::cot_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::acos_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::acos_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::acos_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::acos_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::asin_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::asin_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::asin_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::asin_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::atan_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::atan_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::atan_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::atan_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::cosh_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::cosh_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::cosh_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::cosh_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::sinh_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::sinh_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::sinh_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::sinh_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::tanh_avx2(double const *in_aligned_32, int size, double *out_aligned_32)
{
    return avx2_math::tanh_avx2_packed(in_aligned_32, size, out_aligned_32);
}

template <> bool avx2_basics::tanh_avx2(float const *in_aligned_32, int size, float *out_aligned_32)
{
    return avx2_math::tanh_avx2_packed(in_aligned_32, size, out_aligned_32);
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

template <> void avx2_utility::aligned_free(float *x)
{
    return avx2_utilities::aligned_free<float>(x);
}

template <> void avx2_utility::aligned_free(double *x)
{
    return avx2_utilities::aligned_free<double>(x);
}
