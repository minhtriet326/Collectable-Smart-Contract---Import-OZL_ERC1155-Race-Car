pragma solidity ^0.8.2;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract MyFinalCollection is ERC1155, Ownable {
    string public name;
    string public symbol;
    uint256 public tokenCount;//tokenId
    string public baseURI;//Biến toàn cục lưu trữ đường dẫn gốc đến nơi lưu trữ metadata

    constructor(string memory _name, string memory _symbol, string memory _baseURI) ERC1155(_baseURI) 
    {
        name = _name;
        symbol = _symbol;
        baseURI = _baseURI;
    }

    function mint(uint256 amount) public onlyOwner {
        tokenCount += 1;
        _mint(msg.sender, tokenCount, amount, "");
    }

    function uri(uint256 _tokenId) override public view returns(string memory) {
        return string(
            abi.encodePacked(//Hàm tiện ích của Solidity để kết hợp các giá trị thành một chuỗi duy nhất. Bên trong dấu ngoặc nhọn là các giá trị được kết hợp
                baseURI, 
                Strings.toString(_tokenId),
                ".json"
            )
        );
    }
}