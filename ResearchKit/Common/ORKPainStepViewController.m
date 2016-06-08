//
//  ORKPainStepViewController.m
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/24/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import "ORKPainStepViewController.h"
#import "ORKDefines_Private.h"
#import "ORKResult.h"
#import "ORKTaskViewController_Internal.h"
#import "ORKSkin.h"
#import "ORKStepViewController_Internal.h"

#import "ORKChoiceViewCell.h"
#import "ORKSurveyAnswerCellForScale.h"
#import "ORKSurveyAnswerCellForNumber.h"
#import "ORKSurveyAnswerCellForText.h"
#import "ORKSurveyAnswerCellForPicker.h"
#import "ORKSurveyAnswerCellForImageSelection.h"
#import "ORKSurveyAnswerCellForLocation.h"
#import "ORKAnswerFormat.h"
#import "ORKHelpers.h"
#import "ORKCustomStepView.h"
#import "ORKVerticalContainerView.h"
#import "ORKPainStep.h"
#import "ORKVerticalContainerView_Internal.h"
#import "ORKTableContainerView.h"
#import "ORKStep_Private.h"
#import "ORKTextChoiceCellGroup.h"
#import "ORKStepHeaderView_Internal.h"
#import "ORKNavigationContainerView_Internal.h"
#import "ORKQuestionStepView.h"
#import "ORKVerticalContainerView.h"
#import "ORKAnswerFormat_Internal.h"

@interface ORKPainStepViewController ()
{
    id _answer;
    NSMutableArray *_answerArray;
    ORKVerticalContainerView *_verticalContainer;
    ORKStepHeaderView *_headerView;
    ORKNavigationContainerView *_continueSkipView;
    
    NSCalendar *_savedSystemCalendar;
    NSTimeZone *_savedSystemTimeZone;
    
    ORKTextChoiceCellGroup *_choiceCellGroup;
    
    id _defaultAnswer;
    
    BOOL _visible;
}


@property (nonatomic, copy) id<NSCopying, NSObject, NSCoding> answer;

@property (nonatomic, strong) ORKContinueButton *continueActionButton;

// If `hasChangedAnswer`, then a new `defaultAnswer` should not change the answer
@property (nonatomic, assign) BOOL hasChangedAnswer;

@property (nonatomic, copy) id<NSCopying, NSObject, NSCoding> originalAnswer;

@end

@implementation ORKPainStepViewController 
- (void)initializeInternalButtonItems {
    [super initializeInternalButtonItems];
    self.internalSkipButtonItem.title = ORKLocalizedString(@"BUTTON_SKIP_QUESTION", nil);
}
-(instancetype)initWithStep:(ORKStep *)step result:(ORKResult *)result
{
    self = [self initWithStep:step];
    if(self)
    {
        ORKStepResult *stepResult = (ORKStepResult *)result;
        if(stepResult && [stepResult results].count > 0)
        {
            ORKPainResult *painResult = ORKDynamicCast([stepResult results].firstObject, ORKPainResult);
            id answer = [painResult answer];
            if (painResult != nil && answer == nil)
            {
                answer = ORKNullAnswerValue();
            }
            self.answer = answer;
            self.originalAnswer = answer;
        }
    }
    return self;
}
- (instancetype)initWithStep:(ORKStep *)step {
    self = [super initWithStep:step];
    if (self) {
        //_defaultSource = [ORKAnswerDefaultSource sourceWithHealthStore:[HKHealthStore new]];
        
    }
    
    return self;
}
-(void)stepDidChange {
    [super stepDidChange];
    self.hasChangedAnswer = NO;
    if([self isViewLoaded])
    {
    }
}
-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self stepDidChange];
    _answerArray = [NSMutableArray arrayWithObjects:@0,@0,@0,@0,@0,@0,@0, nil];
    
        _continueSkipView = nil;
        _verticalContainer = [[ORKVerticalContainerView alloc] initWithFrame:CGRectMake(0.0, 0.8*self.view.bounds.size.height, self.view.bounds.size.width, 0.2*self.view.bounds.size.height)];

    _continueSkipView = _verticalContainer.continueSkipContainer;
    [_verticalContainer setContinueHugsContent:TRUE];
    
         _continueSkipView.optional = NO;
    
        
        
        self.continueButtonItem  = self.internalDoneButtonItem;
    self.continueButtonItem.enabled = [self continueButtonEnabled];
    _continueSkipView.continueEnabled = [self continueButtonEnabled];
        _continueSkipView.continueButtonItem = self.continueButtonItem;
        
        

        self.painStepView = [[ORKPainStepView alloc] initWithFrame:CGRectMake(self.view.bounds.origin.x, self.view.bounds.origin.y, self.view.bounds.size.width,self.view.bounds.size.width)];
        [self.painStepView setButtonDelegate:self];
        
 

        [self.view addSubview:self.painStepView];
        [self.painStepView setupFrames];
        [self.painStepView setUpButtons];
    

    [self.view addSubview:_verticalContainer];

}
#pragma mark - Internal
- (ORKPainStep *)painStep {
    assert(!self.step || [self.step isKindOfClass:[ORKPainStep class]]);
    return (ORKPainStep *)self.step;
}

- (BOOL)hasAnswer {
    return !ORKIsAnswerEmpty(self.answer);
}



- (void)notifyDelegateOnResultChange {
    [super notifyDelegateOnResultChange];
    
    if (self.hasNextStep == NO) {
        self.continueButtonItem = self.internalDoneButtonItem;
    } else {
        self.continueButtonItem = self.internalContinueButtonItem;
    }
    
    self.skipButtonItem = self.internalSkipButtonItem;
    if (!self.painStep.optional && !self.readOnlyMode) {
        self.skipButtonItem = nil;
    }
    
    if ([self allowContinue] == NO) {
        self.continueButtonItem  = self.internalContinueButtonItem;
    }
    
   
}

- (BOOL)continueButtonEnabled {
    BOOL enabled = ([self hasAnswer] || (self.painStep.optional && !self.skipButtonItem));
    if (self.isBeingReviewed) {
        enabled = enabled && (![self.answer isEqual:self.originalAnswer]);
    }
    return enabled;
}

- (BOOL)skipButtonEnabled {
    BOOL enabled = [self painStep].optional;
    if (self.isBeingReviewed) {
        enabled = self.readOnlyMode ? NO : enabled && !ORKIsAnswerEmpty(self.originalAnswer);
    }
    return enabled;
}

- (BOOL)allowContinue {
    return !(self.painStep.optional == NO && [self hasAnswer] == NO);
}

// Not to use `ImmediateNavigation` when current step already has an answer.
// So user is able to review the answer when it is present.
- (BOOL)isStepImmediateNavigation {
    return false;
}

/////
-(void)regionPressedWithRegion:(NSInteger)region
{
    int index = (int) region;
    
     if(_answerArray[index] != nil)
     {
         NSNumber *oldValue = _answerArray[index];
         int intOldValue = [oldValue intValue];
         if(intOldValue < 10)
         {
            _answerArray[index] = @([oldValue intValue] + 1);
         }
         //If old value = 10, reset
         else
         {
             _answerArray[index] = @0;
         }
         
         NSLog(@"Region %i Value:%@", index, (NSNumber *) _answerArray[index]);
         [self.painStepView setPainScaleValue:[_answerArray[index] intValue] forRegion:region];
         
         
     }
}
-(ORKStepResult *)result
{
    ORKPainResult *painResult = [[ORKPainResult alloc] initWithIdentifier:self.step.identifier];
    [painResult setRegionsAnswer:_answerArray];
    
    ORKStepResult *result = [[ORKStepResult alloc] initWithStepIdentifier:self.step.identifier results:@[painResult]];
    return result;
}
-(BOOL)hasNextStep
{
    return false;
}
-(void)updateButtonStates {
    
}
@end
