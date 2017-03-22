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

#import "PNMarking.h"



@implementation PNMarking

@synthesize activeContexts;
@synthesize systemMarking;

-(id) init {
    if((self = [super init])) {
        activeContexts = [[NSMutableArray alloc] init];
        systemMarking = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void) addActiveContextToMarking: (PNContextPlace *) context {
    NSParameterAssert(context);
    [activeContexts addObject:context];
}

- (void) removeActiveContextFromMarking: (PNContextPlace *) context {
    [activeContexts removeObject:context];
}

-(void) clean {
    [activeContexts removeAllObjects];
}

- (void) updateSystemState {
    [systemMarking removeAllObjects];
    [systemMarking addObjectsFromArray:activeContexts];
}

- (void) revertOperation {
    [activeContexts removeAllObjects];
    [activeContexts addObjectsFromArray:systemMarking];
    for(PNContextPlace *p in [[PNContextManager sharedManager] temporaryPlaces]) {
        [[p tokens] removeAllObjects];
    }
    [[PNContextManager sharedManager] setStable:YES];
}

-(NSString *) description {
    NSMutableString *desc = [NSMutableString new];
    for(PNContextPlace *p in systemMarking) {
        [desc appendString:[p description]];
    }
    return desc;
}
@end
