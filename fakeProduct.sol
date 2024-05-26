// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract fakeProductDetection {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    enum owner_status {
        with_manufacturer,
        with_retailer,
        with_customer
    }

    struct product_details {
        uint32 unique_product_id;
        string product_name;
        address curr_owner_address;
        owner_status curr_owner_state;
    }

    mapping(uint32 => product_details) public all_product_details;

    event ProductAdded(uint32 unique_id, string prod_name, address owner);
    event OwnershipTransferred(uint32 product_id, address from, address to);

    function add_product_details(uint32 unique_id, string memory prod_name) public {
        require(msg.sender == owner, "You are not authorized");

        product_details memory new_product;
        new_product.unique_product_id = unique_id;
        new_product.product_name = prod_name;
        new_product.curr_owner_address = owner;
        new_product.curr_owner_state = owner_status(0);

        all_product_details[unique_id] = new_product;

        emit ProductAdded(unique_id, prod_name, owner);
    }

    function transfer_owner_ship(uint32 product_id, address new_address) public {
        require(all_product_details[product_id].curr_owner_address == msg.sender, "You are not the owner");
        address previousOwner = all_product_details[product_id].curr_owner_address;
        all_product_details[product_id].curr_owner_address = new_address;
        if (all_product_details[product_id].curr_owner_state == owner_status(0)) {
            all_product_details[product_id].curr_owner_state = owner_status(1);
        } else {
            all_product_details[product_id].curr_owner_state = owner_status(2);
        }

        emit OwnershipTransferred(product_id, previousOwner, new_address);
    }
}
