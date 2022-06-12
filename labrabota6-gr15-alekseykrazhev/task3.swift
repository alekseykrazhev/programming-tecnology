import Foundation

var x : Int
x = 10
var y : Int
y = 11

//1=y^2 + (x-1)^2
//(x - x0)^2 + (y - y0)^2 <= R^2
var a : Int
a = (x - 1) * (x - 1)
if (a + y * y <= 1) {
    print("fits")
} else {
    print("doesnt fit")
}
