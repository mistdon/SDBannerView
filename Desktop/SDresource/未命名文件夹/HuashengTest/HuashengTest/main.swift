//
//  main.swift
//  HuashengTest
//
//  Created by shendong on 16/4/29.
//  Copyright © 2016年 com.sybercare.enterprise. All rights reserved.
//

import Foundation

print("Hello, World!")
// 筐中有很多小球，共有m种颜色的小球，从中取n个球出来，编写函数，请输出排列总数以及所有可能的颜色排列 (m<=n )
//例: 假设筐中有0,1两种颜色， 取3个球出来，则可能排列为000/001/010/011/100/101/110/111




//***********************二分法排序**************************
//1. 源数据
let sources = [12,3,23,34,35,99,98,43]
//2. 二分法排序算法
func binarySort(array: [Int]) -> [Int]{
    var source = array
    for index in 0..<source.count{
        var start  = 0
        var end    = index - 1
        var middle = 0
        let temp   = source[index]
        while(start <= end){
            middle = (start + end) / 2
            if(array[middle] > temp){ //待排序元素在需排序数组的左边
                end = middle - 1
            }else{
                start = middle + 1
            }
        }
        for tempIndex in (end+1)..<index{ //找到了待插入的位置,然后将这个位置以后的所有元素相后移动
            source[tempIndex+1] = source[tempIndex]
        }
        source[end+1] = temp
    }
    return source
}
//3.输出实现
print(binarySort(sources))






