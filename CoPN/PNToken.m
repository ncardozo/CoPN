/**
 Context Petri Nets. Full Petri net-based Context-oriented programming for embedded devices
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

#import "PNToken.h"


@implementation PNToken

@synthesize tValue;
@synthesize color;

- (id) init {
	if((self = [super init])) {
		tValue =[NSNumber numberWithInt:-1 ];
        color = [[NSNumber alloc] initWithInt:1]; //default "black" color
	}
	return self;
}

- (id) initWithValue:(NSNumber *)aValue andColor:(NSNumber *)aColor {
    if((self = [super init])) {
        tValue = aValue;
        color = aColor;
    }
    return self;
}

///------------------------------------------------------------
/// @name Class Methods
///------------------------------------------------------------
- (BOOL) isEqual:(id)object {
    if (![[self color] isEqualToNumber:[(PNToken *)object color]])
        return NO;
    return YES;
}
///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
- (NSUInteger)hash {
    int prime = 31;
    NSUInteger result = 1;
    //    Then for every primitive you do
    //        For 64bit you might also want to shift and xor.
    //   result = prime * result + (int) ([self capacity] ^ ([self capacity] >>> 32));
    //    For objects you use 0 for nil and otherwise their hashcode.
    result = prime * result + [[self tValue] hash];
    result = prime * result + [[self color] hash];
    //    For booleans you use two different values
    //    result = prime * result + (var)?1231:1237;
    return result;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
     PNToken *newToken = [[PNToken allocWithZone:zone] init];
    //   NSLog(@"_copy: %@", [newPlace self]);
    [newToken setValue:[self value]];
    [newToken setColor: [self color]];
    return (newToken);
     */
   // return [self retain];
    return self;
}

/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Token: "];
    [desc appendString:[NSString stringWithFormat:@"color %d #",[[self color] intValue]]];
    [desc appendString: [NSString stringWithFormat:@"%d ", [[self tValue] intValue]]];
    return desc;
}
@end
