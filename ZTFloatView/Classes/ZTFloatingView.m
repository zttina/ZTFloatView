//
//  ZTFloatingView.m
//  ZTFloatView
//
//  Created by zt on 2019/4/8.
//  Copyright © 2019 zt. All rights reserved.
//

#import "ZTFloatingView.h"

@interface ZTFloatingView()

/** 左边的圆圈图片 */
@property (nonatomic,strong) UIImageView *headerView;
/** 文字的上部分 */
@property (nonatomic,strong) UILabel *topLabel;
/** 文字的下部分 */
@property (nonatomic,strong) UILabel *bottomLabel;
/** 最右边的箭头 */
@property (nonatomic,strong) UIImageView *arrowImgV;
/** view的展开时的宽度 */
@property (nonatomic,assign) CGFloat longWidth;
@end

@implementation ZTFloatingView

- (instancetype)initWithFrame:(CGRect)frame
                        image:(UIImage *)image
                      topText:(NSString *)topText
                   bottomText:(NSString *)bottomText
                   arrowImage:(UIImage *)arrowImage {
    
    if (self = [super initWithFrame:frame]) {
        
        self.frame = frame;
        self.longWidth = frame.size.width;
        self.image = image;
        self.topText = topText;
        self.bottomText = bottomText;
        self.arrowImage = arrowImage;
        
        // 创建UI
        [self createUI];
        
        // 默认渐变颜色
        self.layer.cornerRadius = ZTadapter(self.frame.size.height)/2.0;
        self.layer.shadowColor = [ZTHEXCOLOR(0x00007A) colorWithAlphaComponent:0.2].CGColor;
        self.layer.shadowOffset = CGSizeMake(0,5);
        self.layer.shadowOpacity = 1;
        self.layer.shadowRadius = 10;
    }
    return self;
}

//创建UI
- (void)createUI {
    
    // 横向空隙
    CGFloat xSpace = 5;
    // 纵向空隙
    CGFloat ySpace = 5;
    //头像宽高
    CGFloat headerW = (self.frame.size.height - ySpace * 2);
    self.headerView = [[UIImageView alloc] initWithFrame:CGRectMake(xSpace, ySpace, headerW, headerW)];
    [self addSubview:self.headerView];

    // 主image
    self.headerView.image = self.image;
    self.headerView.layer.cornerRadius = headerW/2.0;
    self.headerView.layer.masksToBounds = YES;
    
    // 主title
    self.topLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.headerView.frame) + xSpace,
                                                              ySpace + 2,
                                                              self.frame.size.width - CGRectGetMaxX(self.headerView.frame) + xSpace - 16 - 10,
                                                              (self.frame.size.height/2.0 - (ySpace + 2)))];
    self.topLabel.text = self.topText;
    [self addSubview:self.topLabel];
    self.topLabel.textColor = ZTHEXCOLOR(0xFFFFFF);
    self.topLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightMedium];
    
    // 副title
    self.bottomLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.topLabel.frame.origin.x,
                                                                 CGRectGetMaxY(self.topLabel.frame),
                                                                 CGRectGetWidth(self.topLabel.frame),
                                                                 self.frame.size.height - ySpace - 2 - CGRectGetMaxY(self.topLabel.frame))];
    self.bottomLabel.text = self.bottomText;
    [self addSubview:self.bottomLabel];
    self.bottomLabel.textColor = ZTHEXCOLOR(0xFFFFFF);
    self.bottomLabel.font = [UIFont systemFontOfSize:10 weight:UIFontWeightLight];
    
    // 指向箭头
    self.arrowImgV = [[UIImageView alloc]initWithFrame:CGRectMake(self.frame.size.width - 10 - 6, 0, 6, 10)];
    [self addSubview:self.arrowImgV];
    self.arrowImgV.image = self.arrowImage;
    CGPoint center = self.arrowImgV.center;
    center.y = self.frame.size.height / 2.0;
    self.arrowImgV.center = center;
    [self addGestures];
}

- (void)addGestures {
    // 拖动手势
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(moveTheView:)];
    [self addGestureRecognizer:pan];
    
    // 点击进入订单详情页面
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTheView:)];
    [self addGestureRecognizer:tap];
    [tap requireGestureRecognizerToFail:pan];
    
}

// MARK:tap加在此view上，tap之后 的操作
- (void)tapTheView:(UITapGestureRecognizer *)tap {
    
    if (self.tapBlock) {
        self.tapBlock();
    }
}

// MARK:拖动手势，可全屏拖动。
- (void)moveTheView:(UIPanGestureRecognizer *)panG {
    
    self.layer.shadowColor = [ZTHEXCOLOR(0x00007A) colorWithAlphaComponent:0.2].CGColor;
    // 开始的时候和结束的时候，需要判断此view是否需要缩小到一个圆，在changeBlock里面操作。拖动的时候，在moveBlock里操作。
    if (panG.state == UIGestureRecognizerStateChanged) {
        
        CGPoint location = [panG locationInView:panG.view];
        if (location.y < 0 || location.y > self.superview.bounds.size.height) {
            return;
        }
        CGPoint translation = [panG translationInView:panG.view];
        panG.view.center = CGPointMake(panG.view.center.x + translation.x,panG.view.center.y + translation.y);
        [panG setTranslation:CGPointZero inView:panG.view];
    }else if (panG.state == UIGestureRecognizerStateEnded) {
       
        [self changeFloatViewToCircle:YES];
    }else if (panG.state == UIGestureRecognizerStateBegan) {
        
        [self changeFloatViewToCircle:NO];
    }
}
- (void)changeFloatViewToCircle:(BOOL)isCircle {
    
    __weak typeof(self) weakself = self;
    __block CGRect rect = self.frame;
    if (rect.origin.y < ZT_kNavigationBarHeight) {
        rect.origin.y = ZT_kNavigationBarHeight;
    }
    if (rect.origin.y + rect.size.height > ZTSCREENH - ZT_TAB_BAR_HEIGHT) {
        rect.origin.y = ZTSCREENH - ZT_TAB_BAR_HEIGHT - rect.size.height;
    }
    self.frame = rect;
    if (isCircle) {
        self.layer.masksToBounds = YES;
        //如果是要变成圆，即结束拖动
        //如果x+widht >= screenW 或者 x<=0
        if (rect.origin.x <= 0) {
            [UIView animateWithDuration:0.3 animations:^{
                rect.origin.x = 0;
                
                rect.size.width = rect.size.height;
                weakself.frame = rect;
            }];
        }else if (rect.origin.x + rect.size.width >= ZTSCREENW) {
            [UIView animateWithDuration:0.3 animations:^{
                rect.origin.x = (ZTSCREENW - rect.size.height);
                rect.size.width = rect.size.height;
                weakself.frame = rect;
            }];
        }
        
    }else {
        self.layer.masksToBounds = NO;
        if (rect.size.width == rect.size.height) {
            [UIView animateWithDuration:0.3 animations:^{
                rect.origin.x -= (rect.size.width - rect.size.height);
                if (rect.origin.x < 0) {
                    rect.origin.x = 0;
                }
                rect.size.width = weakself.longWidth;
                weakself.frame = rect;
            }];
            
        }
    }
    
}

#pragma mark - public method
// 添加背景渐变色
- (void)addGradientLayerFromLeftColor:(UIColor *)leftColor toRightColor:(UIColor *)rightColor {
    
    CAGradientLayer *gradientLayer = [[CAGradientLayer alloc] init];
    gradientLayer.cornerRadius = self.layer.cornerRadius;
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = @[
                             (id)leftColor.CGColor,
                             (id)rightColor.CGColor
                             ];
    gradientLayer.locations = @[@0, @1];
    [gradientLayer setStartPoint:CGPointMake(0, 0)];
    [gradientLayer setEndPoint:CGPointMake(1, 0)];
    [self.layer insertSublayer:gradientLayer atIndex:0];
}

#pragma mark -- 设置控件的有关属性
- (void)setImage:(UIImage *)image {
    
    _image = image;
    if (self.headerView) {
        self.headerView.image = image;
    }
}

- (void)setArrowImage:(UIImage *)arrowImage {
    
    _arrowImage = arrowImage;
    if (self.arrowImgV) {
        self.arrowImgV.image = arrowImage;
    }
}

- (void)setTopText:(NSString *)topText {
    
    _topText = topText;
    self.topLabel.text = topText;
}

- (void)setTopTextFont:(UIFont *)topTextFont {
    
    _topTextFont = topTextFont;
    self.topLabel.font = topTextFont;
}

- (void)setTopTextColor:(UIColor *)topTextColor {
    
    _topTextColor = topTextColor;
    self.topLabel.textColor = topTextColor;
}

- (void)setBottomText:(NSString *)bottomText {
    
    _bottomText = bottomText;
    self.bottomLabel.text = bottomText;
}

- (void)setBottomTextFont:(UIFont *)bottomTextFont {
    
    _bottomTextFont = bottomTextFont;
    self.bottomLabel.font = bottomTextFont;
}

- (void)setBottomTextColor:(UIColor *)bottomTextColor {
    
    _bottomTextColor = bottomTextColor;
    self.bottomLabel.textColor = bottomTextColor;
}

- (void)setTapBlock:(TapTheView)tapBlock {
    _tapBlock = [tapBlock copy];
}

@end
