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

#import "PNNode.h"

@class PNToken;

/*
 * A place is a bag of tokens restricted by its upperbound the capacity.
 * If not specified (-1), capacity is assumed to be infinite
 */

@interface PNPlace : PNNode {
@public
	NSMutableArray *tokens;
    NSInteger capacity;
    BOOL inhibiting;
}

///------------------------------------------------------------
/// @name Place Data
///------------------------------------------------------------
/** The (possibly) different activations of a place */
@property(nonatomic, readwrite, retain) NSMutableArray *tokens;
/** The bound of the place (a.k.a how many time can it be activated */
@property(nonatomic, readwrite) NSInteger capacity;
/** Tells if the place is an inhibiting place or not (it has an outgoing inhibitor arc)*/
@property(nonatomic, readwrite) BOOL inhibiting;
///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------

/** Initialize a place with a specific name.
 @param placeName The name of the place to initialize.
 @return The initialized place.
 */
- (id)initWithName:(NSString *)placeName;

/** Initialize a context with a specific name.
 @param contextName The name of the context to initialize.
 @param newCapacity The activation bound of the context
 @return The initialized context.
 */
- (id) initWithName:(NSString *) newName andCapacity: (int) newCapacity;

/**
 Creates a copy of the place with the given name
 */
- (PNPlace *) copyWithName: (NSString *) nodeName;

/**
 Tells whether the place is active.
 @return `YES` if the place is active. `NO` otherwise.
 */
- (BOOL) isActive;

/**
 Tells whether the context is active in a particular thread.
 @param color - The color identifying 
 @return `YES` if the context is active. `NO` otherwise.
 */
- (BOOL) isActiveForThread: (NSNumber *) color;

/**
 Method to designate if the context contains a given token
 a.k.a is active in a given thread.
 */
- (BOOL) containsToken:(PNToken *) token;

/**
 Method to designate if the context contains a given collection of tokens
 a.k.a is active in a given collection of threads.
 */
- (BOOL) containsTokens: (NSArray *) serchTokens;

/** Returns the tocken obkect for a given color
 @param color - The color of the needed tocken
 */
- (PNToken *) getTokenOfColor: (NSNumber *) color;

/**
 Adds a new token (Thread activation) to the place
 */
- (void) addToken: (PNToken *) token;

/**
 Adds a new collection of tokens (Thread activations) to the place
 */
- (void) addTokens: (NSArray *) newTokens;

/**
 Removes the given token (deactivates) from the place
 */
- (void) removeToken: (PNToken *) token;

/**
 Removes a given collection of tokens (deactivates) from the place
 */
- (void) removeTokens: (NSArray *) tokenSet;

/** Returns the tocken obkect for a given color
 @param color - The color of the needed tocken
 */
- (PNToken *) getTokenOfColor: (NSNumber *) color;

/**
 Gets the Prepare for activation place of given a place
 */
- (PNPlace *) getPrepareForActivation;

/**
 Gets the Prepare for activation place of given a place
 */
- (PNPlace *) getPrepareForDeactivation;

/**
 Gets the deactivation flag place of given a place
 */
- (PNPlace *) getDeactivationFlag;

/**
 Printable Version of the place
 */
- (NSString *) description;
@end
