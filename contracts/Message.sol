pragma solidity ^0.4.22;

//import "openzeppelin-solidity/contracts/math/SafeMath.sol";


contract Message {
    //    using SafeMath for uint;

    address owner;

    struct Article {
        address authorAddress;
        string authorNickName;
        string title;
        string body;
        //        uint256 viewCount;
    }

    mapping(bytes32 => Article) public ID2Article;

    modifier isOwner(){
        if (msg.sender == owner) _;
    }

    //    modifier isNotArticleAuthor(bytes32 articleID){
    //        if (msg.sender != ID2Article[articleID].authorAddress) {
    //            ID2Article[articleID].viewCount = ID2Article[articleID].viewCount.add(1);
    //        }
    //        _;
    //    }

    constructor() public{
        owner = msg.sender;
    }

    function publish(string authorNickName, string title, string body) public returns (bytes32){

        //        Article memory temp = Article(msg.sender, authorNickName, title, body, 1);
        Article memory temp = Article(msg.sender, authorNickName, title, body);
        //bytes32 tmpID = sha256(abi.encodePacked(msg.sender, authorNickName, title, body));
        // only encode two argument, the nick name and the title for better usage of searching through the web url
        bytes32 tmpID = sha256(abi.encodePacked(authorNickName, title));
        ID2Article[tmpID] = temp;
        return (tmpID);
    }

    function getArticleByID(bytes32 articleID) public view returns (address, string, string, string){

        Article memory tmp = ID2Article[articleID];
        //        tmp.viewCount = tmp.viewCount.add(1);
        return (tmp.authorAddress, tmp.authorNickName, tmp.title, tmp.body);
    }

    function getArticleByURL(string nickName, string title) public view returns (address, string, string, string){
        bytes32 tmpID = sha256(abi.encodePacked(nickName, title));
        return getArticleByID(tmpID);
    }

    //    function getArticleByID(bytes32 articleID) public isNotArticleAuthor(articleID) view returns (address, string, string, string, uint256){
    //
    //        Article memory tmp = ID2Article[articleID];
    //        //        tmp.viewCount = tmp.viewCount.add(1);
    //        return (tmp.authorAddress, tmp.authorNickName, tmp.title, tmp.body, tmp.viewCount);
    //    }

    // with viewCount version
    //    function getArticleByURL(string nickName, string title) public view returns (address, string, string, string, uint256){
    //        bytes32 tmpID = sha256(abi.encodePacked(nickName, title));
    //        return getArticleByID(tmpID);
    //    }

    //without viewCount version

}
