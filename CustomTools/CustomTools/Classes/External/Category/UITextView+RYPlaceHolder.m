//
//  UITextView+RYPlaceHolder.m
//  DoctorWorkplaces
//
//  Created by 小毅 on 2018/2/26.
//  Copyright © 2018年 Exit_Cola. All rights reserved.
//

#import "UITextView+RYPlaceHolder.h"
#import <objc/runtime.h>
static const void *ry_placeHolderKey;

@interface UITextView ()
@property (nonatomic, readonly) UILabel *ry_placeHolderLabel;
@end
@implementation UITextView (RYPlaceHolder)
+(void)load{
    [super load];
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"layoutSubviews")),
                                   class_getInstanceMethod(self.class, @selector(ryPlaceHolder_swizzling_layoutSubviews)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"dealloc")),
                                   class_getInstanceMethod(self.class, @selector(ryPlaceHolder_swizzled_dealloc)));
    method_exchangeImplementations(class_getInstanceMethod(self.class, NSSelectorFromString(@"setText:")),
                                   class_getInstanceMethod(self.class, @selector(ryPlaceHolder_swizzled_setText:)));
}
#pragma mark - swizzled
- (void)ryPlaceHolder_swizzled_dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [self ryPlaceHolder_swizzled_dealloc];
}
- (void)ryPlaceHolder_swizzling_layoutSubviews {
    if (self.ry_placeHolder) {
        UIEdgeInsets textContainerInset = self.textContainerInset;
        CGFloat lineFragmentPadding = self.textContainer.lineFragmentPadding;
        CGFloat x = lineFragmentPadding + textContainerInset.left + self.layer.borderWidth;
        CGFloat y = textContainerInset.top + self.layer.borderWidth;
        CGFloat width = CGRectGetWidth(self.bounds) - x - textContainerInset.right - 2*self.layer.borderWidth;
        CGFloat height = [self.ry_placeHolderLabel sizeThatFits:CGSizeMake(width, 0)].height;
        self.ry_placeHolderLabel.frame = CGRectMake(x, y, width, height);
    }
    [self ryPlaceHolder_swizzling_layoutSubviews];
}
- (void)ryPlaceHolder_swizzled_setText:(NSString *)text{
    [self ryPlaceHolder_swizzled_setText:text];
    if (self.ry_placeHolder) {
        [self updatePlaceHolder];
    }
}
#pragma mark - associated
-(NSString *)ry_placeHolder{
    return objc_getAssociatedObject(self, &ry_placeHolderKey);
}
-(void)setRy_placeHolder:(NSString *)ry_placeHolder{
    objc_setAssociatedObject(self, &ry_placeHolderKey, ry_placeHolder, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    [self updatePlaceHolder];
}
-(UIColor *)ry_placeHolderColor{
    return self.ry_placeHolderLabel.textColor;
}
-(void)setRy_placeHolderColor:(UIColor *)ry_placeHolderColor{
    self.ry_placeHolderLabel.textColor = ry_placeHolderColor;
}
-(NSString *)placeholder{
    return self.ry_placeHolder;
}
-(void)setPlaceholder:(NSString *)placeholder{
    self.ry_placeHolder = placeholder;
}
#pragma mark - update
- (void)updatePlaceHolder{
    if (self.text.length) {
        [self.ry_placeHolderLabel removeFromSuperview];
        return;
    }
    self.ry_placeHolderLabel.font = self.font?self.font:self.cacutDefaultFont;
    self.ry_placeHolderLabel.textAlignment = self.textAlignment;
    self.ry_placeHolderLabel.text = self.ry_placeHolder;
    [self insertSubview:self.ry_placeHolderLabel atIndex:0];
}
#pragma mark - lazzing
-(UILabel *)ry_placeHolderLabel{
    UILabel *placeHolderLab = objc_getAssociatedObject(self, @selector(ry_placeHolderLabel));
    if (!placeHolderLab) {
        placeHolderLab = [[UILabel alloc] init];
        placeHolderLab.numberOfLines = 0;
        placeHolderLab.textColor = [UIColor lightGrayColor];
        objc_setAssociatedObject(self, @selector(ry_placeHolderLabel), placeHolderLab, OBJC_ASSOCIATION_RETAIN);
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updatePlaceHolder) name:UITextViewTextDidChangeNotification object:self];
    }
    return placeHolderLab;
}
- (UIFont *)cacutDefaultFont{
    static UIFont *font = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        UITextView *textview = [[UITextView alloc] init];
        textview.text = @" ";
        font = textview.font;
    });
    return font;
}
@end
