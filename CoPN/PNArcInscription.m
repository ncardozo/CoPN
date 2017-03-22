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

#import "PNArcInscription.h"


@implementation PNArcInscription

@synthesize flowFunction;
@synthesize iType;

- (id) init {
	if((self = [super init])) {
		iType = NORMAL;
		flowFunction = 1;
	}
	return self;
}

-(id) initWithType: (PNInscriptionType) aType {
    if ((self = [super init])) {
        iType = aType;
        if(aType == INHIBITOR)
            flowFunction = 0;
        else
            flowFunction = 1;
    }
    return self;
}

///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
- (BOOL) isEqual:(id)object {
    if([self flowFunction] != [object flowFunction])
        return NO;
    if ([self iType] != [(PNArcInscription *)object iType])
        return NO;
    return YES;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
     PNArcInscription *newArcInscription = [[PNArcInscription allocWithZone:zone] init];
    NSLog(@"_copy: %@", [newArcInscription self]);
    [newArcInscription setFlowFunction:[self flowFunction]];
    [newArcInscription setType:[self type]];
    return (newArcInscription);
     */
    //return [self retain];
    return self;
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@""];
    if(iType == NORMAL)     
        [desc appendString:@"Nx"];
    else
        [desc appendString:@"Ix"];   
    [desc appendString:[NSString stringWithFormat:@"%d", [self flowFunction]]];
    return desc;
}
@end
