//
//  Type_4FirstViewController.h
//  Simple Converter
//
//  Created by Aaron Chan on 8/10/13.
//  Copyright (c) 2013 AaronChan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Type_4FirstViewController : UIViewController <UITextFieldDelegate>
{
//    IBOutlet UITextField *caloriesTextField;
//    IBOutlet UITextField *kilojoulesTextField;
    IBOutlet UILabel *caloriesTotal;
    IBOutlet UILabel *kilojoulesTotal;
    
//    IBOutlet UILabel *stack;
//    IBOutlet UILabel *input;
//    IBOutlet UIButton *resetButton;
}

//@property (nonatomic, retain) IBOutlet UITextField *caloriesTextField;
//@property (nonatomic, retain) IBOutlet UITextField *kilojoulesTextField;
//@property (nonatomic, retain) IBOutlet UILabel *stack;
//@property (nonatomic, retain) IBOutlet UIButton *resetButton;

@property (nonatomic, retain) IBOutlet UILabel *caloriesTotal;
@property (nonatomic, retain) IBOutlet IBOutlet UILabel *kilojoulesTotal;

//@property (nonatomic, retain) IBOutlet UILabel *input;

//-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event;

@end
