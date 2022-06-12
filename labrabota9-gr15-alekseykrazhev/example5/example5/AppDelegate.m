//
//  AppDelegate.m
//  example5
//
//  Created by Кражевский Алексей И. on 6/6/22.
//

#import "AppDelegate.h"
#import "Record.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

@synthesize
managedObjectContext,managedObjectModel,persistentStoreCoordinator;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasLaunchedOnce"]) { [[NSUserDefaults standardUserDefaults] setBool: YES
    forKey:@"HasLaunchedOnce"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    Record* firstFlight = [NSEntityDescription
    insertNewObjectForEntityForName:@"Record"
    inManagedObjectContext:self.managedObjectContext];
    firstFlight.cityFrom = @"Челябинск"; firstFlight.cityTo = @"Москва"; firstFlight.aviaCompany = @"Аэрофлот"; firstFlight.price = @(1000.0);
    Record* secondFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    secondFlight.cityFrom = @"Челябинск";
        secondFlight.cityTo = @"Москва";
        secondFlight.aviaCompany = @"ЧелАвиа";
        secondFlight.price = @(2000.0);
    Record* thirdFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    thirdFlight.cityFrom = @"Екатеринбург";
        thirdFlight.cityTo = @"Уфа";
        thirdFlight.aviaCompany = @"Аэрофлот";
        thirdFlight.price = @(500.0);
    Record* fourthFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    fourthFlight.cityFrom = @"Челябинск";
        fourthFlight.cityTo = @"Уфа";
        fourthFlight.aviaCompany = @"РусЛайн";
        fourthFlight.price = @(1500.0);
    Record* fifthFlight = [NSEntityDescription insertNewObjectForEntityForName:@"Record" inManagedObjectContext:self.managedObjectContext];
    fifthFlight.cityFrom = @"Екатеринбург";
        fifthFlight.cityTo = @"Москва";
    fifthFlight.aviaCompany = @"Аэрофлот";
        fifthFlight.price = @(800.0);
    [self saveContext];
    }
    return true;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}

// 1
- (NSManagedObjectContext *) managedObjectContext {
    if (managedObjectContext != nil) { return managedObjectContext;
    }
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) { managedObjectContext =
        [[NSManagedObjectContext alloc] init];
            [managedObjectContext
        setPersistentStoreCoordinator: coordinator];
    }
    return managedObjectContext;
}
//2
- (NSManagedObjectModel *)managedObjectModel {
    if (managedObjectModel != nil) { return managedObjectModel;
    }
    managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
          return managedObjectModel;
      }
- (NSURL *)applicationDocumentsDirectory { return [[[NSFileManager defaultManager]
    URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
    }
    
//3
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
if (persistentStoreCoordinator != nil) { return persistentStoreCoordinator;
}
NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"flight.sqlite"];
NSError *error = nil;
persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![persistentStoreCoordinator
addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
URL:storeURL options:nil error:&error]) {
}
    return persistentStoreCoordinator;
}

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext; NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
    // Replace this implementation with code to handle the error appropriately.
    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
    abort();
        
    }
}


@end
