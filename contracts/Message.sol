pragma solidity ^0.4.0;

contract Message {

    string public nick_name;
    string private message;
    address owner;

    modifier restricted() {
        if (msg.sender == owner) _;
    }

    constructor() public{
        owner = msg.sender;

    }

    function publish(string content) public restricted {
        bytes memory temp = bytes(message);
        if (temp.length == 0) {
            message = content;
        }
        delete temp;
    }

    function setNickName(string name) public restricted {
        bytes memory temp = bytes(nick_name);
        if (temp.length == 0) {
            nick_name = name;
        }
        delete temp;
    }

    function getMessage() public view returns (string){
        return message;
    }


}
