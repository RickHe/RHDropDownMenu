//
//  ViewController.m
//  RHDropDownList
//
//  Created by DaFenQI on 2017/9/5.
//  Copyright © 2017年 DaFenQi. All rights reserved.
//

#import "ViewController.h"
#import "RHDropDownMenu.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    RHDropDownMenu *menu = [[RHDropDownMenu alloc] initWithFrame:CGRectMake(100, 100, self.view.bounds.size.width - 200, 30) menuTitle:@"类型" dataSource:@[@"类型1", @"类型2", @"类型3", @"类型4", @"类型5", @"类型6", @"类型7"] maxDisplayMenuNumber:5];
    menu.separationLineInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    menu.separationLineColor = [UIColor whiteColor];
    [self.view addSubview:menu];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
