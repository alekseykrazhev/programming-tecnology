#include <vector>
#include <string>
#include <sstream>
#include <fstream>
#include <iostream>

struct Product{
    std::string name;
    std::string price;
    std::string store;
    std::string sort;
    std::string date;
    std::string good;
};  

std::vector<Product> init(int value);

void end_this_year(std::vector<Product>);
