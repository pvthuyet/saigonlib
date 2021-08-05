#pragma once

#include "define.hpp"
#include <string>
#include <nlohmann/json.hpp>
#include <memory>

SAIGON_NAMESPACE_BEGIN
class json_reader
{
private:
	std::unique_ptr<nlohmann::json> data_;

public:
	void read(std::string_view path);
	
	template<typename T>
	T get(std::string_view key)
	{
		return data_->at(key.data()).get<T>();
	}
};

SAIGON_NAMESPACE_END