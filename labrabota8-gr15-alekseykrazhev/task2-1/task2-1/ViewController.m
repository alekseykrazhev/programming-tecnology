//
//  ViewController.m
//  task2-1
//
//  Created by Кражевский Алексей И. on 6/3/22.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *canvas;
@property CGPoint lastPoint;

@property (strong, nonatomic) IBOutlet UISegmentedControl *sizeChoice;
@property CGFloat size;

@property (strong, nonatomic) IBOutlet UISlider *redSwitch;
@property (strong, nonatomic) IBOutlet UISlider *greenSwitch;
@property (strong, nonatomic) IBOutlet UISlider *blueSwitch;
@property CGFloat red;
@property CGFloat blue;
@property CGFloat green;

@property (strong, nonatomic) IBOutlet UIButton *saveButton;
@property int count;

@end

@implementation ViewController

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
  [self setLastPoint:[touch locationInView:self.view]];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    CGPoint currentPoint = [touch locationInView:self.view];
    UIGraphicsBeginImageContext(self.view.frame.size);
    CGRect drawRect = CGRectMake(0.0f, 0.0f, self.view.frame.size.width, self.view.frame.size.height);
    [[[self canvas] image] drawInRect:drawRect]; CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound); CGContextSetLineWidth(UIGraphicsGetCurrentContext(), _size); CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), _red, _green, _blue, 1.0f); CGContextBeginPath(UIGraphicsGetCurrentContext()); CGContextMoveToPoint(UIGraphicsGetCurrentContext(), _lastPoint.x,
    _lastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    [[self canvas] setImage:UIGraphicsGetImageFromCurrentImageContext()]; UIGraphicsEndImageContext();
    _lastPoint = currentPoint;
    
}
- (IBAction)sizeChanged:(UISegmentedControl *)sender {
    switch (self.sizeChoice.selectedSegmentIndex){
        case 0:
            _size = 1.0;
            break;
        case 1:
            _size = 5.0;
            break;
        case 2:
            _size = 7.0;
            break;
        case 3:
            _size = 10.0;
            break;
        case 4:
            _size = 12.0;
            break;
        default:
            _size = 1.0;
            break;
    }
}

- (IBAction)redChanged:(UISlider *)sender {
    _red = _redSwitch.value;
}

- (IBAction)greenCganged:(UISlider *)sender {
    _green = _greenSwitch.value;
}

- (IBAction)blueChanged:(UISlider *)sender {
    _blue = _blueSwitch.value;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _size = 1.0f;
    _red = 0.1f;
    _green = 0.1f;
    _blue = 0.1f;
    _count = 0;
}

- (IBAction)saveClicked:(UIButton *)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *docs = [paths objectAtIndex:0];
    NSString* path =  [docs stringByAppendingFormat:@"/image1.jpg"];

    NSData* imageData = [NSData dataWithData:UIImageJPEGRepresentation(_canvas.image, .8)];
    NSError *writeError = nil;

    if(![imageData writeToFile:path options:NSDataWritingAtomic error:&writeError]) {
        NSLog(@"%@: Error saving image: %@", [self class], [writeError localizedDescription]);
    }
}

@end
