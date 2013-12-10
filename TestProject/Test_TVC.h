//
//  Test_TVC.h
//  TestProject
//
//  Created by yanada takanori on 13/06/25.
//  Copyright (c) 2013年 yandr225. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Test_TVC : UITableViewController<NSXMLParserDelegate> {
    //xml解析で使用
    NSString *nowTagStr;
    NSString *txtBuffer;
    
    //ユーザ名を格納する配列  
    NSMutableArray *userArr;
    
    //xmlの数を入れる数値
    NSInteger xml_index;
    
    
    //通信コネクト
    NSURLConnection *conect;
    
    //受信データ
    NSMutableData *data;
    
    //LoadingView(通信中にぐるぐる回るやつ)
    UIView *uv_load;
    
}

@end
