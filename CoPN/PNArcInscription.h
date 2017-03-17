/**
 Context Petri Nets. Context-oriented programming for mobile devices
 Copyright (C) 2011  Nicolás Cardozo
 
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

#import "PNElement.h"

/*
 * Arcs are represented by their type and inscription
 * type can be normal or inhibitor, inscription is the arity.
 */
typedef enum {
    NORMAL = 1,
    INHIBITOR = 0
} PNInscriptionType;

@interface PNArcInscription : PNElement {
	int flowFunction;
	PNInscriptionType iType;
}

///------------------------------------------------------------
/// @name Current Activation Data
///------------------------------------------------------------
//Array marked places in the Petri net
@property(nonatomic,readwrite) int flowFunction;
//Current marking to the system (only SCContext accepted here)
@property(nonatomic,readwrite) PNInscriptionType iType;

- (id) initWithType: (PNInscriptionType) aType;

@end
