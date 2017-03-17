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

#import "PNNode.h"
#import "PNToken.h"
#import "SCContext.h"
#import "PNArcInscription.h"

@class SCContext;
@class PNArcInscription;

/*
 Enumeration denoting the priority of the different types of transitions
*/ 
typedef enum {
    EXTERNAL = 0,
    CLEANING = 1,
    INTERNAL = 2
} PNTransitionType;

/*
 Transitions are the actions on places, its input and output places are just 
 arays indicating the place and the arity of the flow function
 */

@interface PNTransition : PNNode {
	NSMutableDictionary *inputs; //<place(SCContext), arity(PNArcInscription)>
	NSMutableDictionary *outputs;
	BOOL enabled;
    PNTransitionType priority;
}

///------------------------------------------------------------
/// @name Context Data
///------------------------------------------------------------
/** Inputs of the transition a Map of <place(SCContext), arity(PNArcInscription)> pairs */
@property(nonatomic,readwrite,retain) NSMutableDictionary *inputs;
/** Outputs of the transition a Map of <place(SCContext), arity(PNArcInscription)> pairs */
@property(nonatomic,readwrite,retain) NSMutableDictionary *outputs;
/** Variable to tell if the transition is enabled or not */
@property(nonatomic,readwrite) BOOL enabled;
/** Priority of the transition: EXTERNAL = 0, CLEANING = 1, or INTERNAL=2 */ 
@property(nonatomic,readwrite) PNTransitionType priority;
///------------------------------------------------------------
/// @name Initialization & Disposal
///------------------------------------------------------------
/** Initialize a context with a specific name.
 @param transitionName The name of the context to initialize.
 @param trnasitionPriority
 @return The initialized context.
 */
- (id) initWithName:(NSString *)newName andPriority: (PNTransitionType) newPriority;

/**
 Adds a new dependency from a context for the (de)activation to take place
 */
- (void) addInput:(PNArcInscription *) newInscription fromPlace: (SCContext *) context;

/**
 Remove a given dependency from a context to the (de)activation action
 */
- (void) removeInput: (SCContext *) placeName;

/**
 Adds a new dependency to (de)activate the given context
 */
- (void) addOutput:(PNArcInscription *) newInscription toPlace: (SCContext *) aPlace;

/**
 Removes the dependency between a (de)activation and the given context
 */
- (void) removeOutput: (SCContext *) placeName;

/**
 Returns all the dependencies for this action to take place
 */
- (NSArray *) normalInputs;

/**
 Returns all inputs from inhibitor arcs for this transition
 */
- (NSArray *) inhibitorInputs;

/** Method to check weather a transition is enabled or not. A transition is enabled if all teh input places have at least the number of tokens described in the flowFunction, or zero if the arc is an inhibitor.
 @param color - Token color for which the transition should be enabled
 */
- (BOOL) checkEnabledWithColor: (NSNumber *) color;

/** Remove the flowFunction qunatity of tokens from the input places, assign the flowFunction quantity for the output places. Executes the (de)activation for a particular context (given by the label) and its dependent contexts
 @pre The transition that is being fired is enabled to fire. (to check before calling this method)
 @param color - Token color for which the transition will fire
 */
- (void) fireWithColor: (NSNumber *) color;

/** Provides a plain representation of the object
 */
- (NSString *) description;

@end