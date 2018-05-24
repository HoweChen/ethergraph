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
        //bytes32 tmpID = sha256(abi.encodePacked(msg.sender, authorNickName, title, body));
        // only encode two argument, the nick name and the title for better usage of searching through the web url
        bytes32 tmpID = sha256(abi.encodePacked(authorNickName, title));
        ID2Article[tmpID] = temp;
        return (tmpID);
    }

    function getArticleByID(bytes32 articleID) public view returns (address, string, string, string){
        Article memory tmp = ID2Article[articleID];
        return (tmp.authorAddress, tmp.authorNickName, tmp.title, tmp.body);
    }

    function getArticleByURL(string nickName, string title) public view returns (address, string, string, string){
        bytes32 tmpID = sha256(abi.encodePacked(nickName, title));
        return getArticleByID(tmpID);
    }
}
