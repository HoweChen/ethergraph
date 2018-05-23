pragma solidity ^0.4.22;
//pragma experimental ABIEncoderV2;

contract Message {

    address owner;

    struct Article {
        address authorAddress;
        string authorNickName;
        string title;
        string body;
    }

    mapping(bytes32 => Article) ID2Article;

    modifier isOwner(){
        if (msg.sender == owner) _;
    }

    constructor() public{
        owner = msg.sender;
    }

    function publish(string authorNickName, string title, string body) public returns (bytes32){
        Article memory temp = Article(msg.sender, authorNickName, title, body);
        bytes32 tmpID = sha256(abi.encodePacked(msg.sender, authorNickName, title, body));
        ID2Article[tmpID] = temp;
        return (tmpID);
    }

    function getArticle(bytes32 articleID) public view returns (address, string, string, string){
        Article memory tmp = ID2Article[articleID];
        return (tmp.authorAddress, tmp.authorNickName, tmp.title, tmp.body);
    }
}
