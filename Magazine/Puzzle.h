//
//  Puzzle.h
//  Magazine
//
//  Created by MBPro on 6/23/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Puzzle : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *cipher;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawingImage;

@property CGPoint lastPoint;
@property CGFloat red;
@property CGFloat green;
@property CGFloat blue;
@property CGFloat brush;
@property CGFloat opacity;
@property BOOL mouseSwiped;
@property NSString *fileName;

@end
