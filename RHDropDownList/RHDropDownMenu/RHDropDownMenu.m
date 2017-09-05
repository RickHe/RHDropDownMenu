//
//  RHDropDownMenu.m
//  kRHDropDownListDemo
//
//  Created by hemiying on 16/1/18.
//  Copyright © 2016年 hemiying. All rights reserved.
//

#import "RHDropDownMenu.h"

#define kRHScreenHeight [UIScreen mainScreen].bounds.size.height
#define kRHScreenWidth [UIScreen mainScreen].bounds.size.width

#define kRHTableViewRowHeightDefaultHeight 30

// color
#define kRHBackgroundViewDefaultColor [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:0.6]
#define kRHMenuItemDefaultColor [UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]

// font
#define kRHDefaultFontSize [UIFont systemFontOfSize:16]

// frame
#define kRHIndicatorIconDefaultFrame CGRectMake(width - 12 - 16, (height - 16) / 2, 16, 16)
#define kRHMenuNameDefaultFrame CGRectMake(12, (height - 16) / 2, 88, 16)
#define kRHMenuItemTextDefaultFrame CGRectMake(12, (30 - 16) / 2 , 188, 16)

@interface RHDropDownMenu () <UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_tableView;
    NSString *_menuTitle;
    UIButton *_clickStartBtn;
    UIImageView *_clickStartTip;
    UILabel *_menuTitleLab;
    NSArray *_tempDataSource;
    CGRect _headViewFrame;
    NSUInteger _maxDisplayMenuNumber;
    UIView *_backgroundView;
}

@property (nonatomic, readwrite, strong) NSArray *dataSource;

@end

@implementation RHDropDownMenu

#pragma mark - LifeCycle
/**
 *  使用数剧初始化
 *
 *  @param frame      大小
 *  @param MenuTitle  菜单名称
 *  @param dataSource 菜单选项数据
 *
 *  @return self
 */
- (instancetype)initWithFrame:(CGRect)frame
                    menuTitle:(NSString *)title
                   dataSource:(NSArray *)dataSource
         maxDisplayMenuNumber:(NSUInteger)maxDisplayMenuNumber {
    if (self = [super initWithFrame:frame]) {
        _headViewFrame = CGRectMake(0, 0, frame.size.width, frame.size.height);
        _maxDisplayMenuNumber = maxDisplayMenuNumber;
        _menuTitle = title;
        _dataSource = dataSource;
        _tempDataSource = [[NSArray alloc] initWithArray:_dataSource copyItems:YES];
        _dataSource = nil;
        
        // 设置一些默认属性
        [self p_setDefaultProperty];
        // 创建子视图
        [self p_createSubviews];
    }
    return self;
}

/**
 *  默认初始化屏蔽
 *
 *  @param frame
 *
 *  @return nil
 */
- (instancetype)initWithFrame:(CGRect)frame {
    NSAssert(true, @"请输入菜单数据参数");
    return nil;
}

/**
 *  默认初始化屏蔽
 *
 *  @return nil
 */
- (instancetype)init {
    NSAssert(true, @"请输入菜单数据参数");
    return nil;
}

#pragma mark - Private_Init
/**
 *  设置默认属性
 */
- (void)p_setDefaultProperty {
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    // 选中颜色
    _sectionColor = [UIColor blackColor];
    
    // 菜单名字属性
    _meneNameTextColor = [UIColor lightGrayColor];
    _menuNameBackgroundColor = [UIColor whiteColor];
    _meneNameTextFont = kRHDefaultFontSize;
    _menuNameFrame = kRHMenuNameDefaultFrame;
    
    // 菜单展开与否指示
    _indicatorIconImage = [UIImage imageNamed:@"opinion_read"];
    _indicatorIconFrame = kRHIndicatorIconDefaultFrame;
    
    // 菜单项属性
    _separationLineColor = [UIColor whiteColor];
    _separationLineInsets = UIEdgeInsetsZero;
    _meneItemTextColor = [UIColor lightGrayColor];
    _menuItemBackgroundColor = kRHMenuItemDefaultColor;
    _meneItemTextFont = kRHDefaultFontSize;
    _menuItemTextFrame = kRHMenuItemTextDefaultFrame;
    _menuItemHeight = 30;
}

/**
 *  创建子视图
 */
- (void)p_createSubviews {
    // 点击展开按钮
    _clickStartBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _clickStartBtn.frame = CGRectMake(0, 0, _headViewFrame.size.width, _headViewFrame.size.height);
    [_clickStartBtn addTarget:self action:@selector(clickToStartAction:) forControlEvents:UIControlEventTouchUpInside];
    _clickStartBtn.backgroundColor = [UIColor whiteColor];
    [self addSubview:_clickStartBtn];
    
    // 菜单名字
    _menuTitleLab = [[UILabel alloc] initWithFrame:_menuNameFrame];
    _menuTitleLab.text = _menuTitle;
    _menuTitleLab.backgroundColor = [UIColor clearColor];
    [_clickStartBtn addSubview:_menuTitleLab];
    
    // 菜单点击展开按钮
    _clickStartTip = [[UIImageView alloc] initWithFrame:_indicatorIconFrame];
    _clickStartTip.image = _indicatorIconImage;
    [_clickStartBtn addSubview:_clickStartTip];
    
    // 线
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, _headViewFrame.size.height, _headViewFrame.size.width, 1)];
    lineView.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:lineView];
    
    // 菜单项
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorColor = _separationLineColor;
    _tableView.backgroundColor = _menuItemBackgroundColor;
    [self addSubview:_tableView];
}

#pragma mark - ShowViews
/**
 *  显示展开的视图
 */
- (void)p_showOpenMenuView {
    _dataSource = [[NSArray alloc] initWithArray:_tempDataSource copyItems:YES];;
    NSUInteger rows = _dataSource.count;
    if (_dataSource.count > _maxDisplayMenuNumber) {
        rows = _maxDisplayMenuNumber;
    }
    CGRect frame = self.frame;
    frame.size.height += rows * _menuItemHeight;
    self.frame = frame;
    _tableView.frame = CGRectMake(0, _headViewFrame.size.height, _headViewFrame.size.width, rows * _menuItemHeight);
    _clickStartTip.transform = CGAffineTransformRotate(_clickStartTip.transform, M_PI_2);
    [_tableView reloadData];
}

/**
 *  显示收起的视图
 */
- (void)p_showCloseMenuView {
    NSUInteger rows = _dataSource.count;
    if (_dataSource.count > _maxDisplayMenuNumber) {
        rows = _maxDisplayMenuNumber;
    }
    CGRect frame = self.frame;
    frame.size.height -= rows * _menuItemHeight;
    self.frame = frame;
    _tableView.frame = CGRectZero;
    _clickStartTip.transform = CGAffineTransformIdentity;
    _dataSource = nil;
    [_tableView reloadData];
}

#pragma mark - Set_MenuName_Property
/**
 *  设置菜单名字背景颜色
 *
 *  @param menuNameBackgroundColor
 */
- (void)setMenuNameBackgroundColor:(UIColor *)menuNameBackgroundColor {
    _menuItemBackgroundColor = menuNameBackgroundColor;
    _clickStartBtn.backgroundColor = menuNameBackgroundColor;
}

/**
 *  设置菜单名字的frame
 *
 *  @param menuNameFrame
 */
- (void)setMenuNameFrame:(CGRect)menuNameFrame {
    _menuNameFrame = menuNameFrame;
    _menuTitleLab.frame = _menuNameFrame;
}

/**
 *  设置菜单名字字体
 *
 *  @param meneNameTextFont
 */
- (void)setMeneNameTextFont:(UIFont *)meneNameTextFont {
    _meneItemTextFont = meneNameTextFont;
    _menuTitleLab.font = _meneNameTextFont;
}

/**
 *  设置菜单名字的文字颜色
 *
 *  @param meneNameTextColor
 */
- (void)setMeneNameTextColor:(UIColor *)meneNameTextColor {
    _meneNameTextColor = meneNameTextColor;
    _menuTitleLab.textColor = _meneNameTextColor;
}

#pragma mark - Set_Menu_Indicator_Icon_Property
/**
 *  设置提示图片frame
 *
 *  @param indicatorIconFrame
 */
- (void)setIndicatorIconFrame:(CGRect)indicatorIconFrame {
    _indicatorIconFrame = indicatorIconFrame;
    _clickStartTip.frame = _indicatorIconFrame;
}

/**
 *  设置提示图片
 *
 *  @param indicatorIconImage
 */
- (void)setIndicatorIconImage:(UIImage *)indicatorIconImage {
    _indicatorIconImage = indicatorIconImage;
    _clickStartTip.image = _indicatorIconImage;
}

#pragma mark - Set_MenuItems_Property
/**
 *  设置分割线颜色
 *
 *  @param separationLineColor
 */
- (void)setSeparationLineColor:(UIColor *)separationLineColor {
    _separationLineColor = separationLineColor;
    _tableView.separatorColor = _separationLineColor;
}

/**
 *  设置背景颜色
 *
 *  @param color
 */
- (void)setMenuItemBackgroundColor:(UIColor *)menuItemBackgroundColor {
    _menuItemBackgroundColor = menuItemBackgroundColor;
    _tableView.backgroundColor = _menuItemBackgroundColor;
}

#pragma mark - Set_Other_Property
/**
 *  设置选中颜色
 *
 *  @param sectionColor 
 */
- (void)setSectionColor:(UIColor *)sectionColor {
    _sectionColor = sectionColor;
    _clickStartBtn.backgroundColor = _sectionColor;
}

/**
 *
 *
 *  @param font
 */
- (void)setFont:(UIFont *)font {
    _font = font;
    _menuTitleLab.font = _font;
}

#pragma mark - Set BackgroundView Property
- (void)setBackgroundViewColor:(UIColor *)backgroundViewColor {
    _backgroundViewColor = backgroundViewColor;
    _backgroundView.backgroundColor = _backgroundViewColor;
}

- (void)setBackgoundViewAlpha:(CGFloat)backgoundViewAlpha {
    _backgoundViewAlpha = backgoundViewAlpha;
    _backgroundView.alpha = backgoundViewAlpha;
}

#pragma mark - ButtonAction
/**
 *  点击展开按钮事件
 *
 *  @param btn
 */
- (void)clickToStartAction:(UIButton *)btn {
    btn.selected = !btn.selected;
    if (btn.selected) {
        _backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0,kRHScreenWidth , kRHScreenHeight)];
        // default color
        _backgroundView.backgroundColor = kRHBackgroundViewDefaultColor;
        [self.superview insertSubview:_backgroundView atIndex:0];
        [self p_showOpenMenuView];
    } else {
        [_backgroundView removeFromSuperview];
        [self p_showCloseMenuView];
    }
}

#pragma mark - UITableViewDataSource
// 区数
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

// cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    for (UIView *view in cell.contentView.subviews) {
        [view removeFromSuperview];
    }
    UILabel *label = [[UILabel alloc] initWithFrame:self.menuItemTextFrame];
    label.text = _dataSource[indexPath.row];
    // 字体
    label.font = self.meneItemTextFont;
    // 字体颜色
    label.textColor = self.meneItemTextColor;
    label.backgroundColor = [UIColor clearColor];
    cell.backgroundColor = [UIColor clearColor];
    [cell.contentView addSubview:label];
    return cell;
}

#pragma mark - UITableViewDelegate
/**
 *  调整分割线位置
 *
 *  @param tableView
 *  @param cell
 *  @param indexPath
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:_separationLineInsets];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:_separationLineInsets];
    }
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
}

//高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kRHTableViewRowHeightDefaultHeight;
}

// 区尾高度
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

// 选中
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _menuTitleLab.text = _tempDataSource[indexPath.row];
    _selectedString = _menuTitleLab.text;
    [_delegate RHDropDownMenu:self didSelectAtIndexPath:indexPath];
    _clickStartBtn.selected = NO;
    [_backgroundView removeFromSuperview];
    [self p_showCloseMenuView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
