#include "json_reader.hpp"
#include <nlohmann/json.hpp>
#include <fstream>

SAIGON_NAMESPACE_BEGIN
void json_reader::read(std::string_view path)
{
	using json = nlohmann::json;
	std::ifstream ifs(path.data());
	auto config = json::parse(ifs);
	int xx = 0;
}
SAIGON_NAMESPACE_END