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
        require( msg.sender == handler[obj] || relies[msg.sender][this]);
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
