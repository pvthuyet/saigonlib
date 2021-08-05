#pragma once

#include "define.hpp"
#include <string>

SAIGON_NAMESPACE_BEGIN
class json_reader
{
public:
	void read(std::string_view path);
};

SAIGON_NAMESPACE_END