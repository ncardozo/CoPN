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

#import "SCContext.h"

@class PNToken;
@class SCContextMethod;

@interface PNContextPlace : SCContext {
    NSMutableArray *contextMethods;
}
/** Variable to hold the method definitions for an specific context */
@property (nonatomic, readwrite, retain) NSMutableArray *contextMethods;

///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------

/** Initialize a context with a specific name.
 @param contextName The name of the context to initialize.
 @return The initialized context.
 */
- (id)initWithName:(NSString *)contextName;

/** Initialize a context with a specific name.
 @param contextName The name of the context to initialize.
 @param newCapacity The activation bound of the context
 @return The initialized context.
 */
- (id) initWithName:(NSString *) newName andCapacity: (NSNumber *) newCapacity;

/** Adds a context method definition to the context */
- (void) addMethod: (SCContextMethod *) method;

@end
