#pragma once
#include "define.hpp"
#include <random>
#include <concepts>
#include <boost/uuid/uuid.hpp>
#include <boost/uuid/uuid_generators.hpp>
#include <boost/uuid/uuid_io.hpp>
#include <boost/lexical_cast.hpp>

SAIGON_NAMESPACE_BEGIN
class random_factor
{
public:
	template<typename T> requires (std::integral<T> || std::floating_point<T>)
		T random_number(T a, T b)
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

	template<typename T> requires(std::same_as<T, std::string> || std::same_as<T, std::wstring>)
	T ramdom_uuid()
	{
		auto uuid = boost::uuids::random_generator()();
		return boost::lexical_cast<T>(uuid);
	}
};
SAIGON_NAMESPACE_END