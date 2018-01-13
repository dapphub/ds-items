/// items.sol - like DSToken, but non-fungible things identified by number

// Copyright (C) 2016, 2017, 2018  DappHub, LLC
 
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program. If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.4.19;

import 'ds-auth/auth.sol';

contract DSItems is DSAuth {
    mapping( uint256 => address )  public handler;
    mapping( address =>
        mapping( address => bool)) public relies; // hodler -> mover -> ok

    function init(uint256 obj, address where)
        auth
    {
        require( handler[obj] == 0x0 );
        handler[obj] = where;
    }
    function init(uint256 obj)
        auth
    {
        require( handler[obj] == 0x0 );
        handler[obj] == msg.sender;
    }
    function move(uint256 obj, address from, address to) {
        require( msg.sender == handler[obj] || relies[from][this]);
        handler[obj] = to;
    }
    function pull(uint256 obj, address from) {
        move(obj, from, this);
    }
    function push(uint256 obj, address to) {
        move(obj, this, to);
    }
    function rely(address whom) {
        relies[msg.sender][whom] = true;
    }
    function deny(address whom) {
        relies[msg.sender][whom] = false;
    }
}
