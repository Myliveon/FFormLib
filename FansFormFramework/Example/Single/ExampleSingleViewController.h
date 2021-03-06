//
//  ExampleViewController.h
//  FansFormFramework
//
//  Created by fans on 2019/9/4.
//  Copyright © 2019 glority-fans. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SingleModel.h"
#import "FFCore.h"
#import <Masonry.h>

@interface ExampleSingleViewController : UIViewController

@property (nonatomic, strong) FFScrollContainerItem *scrollItem;
@property (nonatomic, strong) __kindof FFView *showItem;

@property (nonatomic, assign) SingleModelType type;

@property (nonatomic, strong, readonly) UILabel *tipLb;

@property (nonatomic, strong, readonly) UIView *topView;
@property (nonatomic, strong, readonly) UIView *contentView;
@property (nonatomic, strong, readonly) UIView *bottomView;

@property (nonatomic, strong) UIButton *showBtn;
@property (nonatomic, strong) UIButton *editBtn;
@property (nonatomic, strong) UIButton *mustBtn;
@property (nonatomic, strong) UIButton *checkBtn;

- (void)eventOfShowClick;
- (void)eventOfEditClick;
- (void)eventOfMustClick;
- (void)eventOfCheckClick;
- (FFView *)getSingleItem;
- (void)showJson:(NSString *)json;

- (void)showTip:(NSString *)tip;

@end
