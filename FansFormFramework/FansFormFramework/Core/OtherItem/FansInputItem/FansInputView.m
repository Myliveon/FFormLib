//
//  FansInputView.m
//  FansFormFramework
//
//  Created by fans on 2019/7/22.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import "FansInputView.h"
#import "FansFormTool.h"
#import "FansFormItemConstant.h"
@implementation FansInputView

@synthesize titleLb = _titleLb;
@synthesize textField = _textField;
@synthesize lineView = _lineView;

#pragma mark - Overrides
- (instancetype)init {
    self = [super init];
    if (self) {
        [self addSubview:self.titleLb];
        [self addSubview:self.textField];
        [self addSubview:self.lineView];
        
        _show = YES;
        self.frame = CGRectMake(0, 0, FansFormItemNormalWidth, FansFormItemNormalHeight);
    }
    return self;
}

- (void)layoutSubviews {
    CGFloat gap = 3.f;
    CGFloat height = self.fans_height - gap * 2;
    self.titleLb.frame = CGRectMake(
                                    FansFormItemHorizontalNormalGap,
                                    gap,
                                    FansFormItemTitleNormalWidth,
                                    height
                                    );
    self.textField.frame = CGRectMake(
                                     self.titleLb.fans_right + FansFormItemHorizontalNormalGap,
                                     gap,
                                     self.fans_width - (self.titleLb.fans_right + FansFormItemHorizontalNormalGap),
                                     MAX(height, 0.f)
                                     );
    CGFloat lineWidth = 0.5f;
    self.lineView.frame = CGRectMake(
                                     0.f,
                                     self.fans_height - lineWidth,
                                     self.fans_width,
                                     lineWidth
                                     );
}

#pragma mark - Setter Getter
- (void)setShow:(BOOL)show {
    _show = show;
    
    self.hidden = !show;
}


#pragma mark - Lazy Load
- (UILabel *)titleLb {
    if (!_titleLb) {
        _titleLb = [[UILabel alloc] init];
        _titleLb.textColor = [UIColor fans_colorWithHexValue:FansFormItemTitleNoramlColor];
        _titleLb.font = [UIFont systemFontOfSize:15];
    }
    return _titleLb;
}

- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        
        _textField.font = [UIFont systemFontOfSize:15];
        _textField.textColor = [UIColor fans_colorWithHexValue:FansFormItemValueNoramlColor];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }
    return _textField;
}

- (UIView *)lineView {
    if (!_lineView) {
        _lineView = [UIView new];
        _lineView.backgroundColor = [UIColor fans_colorWithHexValue:FansFormItemLineNoramlColor];
    }
    return _lineView;
}

@end
