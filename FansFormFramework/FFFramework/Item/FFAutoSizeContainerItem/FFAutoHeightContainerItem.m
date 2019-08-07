//
//  FFAHContainerItem.m
//  FansFormFramework
//
//  Created by 谢帆 on 2019/8/2.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FFAutoHeightContainerItem.h"
#import "FFTool.h"
@implementation FFAutoHeightContainerItem

- (instancetype)initWithManager:(__kindof FFViewManager *)manager {
    if (self = [super initWithManager:manager]) {
        self.size = CGSizeMake(0.f, 0.f);
    }
    return self;
}

- (void)layoutSubviews {
    [self mathHeight];
}

- (CGFloat)mathHeight {
    
    __weak typeof(self)weakSelf = self;
    __block FFView *lastView = nil;
    __block CGFloat userHeight = self.paddingInsets.top; //已经使用的高度， 只在横向布局时使用到了
    __block CGFloat useWidth = self.paddingInsets.left;
    [self.subviews enumerateObjectsUsingBlock:^(__kindof FFView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [obj.manager setRefreshBlock:^(FFViewManager *manager) {
            __strong typeof(weakSelf)self = weakSelf;
            [self setNeedsLayout];
            [self layoutIfNeeded];
        }];
        
        CGFloat x = 0.f;
        CGFloat y = 0.f;
        CGFloat width = 0.f;
        
        switch (self.layoutDirection) {
            case FFContainerViewLayoutDirectionVertical:
                x = self.paddingInsets.left + obj.marginInsets.left;
                y = (lastView ? 0.f : self.paddingInsets.top) + lastView.fans_bottom + obj.marginInsets.top + lastView.marginInsets.bottom;
                width = (
                         obj.size.width > 0.f ?
                         obj.size.width :
                         self.fans_width
                         ) - obj.marginInsets.left - obj.marginInsets.right - self.paddingInsets.right;
                break;
            case FFContainerViewLayoutDirectionHorizontal:{
                // 判断宽度是否还可以放得下当前的视图
                useWidth = lastView ? (lastView.fans_right + lastView.marginInsets.right) : self.paddingInsets.left; /**< 目前已使用的宽度 */
                CGFloat remainingWidth = self.fans_width - useWidth - obj.marginInsets.left - obj.marginInsets.right - self.paddingInsets.right;
                
                width = obj.size.width - obj.marginInsets.left - obj.marginInsets.right;
                if (remainingWidth >= obj.size.width && lastView) {
                    //可以放得下
                    x = useWidth + obj.marginInsets.left;
                    y = lastView.fans_y - lastView.marginInsets.top + obj.marginInsets.top;
                } else {
                    //放不下
                    x = self.paddingInsets.left + obj.marginInsets.left;
                    y = userHeight + obj.marginInsets.top;
                    useWidth = self.paddingInsets.left;
                    //这里是折行了, 证明之前一个view 是 那一行最后一个视图。 需要接受边距控制
                    if (lastView) {
                        lastView.fans_width = MAX(0.f, lastView.fans_width - self.paddingInsets.right);
                    }
                }
            }
                break;
        }
        
        
        CGFloat height = MAX(obj.size.height, 0.f);
        
        obj.frame = CGRectMake(x, y, MAX(width, 0.f), MAX(height, 0.f));
        
        if (obj.manager.isShow) {
            lastView = obj;
            if (userHeight < obj.fans_bottom + obj.marginInsets.bottom) {
                userHeight = obj.fans_bottom + obj.marginInsets.bottom;
            }
        }
    }];
    
    return userHeight + self.paddingInsets.bottom;
}

- (void)ff_addSubview:(__kindof FFView *)view {
    [self addSubview:view];
    [super ff_addSubview:view];
    [self ff_refreshSize];
}

- (void)ff_removeSubviewForKey:(NSString *)key {
    [super ff_removeSubviewForKey:key];
    [self ff_refreshSize];
}

- (void)ff_refreshSize {
    self.size = CGSizeMake(self.size.width, [self mathHeight]);
    self.fans_height = self.size.height;
    [self.manager excuteRefreshBlock];
}

@end
