//
//  PNContextMethod.h
//  CoPN
//
//  Created by NicolasCardozo on 3/20/17.
//  Copyright © 2017 NicolasCardozo. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PNContextMethod : NSObject {
    IMP implemetation;
    SEL name;
    char *method_types;
}

@property(nonatomic, readwrite) IMP implementation;
@property(nonatomic, readwrite) SEL name;
@property(nonatomic, readwrite) char *method_types;

- (NSString *) description;
@end
