// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Structs{
    struct Car{
        string model;
        uint year;
        address owner;
    }
    Car public car;
    Car[] public cars;
    mapping(address => Car[]) public carsByOwner;
    
    function examples() external{
        Car memory Benz = Car("Mercedes Benz", 2024, msg.sender);
        Car memory Tesla = Car({model:"Tesla",year:2024,owner:msg.sender});
        Car memory BMW;
        BMW.model = "BMW Series3";
        BMW.owner = msg.sender;
        BMW.year = 2024;
        
        cars.push(Benz);
        cars.push(Tesla);
        cars.push(BMW);

        cars.push(Car("Audi",2024,msg.sender));

        Car memory car1 = cars[0];
        car1.model;
        car1.year;
        car1.owner;

        Car storage car2 = cars[0];
        car2.year = 2023;

        delete car1.owner;

        delete cars[2];


    }
}