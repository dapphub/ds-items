pragma solidity ^0.4.19;

import "ds-test/test.sol";

import "./DsItems.sol";

contract DsItemsTest is DSTest {
    DsItems items;

    function setUp() public {
        items = new DsItems();
    }

    function testFail_basic_sanity() public {
        assertTrue(false);
    }

    function test_basic_sanity() public {
        assertTrue(true);
    }
}
