//
//  ViewController.m
//  Magazine
//
//  Created by MBPro on 6/22/16.
//  Copyright © 2016 MBPro. All rights reserved.
//

#import "ViewController.h"
#import "Puzzle.h"
#import "ArticleViewing.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    self.logoImage.contentMode =UIViewContentModeScaleAspectFit;
    self.puzzleButton.layer.cornerRadius = self.puzzleButton.frame.size.width/2;
    self.gameButton.layer.cornerRadius = self.gameButton.frame.size.width/2;
    self.triviaButton.layer.cornerRadius = self.triviaButton.frame.size.width/2;

}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    NSLog(@"Hello");
    if([segue.identifier isEqualToString:@"showCipher"]) {
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"cipher.jpg";
    } else if([segue.identifier isEqualToString:@"showWordSearch"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"wordsearch.png";
    } else if([segue.identifier isEqualToString:@"showFillInTheBlank"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"fillintheblank.jpg";
    } else if([segue.identifier isEqualToString:@"showMaterialTime"]){
        Puzzle* controller = [segue destinationViewController];
        controller.fileName = @"materialtime.jpg";
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
