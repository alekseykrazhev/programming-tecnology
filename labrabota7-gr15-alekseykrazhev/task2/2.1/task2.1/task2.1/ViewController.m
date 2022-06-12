//
//  ViewController.m
//  task2.1
//
//  Created by Кражевский Алексей И. on 5/12/22.
//

#import "ViewController.h"

NSDictionary *temperatures;
NSDictionary *places;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *InputField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *Temperature;
@end

@implementation ViewController
- (IBAction)buttonPress:(id)sender {
    NSString *cityName= _InputField.text;
    
    NSNumber *temperatur = [temperatures objectForKey:cityName];
    int temp = [temperatur intValue];
    
    if(temperatur==nil){
        ///обработка исключения
        _Temperature.text=@"No city found";
    }
    else{
        ///смена значения температуры
        _Temperature.text=( [[temperatur stringValue] stringByAppendingString:@" C"] );
    
        /// смена цвета
        if(temp <= 0) {
            _Temperature.textColor = [UIColor blueColor];
        }
        if(temp > 0 && temp <= 10){
            _Temperature.textColor = [UIColor yellowColor];
        }
        if(temp > 10) {
            _Temperature.textColor = [UIColor redColor];
        }

    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _Temperature.text=@"0 C";
    
    temperatures =[NSMutableDictionary dictionary];
     
     places =[NSMutableDictionary dictionary];
     
     ///Словарь для связи температур и городов.
     [temperatures setValue:[NSNumber numberWithInt:16] forKey:@"Minsk"];
     [temperatures setValue:[NSNumber numberWithInt:33] forKey:@"Milan"];
     [temperatures setValue:[NSNumber numberWithInt:35] forKey:@"Rome"];
     [temperatures setValue:[NSNumber numberWithInt:14] forKey:@"Moscow"];
     [temperatures setValue:[NSNumber numberWithInt:0] forKey:@"Brest"];
      [temperatures setValue:[NSNumber numberWithInt:8] forKey:@"Yerevan"];
}


@end
