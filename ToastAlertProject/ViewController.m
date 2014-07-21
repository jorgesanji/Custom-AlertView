//
//  ViewController.m
//  ToastAlertProject
//
//  Created by jorge Sanmartin on 14/05/14.
//  Copyright (c) 2014 Jorge Sanmartin. All rights reserved.
//

#import "ViewController.h"
#import "MLAlert.h"
#import "MLChooseOptionAlert.h"
#import "MLEngineAlertView.h"

@interface ViewController ()<MLChooseOptionAlertDelegate>
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/**
 *
 *@brief:Show Stack Toast View
 *
 */
- (IBAction)showTextAlert:(id)sender
{
    [[MLAlert sharedInstance] showAlertWithText:@"Stack ToastView"];
}

/**
 *
 *@brief:Show Toast View
 *
 */

- (IBAction)showTextAlertWithCriticText:(id)sender
{
    [[MLAlert sharedInstance] showAlertWithText:@"Big ToastView" isCritical:YES];
}

/**
 *
 *@brief:Show Load View
 *
 */
- (IBAction)showLoaderAlert:(id)sender
{
    MLLoaderAlert *alert = [[MLAlert sharedInstance] showAlertLoader];
    
    [self performSelector:@selector(hideAlertWithView:) withObject:alert afterDelay:6.5f];
}

/**
 *
 *@brief:Show Custom Load animation View
 *
 */
- (IBAction)showLoader2Alert:(id)sender
{
    
    MLEngineAlertView *engineAlert = [MLEngineAlertView initEngineAlertView];
    MLLoaderAlert *alert = [[MLAlert sharedInstance] showAlertLoaderWithViewForAnimate:engineAlert];
    
    [self performSelector:@selector(hideAlertWithView:) withObject:alert afterDelay:6.5f];
}

/**
 *
 *@brief:Show Alert View with two buttons when press any button starts animation
 *
 */

- (IBAction)showAlertView:(id)sender
{
    [[MLAlert sharedInstance] showChooseAlertWithText:@"Alert View with 2 buttons" cancelText:@"NO" delegate:self otherButtons:@"YES", nil];
}

/**
 *
 *@brief:Show Alert View with one button when press any button starts animation
 *
 */

-(IBAction)showAlertWithOneOpption:(id)sender
{
    [[MLAlert sharedInstance] showChooseAlertWithText:@"Alert View with one button" cancelText:@"Accept" delegate:self otherButtons: nil];
}

/**
 *
 *@brief:Show Alert View with multi buttons when press any button starts animation
 *
 */

-(IBAction)showAlertWithThreeOptions:(id)sender
{
    [[MLAlert sharedInstance] showChooseAlertWithText:@"Alert View with three buttons" cancelText:@"Cancel" delegate:self otherButtons:@"Option 2", @"Option 3", nil];
}


/**
*
*@brief:Delegate Alert View when press any button
*
*/

-(void)alertView:(MLChooseOptionAlert *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"index: %li", buttonIndex);
    NSLog(@"cancelButtonIndex: %d", (alertView.cancelButtonIndex == buttonIndex));
}

/**
*
*@brief: hide current Alert View
*
*/
- (void)hideAlertWithView:(MLGenericAlert *)alert
{
    [alert hide];
}

@end
