pragma solidity ^0.4.22;

import 'openzeppelin-solidity/contracts/math/SafeMath.sol';


contract Message {
    using SafeMath for uint;

    address owner;

    struct Article {
        address authorAddress;
        string authorNickName;
        string title;
        string body;
        uint256 viewCount;
    }

    mapping(bytes32 => Article) ID2Article;

    modifier isOwner(){
        if (msg.sender == owner) _;
    }

    constructor() public{
        owner = msg.sender;
    }

    function publish(string authorNickName, string title, string body) public returns (bytes32){
        Article memory temp = Article(msg.sender, authorNickName, title, body, 1);
        //bytes32 tmpID = sha256(abi.encodePacked(msg.sender, authorNickName, title, body));
        // only encode two argument, the nick name and the title for better usage of searching through the web url
        bytes32 tmpID = sha256(abi.encodePacked(authorNickName, title));
        ID2Article[tmpID] = temp;
        return (tmpID);
    }

    function getArticleByID(bytes32 articleID) public view returns (address, string, string, string, uint256){

        Article memory tmp = ID2Article[articleID];
        // if the one who get this article is not the msg.sender then the viewCount would add one;
        if (msg.sender != tmp.authorAddress) {
            tmp.viewCount = tmp.viewCount.add(1);
        }
        return (tmp.authorAddress, tmp.authorNickName, tmp.title, tmp.body, tmp.viewCount);
    }

    function getArticleByURL(string nickName, string title) public view returns (address, string, string, string, uint256){
        bytes32 tmpID = sha256(abi.encodePacked(nickName, title));
        return getArticleByID(tmpID);
    }
}
