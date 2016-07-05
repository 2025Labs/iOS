//
//  ViewController.h
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YTPlayerView.h"


@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *puzzleButton;
@property (weak, nonatomic) IBOutlet UIButton *gameButton;
@property (weak, nonatomic) IBOutlet UIButton *triviaButton;

@property (weak, nonatomic) IBOutlet YTPlayerView *playerView;

@property (weak, nonatomic) IBOutlet UIImageView *logoImage;

@end

