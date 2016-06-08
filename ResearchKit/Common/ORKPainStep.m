

//
//  ORKPainStep.m
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/24/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//


#import "ORKHelpers.h"
#import "ORKStep_Private.h"
#import "ORKPainStepViewController.h"
#import "ORKDefines_Private.h"
#import "ORKPainStep.h"

@implementation ORKPainStep


+(Class)stepViewControllerClass
{
    return [ORKPainStepViewController class];
}

+(instancetype)painStepWithIdentifier:(NSString *)identifier title:(NSString *)title text:(NSString *)text
{
    ORKPainStep *step = [[ORKPainStep alloc] initWithIdentifier:identifier];
    step.title = title;
    step.text = text;
    return step;
}
-(instancetype)initWithIdentifier:(NSString *)identifier{
    self = [super initWithIdentifier:identifier];
    if(self)
    {
        self.optional = NO;
    }
    return self;
}
-(instancetype)init {
    self = [super init];
    if(self)
    {
    }
    return self;
}
-(void)validateParameters
{
    [super validateParameters];
}
-(instancetype)copyWithZone:(NSZone *)zone
{
    ORKPainStep *step = [super copyWithZone:zone];
    return step;
}
-(BOOL)isEqual:(id)object
{
    BOOL isParentSame = [super isEqual:object];
    
    __typeof(self) castObject = object;
    return isParentSame &&
    ORKEqualObjects(self.title, castObject.title) &&
    ORKEqualObjects(self.text, castObject.text);

}
- (NSUInteger)hash {
    return [super hash];
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    return self;
}
-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [super encodeWithCoder:aCoder];
}
+ (BOOL)supportsSecureCoding {
    return YES;
}











@end