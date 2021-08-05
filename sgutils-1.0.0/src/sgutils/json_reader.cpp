#include "json_reader.hpp"
#include <fstream>

SAIGON_NAMESPACE_BEGIN
void json_reader::read(std::string_view path)
{
	using json = nlohmann::json;
	std::ifstream ifs(path.data());
	data_ = std::make_unique<json>(json::parse(ifs));
}
SAIGON_NAMESPACE_END