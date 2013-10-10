//
//  Type_4FirstViewController.m
//  Simple Converter
//
//  Created by Aaron Chan on 8/10/13.
//  Copyright (c) 2013 AaronChan. All rights reserved.
//

#import "Type_4FirstViewController.h"

typedef enum
{
    convertToCaloriesButton,
    ConvertToKilojoulesButton,
    calorieLabel,
    kilojoulesLabel,
}tagIndex;

@interface Type_4FirstViewController ()

@end

@implementation Type_4FirstViewController

@synthesize caloriesTotal, kilojoulesTotal;

bool even;

//StackInUse determines if the user has started entering numbers
bool stackInUse;

//FirstResponder points to the label in focus
UILabel *firstResponder;

NSTimer *updateTimer;


-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
    for (UITouch *touch in touches)
    {
        //Determine if touch was in contact with either label
        //If TRUE then invalidate tick method and return other label to 0 if it was in focus
        //Start the label in focus with timer
        CGPoint touchLocation = [touch locationInView:touch.view];
        if(CGRectContainsPoint(caloriesTotal.frame, touchLocation))
        {
            [updateTimer invalidate];
            updateTimer = nil;
            if (firstResponder == kilojoulesTotal)
            {
                kilojoulesTotal.text = @"0";
            }
            
            caloriesTotal.text = @"|";
            updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:caloriesTotal repeats:YES];
            firstResponder = caloriesTotal;
        }
        else if(CGRectContainsPoint(kilojoulesTotal.frame, touchLocation))
        {
            [updateTimer invalidate];
            updateTimer = nil;
            
            if (firstResponder == caloriesTotal)
            {
                caloriesTotal.text = @"0";
            }
            
            kilojoulesTotal.text = @"|";
            updateTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(update:) userInfo:kilojoulesTotal repeats:YES];
            firstResponder = kilojoulesTotal;
        }
    }
}

-(void) update:(NSTimer *) timer
{
    //point to label in focus
    UILabel *labelSelected = (UILabel *) [timer userInfo];
    if (!even)
    {
        //If focus bar is NOT found then append focus bar
        if (![labelSelected.text hasSuffix:@"|"])
        {
            labelSelected.text = [labelSelected.text stringByAppendingString:@"|"];
        }
            even = YES;
    }
    else
    {
        //If focus bar IS found then append focus bar
        if ([labelSelected.text hasSuffix:@"|"])
        {
            labelSelected.text = [labelSelected.text substringToIndex:[labelSelected.text length] - 1];
        }
        even = NO;
    }
}


- (IBAction)convert:(UIButton *)button
{
    
    if (button.tag == ConvertToKilojoulesButton)
    {
        //If caloriesTotal was in focus then convert to kilojoules
        if (caloriesTotal == firstResponder)
        {
            double calories = [caloriesTotal.text doubleValue];
            kilojoulesTotal.text = [NSString stringWithFormat:@"%.2f", (calories * 4.184)];
        }
    }
    else
    {
        //If kilojoulesTotal was in focus then convert to calories
        if (kilojoulesTotal == firstResponder)
        {
            double kilojoules = [kilojoulesTotal.text doubleValue];
            caloriesTotal.text = [NSString stringWithFormat:@"%.2f", (kilojoules * 0.239)];
        }
    }
}

-(IBAction)digitButtonPressed:(UIButton *)sender
{
    //Remove focus bar
    if ([firstResponder.text hasSuffix:@"|"])
    {
        //Remove last char
        firstResponder.text = [firstResponder.text substringToIndex:[firstResponder.text length] - 1];
    }
    //If User has already started entering, continue
    if (stackInUse)
    {
        //Append which ever digit pressed to the end of label in focus
        firstResponder.text = [firstResponder.text stringByAppendingString:sender.currentTitle];
    }
    else
    {
        //If Stack NOT in use and user hasn't entered "0"
        if(![sender.currentTitle isEqualToString:@"0"])
        {
            firstResponder.text = sender.currentTitle;
            stackInUse = YES;
        }
    }
}

-(IBAction)resetButtonPressed:(UIButton *)sender
{
    //Reset input/outputs
    caloriesTotal.text = @"0";
    kilojoulesTotal.text = @"0";
    stackInUse = NO;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    //Initialise values at start up
    caloriesTotal.text = @"0";
    kilojoulesTotal.text = @"0";
    stackInUse = NO;
    even = YES;
    firstResponder = nil;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
