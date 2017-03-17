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

#import "PNInternalTransition.h"
#import "SCContextManager.h"

@implementation PNInternalTransition

- (id)init {
    self = [super init];
    [self setPriority:INTERNAL];
    return self;
}

- (id) initWithName:(NSString *)newName {
    self = [super initWithName:newName];
    if([newName hasPrefix:@"cl."])
        [self setPriority:CLEANING];
    else
        [self setPriority:INTERNAL];
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(BOOL) checkEnabledWithColor:(NSNumber *)color {
    [super checkEnabledWithColor:color];
    if(enabled)
        [[SCContextManager sharedContextManager] addInternalTransitionToQueue: self];
    return enabled;
}

@end
