//
//  SPPurchaseButton.h
//  SPPurchaseButton
//
//  Created by Åke Lagercrantz on 2013-12-22.
//  Copyright (c) 2013 Spire. All rights reserved.
//


typedef enum
{
    SPPurchaseButtonTypeConfirm  = 1 << 0,
    SPPurchaseButtonTypeFeedback = 1 << 1
} SPPurchaseButtonTypeMask;

#import <UIKit/UIKit.h>

static int const SPControlStateConfirming = 1 << 16;
static int const SPControlStateFeedback   = 1 << 17;

static int const SPControlEventPressConfirm  = 1 << 24;
static int const SPControlEventPressFeedback = 1 << 25;

@interface SPPurchaseButton : UIButton

@property (nonatomic) SPPurchaseButtonTypeMask buttonTypeMask;
@property (nonatomic) UIControlState animationForStates;
@property (nonatomic) NSUInteger resizePriority;
@property (nonatomic) double feedbackTime;

#pragma mark - Confirming
-(SPPurchaseButton *)initConfirmingWithTitle:(NSString *)title
                                       color:(UIColor *)color
                             confirmingTitle:(NSString *)confirmingTitle
                             confirmingColor:(UIColor *)confirmingColor;

-(SPPurchaseButton *)initConfirmingWithTitle:(NSString *)title
                                       color:(UIColor *)color
                              highlightColor:(UIColor *)highlightColor
                             confirmingTitle:(NSString *)confirmingTitle
                             confirmingColor:(UIColor *)confirmingColor
                    confirmingHighlightColor:(UIColor *)confirmingHighlightColor;

-(void)configureConfirmingWithTitle:(NSString *)title
                              color:(UIColor *)color
                    confirmingTitle:(NSString *)confirmingTitle
                    confirmingColor:(UIColor *)confirmingColor;

-(void)configureConfirmingWithTitle:(NSString *)title
                              color:(UIColor *)color
                     highlightColor:(UIColor *)highlightColor
                    confirmingTitle:(NSString *)confirmingTitle
                    confirmingColor:(UIColor *)confirmingColor
           confirmingHighlightColor:(UIColor *)confirmingHighlightColor;

#pragma mark - Feedback
-(SPPurchaseButton *)initFeedbackWithTitle:(NSString *)title
                                     color:(UIColor *)color
                             feedbackTitle:(NSString *)feedbackTitle
                             feedbackColor:(UIColor *)feedbackColor;

-(SPPurchaseButton *)initFeedbackWithTitle:(NSString *)title
                                     color:(UIColor *)color
                            highlightColor:(UIColor *)highlightColor
                             feedbackTitle:(NSString *)feedbackTitle
                             feedbackColor:(UIColor *)feedbackColor
                    feedbackHighlightColor:(UIColor *)feedbackHighlightColor;

-(void)configureFeedbackWithTitle:(NSString *)title
                            color:(UIColor *)color
                    feedbackTitle:(NSString *)feedbackTitle
                    feedbackColor:(UIColor *)feedbackColor;

-(void)configureFeedbackWithTitle:(NSString *)title
                            color:(UIColor *)color
                   highlightColor:(UIColor *)highlightColor
                    feedbackTitle:(NSString *)feedbackTitle
                    feedbackColor:(UIColor *)feedbackColor
           feedbackHighlightColor:(UIColor *)feedbackHighlightColor;

#pragma mark - Confirming and Feedback
-(SPPurchaseButton *)initConfirmingAndFeedbackWithTitle:(NSString *)title
                                                  color:(UIColor *)color
                                        confirmingTitle:(NSString *)confirmingTitle
                                        confirmingColor:(UIColor *)confirmingColor
                                          feedbackTitle:(NSString *)feedbackTitle
                                          feedbackColor:(UIColor *)feedbackColor;

-(SPPurchaseButton *)initConfirmingAndFeedbackWithTitle:(NSString *)title
                                                  color:(UIColor *)color
                                         highlightColor:(UIColor *)highlightColor
                                        confirmingTitle:(NSString *)confirmingTitle
                                        confirmingColor:(UIColor *)confirmingColor
                               confirmingHighlightColor:(UIColor *)confirmingHighlightColor
                                          feedbackTitle:(NSString *)feedbackTitle
                                          feedbackColor:(UIColor *)feedbackColor
                                 feedbackHighlightColor:(UIColor *)feedbackHighlightColor;

-(void)configureConfirmingAndFeedbackWithTitle:(NSString *)title
                                         color:(UIColor *)color
                               confirmingTitle:(NSString *)confirmingTitle
                               confirmingColor:(UIColor *)confirmingColor
                                 feedbackTitle:(NSString *)feedbackTitle
                                 feedbackColor:(UIColor *)feedbackColor;

-(void)configureConfirmingAndFeedbackWithTitle:(NSString *)title
                                         color:(UIColor *)color
                                highlightColor:(UIColor *)highlightColor
                               confirmingTitle:(NSString *)confirmingTitle
                               confirmingColor:(UIColor *)confirmingColor
                      confirmingHighlightColor:(UIColor *)confirmingHighlightColor
                                 feedbackTitle:(NSString *)feedbackTitle
                                 feedbackColor:(UIColor *)feedbackColor
                        feedbackHighlightColor:(UIColor *)feedbackHighlightColor;

#pragma mark - UIControl states
-(BOOL)confirming;
-(void)setConfirming:(BOOL)newConfirming;
-(BOOL)feedback;
-(void)setFeedback:(BOOL)newFeedback;
-(void)reset;
-(void)refresh;

@end

