//
//  Puzzle.h
//  Magazine
//
//  Created by 2025 Labs on 6/23/16.
//  Copyright @ 2017 2025 Labs LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "YTPlayerView.h"



@interface youtubeViewController : UIViewController<YTPlayerViewDelegate>
@property(nonatomic, strong) IBOutlet YTPlayerView *playerView;

@property NSString* videoID;

@end
