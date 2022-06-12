#include <iostream>
#include "/home/alex/Desktop/study/4 sem/TP/labrabota3-z3-gr15-alekseykrazhev/include/PRODUCT.h"


int main(){
    std::vector<PRODUCT> vec = init(10);
    std::cout << "\nProducts with two days left:\n";
    two_days(vec);
    std::cout << "\nCount for suppliers:\n";
    same_sup(vec); 
    std::cout << "\nMax price:\n";
    max_price(vec);
    std::cout << "\nSorted:\n";
    date_up(vec);
    return 0;
}