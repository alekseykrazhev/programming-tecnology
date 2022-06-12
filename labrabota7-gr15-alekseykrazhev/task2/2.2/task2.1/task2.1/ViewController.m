//
//  ViewController.m
//  task2.1
//
//  Created by Кражевский Алексей И. on 5/12/22.
//

#import "ViewController.h"

NSDictionary *temperatures;
NSDictionary *places;
NSDictionary *info;

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UITextField *InputField;
@property (weak, nonatomic) IBOutlet UIButton *button;
@property (weak, nonatomic) IBOutlet UILabel *Temperature;
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;
@property (weak, nonatomic) IBOutlet UILabel *SportInfo;
@end

@implementation ViewController
- (IBAction)buttonPress:(id)sender {
    NSString *cityName= _InputField.text;
    
    NSNumber *temperatur = [temperatures objectForKey:cityName];
    int temp = [temperatur intValue];
    NSString *sport=[places objectForKey:cityName];
    NSString *inf=[info objectForKey:cityName];
    
    if(temperatur==nil){
        ///обработка исключения
        _Temperature.text=@"No city found";
    }
    else{
        ///смена значения температуры
        _Temperature.text=( [[temperatur stringValue] stringByAppendingString:@" C"] );
    
        _ImageView.image=[UIImage imageNamed:sport];
        
        _SportInfo.text=inf;
        
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
    _SportInfo.text = @"";
    
    temperatures =[NSMutableDictionary dictionary];
     
     places =[NSMutableDictionary dictionary];
    
    info = [NSMutableDictionary dictionary];
     
     ///Словарь для связи температур и городов.
     [temperatures setValue:[NSNumber numberWithInt:16] forKey:@"Minsk"];
     [temperatures setValue:[NSNumber numberWithInt:33] forKey:@"Gomel"];
     [temperatures setValue:[NSNumber numberWithInt:35] forKey:@"Bejing"];
     [temperatures setValue:[NSNumber numberWithInt:14] forKey:@"Nanjing"];
     [temperatures setValue:[NSNumber numberWithInt:0] forKey:@"Brest"];
      [temperatures setValue:[NSNumber numberWithInt:8] forKey:@"Chengdu"];
    
    [places setValue:@"minsk" forKey:@"Minsk"];
    [places setValue:@"bejing" forKey:@"Bejing"];
    [places setValue:@"brest" forKey:@"Brest"];
    [places setValue:@"gomel" forKey:@"Gomel"];
    [places setValue:@"nanjing" forKey:@"Nanjing"];
    [places setValue:@"chengdu" forKey:@"Chengdu"];
    
    [info setValue:@"basketball stadium, swimming pool, a gymnasium, a martial art space, and rooms for boxing, taekwondo, table tennis, etc." forKey:@"Chengdu"];
    [info setValue:@"Nanjing Olympic Sports Centre. Used for various sport activities since 2007." forKey:@"Nanjing"];
    [info setValue:@"club teams in basketball, volleyball, handball. " forKey:@"Brest"];
    [info setValue:@"Mostly football, sometimes conserts." forKey:@"Gomel"];
    [info setValue:@"Hockey matches and concerts are held in the main area. Minsk Arena has a skating rink where children and adults can rent skates." forKey:@"Minsk"];
    [info setValue:@"basketball stadium, swimming pool, a gymnasium, a martial art space, and rooms for boxing, taekwondo, table tennis, etc." forKey:@"Bejing"];
}


@end
