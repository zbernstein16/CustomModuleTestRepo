//
//  ORKPainStepView.m
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/26/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKPainStepView.h"

@implementation ORKPainStepView



-(void)buttonPressed:(UIButton *)sender
{
    NSLog(@"Button Pressed");
    NSInteger region = sender.tag;
    [self.buttonDelegate regionPressedWithRegion:region];
    
    
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if(self) {
        [self setup];
    }
    return self;
}
- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}
- (void)setup {
//    [self setupFrames];
//    [[NSBundle bundleForClass:[self class]] loadNibNamed:@"ORKPainStepView" owner:self options:nil];
//    
//    _buttonsArray = [NSMutableArray new];
//    for(id object in self.view.subviews)
//    {
//       if ([object isMemberOfClass:[UIButton class]])
//       {
//           UIButton *button = (UIButton *) object;
//            [button setTitle:@"0" forState:UIControlStateNormal];
//           [button setAlpha:0.1];
//           [_buttonsArray addObject:button];
//       }
//    }
//    [self addSubview:self.view];
    UIImage *background = [UIImage imageWithContentsOfFile:[[NSBundle bundleForClass:[self class]] pathForResource:@"back" ofType:@"png"]];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.frame];
    imageView.clipsToBounds = YES;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [imageView setImage:background];
    [self addSubview:imageView];
    
    _buttonsArray = [[NSMutableArray alloc] initWithCapacity:7];
    for (int i=0;i<7;i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width/8.0, self.frame.size.width/8.0)];
        [button setBackgroundColor:[UIColor redColor]];
        [button setTitle:@"0" forState:UIControlStateNormal];
        [button setAlpha:0.05];
        [button.layer setCornerRadius:self.frame.size.width/16.0];
        button.tag = (NSInteger) i;
        [button addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        float widthRatio = 2.7;
        switch((int)button.tag)
        {
            //Neck
            case 0:
                [button setCenter:CGPointMake(self.frame.size.width/2.05, self.frame.size.height/15.0)];
                break;

            //Upper Left
            case 1:
                [button setCenter:CGPointMake(self.frame.size.width/widthRatio, self.frame.size.height/3.0)];
                break;
                
            //Mid Left
            case 2:
                [button setCenter:CGPointMake(self.frame.size.width/widthRatio, 2.0*self.frame.size.height/3.0)];
                break;
            //Lower Left
            case 3:
                [button setCenter:CGPointMake(self.frame.size.width/widthRatio, 5.0*self.frame.size.height/6.0)];
                break;
                
            //Lower Right
            case 4:
                [button setCenter:CGPointMake((1-1/widthRatio)*self.frame.size.width, 5.0*self.frame.size.height/6.0)];
                break;
            //Mid Right
            case 5:
                [button setCenter:CGPointMake((1-1/widthRatio)*self.frame.size.width, 2.0*self.frame.size.height/3.0)];
                break;
                
            //Upper Right
            case 6:
                [button setCenter:CGPointMake((1-1/widthRatio)*self.frame.size.width, self.frame.size.height/3.0)];
                break;
            default:
                NSLog(@"Failed");
                break;
                
        }
        [self addSubview:button];
        [_buttonsArray addObject:button];
        
    }
}
-(void)setupFrames
{
    //[self.view setFrame:self.frame];
    
}
-(void)setPainScaleValue:(int)value forRegion:(NSInteger)region
{
    UIButton *button = _buttonsArray[region];
    NSString *title = [NSString stringWithFormat:@"%i",value];
    [button setTitle:title forState:UIControlStateNormal];
    if(value == 0)
    {
        [button setAlpha:0.05];
    }
    else {
    button.alpha += 0.05;
    }

}
-(void)setUpButtons
{
//    for(id object in self.view.subviews)
//    {
//        if ([object isMemberOfClass:[UIButton class]])
//        {
//            UIButton *button = (UIButton *) object;
//            [button setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)];
//            NSLog(@"Button Tag:%i x:%f y%f",(int)button.tag,button.center.x,button.center.y);
//            
//        }
//    }
//    [self setNeedsDisplay];

}
@end
