//
//  MYNotesSearchViewController.m
//  MYNoteBook
//
//  Created by chenweinan on 16/12/4.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "MYNotesSearchViewController.h"
#import "MYNoteDetailWebViewController.h"
#import "MYNotesUtility.h"
#import "MYSignUpTipsViewController.h"
#import "MYSearchBar.h"
#import "MYSearchHisttoryModel.h"
#import "MYLineView.h"
#import "MYNotesSpeechSearchViewController.h"

@interface MYNotesSearchViewController ()<UITableViewDelegate, UITableViewDataSource, UIAlertViewDelegate, UISearchBarDelegate>

@property (strong, nonatomic) MYSearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *footerView;

@property (strong, nonatomic) NSArray *data;

@property (assign, nonatomic) BOOL isToImageScanVc;
@property (strong, nonatomic) id selectItem;

@property (strong, nonatomic) MYSearchHisttoryModel *searchModel;
@property (assign, nonatomic) BOOL isShowHistory;

@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *filterBtn;

@end

@implementation MYNotesSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configNavigationBar];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    [self.tableView setShowsVerticalScrollIndicator:NO];
    
    self.searchModel = [[MYSearchHisttoryModel alloc] init];
    [self.searchModel loadHistoryData];
    // Do any additional setup after loading the view.
    
    id target = self.navigationController.navigationController.interactivePopGestureRecognizer.delegate;
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:target action:@selector(handleNavigationTransition:)];
    [self.view addGestureRecognizer:pan];
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = NO;
    // Do any additional setup after loading the view.
}

- (void)handleNavigationTransition:(UIPanGestureRecognizer *)gesture{};

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if(_isToImageScanVc == YES){
    self.navigationController.navigationController.interactivePopGestureRecognizer.enabled = YES;
        _isToImageScanVc = NO;
    }
    
    if(![_searchBar.text length]){
        _isShowHistory = YES;
        [self onlySeeNone];
        [self.searchModel loadHistoryData];
        [self.tableView reloadData];
    }
}

- (void)configNavigationBar{
    self.navigationItem.leftBarButtonItem = nil;
    UIBarButtonItem *rightBtn = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(onClickCancel)];
    self.navigationItem.rightBarButtonItem = rightBtn;
    rightBtn.tintColor = [UIColor grayColor];
    
    _searchBar = [[MYSearchBar alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH - 20, 38)];
    [_searchBar setSearchBarColor:[UIColor whiteColor]];
    _searchBar.delegate = self;
    [_searchBar.searchTextFiled addTarget:self action:@selector(onTextChanged) forControlEvents:UIControlEventEditingChanged];
    self.navigationItem.titleView = _searchBar;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (void)onClickCancel{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)onClickClearHistory{
    [_searchModel clearHistory];
    [self.tableView reloadData];
}

- (void)searchNotesWithKeyword:(NSString *)keyword onlySee:(NSInteger)type{//1只看ios 2只看php 0看全部
    if(![keyword length])
        return;

    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        
        [[[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"(Name contains[c] %@)", keyword]] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *componets = [obj[@"ParentID"] componentsSeparatedByString:@","];
            if([componets count] == 4){//是具体的文章
                if(type == 0 || (type == 1 && [componets[1] integerValue] == -1) || (type == 2 && [componets[1] integerValue] == -2))
                    [array addObject:obj];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.data = array;
            switch (type) {
                case 0:
                    [weakSelf onlySeeAll];
                    break;
                case 1:
                    [weakSelf onlySeeIOS];
                    break;
                case 2:
                    [weakSelf onlySeePHP];
                    break;
                default:
                    break;
            }
                [weakSelf.tableView reloadData];
        });
    });
}

- (void)searchAllNotesWithOnlySee:(NSInteger)type{//查看所有文章，1只看ios 2只看php 0看全部
    if([_searchBar.text length] > 0)
        return;
    
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableArray *array = [NSMutableArray array];
        
        [[[MYNotesUtility defaultUtility] filterArrayWithPredicate:[NSPredicate predicateWithFormat:@"ID > -100"]] enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            NSArray *componets = [obj[@"ParentID"] componentsSeparatedByString:@","];
            if([[componets lastObject] integerValue] > 0){//是具体的文章
                if(type == 0 || (type == 1 && [componets[1] integerValue] == -1) || (type == 2 && [componets[1] integerValue] == -2))
                    [array addObject:obj];
            }
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.data = array;
            switch (type) {
                case 0:
                    [weakSelf onlySeeAll];
                    break;
                case 1:
                    [weakSelf onlySeeIOS];
                    break;
                case 2:
                    [weakSelf onlySeePHP];
                    break;
                default:
                    break;
            }
            weakSelf.isShowHistory = NO;
            [weakSelf.tableView reloadData];
        });
    });
}

#pragma mark UISearchBarDelegate

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar{
    [self.searchBar endEditing:YES];
#ifndef DEBUG
    [[BaiduMobStat defaultStat] logEvent:@"speech_search_button_click" eventLabel:@"语音搜索按钮"];
#endif
    [self performSegueWithIdentifier:@"speech" sender:nil];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [self searchNotesWithKeyword:searchBar.text onlySee:0];
    [self.searchBar endEditing:YES];
    [_searchModel addHistory:searchBar.text];
}

- (void)onTextChanged{
    if(![_searchBar.text length]){
        _isShowHistory = YES;
        [self.searchModel loadHistoryData];
        [self.tableView reloadData];
        return;
    }
    _isShowHistory = NO;
    [self.tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    if(_isShowHistory){
        return [self.searchModel.data count];
    }
    
    if([_data count] == 0)
        return 0;
    return [_data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"aaa" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setTintColor:[UIColor groupTableViewBackgroundColor]];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    
    NSString *title;
    if(_isShowHistory)
         title = [(SearchHistory *)[_searchModel.data objectAtIndex:indexPath.row] keyword];
        else
    title = [[_data objectAtIndex:indexPath.row] valueForKey:@"Name"];
    [cell.textLabel setText:[NSString stringWithFormat:@"%.2ld. %@", (long)indexPath.row + 1, title]];
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(_isShowHistory){
        if(!_footerView){
            _footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 44)];
            [_footerView setBackgroundColor:[UIColor clearColor]];
            
            UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 44)];
            [button setTitle:@"清除历史纪录" forState:UIControlStateNormal];
            [button setTitle:@"您的搜索纪录将会保存在这里" forState:UIControlStateSelected];
            [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [button.titleLabel setFont:GLOBAL_NORMAL_FONT(15)];
            [button addTarget:self action:@selector(onClickClearHistory) forControlEvents:UIControlEventTouchUpInside];
            [_footerView addSubview:button];
            
            MYLineView *lineView = [[MYLineView alloc] initWithFrame:CGRectMake(0, 0, WINDOW_WIDTH, 1)];
            lineView.backgroundColor = [UIColor clearColor];
            lineView.lineColor = GLOBAL_CELL_LINE_COLOR;
            [_footerView addSubview:lineView];
        }
        UIButton *button = (UIButton *)[_footerView.subviews objectAtIndex:0];
        MYLineView *lineView = (MYLineView *)[_footerView.subviews lastObject];
        if([_searchModel.data count] == 0){
            [button setSelected:YES];
            [button setBackgroundColor:[UIColor clearColor]];
            [lineView setHidden:YES];
        }
        else{
            [button setSelected:NO];
            [button setBackgroundColor:[UIColor whiteColor]];
            [lineView setHidden:NO];
        }
        return _footerView;
    }
    return nil;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.searchBar endEditing:YES];
    [self onClickCellAtIndexPath:indexPath];
}
- (void)onClickCellAtIndexPath:(NSIndexPath *)indexPath{
    if(_isShowHistory){
        _isShowHistory = NO;
        NSString *keywords = [(SearchHistory *)[_searchModel.data  objectAtIndex:indexPath.row] keyword];
        [self.searchBar setText:keywords];
        [self searchNotesWithKeyword:keywords onlySee:0];
        return;
    }
    
    id item = [_data objectAtIndex:indexPath.row];
    NSString *storyName = [item objectForKey:@"storyboardName"];
    if([storyName length]){
        _selectItem = item;
        [[[UIAlertView alloc] initWithTitle:@"提示" message:@"请选择笔记查看或者项目演示" delegate:self cancelButtonTitle:@"笔记" otherButtonTitles:@"演示", nil] show];
    }else{
        MYNoteDetailWebViewController *controller = [[MYNoteDetailWebViewController alloc] init];
        controller.filePath = [MYNotesUtility getFileWithFileName:[NSString stringWithFormat:@"%@.pdf", [item objectForKey:@"Name"]]];
        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if(_isShowHistory)
        return 44;
    return 0;
}

#pragma mark UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:{
            MYNoteDetailWebViewController *controller = [[MYNoteDetailWebViewController alloc] init];
            controller.filePath = [MYNotesUtility getFileWithFileName:[NSString stringWithFormat:@"%@.pdf", [_selectItem objectForKey:@"Name"]]];
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
            }else if([storyName isEqualToString:@"MYNav"]){
                [self.navigationController.navigationController presentViewController:controller animated:YES completion:nil];
            }else
                [self.navigationController pushViewController:controller animated:YES];
        }
            break;
        default:
            break;
    }
}

#pragma mark ScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar endEditing:YES];
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if([segue.identifier isEqualToString:@"speech"]){
        MYNotesSpeechSearchViewController *vc = (MYNotesSpeechSearchViewController *) segue.destinationViewController;
        __weak typeof(self) weakSelf = self;
        [vc setResultBlock:^(BOOL isResult, NSString *keyWords){
            weakSelf.isShowHistory = NO;
            [weakSelf.searchBar setText:keyWords];
            [weakSelf performSelector:@selector(searchBarSearchButtonClicked:) withObject:weakSelf.searchBar afterDelay:0.66];
        }];
    }
}

#pragma mark 其他事件

- (IBAction)onClickFilterBtn:(UIButton *)sender {
    if([_searchBar.text length] > 0)
        [self searchNotesWithKeyword:_searchBar.text onlySee:sender.tag];
    else
        [self searchAllNotesWithOnlySee:sender.tag];
}

- (void)onlySeeIOS{
    [self.filterBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:obj.tag == 1 ? YES : NO];
    }];
}

- (void)onlySeePHP{
    [self.filterBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:obj.tag == 2 ? YES : NO];
    }];
}

- (void)onlySeeAll{
    [self.filterBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:obj.tag == 0 ? YES : NO];
    }];
}

- (void)onlySeeNone{
    [self.filterBtn enumerateObjectsUsingBlock:^(UIButton *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:0];
    }];
}


@end
