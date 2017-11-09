//
//  ViewController.h
//  Magazine
//
//  Created by 2025 Labs on 6/22/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "IGCMenu.h"

@interface ViewController : UIViewController<IGCMenuDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;

@property (weak, nonatomic) IBOutlet UIButton *puzzleButton;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;
@property (weak, nonatomic) IBOutlet UIButton *triviaButton;
@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property NSString *currentTopic;
@property int leftArticlePageToJumpTo;
@property int rightArticlePageToJumpTo;
@property int pageNumber;
@property int maxPageNumber;
@property IGCMenu *_menu;

@property BOOL isScrollingEnabled;
@property BOOL _isMenuActive;

@property (weak, nonatomic) IBOutlet UILabel *currentActivity;

@end

