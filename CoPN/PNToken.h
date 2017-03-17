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

#import "PNElement.h"

/*
 * Token elements go into places, a token in a place is represented by its multiplicity
 */

@interface PNToken : PNElement {
@public	
    NSNumber *tValue;
    NSNumber *color;
}

@property(nonatomic, readwrite, retain) NSNumber *tValue;
@property(nonatomic, readwrite, retain) NSNumber *color;

-(id) initWithValue: (NSNumber *) aValue andColor: (NSNumber *) aColor;
-(id) copyWithZone: (NSZone *) zone;

@end
