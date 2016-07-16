//
//  PuzzleNavigation.h
//  Magazine
//
//  Created by MBPro on 6/24/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface PuzzleNavigation : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *logoImage;
@property (weak, nonatomic) IBOutlet UIButton *triviaButton;
@property (weak, nonatomic) IBOutlet UIButton *GameButton;
@property (weak, nonatomic) IBOutlet UIButton *PuzzleButton;
@property NSString *currentTopic;

@end
