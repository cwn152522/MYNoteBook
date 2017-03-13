//
//  MYNotesListTableViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/4.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNotesListViewController.h"
#import "MYImageScanViewController.h"
#import "ViewController.h"
#import "MYNavigationController.h"
#import "MYNavigationBar.h"
#import "MYSignUpTipsViewController.h"
#import "MYNoteDetailWebViewController.h"
#import "MYNotesUtility.h"

@interface MYNotesListViewController ()<UIAlertViewDelegate, MYNavigationControllerCustomBar, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (assign, nonatomic) BOOL isToImageScanVc;

@property (strong, nonatomic) id selectItem;

@end

@implementation MYNotesListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.yxhNavigationBar setMyBackgroundColor:GLOBAL_COLOR];
    [self.navigationController.yxhNavigationBar scrollViewDidScroll:CGPointZero];
    
    [self setTitle:self.navigationTitle];
    [self.navigationItem setHidesBackButton:YES];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"item_back"] style:UIBarButtonItemStyleDone target:self action:@selector(onClickBack)];
    [self.navigationItem setLeftBarButtonItem:button];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[self image:[UIImage imageNamed:@"6401136"] scaleImageToSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)]]];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_isToImageScanVc){
        self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = YES;
        _isToImageScanVc = NO;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
#ifdef DEBUG
    [[BaiduMobStat defaultStat] pageviewStartWithName:self.title];
#endif
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
#ifndef DEBUG
    [[BaiduMobStat defaultStat] pageviewEndWithName:self.title];
#endif
}

- (void)onClickBack{
    CATransition *animation = [CATransition animation];
    animation.type = @"rippleEffect";
    animation.duration = 0.33;
    [self.navigationController.navigationController.view.layer addAnimation:animation forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
    if([_data count] == 0)
        return 0;
    return [_data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    
    NSString *title = [[_data objectAtIndex:indexPath.row] valueForKey:@"Name"];
    
    [cell.textLabel setText:[NSString stringWithFormat:@"%.2ld. %@", (long)indexPath.row + 1, title]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTintColor:[UIColor groupTableViewBackgroundColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if( [self.title rangeOfString:@"(\\d)*年" options:NSRegularExpressionSearch].location != NSNotFound){
        MYNotesListViewController *controller = [[self storyboard] instantiateViewControllerWithIdentifier:@"NotesListViewController"];
        NSArray *data = [[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:[NSString stringWithFormat:@"ParentID=%ld", (long)[[_data[indexPath.row] objectForKey:@"ID"] integerValue]]]];
        controller.data = data;
        controller.navigationTitle = [[_data objectAtIndex:indexPath.row] valueForKey:@"Name"];
        
        CATransition *animation = [CATransition animation];
        animation.type = @"rippleEffect";
        animation.duration = 0.33;
        [self.navigationController.navigationController.view.layer addAnimation:animation forKey:nil];
        [self.navigationController pushViewController:controller animated:NO];
        return;
    }
    
    id item = [_data objectAtIndex:indexPath.row];
        NSString *storyName = [item objectForKey:@"storyboardName"];
        if([storyName length]){
            _selectItem = item;
            [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择笔记查看或者项目演示" delegate:self cancelButtonTitle:@"笔记" otherButtonTitles:@"演示", nil] show];
        }else{
            MYNoteDetailWebViewController *controller = [[MYNoteDetailWebViewController alloc] init];
            controller.filePath = [MYNotesUtility getDocxFileWithDocxName:[NSString stringWithFormat:@"%@.docx", [item objectForKey:@"Name"]]];
            [self.navigationController pushViewController:controller animated:YES];
        }
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

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            MYNoteDetailWebViewController *controller = [[MYNoteDetailWebViewController alloc] init];
            controller.filePath = [MYNotesUtility getDocxFileWithDocxName:[NSString stringWithFormat:@"%@.docx", [_selectItem objectForKey:@"Name"]]];
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        case 1:{
            _isToImageScanVc = YES;
            self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
            
            NSString *storyName = [_selectItem objectForKey:@"storyboardName"];
            NSString *storyboardId = [_selectItem objectForKey:@"storyboardId"];
            UIViewController *controller = [[UIStoryboard storyboardWithName:storyName bundle:nil] instantiateViewControllerWithIdentifier:storyboardId];
            
            if([storyName isEqualToString:@"Tips"]){
                [(MYSignUpTipsViewController *)controller performSelector:@selector(insertIntoParentViewController:) withObject:self.navigationController.navigationController afterDelay:0.44];
            }else if([storyName isEqualToString:@"CustomNav"]){
                [self.navigationController.navigationController presentViewController:controller animated:YES completion:nil];
            }else
            [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark MYNavigationControllerCustomBar

- (Class)myNavigationControllerCustomBar{
    return NSClassFromString(@"MYNavigationBar");
}

#pragma mark UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [self.navigationController.yxhNavigationBar scrollViewDidScroll:scrollView.contentOffset];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
