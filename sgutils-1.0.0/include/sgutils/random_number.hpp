#pragma once
#include "define.hpp"
#include <random>
#include <concepts>

SAIGON_NAMESPACE_BEGIN
class random_number
{
public:
	template<typename T> requires (std::integral<T> || std::floating_point<T>)
	T operator()(T a, T b)
	{
		std::random_device rd;  //Will be used to obtain a seed for the random number engine
		std::mt19937 gen(rd()); //Standard mersenne_twister_engine seeded with rd()
		if constexpr (std::integral<T>) {
			std::uniform_int_distribution<T> dis(a, b);
			return dis(gen);
		}
		else {
			std::uniform_real_distribution<T> dis(a, b);
			return dis(gen);
		}
	}
};
SAIGON_NAMESPACE_END