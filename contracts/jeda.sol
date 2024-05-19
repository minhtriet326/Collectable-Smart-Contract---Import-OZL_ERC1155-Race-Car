pragma solidity ^0.8.2;

import "./ERC721.sol";

contract jeda is ERC721 {//đây là 1 collectable có 2 metadata và nó implements ERC721 metadata
    string public name;
    string public symbol;
    //cái tokenCount này đồng thời là tokenId luôn
    uint256 public tokenCount;//đếm coi SM này đã mint ra bao nhiêu NFT rồi
    mapping(uint256 => string) private _tokenURIs;//lưu tokenURI của mỗi NFT(token ID)

    constructor(string memory _name, string memory _symbol) {
        name = _name;
        symbol = _symbol;
    } 

    function tokenURI(uint256 tokenId) public view returns(string memory) {//trả về URI mà mình lưu metadata của NFT để front-end có thể lấy và hiển thị lên
        require(_owners[tokenId] != address(0), "Token ID does not exist");
        return _tokenURIs[tokenId];
    }

    function mint(string memory _tokenURI) public {//mint ra NFT mới
        tokenCount += 1; //tokenId
        _balances[msg.sender] += 1;
        _owners[tokenCount] = msg.sender;
        _tokenURIs[tokenCount] = _tokenURI;

        emit Transfer(address(0), msg.sender, tokenCount);
    }

    function supportInterface(bytes4 interfaceID) public pure override returns(bool) {
        return interfaceID == 0x80ac58cd || interfaceID == 0x5b5e139f;//ERC721 metadata
    }
}