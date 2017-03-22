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

#import "PNExternalTransition.h"
#import "PNContextManager.h"

@implementation PNExternalTransition

- (id)init {
    self = [super init];
    [self setEnabled: YES];
    [self setPriority: EXTERNAL];
    return self;
}

- (id) initWithName:(NSString *) newName {
    self = [super initWithName:newName];
    [self setEnabled: YES];
    [self setPriority: EXTERNAL];
    return self;
}

- (BOOL) checkEnabledWithColor:(NSNumber *)color {
    return YES;
}

@end
