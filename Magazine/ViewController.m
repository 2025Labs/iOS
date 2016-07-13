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
#import "IGCMenu.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.playerView loadWithVideoId:@"lZxJgTiKDis"];
    [self prepareNavigationMenu];
    [self prepareMenu];
    }

-(void) prepareNavigationMenu {
    self.logoImage.contentMode =UIViewContentModeScaleAspectFit;
    self.puzzleButton.layer.cornerRadius = self.puzzleButton.frame.size.width/2;
    self.gameButton.layer.cornerRadius = self.gameButton.frame.size.width/2;
    self.triviaButton.layer.cornerRadius = self.triviaButton.frame.size.width/2;
    
}
-(void) prepareMenu {
    _menuButton.clipsToBounds = YES;
    _menuButton.layer.cornerRadius = self.menuButton.frame.size.width / 2;
    [_menuButton setImage:[UIImage imageNamed:@"plus.png"] forState:UIControlStateNormal];
    
    if(_menu == nil) {
        _menu = [[IGCMenu alloc] init];
    }
    _menu.menuButton = self.menuButton;
    _menu.menuSuperView = self.view;
    _menu.disableBackground = YES;
    _menu.numberOfMenuItem = 3;
    _menu.menuRadius = 125; //How far apart the menu displays
    _menu.menuHeight = 90; //Size of the circles
    _menu.menuItemsNameArray = [NSArray arrayWithObjects:@"Computing", @"Energy", @"Materials", nil];
    _isMenuActive = false;
    _menu.delegate = self;

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
    } else if([segue.identifier isEqualToString:@"showArticle"]) {
        ArticleViewing* controller = [segue destinationViewController];
        //aroundtheworld not aroundtheworld.jpg because the scrollview appends the filetype in the method
        controller.fileName = @"article";
        controller.numPages = 4;
    }
}

- (IBAction)menuPressed:(id)sender {
    if(_isMenuActive) {
        [_menu hideCircularMenu];
        _isMenuActive = false;
    } else {
        [_menu showCircularMenu];
        _isMenuActive = true;
    }
}

- (void)igcMenuSelected:(NSString *)selectedMenuName atIndex:(NSInteger)index{

    switch (index) {
        case 0:
            NSLog(@"Transition to Computing");
            break;
        case 1:
            NSLog(@"Transition to Energy");

            break;
        case 2:
            NSLog(@"Transition to Materials");

            break;
        default:
            break;
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
