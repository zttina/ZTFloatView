//
//  ZTUtil.h
//  ZTFloatView
//
//  Created by zt on 2019/4/13.
//  Copyright © 2019 zt. All rights reserved.
//

#ifndef ZTUtil_h
#define ZTUtil_h
/*屏幕宽度*/
#define ZTSCREENW (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)
/*屏幕高度*/
#define ZTSCREENH (([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width) ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)


#define ZTHEXCOLOR(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]


#define ZTWIDTH_RATE ZTSCREENW/375.f  // 不同屏幕宽度的比例系数

#define ZTadapter(value)  (value)*ZTWIDTH_RATE


#define ZTgradient1 ZTHEXCOLOR(0x0060FF)

#define ZT_Is_iPhoneX  ((ZTSCREENH == 812 || ZTSCREENH == 896) ? YES : NO)
// tabBar高度
#define ZT_TAB_BAR_HEIGHT (ZT_Is_iPhoneX ? 83 : 49)
// 状态栏高度
#define ZT_kNavigationBarHeight (ZT_Is_iPhoneX ? 88 : 64)


//#import "ZTFloatPushAnimation.h"这个用来写push动效的。暂未整理好。下次提



#endif /* ZTUtil_h */
