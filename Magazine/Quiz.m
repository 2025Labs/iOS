//
//  ViewController.m
//  Quiz
//
//  Created by MBPro on 6/29/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "Quiz.h"

@interface Quiz ()

@end

@implementation Quiz

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _checkmarkImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"checkmark.png"]];
    _wrongImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wrong.png"]];
    
    NSString* filePath = [[NSBundle mainBundle] pathForResource:@"quiz" ofType:@"json"];
    NSData *content = [[NSData alloc] initWithContentsOfFile:filePath];
    
    _jsonArray = [NSJSONSerialization JSONObjectWithData:content options:kNilOptions error:nil];
    _choiceArray = [[NSMutableArray alloc] initWithObjects:_choice1,_choice2,_choice3,_choice4,nil];
    _question.numberOfLines = 2;
    _question.adjustsFontSizeToFitWidth = YES;
    _question.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"@concrete.jpg"]];
    
    _questionIndex = 0;
    [_choice1.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [_choice2.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [_choice3.titleLabel setAdjustsFontSizeToFitWidth:YES];
    [_choice4.titleLabel setAdjustsFontSizeToFitWidth:YES];
    
    _navigationBarTitle = [NSString stringWithFormat:@"Question %d/%d", _questionIndex+1, [_jsonArray count]];
                      
    self.navigationItem.title= _navigationBarTitle;
    
    [self initializeQuiz];
}

-(void) initializeQuiz {
    //Check to see if the question # we are on is within the # of questions available
    if(_questionIndex < [_jsonArray count]){
        NSDictionary *dict = [_jsonArray objectAtIndex:_questionIndex];
        int choiceIndex = 0;
        for (NSString* key in dict) {
            NSLog(@"Key: %@ choiceIndex: %d", key, choiceIndex);
            if([key isEqualToString:@"question"]) {
                _question.text = [dict objectForKey:key];
            } else if([key isEqualToString:@"correct"]) {
                _correctChoice = [dict objectForKey:key];
            } else {
                [_choiceArray[choiceIndex] setTitle:[dict objectForKey:key] forState:UIControlStateNormal];
                choiceIndex++;
            }
        }
    }
     _navigationBarTitle = [NSString stringWithFormat:@"Question %d/%d", _questionIndex+1, [_jsonArray count]];
    self.navigationItem.title = _navigationBarTitle;
}

-(void) moveToNextQuestion {
    //1: Go through and change the state of each button .selected
    //2: Remove all images
    //3: Initialize the quiz with the incremented quiz #
    [self resetButtonStates];
    [self removeFeedbackImages];
    [self incrementQuestionIndex];
    [self initializeQuiz];
}

- (IBAction)moveToPreviousQuestion:(UIButton*)sender {
    [self resetButtonStates];
    [self removeFeedbackImages];
    [self decrementQuestionIndex];
    [self initializeQuiz];
}

- (IBAction)skipToNextQuestion:(UIButton*)sender {
    [self resetButtonStates];
    [self removeFeedbackImages];
    [self incrementQuestionIndex];
    [self initializeQuiz];
}

-(void) decrementQuestionIndex {
    if(_questionIndex > 0)
        _questionIndex--;
}
-(void) incrementQuestionIndex {
    if(_questionIndex < [_jsonArray count]-1)
        _questionIndex++;
}

-(void) resetButtonStates {
    for(int i =0; i < [_choiceArray count]; i++) {
        [_choiceArray[i] setSelected:NO];
        [_choiceArray[i] setBackgroundColor:[UIColor clearColor]];
    }
}

-(void) removeFeedbackImages {
    [_checkmarkImage setHidden:YES];
    [_wrongImage setHidden:YES];
}

- (IBAction)choicePressed:(UIButton*)sender {
    CGPoint coordinates = sender.frame.origin;
    
    if([sender.currentTitle isEqualToString:_correctChoice]) {
        [sender setBackgroundColor:[UIColor greenColor]];
        if(![sender isSelected]) {
            sender.selected = ![sender isSelected];
            [_checkmarkImage setFrame:CGRectMake(coordinates.x, coordinates.y, 50, 50)];
            [self.view addSubview:_checkmarkImage];
            [_checkmarkImage setHidden:NO];
            [_wrongImage setHidden:YES];
        } else if([sender isSelected]) {
            [self moveToNextQuestion];
        }
    } else {
        [sender setBackgroundColor:[UIColor redColor]];
        [_wrongImage setFrame:CGRectMake(coordinates.x, coordinates.y, 50, 50)];
        [self.view addSubview:_wrongImage];
        [_wrongImage setHidden:NO];
        [_checkmarkImage setHidden:YES];
        NSLog(@"incorrect choice");
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
