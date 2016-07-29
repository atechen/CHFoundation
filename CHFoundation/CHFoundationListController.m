//
//  CHFoundationListController.m
//  CHFoundation
//
//  Created by 陈 斐 on 16/3/31.
//  Copyright © 2016年 atechen. All rights reserved.
//

#import "CHFoundationListController.h"

@interface CHFoundationListController ()
{
    NSArray *_sectionArr;
}
@end

@implementation CHFoundationListController

static NSString *rootTableViewCellID = @"rootTableViewCellID";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    _sectionArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"FoundationList" ofType:@"plist"]] ;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:rootTableViewCellID];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _sectionArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSDictionary *sectionDic = _sectionArr[section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    return sectionArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:rootTableViewCellID];
    NSDictionary *sectionDic = _sectionArr[indexPath.section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    cell.textLabel.text = sectionArr[indexPath.row][@"title"];
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSDictionary *sectionDic = _sectionArr[section];
    return sectionDic[@"sectionName"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *sectionDic = _sectionArr[indexPath.section];
    NSArray *sectionArr = sectionDic[@"sectionArr"];
    NSString *className = sectionArr[indexPath.row][@"class"];
    int flag = [sectionArr[indexPath.row][@"flag"] intValue];
    Class detailClass = NSClassFromString(className);
    
    UIViewController *controller;
    switch (flag) {
        case 0:
        {
            controller = [[detailClass alloc] init];
            break;
        }
        default:
            break;
    }
    [self.navigationController pushViewController:controller animated:YES];
}

@end
