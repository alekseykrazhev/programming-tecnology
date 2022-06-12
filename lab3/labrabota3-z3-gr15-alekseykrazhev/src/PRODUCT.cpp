#include "/home/alex/Desktop/study/4 sem/TP/labrabota3-z3-gr15-alekseykrazhev/include/PRODUCT.h"

std::vector<PRODUCT> init(int value){
    std::vector<PRODUCT> vec;
    for (int i = 0; i < value; ++i) {
        PRODUCT pr;
        std::cout << "Enter name:\n";
        std::cin >> pr.name;
        std::cout << "Enter price:\n";
        std::cin >> pr.price;
        std::cout << "Enter date:";
        std::getline(std::cin, pr.date);
        std::getline(std::cin, pr.date);
        std::cout << "Enter till its good:\n";
        std::cin >> pr.good;
        std::cout << "Enter amount:\n";
        std::cin >> pr.amount;
        std::cout << "Enter supplier:\n";
        std::cin >> pr.supplier;
        vec.push_back(pr);
    }
    return vec;
}

void two_days(std::vector<PRODUCT> vec){
    for (auto i : vec) {
        if (i.good == 2) {
            std::cout << i.name << ' ' << i.price << ' ' << i.date << ' ' << i.good << ' ' << i.amount << ' ' << i.supplier << '\n';
        }
    }
}

void same_sup(std::vector<PRODUCT> vec){
    std::set<std::string> s;
    for (int i = 0; i < vec.size(); ++i) {
        if(s.count(vec[i].supplier)){
            continue;
        }
        s.insert(vec[i].supplier);
        int count = 0;
        for (int j = i; j < vec.size(); ++j) {
            if (vec[i].supplier == vec[j].supplier){
                count++;
            }
        }
        std::cout << vec[i].supplier << " count = " << count << '\n';
    }
}

void max_price(std::vector<PRODUCT> vec){
    int max = -1;
    int indx = -1;
    for (auto i = 0; i < vec.size(); ++i) {
        if (vec[i].good >= 0 && vec[i].price > max){
            indx = i;
            max = vec[indx].price;
        }
    }
    if (indx != -1) {
        std::cout << vec[indx].name << ' ' << vec[indx].price << ' ' << vec[indx].date << ' '
         << vec[indx].good << ' ' << vec[indx].amount << ' ' << vec[indx].supplier << '\n';
    } else {
        std::cout << "Error!\n";
    }
}

bool comp(PRODUCT a, PRODUCT b){
    std::stringstream s1 (a.date);
    std::stringstream s2 (b.date);
    std::vector<int> a1;
    std::vector<int> b1;
    int s;
    while (s1 >> s){
        a1.push_back(s);
    }
    while (s2 >> s){
        b1.push_back(s);
    }
    for (int i = 2; i >= 0; --i) {
        if (a1[i] < b1[i]) {
            return true;
        }
        if (a1[i] > b1[i]) {
            return false;
        }
    }
    return false;
}

void date_up(std::vector<PRODUCT> vec) {
    std::sort(vec.begin(), vec.end(), comp);
    for (auto i : vec) {
        std::cout << i.name << ' ' << i.price << ' ' << i.date << ' ' << i.good << ' ' << i.amount << ' ' << i.supplier << '\n';
    }
}

