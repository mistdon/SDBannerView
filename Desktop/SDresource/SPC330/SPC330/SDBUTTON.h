//
//  SDBUTTON.h
//  SPC330
//
//  Created by shendong on 16/5/5.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, ButtonImageTitleStyle ) {
    ButtonImageTitleStyleDefault      = 0,//图片在左，文字在右，整体居中。
    ButtonImageTitleStyleLeft         = 0,//图片在左，文字在右，整体居中。
    ButtonImageTitleStyleRight        = 2,//图片在右，文字在左，整体居中。
    ButtonImageTitleStyleTop          = 3,//图片在上，文字在下，整体居中。
    ButtonImageTitleStyleBottom       = 4,//图片在下，文字在上，整体居中。
    ButtonImageTitleStyleCenterTop    = 5,//图片居中，文字在上距离按钮顶部。
    ButtonImageTitleStyleCenterBottom = 6,//图片居中，文字在下距离按钮底部。
    ButtonImageTitleStyleCenterUp     = 7,//图片居中，文字在图片上面。
    ButtonImageTitleStyleCenterDown   = 8,//图片居中，文字在图片下面。
    ButtonImageTitleStyleRightLeft    = 9,//图片在右，文字在左，距离按钮两边边距
    ButtonImageTitleStyleLeftRight    = 10,//图片在左，文字在右，距离按钮两边边距
};
@interface SDBUTTON : UIButton
-(void)setButtonImageTitleStyle:(ButtonImageTitleStyle)style padding:(CGFloat)padding;
@end
