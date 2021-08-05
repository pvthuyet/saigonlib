#pragma once

#include "define.hpp"
#include <string>
#include <nlohmann/json.hpp>
#include <memory>
#include <optional>

SAIGON_NAMESPACE_BEGIN
class json_reader
{
private:
	std::unique_ptr<nlohmann::json> data_;

public:
	void read(std::string_view path);
	
	template<typename T>
	std::optional<T> get(std::string_view key)
	{
		try {
			return data_->at(key.data()).get<T>();
		}
		catch (std::exception const&) {
			return std::nullopt;
		}
	}
};

SAIGON_NAMESPACE_END