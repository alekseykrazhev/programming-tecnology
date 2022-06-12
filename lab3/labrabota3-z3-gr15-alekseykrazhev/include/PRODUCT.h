#include <vector>
#include <string>
#include <sstream>
#include <set>
#include <algorithm>
#include <iostream>

struct PRODUCT{
    std::string name;
    int price;
    std::string date;
    int good;
    int amount;
    std::string supplier;
};  

std::vector<PRODUCT> init(int value);

void two_days(std::vector<PRODUCT> vec);

void same_sup(std::vector<PRODUCT> vec);

void max_price(std::vector<PRODUCT> vec);

void date_up(std::vector<PRODUCT> vec);
