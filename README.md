RHDropDownMenu
========================

![github](http://a2.qpic.cn/psb?/V10AI9AY3CwCiW/n66PqQHNIijHlGv1LGCBDcHY6C70jD7H5iIHqCFelJw!/b/dH4BAAAAAAAA&bo=nQH0AgAAAAACFFo!&rf=viewer_4)

目录
--------------------------
* [默认使用] (#默认使用)

* [自定义效果] (#自定义效果)

#### <a id = "默认使用"></a>默认使用
<!--## <a id="UIWebView01-下拉刷新"></a>UIWebView01-下拉刷新-->
        RHDropDownMenu *menu = [[RHDropDownMenu alloc] initWithFrame:CGRectMake(100, 100, self.view.bounds.size.width - 200, 30)
        menuTitle:@"MenuName" 
        dataSource:@[@"item1", @"item2", @"item3", @"item4", @"item5", @"item6", @"item7"] 
        maxDisplayMenuNumber:5];
        self.view addSubview:menu];
  
  若想要检测到选中菜单事件可设置代理
  
        menu.delegate = self;
  
  必须要实现方法 : 
        
        - (void)RHDropDownMenu:(XYDorpDownMenu *)menu didSelectAtIndexPath:(NSIndexPath *)indexPath;


#### <a id = "自定义效果"></a>自定义效果
  
  * 下拉菜单提示文字属性
  
  menuNameFrame : 下拉菜单提示文字的位置
  
  meneNameTextColor : 下拉菜单提示文字的字体颜色
  
  meneNameTextFont : 下拉菜单提示文字字体
  
  menuNameBackgroundColor : 下拉菜单提示文字背景颜色
  
  * 下拉菜单提示展开收起图标
  
  indicatorIconImage : 图标
  
  indicatorIconFrame : 位置
  
  默认有一张图片和位置,若不想要则将图片设为nil
  
  * 下拉菜单菜单项属性
  
  separationLineColor : 分割线颜色
  
  separationLineColor : 分割线偏移
  
  meneItemTextFont : 菜单项文字字体
  
  meneItemTextColor : 菜单项文字颜色
  
  menuItemBackgroundColor : 菜单项背景颜色
  
  menuItemTextFrame : 菜单项文字位置
  
  menuItemHeight : 菜单项高度
  
