//
//  Quiz.h
//  Quiz
//
//  Created by 2025 Labs on 6/29/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Quiz : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *question;
@property (weak, nonatomic) IBOutlet UIButton *choice1;
@property (weak, nonatomic) IBOutlet UIButton *choice2;
@property (weak, nonatomic) IBOutlet UIButton *choice3;
@property (weak, nonatomic) IBOutlet UIButton *choice4;
@property (weak, nonatomic) IBOutlet UIButton *previousButton;
@property (weak, nonatomic) IBOutlet UIButton *nextButton;

@property NSMutableArray* choiceArray;
@property NSString* correctChoice;
@property UIImageView *checkmarkImage;
@property UIImageView *wrongImage;
@property int questionIndex;
@property NSArray *jsonArray;
@property NSString *navigationBarTitle;
- (IBAction)choicePressed:(UIButton*)sender;
- (IBAction)skipToNextQuestion:(UIButton*)sender;

- (IBAction)moveToPreviousQuestion:(UIButton*)sender;

@end

