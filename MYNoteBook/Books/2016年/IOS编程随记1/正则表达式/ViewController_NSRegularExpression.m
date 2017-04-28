//
//  ViewController_NSRegularExpression.m
//  MYNoteBook
//
//  Created by chenweinan on 16/11/26.
//  Copyright © 2016年 chenweinan. All rights reserved.
//

#import "ViewController_NSRegularExpression.h"

@interface ViewController_NSRegularExpression ()

@property (weak, nonatomic) IBOutlet UILabel *textStr;
@property (weak, nonatomic) IBOutlet UILabel *pattern;

@end

@implementation ViewController_NSRegularExpression

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"NSRegularExpression";
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//纯数字判断(正则表达式与NSPredicate连用)
- (BOOL)validateNumber:(NSString *)textString{
    NSString *number = @"^[0-9]+$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return [predicate evaluateWithObject:textString];
}

//手机号验证(NSString方法)
- (BOOL)validatePhoneNumber:(NSString *)textString{
    NSRange range = [textString rangeOfString:@"^1[3]\\d{9}$" options:NSRegularExpressionSearch];
    if (range.location != NSNotFound) {
        return YES;
    }
    return NO;
}
//获取字符串中的数字(NSString方法)
- (NSString *)getNumbersOfString:(NSString *)textString{
    NSRange range = [textString rangeOfString:@"[0-9]+" options:NSRegularExpressionSearch];
    if(range.location != NSNotFound){
        return [textString substringWithRange:range];
    }
    return nil;
}

//纯数字判断(正则表达式类)
- (BOOL)isValidateNumber:(NSString *)textString{
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d+$" options:NSRegularExpressionCaseInsensitive error:&error];
    NSTextCheckingResult *result = [regex firstMatchInString:textString options:0 range:NSMakeRange(0, [textString length])];
    if(result){
        NSLog(@"%@",[textString substringWithRange:result.range]);
        return YES;
    }
    return NO;
}
//获取字符串的数字匹配所有结果(正则表达式类)
- (NSArray *)filterdigistsWithString:(NSString *)textString{
    NSError *error = NULL;
    NSMutableArray *tempArr = [NSMutableArray array];
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:_pattern.text options:NSRegularExpressionCaseInsensitive error:&error];
    NSLog(@"%@", _pattern.text);
    for(NSTextCheckingResult *result in [regex matchesInString:textString options:0 range:NSMakeRange(0, textString.length)]){
        [tempArr addObject:[textString substringWithRange:result.range]];
    }
    return [NSArray arrayWithArray:tempArr];
}

- (IBAction)onClickMatching:(id)sender {
    NSArray *result = [self filterdigistsWithString:_textStr.text];
    [[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"正则匹配结果：%@", result] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil] show];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
