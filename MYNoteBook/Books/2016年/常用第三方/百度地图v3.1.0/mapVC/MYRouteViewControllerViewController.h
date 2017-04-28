//
//  MYRouteViewControllerViewController.h
//  MayiW
//
//  Created by 陈伟南 on 16/9/17.
//  Copyright © 2016年 Jam. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "MYBaseViewController.h"

@interface MYRouteViewControllerViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *busButton;
@property (weak, nonatomic) IBOutlet UIButton *taxiButton;
@property (weak, nonatomic) IBOutlet UIButton *walkButton;

@property (weak, nonatomic) IBOutlet UIView *busLineView;
@property (weak, nonatomic) IBOutlet UIView *taxiLineView;
@property (weak, nonatomic) IBOutlet UIView *walkLineView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIButton *formButton;
@property (weak, nonatomic) IBOutlet UIButton *toButton;

@end
