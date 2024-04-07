// SPDX-License-Identifier: MIT

pragma solidity ^0.8.1;

contract fakeProductDetection{
    
    address public owner;

    constructor(){
        owner = msg.sender;
    }

    enum owner_status{
        with_manufacturer,
        with_retailer,
        with_customer
    }

    struct product_details{
        uint32 unique_product_id;
        string product_name;
        address curr_owner_address;
        owner_status curr_owner_state;
    }

    mapping(uint32 => product_details) public all_product_details;
    
    function add_product_details(uint32 unique_id, string memory prod_name) public{

        require(msg.sender == owner,"you are not authorized");
        
        product_details memory new_product ;

        new_product.unique_product_id = unique_id;
        new_product.product_name = prod_name;
        new_product.curr_owner_address = owner;
        new_product.curr_owner_state = owner_status(0);

         all_product_details[unique_id] = new_product;

    }

    function transfer_owner_ship(uint32 product_id , address new_address) public{
        require(all_product_details[product_id].curr_owner_address == msg.sender,"you are not the owner");
        all_product_details[product_id].curr_owner_address = new_address;
        if(all_product_details[product_id].curr_owner_state == owner_status(0)){
            all_product_details[product_id].curr_owner_state = owner_status(1);
        }else{
            all_product_details[product_id].curr_owner_state = owner_status(2);
        }
    }
}
