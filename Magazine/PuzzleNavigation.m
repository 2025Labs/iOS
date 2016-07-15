//
//  PuzzleNavigation.m
//  Magazine
//
//  Created by MBPro on 6/24/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "PuzzleNavigation.h"
#import "Puzzle.h"
#import "ArticleViewing.h"
@implementation PuzzleNavigation

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.logoImage.contentMode =UIViewContentModeScaleAspectFit;
    self.PuzzleButton.layer.cornerRadius = self.PuzzleButton.frame.size.width/2;
    self.GameButton.layer.cornerRadius = self.GameButton.frame.size.width/2;
    self.triviaButton.layer.cornerRadius = self.triviaButton.frame.size.width/2;
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Hello");
    if([segue.identifier isEqualToString:@"showCipher"]) {
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"cipher";
    } else if([segue.identifier isEqualToString:@"showWordSearch"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"wordsearch";
    } else if([segue.identifier isEqualToString:@"showFillInTheBlank"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"fillintheblank";
    } else if([segue.identifier isEqualToString:@"showMaterialTime"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"materialtime";
    } else if([segue.identifier isEqualToString:@"showWorld"]) {
        ArticleViewing* controller = [segue destinationViewController];
        //aroundtheworld not aroundtheworld.jpg because the scrollview appends the filetype in the method
        controller.fileName = @"aroundtheworld";
        controller.numPages = 2;
    }  else if([segue.identifier isEqualToString:@"showArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        //aroundtheworld not aroundtheworld.jpg because the scrollview appends the filetype in the method
        controller.fileName = @"article";
        controller.numPages = 4;
    }
}


@end
