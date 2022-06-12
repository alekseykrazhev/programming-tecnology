#include "/home/alex/Desktop/study/4 sem/TP/labrabota3-z4-gr15-alekseykrazhev/include/Product.h"

std::vector<Product> init(int value)
{
    std::vector<Product> vec;
    std::ifstream in("./doc/in.txt");

    for (int i = 0; i < value; ++i)
    {
        Product pr;
        std::getline(in, pr.name);
        std::getline(in, pr.price);
        std::getline(in, pr.store);
        std::getline(in, pr.sort);
        std::getline(in, pr.date);
        std::getline(in, pr.good);
        vec.push_back(pr);
    }

    return vec;
}

void end_this_year(std::vector<Product> vec)
{
    std::ofstream out("./doc/out.txt");
    out << "Products ending in 2022:\n";

    for (auto i : vec)
    {
        std::stringstream s1(i.good);
        int year;
        int s;
        while (s1 >> s)
        {
            year = s;
        }
        if (year == 2022)
        {
            out << '\n'
                << i.name << ' ' << i.price << ' ' << i.store << ' ' << i.sort << ' ' << i.date << ' ' << i.good << '\n';
        }
    }
}