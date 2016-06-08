//
//  ORKPainStep.h
//  ResearchKit
//
//  Created by Zachary Bernstein on 5/24/16.
//  Copyright © 2016 researchkit.org. All rights reserved.
//


#import <ResearchKit/ORKDefines.h>
#import <UIKit/UIKit.h>
#import <ResearchKit/ORKStep.h>


NS_ASSUME_NONNULL_BEGIN


ORK_CLASS_AVAILABLE
@interface ORKPainStep : ORKStep


+(instancetype)painStepWithIdentifier:(NSString *)identifier
                                title:(nullable NSString *)title
                                 text:(nullable NSString *)text;
@end

NS_ASSUME_NONNULL_END