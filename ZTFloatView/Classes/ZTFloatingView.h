//
//  ZTFloatingView.h
//  ZTFloatView
//
//  Created by zt on 2019/4/8.
//  Copyright © 2019 zt. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ZTUtil.h"

NS_ASSUME_NONNULL_BEGIN

/**
 点击view，跳到下一页面的block，传的参数可在这里传
 */
typedef void(^TapTheView)(void);

@interface ZTFloatingView : UIView

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;

#pragma mark ---- 初始化方法
/**
 初始化浮窗
 左图，上下文字，右箭头

 @param frame 位置frame
 @param image 浮窗图片
 @param topText 浮窗主标题
 @param bottomText 浮窗副标题
 @param arrowImage 浮窗右边的箭头图标
 @return 浮窗对象
 */
- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                      topText:(NSString *)topText
                   bottomText:(NSString *)bottomText
                   arrowImage:(UIImage *)arrowImage;

#pragma mark ---- 属性
/**
 浮窗主图片
 */
@property (nonatomic,strong) UIImage *image;

/**
 浮窗主title
 */
@property (nonatomic,copy) NSString *topText;
/**
 浮窗主title字体
 */
@property (nonatomic,strong) UIFont *topTextFont;
/**
 浮窗主title字体颜色
 */
@property (nonatomic,strong) UIColor *topTextColor;

/**
 浮窗副title
 */
@property (nonatomic,copy) NSString *bottomText;
/**
 浮窗副title字体
 */
@property (nonatomic,strong) UIFont *bottomTextFont;
/**
 浮窗副title字体颜色
 */
@property (nonatomic,strong) UIColor *bottomTextColor;

/**
 浮窗箭头图片
 */
@property (nonatomic,strong) UIImage *arrowImage;

#pragma mark ---- 事件回调
/**
 点击view后的处理
 */
@property (nonatomic,copy) TapTheView tapBlock;

#pragma mark ---- 公共方法

/**
 添加渐变背景

 @param leftColor 从左边的色
                     ||
 @param rightColor 右边的颜色
 */
- (void)addGradientLayerFromLeftColor:(UIColor *)leftColor toRightColor:(UIColor *)rightColor;

@end

NS_ASSUME_NONNULL_END
