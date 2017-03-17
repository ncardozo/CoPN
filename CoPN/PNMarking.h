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


@class SCContext;

/*
 * Array of currently marked places
 */
@interface PNMarking : NSObject {
	NSMutableArray *activeContexts; 
    NSMutableArray *systemMarking; 
}

///------------------------------------------------------------
/// @name Current Activation Data
///------------------------------------------------------------
//Array marked places in the Petri net
@property(nonatomic,retain) NSMutableArray *activeContexts;
//Current marking to the system (only SCContext accepted here)
@property(nonatomic,readonly,retain) NSMutableArray *systemMarking;

///------------------------------------------------------------
/// @name Functional Methods
///------------------------------------------------------------
/**
 Removes all the tokens from the places in the Petri net
 */
- (void) clean;

/**
 Adds a place to the current marking of the Petri net
 */
- (void) addActiveContextToMarking: (SCContext *) context;

/**
 Removes a places from the current marking of the Petri net
 */
- (void) removeActiveContextFromMarking: (SCContext *) context;

/**
 sets the systemMarking as the current marking of the Petri net
 */
- (void) updateSystemState;

/**
 Retrieves all operation in case an instable state
 */
- (void) revertOperation;
@end
