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

#import "PNTransition.h"

@implementation PNTransition

@synthesize inputs;
@synthesize outputs;
@synthesize enabled;
@synthesize priority;

- (id) init {
	if((self = [super init])) {
        inputs = [NSMutableDictionary dictionary]; // <key (SCContext), value (PNTransitionType type)>
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
	}
	return self;
}

- (id) initWithName: (NSString *) aName {
    if((self = [super initWithName: aName])) {
		inputs = [NSMutableDictionary dictionary];
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
	}
	return self;
}

- (id) initWithName: (NSString *) aName andPriority: (PNTransitionType) newPriority {
    if((self = [super initWithName: aName])) {
		inputs = [NSMutableDictionary dictionary];
		outputs = [NSMutableDictionary dictionary];	
        enabled = NO;
        priority = newPriority;
	}
	return self;
}

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
- (void) addInput:(PNArcInscription *) newInscription fromPlace: (PNPlace *) input {
    NSParameterAssert(input);
    NSParameterAssert(newInscription);
	//[inputs setObject:newInscription forKey: input];
    [inputs setObject:newInscription forKey: (id)input];
}

- (void) removeInput:(PNPlace *) context {
	NSParameterAssert(context);
    [inputs removeObjectForKey:context];
}

- (void) addOutput:(PNArcInscription *)newInscription toPlace: (PNPlace *) context {
    if ([newInscription iType] == INHIBITOR) {
        @throw ([NSException
                 exceptionWithName:@"InvalidArcInscriptionException"
                 reason:@"It is not posible to have inhibitor arcs for an output"
                 userInfo:nil]);
    } else
        //[outputs setObject:newInscription forKey: context];
        [outputs setObject:newInscription forKey: (id)context];
}

- (void) removeOutput:(PNPlace *) context {
	[outputs removeObjectForKey:context];
}

- (NSArray *) normalInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNPlace *c in [inputs allKeys]) {
        PNArcInscription *ai = [inputs objectForKey:c];
        if([ai iType] == NORMAL) {
            [result addObject:c];
        }
    }
    return result;
}

- (NSArray *) inhibitorInputs {
    NSMutableArray *result = [[NSMutableArray alloc] init];
    for(PNPlace *c in [inputs allKeys]) {
        PNArcInscription *ai = [inputs objectForKey:c];
        if([ai iType] == INHIBITOR) {
            [result addObject:c];
        }
    }
    return ([result count] > 0) ? result : nil;
}

- (BOOL) checkEnabledWithColor:(NSNumber *)color {
    enabled = YES;
    if(color == [NSNumber numberWithInt:1]) { //black token
        for(PNPlace* key in [inputs keyEnumerator]){
            PNArcInscription *ai = [inputs objectForKey:key]; 
            PNInscriptionType aType = [ai iType]; 		
            if (aType == NORMAL) {
                if([[key tokens] count] > 0) {
                    for (PNToken *tock in [key tokens]) {
                        if ([[tock tValue] intValue] < [ai flowFunction]) {
                            enabled = NO;
                            break;
                        }
                    }
                } else {
                    enabled = NO;
                    break;
                }
            } else if ((aType == INHIBITOR) && ([[key tokens] count] != 0)) {
                enabled = NO;
                break;
            }
        }
    } else {
        for(PNPlace* key in [inputs keyEnumerator]){
            int blackToken = [[[key getTokenOfColor:[NSNumber numberWithInt:1]] tValue] intValue]; //Black token
            int tokenCount = [[[key getTokenOfColor:color] tValue] intValue];
            PNArcInscription *ai = [inputs objectForKey:key]; 
            PNInscriptionType aType = [ai iType]; 		
            if((aType == NORMAL) && ([ai flowFunction] > tokenCount && [ai flowFunction] > blackToken)) {
                enabled = NO;
                break;
            } else if ((aType == INHIBITOR) && (tokenCount != 0  || blackToken != 0)) {
                enabled = NO;
                break;
            }
        }
    }
    if(enabled) {
        for(PNPlace* key2 in [outputs keyEnumerator]){
            PNToken *t = [key2 getTokenOfColor:color];
            PNArcInscription *ai = [outputs objectForKey:key2];
            if(key2.capacity != -1 && [[t tValue] intValue] + [ai flowFunction] > key2.capacity) {
                enabled = NO;
                break;
            } 
        }
    }
    return enabled;
}

- (void) fireWithColor:(NSNumber *)color {
	int flow;
    if (color == [NSNumber numberWithInt:1]) { //Black token
        for(PNPlace *inpp in [inputs keyEnumerator]) {
            if([outputs objectForKey:inpp] == nil) {
                PNArcInscription *ai = [inputs objectForKey:inpp];
                if([ai iType] == NORMAL) {
                    flow = [[inputs objectForKey:inpp] flowFunction];
                    NSMutableArray *tempArray = [NSMutableArray arrayWithArray:[inpp tokens]];
                    for (PNToken *t in tempArray) {
                        [t setTValue:[NSNumber numberWithInt:([[t tValue] intValue] - flow)]];
                        if([[t tValue] intValue] < 1) 
                            [inpp removeToken:t];
                    }
                }
            }
        }
    } else {
        for(PNPlace *inpp in [inputs keyEnumerator]) {
            if([outputs objectForKey:inpp] == nil) {
                PNArcInscription *ai = [inputs objectForKey:inpp];
                if([ai iType] == NORMAL) {
                    flow = [[inputs objectForKey:inpp] flowFunction];
                    PNToken *t = [inpp getTokenOfColor: color];
                    [t setTValue:[NSNumber numberWithInt:([[t tValue] intValue] - flow)]];
                    if([[t tValue] intValue] < 1) 
                        [inpp removeToken:t];
                }
            }
        }
    }
    for(PNPlace *outp in [outputs keyEnumerator]) {
        if([inputs objectForKey:outp] == nil || [[inputs objectForKey:outp] iType] ==INHIBITOR) {
            flow = [[outputs objectForKey:outp] flowFunction];
            PNToken *tok = [outp getTokenOfColor:color];
            if(tok != nil) {
                [tok setTValue:[NSNumber numberWithInt:([[tok tValue] intValue] + flow)]];
            } else {
                PNToken *tock = [[PNToken alloc] init];
                [tock setTValue:[NSNumber numberWithInt:flow]];
                [tock setColor:color];
                [[outp tokens] addObject:tock]; 
            }
        }
    }
}
///------------------------------------------------------------
/// @name Auxilliary Methods
///------------------------------------------------------------
/**
 * Provides a "plane" printable version of the object
 */
- (NSString *) description {
    NSMutableString *desc = [NSMutableString stringWithString:@"@Transition "];
    [desc appendString:[self label]];
    if([self enabled])
     [desc appendString:@" (enabled) "];   
    else
     [desc appendString:@" (disabled) "];      
    
    [desc appendString:@"Inputs("];
    for (PNPlace *p in [[self inputs] allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p label]];
        [desc appendString:@", "];
        [desc appendString:[[[self inputs] objectForKey:p] description]];
        [desc appendString:@"> | "];
    }
    [desc appendString:@") - Outputs("];
    for (PNPlace *p in [[self outputs] allKeys]) {
        [desc appendString:@"<"];
        [desc appendString: [p label]];
        [desc appendString:@", "];
        [desc appendString:[[[self outputs] objectForKey:p] description]];
        [desc appendString:@"> | "];
    }
    [desc appendString:@")"];
    return desc;
}
@end
