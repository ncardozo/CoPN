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

#import "PNInternalTransition.h"
#import "PNContextManager.h"

@implementation PNInternalTransition

- (id)init {
    self = [super init];
    [self setPriority:INTERNAL];
    return self;
}

- (id) initWithName:(NSString *)newName {
    self = [super initWithName:newName];
    [self setPriority:INTERNAL];
    return self;
}

-(BOOL) checkEnabledWithColor:(NSNumber *)color {
    [super checkEnabledWithColor:color];
    if(enabled)
        [[PNContextManager sharedManager] addInternalTransitionToQueue: self];
    return enabled;
}

@end
