//
//  RootViewController.m
//  JsonExampleWithNSJSONSerialization
//
//  Created by Tiger on 13-12-23.
//  Copyright (c) 2013年 GhH. All rights reserved.
//

#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    
//    [self genJson];
    [self readJson];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc{

    [super dealloc];
}

#pragma mark -Json生成
/**
 Json生成规则
 1、最上层必须是NSArray 或者 NSDictionary
 2、能够生成的数据类型必须是NSString,NSNumber,NSArray,NSDictionary,NSNull.
 3、json基本格式就是键值对，所有key必须是NSString
 4、NSNumber 不能是 NaN或者无限大
 5、不支持自定义NSObject
 */
-(void)genJson{

    // 原始数据
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"tiger",@"Name",[NSNumber numberWithInt:26],@"Age",[NSArray arrayWithObjects:[NSNumber numberWithInt:38],[NSNumber numberWithInt:28],[NSNumber numberWithInt:38], nil],@"Measurements", nil];
//    NSArray *dic = [NSArray arrayWithObjects:@"1",@"2",@"3", nil];
    NSLog(@"dic : %@",dic);
    
    // 验证是否能生成json
    if ([NSJSONSerialization isValidJSONObject:dic]) {
       
        // 生成NSData
        NSError *error;
        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&error];
        NSLog(@"jsonData : %@",jsonData);
        
        // 生成NSString
        NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        NSLog(@"jsonString : %@",jsonString);
        // 这里有alloc,所以非ARC注意release
        [jsonString release];
        
    }else{
        
        NSLog(@"无法生成JSON");
        
    }
    
}

#pragma mark -Json解析
/**
 解析参数
 1、指定数组和字典创建为可变对象NSMutableArray和NSMutableDictionary。
 2、指定末端的string为可变对象NSMutableString
 3、指定解析器顶层对象可以是非NSArray和NSDictionary的顶层对象，
 */
-(void)readJson{
    
    // Json原始数据
    NSString *jsonString = @"{\"Age\":26,\"Name\":\"tiger\",\"Measurements\":[38,28,38]}";
//    NSString *jsonString = @"[1,2,3]";
    NSLog(@"jsonString : %@",jsonString);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"jsonData : %@",jsonData);
    
    // Json解析
    NSError *error;
    id json = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingAllowFragments error:&error];
    if ([json isKindOfClass:[NSArray class]]) {
        NSLog(@"NSArray : %@",json);
    }else if([json isKindOfClass:[NSDictionary class]]){
        NSLog(@"NSDictionary : %@",json);
    }else{
        NSLog(@"json class : %@",[json class]);
    }
    
}


@end
