//
//  Record.h
//  example5
//
//  Created by Кражевский Алексей И. on 6/8/22.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Record : NSManagedObject

@property (nonatomic, retain) NSString * cityFrom;
@property (nonatomic, retain) NSString * cityTo;
//@property (nonatomic, retain) NSString * company;
@property (nonatomic, retain) NSNumber* price;
@property (nonatomic, retain) NSString * aviaCompany;

@end
