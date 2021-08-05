#include "json_reader.hpp"
#include <gtest/gtest.h>

int main(int argc, char* argv[])
{
	testing::InitGoogleTest(&argc, argv);
	return RUN_ALL_TESTS();
}

TEST(json_reader, load_json_file)
{
	ASSERT_EQ(1, 1);
}