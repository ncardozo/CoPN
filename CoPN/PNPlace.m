/**
 Petri Net Kernel. Context-oriented programming for mobile devices
 Copyright (C) 2012  Nicolás Cardozo
 
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

#import "PNPlace.h"
#import "SCContextManager.h"
#import "PNToken.h"


@implementation PNPlace

@synthesize tokens;
@synthesize capacity;
@synthesize inhibiting;

#pragma mark - Instance creation / descrution

- (id) init {
	if((self = [super init])) {
		tokens = [[NSMutableArray alloc] init];
        capacity = -1;
        inhibiting = NO;
	}
	return self;
}

- (id) initWithName:(NSString *) newName {
	if((self = [super initWithName: newName])) {
		tokens = [[NSMutableArray alloc] init];
		capacity = -1; //default value for infinite capacity
        inhibiting = NO;        
	}
	return self;
}

- (id) initWithName:(NSString *) newName andCapacity: (int) newCapacity{
	if((self = [super initWithName: newName])) {
		capacity = newCapacity;
        tokens = [[NSMutableArray alloc] init];
        inhibiting = NO;
	}
	return self;
}

- (PNPlace *) copyWithName: (NSString *) nodeName {
	PNPlace *newPlace = [[PNPlace alloc] init];
	[newPlace setTokens: [self tokens]];
	[newPlace setLabel: nodeName];
	return newPlace;
}

- (void)dealloc { 
	[tokens release];
    [super dealloc]; 
}

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
- (BOOL) isActive {
	return [tokens count] > 0;
}

- (BOOL) isActiveForThread:(NSNumber *)color {
    for(PNToken *t in tokens) {
        if([[t color] isEqualToNumber:color])
            return YES;
    }
    return NO;
}

- (BOOL) containsToken:(PNToken *)token {
	NSArray *searchTokens = [NSArray arrayWithObject:token];
	return [self containsTokens: searchTokens];
}

- (BOOL) containsTokens:(NSArray *) searchTokens {
	for(PNToken *t in searchTokens) {
		if (![tokens containsObject:t]) {
			return NO;
		}
	}
	return YES;
}

- (void) addToken:(PNToken *)token {
    [token retain];
    BOOL alreadyColor = NO;
    for (PNToken *tok in tokens) {
        if ([[tok color] isEqualToNumber:[token color]]) {
            [tok setTValue:[NSNumber numberWithInt:[[tok tValue] intValue] + [[token tValue] intValue]]];
            alreadyColor = YES;
            break;
        }
    }
    if(!alreadyColor) {
        NSArray *addTokens = [NSArray arrayWithObject:token];
        [self addTokens:addTokens];
    }
    [token release];
}

- (void) addTokens:(NSArray *)newTokens {
	[tokens addObjectsFromArray:newTokens];
}

- (void) removeToken:(PNToken *)token {
	NSArray *removeTokens = [NSArray arrayWithObject:token];
	[self removeTokens:removeTokens];
}

- (void) removeTokens:(NSArray *)tokenSet {
	[tokens removeObjectsInArray:tokenSet];
}

- (PNToken *) getTokenOfColor:(NSNumber *)color {
    PNToken *tok = nil;
    for(PNToken *t in tokens)
        if([[t color] isEqualToNumber: color]) {
            tok = t;
            break;
        }
    return tok;
}

-(PNPlace *) getPrepareForActivation {
    for (PNPlace *c in [[SCContextManager sharedContextManager] temporaryPlaces]) {
        if ([[c label] hasPrefix:@"PR("] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}

-(PNPlace *) getPrepareForDeactivation {
    for(PNPlace *c in [[SCContextManager sharedContextManager] temporaryPlaces]) {
        if([[c label] hasPrefix:@"PRN("] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}

-(PNPlace *) getDeactivationFlag {
    for(PNPlace *c in [[SCContextManager sharedContextManager] temporaryPlaces]) {
        if([[c label] hasPrefix:@"NEG("] && [[c label] hasSuffix:[self label]])
            return c;
    }
    return nil;
}
///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:[self label]];
    [desc appendString:@" ("];
    if (![self tokens]) {
        [desc appendString:@"0 tokens)"];
    } else {
        for(PNToken *t in [self tokens]) {
            [desc appendString: [t description]];
        }
        [desc appendString:@")"];
    }
    return desc;
}

/**
 * Two places are said to be equal if they have the same name and same capacity
 */
- (BOOL) isEqual:(id)object {
    if(![[self label] isEqualToString: [object label]])
        return NO;
    if ([self capacity] != [object capacity])
        return NO;
    return YES;
}

- (NSUInteger)hash {
    int prime = 31;
    NSUInteger result = 1;
    //    Then for every primitive you do
    result = prime + [self capacity];
    //        For 64bit you might also want to shift and xor.
    //   result = prime * result + (int) ([self capacity] ^ ([self capacity] >>> 32));
    //    For objects you use 0 for nil and otherwise their hashcode.
    //result = prime * result + [[self tokens] hash];
    result = prime * result + [[self label] hash];
    //    For booleans you use two different values
    //    result = prime * result + (var)?1231:1237;
    return result;
}

/**
 * Auxiliary method need to pass it as parameter of NSMutableDictionary (a hashmap)
 */
-(id) copyWithZone: (NSZone *) zone {
    /*
    PNPlace *newPlace = [[PNPlace allocWithZone:zone] init];
    //   NSLog(@"_copy: %@", [newPlace self]);
    [newPlace setLabel:[self label]];
    [newPlace setTokens:tokens];
    [newPlace setCapacity:capacity];
    return (newPlace);
     */
    return [self retain];
}

@end