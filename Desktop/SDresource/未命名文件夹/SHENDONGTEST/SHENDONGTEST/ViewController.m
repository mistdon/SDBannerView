//
//  ViewController.m
//  SHENDONGTEST
//
//  Created by shendong on 16/4/29.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 筐中有很多小球，共有m种颜色的小球，从中取n个球出来，编写函数，请输出排列总数以及所有可能的颜色排列 (m<=n )
    //例: 假设筐中有0,1两种颜色， 取3个球出来，则可能排列为000/001/010/011/100/101/110/111
    // Do any additional setup after loading the view, typically from a nib.
    
//    [self makeListOfBubbles:5 color:6];
    
//    NSArray *source = @[@12,@3,@23,@34,@35,@99,@98,@43];
//    NSLog(@"source = %@",source);
//    NSArray *result =  [self binarySort:source];
//    NSLog(@"result = %@",result);
    NSMutableArray *result = [NSMutableArray array];//结果
    NSMutableArray *list = [NSMutableArray array];//每次递归的子集
    int pos = 0;//保证子集升序排列
    [self subsetsHelper:result list:list nums:@[@1,@2,@3] postion:pos];
    
//    [self makeListOfAllBalls:3 withColor:2];
    
//    NSLog(@"num = %ld",[self multiPlus:5 temp:2]);
//    NSLog(@"result = %d",[self sum:5]);
//    NSLog(@"result = %lu",(unsigned long)[self sortlist:5 count:3]);
}
- (int)sum:(int)num{
    if (num == 0) {
        return num;
    }
    return num + [self sum:num - 1];
}

//num 乘数， count 次数
- (NSUInteger)sortlist:(NSUInteger)num count:(NSUInteger)count{
    if (count == 1) {
        return num;
    }
    return num * [self sortlist:num count:count - 1];
}
- (void)makeListOfAllBalls:(NSUInteger )ball withColor:(NSUInteger)color{
//    NSLog(@"count = %lu",(unsigned long)[self sortlist:color count:ball]);
    if (ball < color) {
        [NSException raise:@"Range" format:@"color cannot above the count of balls"];
        return;
    }
    //设置颜色集合
    NSMutableArray *colorArray = [NSMutableArray array];
    for (NSUInteger index = 0; index < color; index++) {
        [colorArray addObject:[NSNumber numberWithLongLong:index]];
    }
    NSLog(@"colorarray = %@",colorArray);
    
    for (NSInteger i; i < ball; i++) {
        
    }
    
    
}
- (NSArray *)binarySort:(NSArray *)array {
    NSMutableArray *result = [array mutableCopy];
    for (NSInteger index = 0; index < result.count; index++) {
        NSInteger start, end, middle;
        start  = 0;
        end    = index - 1;
        middle = 0;
        NSInteger temp = [result[index] integerValue];
        while (start <= end) {
            middle = (start + end) / 2;
            if ([array[middle] integerValue] >  temp) {
                end = middle - 1;
            }else{
                start = middle + 1;
            }
        }
        for (NSInteger j = index - 1; j > end; j--) {
            result[j+1] = result[j];
        }
        [result replaceObjectAtIndex:end+1 withObject:[NSNumber numberWithInteger:temp]];
    }
    return [result copy];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)subsetsHelper:(NSMutableArray<NSMutableArray *> *)result
                 list:(NSMutableArray *)list
                 nums:(NSArray *)nums
              postion:(int)pos {
    [result addObject:[list mutableCopy]];
    for (int i = pos; i < nums.count; i++) {
        [list addObject:nums[i]];
        [self subsetsHelper:result list:list nums:nums postion:i + 1];
//        [list removeObjectAtIndex:list.count - 1];
    }
    NSLog(@"result = %@",result);
}
@end
