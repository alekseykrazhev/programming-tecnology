//
//  main.m
//  task1
//
//  Created by Alex on 4/15/22.
//  Copyright © 2022 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        for (int i = 0; i < 1000; i++){
            if ((i / 100) % 2 != 0){
                int b = i % 10;
                int x = i % 100;
                int c = x / 10;
                int a = i / 100;
                if (a==b | a==c | b==c){
                    NSLog (@"%i%i%i", a, c, b);
                }
            }
        }
    }
    return 0;
}
