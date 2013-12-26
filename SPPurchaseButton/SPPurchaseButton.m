//
//  SPPurchaseButton.m
//  SPPurchaseButton
//
//  Created by Åke Lagercrantz on 2013-12-22.
//  Copyright (c) 2013 Spire. All rights reserved.
//

#import "SPPurchaseButton.h"


@interface SPPurchaseButton ()

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic) UIControlState customState;
@property (nonatomic, strong) NSMutableArray *widthConstraints;
@property (nonatomic, strong) UIButton *cancelOverlay;

@end

@implementation SPPurchaseButton

////////////////////////////////////////////////////////////////////////
#pragma mark - Init
////////////////////////////////////////////////////////////////////////

-(id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configure];
    }
    
    return self;
}

-(void)configure {
    // Init
    self.widthConstraints = [[NSMutableArray alloc] init];
    
    // We don't want AutoreizingMask as constraints.
    [self setTranslatesAutoresizingMaskIntoConstraints:NO];
    
    // Create contet edge insets
    [self setContentEdgeInsets:UIEdgeInsetsMake(5, 10, 5, 10)];
    
    // Set content mode for title, to prevent it from scaling.
    [self.titleLabel setContentMode:UIViewContentModeLeft];
    
    // Draw a rounded rectangle border around the button.
    self.layer.cornerRadius = 2;
    self.layer.borderWidth = 1;
    self.layer.borderColor = self.titleLabel.textColor.CGColor;
    
    // Assert custom state is within UIControlStateApplication
    NSAssert( SPControlStateConfirming & UIControlStateApplication, @"Custom state not within UIControlStateApplication" );
    NSAssert( SPControlStateFeedback & UIControlStateApplication, @"Custom state not within UIControlStateApplication" );
    
    // Default width constraint priority
    self.resizePriority = 900;
    
    // Default animations
    self.animationForStates = (UIControlStateNormal | SPControlStateFeedback | SPControlStateConfirming);
    
    // Default mode
    self.buttonTypeMask = (SPPurchaseButtonTypeConfirm | SPPurchaseButtonTypeFeedback);
    
    // Default timings
    self.feedbackTime = 2.0;
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Init with Confirming
////////////////////////////////////////////////////////////////////////

-(SPPurchaseButton *)initConfirmingWithTitle:(NSString *)title
                                       color:(UIColor *)color
                             confirmingTitle:(NSString *)confirmingTitle
                             confirmingColor:(UIColor *)confirmingColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureConfirmingWithTitle:title
                                     color:color
                           confirmingTitle:confirmingTitle
                           confirmingColor:confirmingColor];
    }
    
    return self;
}

-(SPPurchaseButton *)initConfirmingWithTitle:(NSString *)title
                                       color:(UIColor *)color
                              highlightColor:(UIColor *)highlightColor
                             confirmingTitle:(NSString *)confirmingTitle
                             confirmingColor:(UIColor *)confirmingColor
                    confirmingHighlightColor:(UIColor *)confirmingHighlightColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureConfirmingWithTitle:title
                                     color:color
                            highlightColor:highlightColor
                           confirmingTitle:confirmingTitle
                           confirmingColor:confirmingColor
                  confirmingHighlightColor:confirmingHighlightColor];
    }
    
    return self;
    
}

-(void)configureConfirmingWithTitle:(NSString *)title
                              color:(UIColor *)color
                    confirmingTitle:(NSString *)confirmingTitle
                    confirmingColor:(UIColor *)confirmingColor {
    [self configureConfirmingWithTitle:title
                                 color:color
                        highlightColor:nil
                       confirmingTitle:confirmingTitle
                       confirmingColor:confirmingColor
              confirmingHighlightColor:nil];
}

-(void)configureConfirmingWithTitle:(NSString *)title
                              color:(UIColor *)color
                     highlightColor:(UIColor *)highlightColor
                    confirmingTitle:(NSString *)confirmingTitle
                    confirmingColor:(UIColor *)confirmingColor
           confirmingHighlightColor:(UIColor *)confirmingHighlightColor {
    [self reset];
    
    [self setButtonTypeMask:SPPurchaseButtonTypeConfirm];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    if (!highlightColor)
        highlightColor = color;
    
    if (!confirmingTitle)
        confirmingTitle = title;
    
    if (!confirmingColor)
        confirmingColor = color;
    
    if (!confirmingHighlightColor)
        confirmingHighlightColor = confirmingColor;
    
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
    [self setTitle:confirmingTitle forState:SPControlStateConfirming];
    [self setTitle:confirmingTitle forState:(SPControlStateConfirming | UIControlStateHighlighted)];
    [self setTitleColor:confirmingColor forState:SPControlStateConfirming];
    [self setTitleColor:confirmingHighlightColor forState:(SPControlStateConfirming | UIControlStateHighlighted)];
    
    [self didToggleState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Init with Feedback
////////////////////////////////////////////////////////////////////////

-(SPPurchaseButton *)initFeedbackWithTitle:(NSString *)title
                                     color:(UIColor *)color
                             feedbackTitle:(NSString *)feedbackTitle
                             feedbackColor:(UIColor *)feedbackColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureFeedbackWithTitle:title
                                   color:color
                           feedbackTitle:feedbackTitle
                           feedbackColor:feedbackColor];
    }
    
    return self;
}

-(SPPurchaseButton *)initFeedbackWithTitle:(NSString *)title
                                     color:(UIColor *)color
                            highlightColor:(UIColor *)highlightColor
                             feedbackTitle:(NSString *)feedbackTitle
                             feedbackColor:(UIColor *)feedbackColor
                    feedbackHighlightColor:(UIColor *)feedbackHighlightColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureFeedbackWithTitle:title
                                   color:color
                          highlightColor:highlightColor
                           feedbackTitle:feedbackTitle
                           feedbackColor:feedbackColor
                  feedbackHighlightColor:feedbackHighlightColor];
    }
    
    return self;
}

-(void)configureFeedbackWithTitle:(NSString *)title
                            color:(UIColor *)color
                    feedbackTitle:(NSString *)feedbackTitle
                    feedbackColor:(UIColor *)feedbackColor {
    [self configureFeedbackWithTitle:title
                               color:color
                      highlightColor:nil
                       feedbackTitle:feedbackTitle
                       feedbackColor:feedbackColor
              feedbackHighlightColor:nil];
}

-(void)configureFeedbackWithTitle:(NSString *)title
                            color:(UIColor *)color
                   highlightColor:(UIColor *)highlightColor
                    feedbackTitle:(NSString *)feedbackTitle
                    feedbackColor:(UIColor *)feedbackColor
           feedbackHighlightColor:(UIColor *)feedbackHighlightColor {
    [self reset];
    
    [self setButtonTypeMask:SPPurchaseButtonTypeFeedback];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    if (!highlightColor)
        highlightColor = color;
    
    if (!feedbackTitle)
        feedbackTitle = title;
    
    if (!feedbackColor)
        feedbackColor = color;
    
    if (!feedbackHighlightColor)
        feedbackHighlightColor = feedbackColor;
    
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
    [self setTitle:feedbackTitle forState:SPControlStateFeedback];
    [self setTitle:feedbackTitle forState:(SPControlStateFeedback | UIControlStateHighlighted)];
    [self setTitleColor:feedbackColor forState:SPControlStateFeedback];
    [self setTitleColor:feedbackHighlightColor forState:(SPControlStateFeedback | UIControlStateHighlighted)];
    
    [self didToggleState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Init with Confirming and Feedback
////////////////////////////////////////////////////////////////////////

-(SPPurchaseButton *)initConfirmingAndFeedbackWithTitle:(NSString *)title
                                                  color:(UIColor *)color
                                        confirmingTitle:(NSString *)confirmingTitle
                                        confirmingColor:(UIColor *)confirmingColor
                                          feedbackTitle:(NSString *)feedbackTitle
                                          feedbackColor:(UIColor *)feedbackColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureConfirmingAndFeedbackWithTitle:title
                                                color:color
                                      confirmingTitle:confirmingTitle
                                      confirmingColor:confirmingColor
                                        feedbackTitle:feedbackTitle
                                        feedbackColor:feedbackColor];
    }
    
    return self;
}

-(SPPurchaseButton *)initConfirmingAndFeedbackWithTitle:(NSString *)title
                                                  color:(UIColor *)color
                                         highlightColor:(UIColor *)highlightColor
                                        confirmingTitle:(NSString *)confirmingTitle
                                        confirmingColor:(UIColor *)confirmingColor
                               confirmingHighlightColor:(UIColor *)confirmingHighlightColor
                                          feedbackTitle:(NSString *)feedbackTitle
                                          feedbackColor:(UIColor *)feedbackColor
                                 feedbackHighlightColor:(UIColor *)feedbackHighlightColor {
    self = [super init];
    
    if (self) {
        [self configure];
        [self configureConfirmingAndFeedbackWithTitle:title
                                                color:color
                                       highlightColor:highlightColor
                                      confirmingTitle:confirmingTitle
                                      confirmingColor:confirmingColor
                             confirmingHighlightColor:confirmingHighlightColor
                                        feedbackTitle:feedbackTitle
                                        feedbackColor:feedbackColor
                               feedbackHighlightColor:feedbackHighlightColor];
    }
    
    return self;
}

-(void)configureConfirmingAndFeedbackWithTitle:(NSString *)title
                                         color:(UIColor *)color
                               confirmingTitle:(NSString *)confirmingTitle
                               confirmingColor:(UIColor *)confirmingColor
                                 feedbackTitle:(NSString *)feedbackTitle
                                 feedbackColor:(UIColor *)feedbackColor {
    [self configureConfirmingAndFeedbackWithTitle:title
                                            color:color
                                   highlightColor:nil
                                  confirmingTitle:confirmingTitle
                                  confirmingColor:confirmingColor
                         confirmingHighlightColor:nil
                                    feedbackTitle:feedbackTitle
                                    feedbackColor:feedbackColor
                           feedbackHighlightColor:nil];
}

-(void)configureConfirmingAndFeedbackWithTitle:(NSString *)title
                                         color:(UIColor *)color
                                highlightColor:(UIColor *)highlightColor
                               confirmingTitle:(NSString *)confirmingTitle
                               confirmingColor:(UIColor *)confirmingColor
                      confirmingHighlightColor:(UIColor *)confirmingHighlightColor
                                 feedbackTitle:(NSString *)feedbackTitle
                                 feedbackColor:(UIColor *)feedbackColor
                        feedbackHighlightColor:(UIColor *)feedbackHighlightColor {
    [self reset];
    
    [self setButtonTypeMask:(SPPurchaseButtonTypeConfirm | SPPurchaseButtonTypeFeedback)];
    
    [self setTitle:title forState:UIControlStateNormal];
    [self setTitleColor:color forState:UIControlStateNormal];
    
    if (!highlightColor)
        highlightColor = color;
    
    if (!confirmingTitle)
        confirmingTitle = title;
    
    if (!confirmingColor)
        confirmingColor = color;
    
    if (!confirmingHighlightColor)
        confirmingHighlightColor = confirmingColor;
    
    if (!feedbackTitle)
        feedbackTitle = title;
    
    if (!feedbackColor)
        feedbackColor = color;
    
    if (!feedbackHighlightColor)
        feedbackHighlightColor = feedbackColor;
    
    [self setTitleColor:highlightColor forState:UIControlStateHighlighted];
    [self setTitle:confirmingTitle forState:SPControlStateConfirming];
    [self setTitle:confirmingTitle forState:(SPControlStateConfirming | UIControlStateHighlighted)];
    [self setTitleColor:confirmingColor forState:SPControlStateConfirming];
    [self setTitleColor:confirmingHighlightColor forState:(SPControlStateConfirming | UIControlStateHighlighted)];
    [self setTitle:feedbackTitle forState:SPControlStateFeedback];
    [self setTitle:feedbackTitle forState:(SPControlStateFeedback | UIControlStateHighlighted)];
    [self setTitleColor:feedbackColor forState:SPControlStateFeedback];
    [self setTitleColor:feedbackHighlightColor forState:(SPControlStateFeedback | UIControlStateHighlighted)];
    
    [self didToggleState:UIControlStateNormal];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - UIControlState
////////////////////////////////////////////////////////////////////////

- (UIControlState)state {
    NSInteger returnState = [super state];
    return ( returnState | self.customState );
}

- (BOOL)confirming {
    return (self.state & SPControlStateConfirming) > 0;
}
- (void)setConfirming:(BOOL)newConfirming {
    [self willToggleState:SPControlStateConfirming];
    
    if (newConfirming) {
        // Add Feedback, but remove Confirming, since they can't be active simultaneously.
        self.customState |= SPControlStateConfirming;
        self.customState &= ~SPControlStateFeedback;
        
        // Create cancelOverlay
        [self createCancelOverlay];
    }
    else {
        self.customState &= ~SPControlStateConfirming;
        
        // Remove cancelOverlay
        [self deleteCancelOverlay];
    }
    
    [self didToggleState:SPControlStateConfirming];
}

- (BOOL)feedback {
    return (self.state & SPControlStateFeedback) > 0;
}
- (void)setFeedback:(BOOL)newFeedback {
    [self willToggleState:SPControlStateFeedback];
    
    if (newFeedback) {
        // Add Feedback, but remove Confirming, since they can't be active simultaneously.
        self.customState |= SPControlStateFeedback;
        self.customState &= ~SPControlStateConfirming;
        
        // Remove cancelOverlay.
        [self deleteCancelOverlay];
        
        self.timer = [NSTimer timerWithTimeInterval:self.feedbackTime
                                             target:self
                                           selector:@selector(feedbackTimerFired:)
                                           userInfo:nil repeats:NO];
        [[NSRunLoop mainRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    else {
        self.customState &= ~SPControlStateFeedback;
    }
    
    [self didToggleState:SPControlStateFeedback];
}

- (void)setSelected:(BOOL)newSelected {
    [self willToggleState:UIControlStateSelected];
    
    [super setSelected:newSelected];
    
    [self didToggleState:UIControlStateSelected];
}

- (void)setHighlighted:(BOOL)newHighlighted {
    [self willToggleState:UIControlStateHighlighted];
    
    [super setHighlighted:newHighlighted];
    
    [self didToggleState:UIControlStateHighlighted];
}

- (void)setEnabled:(BOOL)newEnabled {
    [self willToggleState:UIControlStateDisabled];
    
    [super setEnabled:newEnabled];
    
    [self didToggleState:UIControlStateDisabled];
}

- (void)willToggleState:(UIControlState)state {
    [self.timer invalidate];
    if ((state & self.animationForStates) > 0)
        [self lockWidth];
}

- (void)didToggleState:(UIControlState)state {
    self.layer.borderColor = [self titleColorForState:self.state].CGColor;
    
    // Force re-layout of button.
    [self invalidateIntrinsicContentSize];
    
    // Should animate?
    if ((state & self.animationForStates) > 0)
        [self unlockWidth];
}

-(void)reset {
    self.customState = 0;
    self.buttonTypeMask = 0;
    [self didToggleState:0];
}

-(void)refresh {
    [self didToggleState:0];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Cancel overlay
////////////////////////////////////////////////////////////////////////

-(void)createCancelOverlay {
    self.cancelOverlay = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cancelOverlay setFrame:self.window.frame];
    [self.cancelOverlay addTarget:self
                           action:@selector(didPressCancelOverlay)
                 forControlEvents:UIControlEventTouchDown];
    
    [self.superview addSubview:self.cancelOverlay];
    
    [self.superview bringSubviewToFront:self];
}


-(void)deleteCancelOverlay {
    if (self.cancelOverlay) {
        [self.cancelOverlay removeFromSuperview];
        self.cancelOverlay = nil;
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Action handlers / Touch
////////////////////////////////////////////////////////////////////////

-(void)didPressCancelOverlay {
    [self setConfirming:NO];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    
    // Touch point was outside button frame, user cancelled touch.
    if(!CGRectContainsPoint(self.frame, [[touches anyObject] locationInView:self.superview])){
        [super touchesCancelled:touches withEvent:event];
    }
    // Touch point was within button frame.
    else {
        // Send custom control events.
        if (self.confirming && self.buttonTypeMask & SPPurchaseButtonTypeConfirm) {
            [self sendActionsForControlEvents:SPControlEventPressConfirm];
        }
        if (self.feedback && self.buttonTypeMask & SPPurchaseButtonTypeFeedback) {
            [self sendActionsForControlEvents:SPControlEventPressFeedback];
        }
        
        [super touchesEnded:touches withEvent:event];
        
        // Handle state changes.
        if (!self.confirming && self.buttonTypeMask & SPPurchaseButtonTypeConfirm) {
            // Touch point was within button frame, set button in confirm mode.
            [self setConfirming:YES];
        }
        else {
            if (self.buttonTypeMask & SPPurchaseButtonTypeFeedback) {
                [self setFeedback:YES];
            }
            else {
                [self setConfirming:NO];
                [self setFeedback:NO];
            }
        }
    }
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Animation
////////////////////////////////////////////////////////////////////////

- (void)lockWidth {
    // Create a constraint with the current button width to prevent it from rescaling
    // when title is changed.
    NSArray *newConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:[self(width@priority)]"
                                                                      options:0
                                                                      metrics:@{@"width": @(self.bounds.size.width),
                                                                                @"priority": @(self.resizePriority)}
                                                                        views:NSDictionaryOfVariableBindings(self)];
    
    [self.widthConstraints addObjectsFromArray:newConstraints];
    [self addConstraints:newConstraints];
}

- (void)unlockWidth {
    // Ensures that all pending layout operations have been completed
    [self layoutIfNeeded];
    
    // Animate width change
    [UIView animateWithDuration:0.5 animations:^{
        // Remove width constraint and let autolayout resize it to appropriate width.
        
        [self removeConstraints:[NSArray arrayWithArray:self.widthConstraints]];
        [self.widthConstraints removeAllObjects];
        
        // Forces the layout of the subtree animation block and then captures all of the frame changes
        [self layoutIfNeeded];
    }];
}

////////////////////////////////////////////////////////////////////////
#pragma mark - Timers fired
////////////////////////////////////////////////////////////////////////

- (void)feedbackTimerFired:(NSTimer *)timer {
    [self setFeedback:NO];
}

@end
