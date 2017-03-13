<?php

//1.数据库连接及数据库字符编码设置
$conn = new mysqli('localhost','root','root','rongCloudDemo');
if(mysqli_connect_error()){
	die('unable to connect the database').mysqli_connect_error();
	}
	$conn ->set_charset("utf8");

//2.请求参数获取
$userInfoId = $_POST["userInfoId"];
if(is_null($userInfoId)){
	$userInfoId = $_GET["userInfoId"];
}

//3.数据库sql查询
// (1)查一条数据
$result = $conn->query("select * from userInfo_tb where userInfoId = '$userInfoId'");
$row = $result -> fetch_array();
$showDictionary = [
	"name" => $row["name"],
	"headerImage" => $row["headerImage"],
	"token" => $row["token"]
];
/*
// (2)查多条数据
$result=$conn->query("select * from friendShip_tb where userInfoId = '$userInfoId' ");
$showArray = array();
 $i = 0;
 while($row = $result->fetch_array())
 {
 	$showArray[$i]["toId"]=$row["toId"];
	$toUserId = $showArray[$i]["toId"];
	$result1 = $conn->query("select * from userInfo_tb where userInfoId='$toUserId'");
	$row = $result1->fetch_array();
	$showArray[$i]["toName"] = $row["name"];
	$showArray[$i]["toHeaderImage"]=$row["headerImage"];
 	$i++;
 }
// (3)修改一条数据
$result = $conn->query("UPDATE userInfo_tb SET token='$token' where userInfoId = '$userInfoId'"); 
// (4)删除一条数据
$conn->query("DELETE FROM RadioArticle_tb where radioArticleId='$radioArticleId'");
// (5)添加一条数据
$conn ->query("insert into radioCollectState_tb(phoneNumber,radioArticleId)values('$phoneNumber','$radioArticleId')");
*/

//4.返回json数据
$jsonDic = [
	'error_code' => 200,
	'result' => $showDictionary,
	'reason' => "success",
	];
echo json_encode($jsonDic);

//5.断开连接
mysqli_close($conn);


/*＊＊＊＊＊＊＊＊常见问题及解决＊＊＊＊＊＊＊＊＊＊
// (1)怎么获取当前时间？
date_default_timezone_set('prc');
$time = date('y-m-d H:i:s',time());
// (2)怎么获取表数据总数？
$result = $conn->query("SELECT * FROM  read_tb  order by time desc");
$total=mysqli_num_rows($result);
// (3)怎么去除html标签？
$easy = strip_tags($row["article"]);
$easy = str_replace(array("\r","&nbsp;","&nbs","\n"),"",$easy);
// (4)怎么截取长篇幅字符串，前面70个字符？
$showArray[$i]["easyArticle"] = mb_substr($easy, 0, 70, 'utf-8');
// (5)前端发的请求接收到的特殊字符或中文乱码？
- (NSString*) mk_urlEncodedString:(NSString *)string { // mk_ prefix prevents a clash with a private api
    CFStringRef encodedCFString = CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                          (__bridge CFStringRef) string,
                                                                          nil,
                                                                          CFSTR("?!@#$^&%*+,:;='\"`<>()[]{}/\\| "),
                                                                          kCFStringEncodingUTF8);
    NSString *encodedString = [[NSString alloc] initWithString:(__bridge_transfer NSString*) encodedCFString];
    if(!encodedString)
        encodedString = @"";
    return encodedString;
}
- (NSString *)getParamsFromDictionary:(NSDictionary *)dic{//对请求参数进行编码
    NSMutableString *str = [NSMutableString stringWithString:@""];
    for(NSString *param in [dic allKeys]){
        NSObject *value = [dic objectForKey:param];
        if([value isKindOfClass:[NSString class]]){
        [str appendString:[NSString stringWithFormat:@"%@=%@&", [self mk_urlEncodedString:param], [self mk_urlEncodedString:(NSString *)value]]];
        }else{
            [str appendFormat:@"%@=%@&", [self mk_urlEncodedString: param], value];
        }
    }
    if([str length] > 0)
        [str deleteCharactersInRange:NSMakeRange([str length] - 1, 1)];
    return str;
}
*/
?>
