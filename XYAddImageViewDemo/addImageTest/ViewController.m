//
//  ViewController.m
//  addImageTest
//
//  Created by hemiying on 15/12/30.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import "ViewController.h"
#import "XYAddImageView.h"

#define kScreenHeight [UIScreen mainScreen].bounds.size.height
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    XYAddImageView *img = [[XYAddImageView alloc] initWithFrame:CGRectMake(0, 100, kScreenWidth, 100) NumberOfImageForOneLine:5];
    [self.view addSubview:img];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
