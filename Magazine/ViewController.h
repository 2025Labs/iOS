//
//  ViewController.h
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"
#import "IGCMenu.h"

@interface ViewController : UIViewController<IGCMenuDelegate>

@property (weak, nonatomic) IBOutlet UIButton *puzzleButton;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;
@property (weak, nonatomic) IBOutlet UIButton *triviaButton;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *coverPage;

@property (weak, nonatomic) IBOutlet UIButton *topArticle;
@property (weak, nonatomic) IBOutlet UIButton *bottomArticle;
@property (weak, nonatomic) IBOutlet UIButton *topPuzzle;
@property (weak, nonatomic) IBOutlet UIButton *bottomPuzzle;


@property (weak, nonatomic) IBOutlet UIButton *menuButton;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIButton *nextButton;
@property (weak, nonatomic) IBOutlet UIButton *prevButton;


@property NSString *currentTopic;
@property int leftArticlePageToJumpTo;
@property int rightArticlePageToJumpTo;
@property int pageNumber;
@property int maxPageNumber;


@property IGCMenu *menu;
@property BOOL isMenuActive;
@end

