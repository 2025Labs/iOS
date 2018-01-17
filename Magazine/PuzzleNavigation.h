//
//  PuzzleNavigation.h
//  Magazine
//
//  Created by 2025 Labs on 6/24/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "IGCMenu.h"
#import <libpq/libpq-fe.h>
#import "Puzzle.h"

@interface PuzzleNavigation : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *triviaButton;
@property (weak, nonatomic) IBOutlet UIButton *GameButton;
@property (weak, nonatomic) IBOutlet UIButton *PuzzleButton;
@property NSString *currentTopic;
@property NSString *note;
@property (nonatomic, strong) NSString *incomingSegue;


//Drawing Variables


@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property Puzzle *puzzleController;

@property CGPoint lastPoint;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat brush;
@property CGFloat opacity;
@property BOOL mouseSwiped;


@property IGCMenu *menu;
@property BOOL isMenuActive;

@property const char *connectionString;
@property PGresult *result;
@property PGconn *connection;
@property NSString *fileName;
@property NSMutableArray *fileArray;

@end
