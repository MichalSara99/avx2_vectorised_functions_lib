#pragma once
#if !defined(_AVX2_UTILITIES)
#define _AVX2_UTILITIES

#include <new>
#include <typeinfo>

namespace avx2_utilities
{

template <typename Type> Type *aligned_alloc(std::size_t size, std::size_t Alignment)
{
    return (Type *)operator new[](sizeof(Type) * size, std::align_val_t(Alignment));
}

template <typename Type> void aligned_free(Type *x)
{
    _aligned_free((void *)x);
}

} // namespace avx2_utilities

#endif ///_AVX2_UTILITIES
