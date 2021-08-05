#include "json_reader.hpp"
#include <gtest/gtest.h>

int main(int argc, char* argv[])
{
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

TEST(json_reader, read_single_attribute)
{
	using namespace std::string_literals;
	sg::json_reader reader{};
	reader.read("01.json");
	auto v1 = reader.get<std::string>("key01");
	ASSERT_EQ(v1, "value01"s);
}

TEST(json_reader, read_multiple_attribute)
{
	using namespace std::string_literals;
	sg::json_reader reader{};
	reader.read("02.json");
	auto v1 = reader.get<std::string>("key01");
	ASSERT_EQ(v1, "value01"s);
	auto v2 = reader.get<std::string>("key02");
	ASSERT_EQ(v2, "value02"s);
}

TEST(json_reader, read_not_exist_attribute)
{
	using namespace std::string_literals;
	sg::json_reader reader{};
	reader.read("01.json");
	auto v1 = reader.get<std::string>("key is not existed");
	ASSERT_EQ(v1, std::nullopt);
}