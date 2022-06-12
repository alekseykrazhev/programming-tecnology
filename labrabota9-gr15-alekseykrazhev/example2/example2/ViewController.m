//
//  ViewController.m
//  example2
//
//  Created by Кражевский Алексей И. on 6/6/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIView *regV;
@property (strong, nonatomic) IBOutlet UISegmentedControl *segm;
@property (strong, nonatomic) IBOutlet UITextField *loginL;
@property (strong, nonatomic) IBOutlet UITextField *passL;
@property (strong, nonatomic) IBOutlet UITextField *loginR;
@property (strong, nonatomic) IBOutlet UITextField *mailR;
@property (strong, nonatomic) IBOutlet UITextField *passR;
@property (strong, nonatomic) IBOutlet UITextField *r_passR;
@property (strong, nonatomic) IBOutlet UISwitch *agreeR;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_regV setHidden:YES];
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    
    if ([user objectForKey:@"login"] != nil || [user objectForKey:@"pass"] !=nil) {
        [self performSegueWithIdentifier:@"closeZone" sender:self];
    }
}

- (IBAction)segment:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger select = seg.selectedSegmentIndex;
    
    if (select == 0){
        [_regV setHidden:YES];
    } else {
        [_regV setHidden:NO];
    }
}
- (IBAction)segmentR:(id)sender {
    UISegmentedControl *seg = (UISegmentedControl *)sender;
    NSInteger select = seg.selectedSegmentIndex;
    
    if (select == 0){
        [_regV setHidden:NO];
    } else {
        [_regV setHidden:YES];
    }
}

- (IBAction)buttonL:(id)sender {
    if (![_loginL.text isEqualToString:@""] || ![_passL.text isEqualToString:@""]) {
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:_loginL.text forKey:@"login"];
        [user setObject:_passL.text forKey:@"pass"];
        [self performSegueWithIdentifier:@"closeZone" sender:self];
    }
}

- (IBAction)buttonR:(id)sender {
    if (![_loginR.text isEqualToString:@""] || ![_passR.text isEqualToString:@""] || ![_mailR.text isEqualToString:@""] || ![_r_passR.text isEqualToString:@""]) {
        
        if (![_passR.text isEqualToString:_r_passR.text]){
            NSLog(@"passwords don't match");
            return;
        }
        
        if (!_agreeR.on){
            NSLog(@"agree with terms!");
            return;
        }
        
        NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
        [user setObject:_loginL.text forKey:@"login"];
        [user setObject:_passL.text forKey:@"pass"];
        [self performSegueWithIdentifier:@"closeZone" sender:self];
    } else {
        NSLog(@"fill the rest!");
    }
}

@end
