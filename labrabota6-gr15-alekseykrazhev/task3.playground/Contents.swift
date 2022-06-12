//: A Cocoa based Playground to present user interface

import AppKit
import PlaygroundSupport
import Foundation

let nibFile = NSNib.Name("MyView")
var topLevelObjects : NSArray?

Bundle.main.loadNibNamed(nibFile, owner:nil, topLevelObjects: &topLevelObjects)
let views = (topLevelObjects as! Array<Any>).filter { $0 is NSView }

// Present the view in Playground
PlaygroundPage.current.liveView = views[0] as! NSView

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
