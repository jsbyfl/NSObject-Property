//
//  NSObject+Property.h
//  Property_Demo
//
//  Created by Paddy-long on 16/3/25.
//  Copyright © 2016年 Paddy-long. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Property)

/**
 *  获取对象的所有属性和属性值(不包含父类)
 *  @return 对象的属性和属性值组成的字典
 */
- (NSDictionary *)getAllPropertiesAndVaules;

/**
 *  获取类的所有属性(不包含父类)
 *  @return 类的所有属性列表
 */
+ (NSArray *)getAllProperties;

/**
 *  打印类的所有的实例方法
 */
+ (void)allMethods;

/**
 *  打印类的成员变量和类型
 */
+ (void)allMemberVarAndTypes;


/**
 *  对model赋值，属性中 可能含有自定义model
 *
 *  @return 新的model
 */
-(id)createModelWithinMd;

/**
 *  对model赋值，属性中没有自定义model
 *  @return 新的model
 */
-(id)createModel;

@end
