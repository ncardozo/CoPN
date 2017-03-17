/**
 Context Petri Nets. Context-oriented programming for mobile devices
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

#import "PNMarking.h"
#import "SCContext.h"
#import "SCContextManager.h"

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

- (void) dealloc {
    [activeContexts release];
    [systemMarking release];
    [super dealloc];
}

- (void) addActiveContextToMarking: (SCContext *) context {
    NSParameterAssert(context);
    [activeContexts addObject:context];
}

- (void) removeActiveContextFromMarking: (SCContext *) context {
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
    for(SCContext *p in [[SCContextManager sharedContextManager] temporaryPlaces]) {
        [[p tokens] removeAllObjects];
    }
    [[SCContextManager sharedContextManager] setStable:YES];
}

-(NSString *) description {
    NSMutableString *desc = [[NSMutableString alloc] init];
    for(SCContext *c in systemMarking) {
        [desc appendString:[c description]];
    }
    return [desc autorelease];
}
@end
