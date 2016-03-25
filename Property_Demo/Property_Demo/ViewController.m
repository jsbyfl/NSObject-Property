//
//  ViewController.m
//  Property_Demo
//
//  Created by Paddy-long on 16/3/25.
//  Copyright © 2016年 Paddy-long. All rights reserved.
//

#import "ViewController.h"
#import "NSObject+Property.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSDictionary *propertiesDic = [self getAllPropertiesAndVaules];
    
    NSArray *propertiesList = [[self class] getAllProperties];
    
    [[self class] allMethods];
    [[self class] allMemberVarAndTypes];
}


- (void)test
{
    
}

@end
