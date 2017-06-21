//
//  ViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/3.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

/**
 *  陈伟南 17/04/28    更新内容：所有文档采用pdf格式替换word格式
 *
 * @note 文档使用pdf格式代替word格式，因为webview显示word存在排版、字体错乱，文件较大等问题。
 */

#import "ViewController.h"
#import "MYNotesListViewController.h"
#import "MYNotesUtility.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *data;
@property (strong, nonatomic) NSIndexPath *selectIndexPath;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configNavigationBar];
//    NSArray *temp = [[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"Name CONTAINS '绘制'"]];

    self.data = [[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"ParentID ENDSWITH[cd] '-100'"]];
    [self.tableView reloadData];

    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[self image:[UIImage imageNamed:@"6401136"] scaleImageToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)configNavigationBar{
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(toSearch:)];
    self.navigationItem.rightBarButtonItem = rightBtn;
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)toSearch:(UIBarButtonItem *)sender {
#ifndef DEBUG
    [[BaiduMobStat defaultStat] logEvent:@"search_button_click" eventLabel:@"搜索按钮"];
#endif
    [self performSegueWithIdentifier:@"toSearch" sender:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if(![segue.identifier isEqualToString:@"notesList"])
        return;
    MYNotesListViewController *controller = (MYNotesListViewController *)segue.destinationViewController;
    NSArray *data = [[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ParentID ENDSWITH[cd] '%ld'", (long)[[_data[_selectIndexPath.row] objectForKey:@"ID"] integerValue]]]];
    controller.data = data;
    controller.navigationTitle = [[_data objectAtIndex:_selectIndexPath.row] valueForKey:@"Name"];
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if([_data count] == 0)
        return 0;
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"aaa"];
    }
    
    NSString *title = [[_data objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%.2ld. %@", (long)indexPath.row + 1, title]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTintColor:[UIColor groupTableViewBackgroundColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    _selectIndexPath = indexPath;
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.duration = 0.33;
    [self.navigationController.navigationController.view.layer addAnimation:animation forKey:nil];
    [self performSegueWithIdentifier:@"notesList" sender:nil];
}

#pragma mark private method

- (UIImage *)image:(UIImage *)image scaleImageToSize:(CGSize)size{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, 0, size.height);
    CGContextScaleCTM(context, 1, -1);
    CGContextDrawImage(context, rect, image.CGImage);
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
