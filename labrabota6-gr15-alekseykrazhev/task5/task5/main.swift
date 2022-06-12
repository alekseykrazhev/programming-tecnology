//
//  main.swift
//  task5
//
//  Created by Alex on 2/15/22.
//  Copyright © 2022 Alex. All rights reserved.
//

import Foundation

// initialize empty Dictionary
var Product : Dictionary<String, Int> = [:]
// initialize Dictionary with data
var Shop: Dictionary<String, Int> = ["Perekrestok": 50, "Evroopt": 150, "Zara": 20, "Angelo": 10]

// count amount of data in Dictionary
print("Amount of data = ", Shop.count)

// print element by key
var key: String = "Evroopt"
print("\(key): \(String(describing: Shop[key]?.description))")

// print all elements in Dictionary
print("All elements in Shop:")
for (shop, val) in Shop{
    print ("\(shop): \(val) ")
}

// Add element to Dictionary
Product["Fish"] = 2022
print("Fish: \(String(describing: Product["Fish"]?.description))")

// modify elements in Dictionary
Shop.updateValue(25, forKey: "Zara")
print("Zara: \(String(describing: Shop["Zara"]))")

// sort by key
let sorted = Shop.sorted { $0.key < $1.key }
print("Shop Dict sorted by key:")
for (shop, val) in sorted{
    print ("\(shop): \(val) ")
}

// sort by element
let sorted1 = Shop.sorted { $0.value < $1.value }
print("Shop Dict sorted by key:")
for (shop, val) in sorted1{
    print ("\(shop): \(val) ")
}

// delete element
Shop.removeValue(forKey: "Perekrestok")
print("Removed Perekrestok from Shop")
for (shop, val) in Shop{
    print ("\(shop): \(val)")
}

// delete all elements
Product.removeAll()
if (Product.isEmpty) {
    print("Deleted all elements from Product successfully")
} else {
    print("Delete failed")
}
