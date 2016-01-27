//
//  ViewController.m
//  XYDropDownListDemo
//
//  Created by hemiying on 16/1/18.
//  Copyright © 2016年 hemiying. All rights reserved.
//

#import "ViewController.h"
#import "XYDorpDownMenu.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XYDorpDownMenu *menu = [[XYDorpDownMenu alloc] initWithFrame:CGRectMake(100, 100, self.view.bounds.size.width - 200, 30) MenuTitle:@"类型" DataSource:@[@"财务类型", @"非财务类型", @"非财务类型", @"非财务类型", @"非财务类型", @"非财务类型", @"非财务类型"] MaxDisplayMenuNumber:5];
    menu.separationLineInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    menu.separationLineColor = [UIColor whiteColor];
    [self.view addSubview:menu];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
