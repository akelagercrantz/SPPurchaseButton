//
//  ViewController.m
//  Storyboard
//
//  Created by Åke Lagercrantz on 2013-12-25.
//  Copyright (c) 2013 Spire. All rights reserved.
//

#import "ViewController.h"
#import "SPPurchaseButton.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet SPPurchaseButton *leftButton;
@property (strong, nonatomic) SPPurchaseButton *middleButton;
@property (weak, nonatomic) IBOutlet SPPurchaseButton *rightButton;
@property (weak, nonatomic) IBOutlet UILabel *middleButtonDescriptionLabel;
- (IBAction)didPressButton:(SPPurchaseButton *)sender;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    /////////////////////////////////////////////////////////////////////////////
    // Configure methods for easy customization of a button from a storyboard. //
    /////////////////////////////////////////////////////////////////////////////

    [self.leftButton configureFeedbackWithTitle:@"Follow"
                                          color:blueColor
                                 highlightColor:lightBlueColor
                                  feedbackTitle:@"Following"
                                  feedbackColor:orangeColor
                         feedbackHighlightColor:lightOrangeColor];
    
    [self.rightButton configureConfirmingWithTitle:@"Delete"
                                             color:redColor
                                    highlightColor:lightRedColor
                                   confirmingTitle:@"Are you sure?"
                                   confirmingColor:greenColor
                          confirmingHighlightColor:lightGreenColor];
    
    
    /////////////////////////////////////////////
    // To create a new button programmatically //
    /////////////////////////////////////////////
    self.middleButton = [[SPPurchaseButton alloc] initConfirmingAndFeedbackWithTitle:@"$99.9"
                                                                               color:blueColor
                                                                      highlightColor:lightBlueColor
                                                                     confirmingTitle:@"Purchase"
                                                                     confirmingColor:greenColor
                                                            confirmingHighlightColor:lightGreenColor
                                                                       feedbackTitle:@"Added to cart"
                                                                       feedbackColor:orangeColor
                                                              feedbackHighlightColor:lightOrangeColor];
    
    [self.view addSubview:self.middleButton];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.middleButton
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.middleButton
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];

    
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    // These actions will be fired when the user presses a button in either confirm or feedback mode. //
    // The normal UIControlEvents such as UIControlEventTouchUpInside still works for all touches.    //
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    // leftButton UIControlEventTouchUpInside added from Storyboard
    [self.leftButton addTarget:self action:@selector(didPressButtonInConfirmMode:) forControlEvents:SPControlEventPressConfirm];
    [self.leftButton addTarget:self action:@selector(didPressButtonInFeedbackMode:) forControlEvents:SPControlEventPressFeedback];
    
    // rightButton UIControlEventTouchUpInside added from Storyboard
    [self.rightButton addTarget:self action:@selector(didPressButtonInConfirmMode:) forControlEvents:SPControlEventPressConfirm];
    [self.rightButton addTarget:self action:@selector(didPressButtonInFeedbackMode:) forControlEvents:SPControlEventPressFeedback];
    
    [self.middleButton addTarget:self action:@selector(didPressButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleButton addTarget:self action:@selector(didPressButtonInConfirmMode:) forControlEvents:SPControlEventPressConfirm];
    [self.middleButton addTarget:self action:@selector(didPressButtonInFeedbackMode:) forControlEvents:SPControlEventPressFeedback];
    
    
    /////////////////////////////////////////////////////////
    // Any combination of UIControlStates is customizable. //
    /////////////////////////////////////////////////////////
    
    [self.rightButton setTitle:@"Are you REALLY sure?" forState:(SPControlStateConfirming | UIControlStateHighlighted)];
    
    // To add animation for the custom highlight title, just add the following.
    //self.rightButton.animationForStates |= UIControlStateHighlighted;
}


- (IBAction)didPressButton:(SPPurchaseButton *)sender {
    NSLog(@"UIControlEventTouchUpInside");
}

- (void)didPressButtonInConfirmMode:(SPPurchaseButton *)sender {
    NSLog(@"SPControlEventPressConfirm");
}

- (void)didPressButtonInFeedbackMode:(SPPurchaseButton *)sender {
    NSLog(@"SPControlEventPressFeedback");
}
@end
