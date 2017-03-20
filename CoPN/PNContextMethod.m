//
//  PNContextMethod.m
//  CoPN
//
//  Created by NicolasCardozo on 3/20/17.
//  Copyright © 2017 NicolasCardozo. All rights reserved.
//

#import "PNContextMethod.h"

@implementation PNContextMethod

@synthesize method_types;
@synthesize name;
@synthesize implementation;

- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString: @"Method nane: "];
    [desc appendString: NSStringFromSelector(name)];
    [desc appendString: @" Type: "];
    [desc appendString:[NSString stringWithCString:method_types encoding:(NSUTF8StringEncoding)]];
    
    return desc;
}



@end
