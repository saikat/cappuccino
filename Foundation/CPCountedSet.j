/*
 * CPCountedSet.j
 * Foundation
 *
 * Created by .
 * Copyright 2008, 280 North, Inc.
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA
 */

@import "CPSet.j"

/*! 
    @class CPCountedSet
    @ingroup foundation
    @brief An mutable collection of objects and counts of their instances.

*/
@implementation CPCountedSet : CPMutableSet
{
    Object  _counts;
}

- (void)addObject:(id)anObject
{
    if (!_counts)
        _counts = {};
    
    [super addObject:anObject];
    
    var hash = [anObject hash];
    
    if (_counts[hash] === undefined)
        _counts[hash] = 1;
    else
        ++_counts[hash];
}

- (void)removeObject:(id)anObject
{
    if (!_counts)
        return;
        
    var hash = [anObject hash];
    
    if (_counts[hash] === undefined)
        return;
    
    else
    {
        --_counts[hash];
        
        if (_counts[hash] === 0)
        {
            delete _counts[hash];
            [super removeObject:anObject];
        }
    }
}

- (void)removeAllObjects
{
    [super removeAllObjects];
    _counts = {};
}

/*
    Returns the number of times anObject appears in the receiver.
    @param anObject The object to check the count for.
*/
- (unsigned)countForObject:(id)anObject
{
    if (!_counts)
        _counts = {};
    
    var hash = [anObject hash];
    
    if (_counts[hash] === undefined)
        return 0;
    
    return _counts[hash];
}


/* 

Eventually we should see what these are supposed to do, and then do that.

- (void)intersectSet:(CPSet)set

- (void)minusSet:(CPSet)set

- (void)unionSet:(CPSet)set

*/

@end
