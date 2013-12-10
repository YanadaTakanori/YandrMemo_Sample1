//
//  Test_TVC.m
//  TestProject
//
//  Created by yanada takanori on 13/06/25.
//  Copyright (c) 2013年 yandr225. All rights reserved.
//

#import "Test_TVC.h"

@interface Test_TVC ()

@end

@implementation Test_TVC

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

// 初期読込
- (void)viewDidLoad
{
    [super viewDidLoad];

    //ユーザ名格納配列　初期化
    userArr = [[NSMutableArray alloc] init];
    
    //配列番号
    xml_index = 0;
    
    
    //PHPファイルのURLを設定
    NSString *url = @"http://www.randy-boy.com/sample/test_xml_create.php";
    
    //URLを指定してXMLパーサーを作成
    NSURL *myURL = [NSURL URLWithString:url];
    NSXMLParser *myParser = [[NSXMLParser alloc] initWithContentsOfURL:myURL];
    myParser.delegate = self;
    
    //xml解析開始
    [myParser parse];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

// XMLの解析
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    //解析中タグの初期化
    nowTagStr = @"";
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
    
    //開始タグが user の場合
    if ([elementName isEqualToString:@"user"]) {
        //解析中タグに設定
        nowTagStr = [NSString stringWithString:elementName];
        
        //テキストバッファの初期化
        txtBuffer = @"";
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    //解析中のタグが user の場合
    if ([nowTagStr isEqualToString:@"user"]){
        //テキストバッファに文字を追加する
        txtBuffer = [txtBuffer stringByAppendingString:string];
    }
}

- (void)parser:(NSXMLParser *) parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    //終了タグが user の場合
    if ([elementName isEqualToString:@"user"]) {
        NSString *xml_name =txtBuffer;
        
        //userArrにユーザ名を格納
        [userArr insertObject:xml_name atIndex:xml_index];
        
        xml_index++;
    }
}




// Tableviewの設定
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //section数
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //cell数
    return [userArr count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //indexPathよりrowを取得し、rowをもとにuserArr配列から街頭するユーザ名を取得
    cell.textLabel.text = [userArr objectAtIndex:indexPath.row];
    
    
    return cell;
}




@end
