//
//  XYAddImageView.h
//  addImageTest
//
//  Created by hemiying on 15/12/30.
//  Copyright © 2015年 hemiying. All rights reserved.
//

#import <UIKit/UIKit.h>
@class XYAddImageView;

@protocol XYAddImageViewDelegtate <NSObject>

/**
 *  增加了图片并且frame变大
 *
 *  @param imageView
 */
- (void)XYAddImageViewFrameDidIncrease:(XYAddImageView *)imageView;
/**
 *  删除了图片并且frame变小
 *
 *  @param imageView
 */
- (void)XYAddImageViewFrameDidDecrease:(XYAddImageView *)imageView;

@end

@interface XYAddImageView : UIView

/**
 *  初始化
 *
 *  @param frame         frame
 *  @param numberOfImage 一行显示几张图片
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
      NumberOfImageForOneLine:(NSUInteger)numberOfImage;

@property (nonatomic, readwrite, strong) UIImage *deleteImage;
@property (nonatomic, readwrite, strong) UIImage *addImage;
@property (nonatomic, weak) id<XYAddImageViewDelegtate> delegate;
@property (nonatomic, readonly, assign) NSUInteger currentSection; // 当前图片行数

@end
