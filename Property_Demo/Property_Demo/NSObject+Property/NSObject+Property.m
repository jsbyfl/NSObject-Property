//
//  NSObject+Property.m
//  Property_Demo
//
//  Created by Paddy-long on 16/3/25.
//  Copyright © 2016年 Paddy-long. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>

@implementation NSObject (Property)

/**
 *  获取对象的所有属性和属性值
 *  @return 对象的属性和属性值组成的字典
 */
- (NSDictionary *)getAllPropertiesAndVaules
{
    NSMutableDictionary *props = [NSMutableDictionary dictionary];
    unsigned int count = 0;
    objc_property_t *properties =class_copyPropertyList([self class], &count);
    
    for (int i = 0; i < count; i++)
    {
        objc_property_t property = properties[i];
        const char* char_f =property_getName(property);
        NSString *propertyName = [NSString stringWithUTF8String:char_f];
        id propertyValue = [self valueForKey:(NSString *)propertyName];
        if (propertyValue) [props setObject:propertyValue forKey:propertyName];
    }
    
    free(properties);
    return [props copy];
}

/**
 *  获取类的所有属性
 *  @return 类的所有属性列表
 */
+ (NSArray *)getAllProperties
{
    unsigned int count = 0;
    objc_property_t *properties  =class_copyPropertyList([self class], &count);
    NSMutableArray *propertiesArray = [NSMutableArray arrayWithCapacity:count];
    
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName =property_getName(properties[i]);
        [propertiesArray addObject: [NSString stringWithUTF8String: propertyName]];
    }
    
    free(properties);
    return [propertiesArray copy];
}

/**
 *  打印类的所有的实例方法
 */
+ (void)allMethods
{
    unsigned int mothedCount_f = 0;
    Method *mothList_f = class_copyMethodList([self class],&mothedCount_f);
    
    for(int i = 0;i < mothedCount_f;i++)
    {
        Method method_f = mothList_f[i];
        SEL name_f = method_getName(method_f); //方法名称
        
        const char *name_s = sel_getName(name_f);
        int arguments = method_getNumberOfArguments(method_f);
        const char *encoding = method_getTypeEncoding(method_f);
        
        NSLog(@"[方法名：%@],[参数个数：%d],[编码方式：%@]",[NSString stringWithUTF8String:name_s], arguments,[NSString stringWithUTF8String:encoding]);
    }
    free(mothList_f);
}

/**
 *  打印类的成员变量和类型
 */
+ (void)allMemberVarAndTypes
{
    unsigned int count = 0;
    Ivar *mVarList = class_copyIvarList([self class], &count);
    
    for (int i = 0; i < count; i++) {
        Ivar _mIva = mVarList[i];
        
        const char *name_s = ivar_getName(_mIva);
        const char *type = ivar_getTypeEncoding(_mIva);
        
        NSLog(@"[%s] = [%s]\n",name_s,type);
    }
}


/**
 *  对model赋值，属性中 可能含有自定义model
 *
 *  @return 新的model
 */
-(id)createModelWithinMd
{
    //1、获取 源对象的 属性和属性内容
    NSDictionary *sourceDic = [self getAllPropertiesAndVaules];
    
    //2、获取 源对象的 类型
    Class class = [self class];
    
    //3、创建目标对象
    id targtObj = [[class alloc] init];
    
    //4、为目标对象赋值
    [sourceDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        Class _MdClass = [obj class];
        NSString *_className = NSStringFromClass(_MdClass);
        if (![_className hasPrefix:@"__"]) {
            id _MdValue = [obj createModelWithinMd];
            [targtObj setValue:_MdValue forKey:key];
        }else{
            [targtObj setValue:obj forKey:key];
        }
    }];
    
    return targtObj;
}

/**
 *  对model赋值，属性中没有自定义model
 *  @return 新的model
 */
-(id)createModel
{
    //1、获取 源对象的 属性和属性内容
    NSDictionary *sourceDic = [self getAllPropertiesAndVaules];
    
    //2、获取 源对象的 类型
    Class class = [self class];
    
    //3、创建目标对象
    id targtObj = [[class alloc] init];
    
    //4、为目标对象赋值
    [sourceDic enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        [targtObj setValue:obj forKey:key];
    }];
    
    return targtObj;
}

@end
