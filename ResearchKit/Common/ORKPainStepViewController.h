//
//  ORKPainStepViewController.h
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/24/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//

#import <ResearchKit/ORKStepViewController.h>
#import <ResearchKit/ORKDefines.h>
#import "ORKPainStepView.h"
#import "ORKVerticalContainerView.h"
/**
 The `ORKQuestionStepViewController` class is the concrete `ORKStepViewController`
 implementation for `ORKQuestionStep`.
 
 You should not need to instantiate an `ORKQuestionStepViewController` object
 directly. Instead, create an `ORKQuestionStep` object, include it in a task
 the task using a task view controller. The task view
 controller automatically instantiates the question step view controller
 when it needs to present a question step.
 
 To use `ORKQuestionStepViewController` directly, create an `ORKQuestionStep` object and use
 `initWithStep:` to initialize it. To receive the result of the question, and to determine
 when to dismiss the view controller, implement `ORKStepViewControllerDelegate`.
 */

ORK_CLASS_AVAILABLE
@interface ORKPainStepViewController : ORKStepViewController <PainRegionProtocol>


@property (strong, nonatomic) ORKPainStepView *painStepView;



@end
