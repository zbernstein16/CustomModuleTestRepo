//
//  ORKPainStepView.h
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/26/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ResearchKit/ORKVerticalContainerView.h>
@protocol PainRegionProtocol
-(void)regionPressedWithRegion:(NSInteger)region;

@end
@interface ORKPainStepView : UIView


@property (nonatomic, weak) id <PainRegionProtocol> buttonDelegate;


-(void)setupFrames;
-(void)buttonPressed:(id)sender;
-(void)setPainScaleValue:(int)value forRegion:(NSInteger)region;
-(void)setUpButtons;
@property (nonatomic, strong) NSMutableArray *buttonsArray;
@end
