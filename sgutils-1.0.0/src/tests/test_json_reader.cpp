#include "json_reader.hpp"
#include <gtest/gtest.h>

int main(int argc, char* argv[])
{
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

TEST(json_reader, load_json_file)
{
	using namespace std::string_literals;
	sg::json_reader reader{};
	reader.read("config.json");
	auto v = reader.get<std::string>("frontend_host");
	ASSERT_EQ(v, "tcp://*:5555"s);
}