/**
 Context Petri Nets. Full Petri net-based Context-oriented programming language for embedded devices
 Copyright (C) 2017  Nicolás Cardozo
 
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

#import "PNContextPlace.h"


@implementation PNContextPlace

@synthesize contextMethods;
@synthesize activationTimes;

#pragma mark - Instance creation / descrution

- (id) init {
	if((self = [super init])) {
        contextMethods = [NSMutableArray new];
        activationTimes = [NSMutableArray new];
	}
	return self;
}

- (id) initWithName:(NSString *) newName {
	if((self = [super initWithName: newName])) {
        contextMethods = [NSMutableArray new];
        activationTimes = [NSMutableArray new];
	}
	return self;
}


- (id) initWithName:(NSString *) newName andCapacity: (int) newCapacity {
    if(self = [super initWithName: newName andCapacity: newCapacity]) {
        contextMethods = [NSMutableArray new];
        activationTimes = [NSMutableArray new];
    }
	return self;
}

- (PNContextPlace *) copyWithName: (NSString *) nodeName {
	PNContextPlace *newPlace = [[PNContextPlace alloc] init];
	//newPlace = [super copy];
	[newPlace setTokens: [self tokens]];
	[newPlace setLabel: nodeName];
    [newPlace setContextMethods: contextMethods];
    [newPlace setActivationTimes:activationTimes];
	return newPlace;
}

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
-(void) addMethod:(PNContextMethod *)method {
    [contextMethods addObject:method];
}
///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@ContextPlace "];
    [desc appendString:[super description]];
    [desc appendString: @" - lastActiveAt: "];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *numStr = [dateFormatter stringFromDate: [self.activationTimes firstObject]];
    [desc appendString: numStr];
    [desc appendString:@" capacity="];
    if(capacity == -1)
        [desc appendString:@" Unbounded"];
    else
        [desc appendFormat:@" %ld",(long)capacity];
    [desc appendString:@"\nMethod definitions: \n"];
    for (PNContextMethod *method in contextMethods) {
        [desc appendFormat:@"%@ \n", [method description]];
    }
    return desc;
}

- (NSUInteger)hash {
    int prime = 31;
    NSUInteger result = [super hash];
    //    Then for every primitive you do
    result = prime * result + [[self.activationTimes firstObject] hash];
    return result;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
     PNContextPlace *newPlace = [[PNContextPlace allocWithZone:zone] init];
    //   NSLog(@"_copy: %@", [newPlace self]);
    [newPlace setLabel:[self label]];
    [newPlace setTokens: [self tokens]];
    [newPlace setCapacity: [self capacity]];
    [newPlace setLastActivationTime: [self lastActivationTime]];
    return (newPlace);
     */
    return self;
}

@end
