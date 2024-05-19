pragma solidity ^0.8.2;

contract ERC721 {
    event Transfer(address indexed _from, address indexed _to, uint256 indexed _tokenId);
    event Approval(address indexed _owner, address indexed _approved, uint256 indexed _tokenId);
    event ApprovalForAll(address indexed _owner, address indexed _operator, bool _approved);

    mapping(address => uint256) internal _balances;
    mapping(uint256 => address) internal _owners;
    mapping(address => mapping(address => bool)) private _operatorApprovals;
    mapping(uint256 => address) private _tokenApprovals;

    //return the number of NFTs of an user
    function balanceOf(address _owner) external view returns (uint256) {
        require(_owner != address(0), "Address is zero");
        return _balances[_owner];
    }

    //Find an owner of a NFT
    function ownerOf(uint256 _tokenId) public view returns (address) {
        address owner = _owners[_tokenId];
        require(owner != address(0), "Token ID does not exist");
        return owner;
    }

    //enable or disable an operator
    function setApprovalForAll(address _operator, bool _approved) external {
        _operatorApprovals[msg.sender][_operator] = _approved;
        emit ApprovalForAll(msg.sender, _operator, _approved);
    }

    //check if an address is an operator for another address
    function isApprovedForAll(address _owner, address _operator) public view returns (bool) {
        return _operatorApprovals[_owner][_operator];
    }

    //approve an operator manage a specific NFT
    function approve(address _approved, uint256 _tokenId) public payable {
        require(ownerOf(_tokenId) == msg.sender || isApprovedForAll(ownerOf(_tokenId), msg.sender), "msg.sender is not the owner or the approved operator");
        _tokenApprovals[_tokenId] = _approved;
        emit Approval(msg.sender, _approved, _tokenId);
    }

    //get the approved address for an NFT
    function getApproved(uint256 _tokenId) public view returns (address) {
        require(_owners[_tokenId] != address(0), "TokenID does not exist");
        return _tokenApprovals[_tokenId];
    }

    //Transfer ownership of an single NFT
    function transferFrom(address _from, address _to, uint256 _tokenId) public payable {
        address owner = ownerOf(_tokenId);

        require(//hoặc là owner, hoặc được approve, hoặc là operator
            msg.sender == owner ||
            getApproved(_tokenId) == msg.sender ||
            isApprovedForAll(owner, msg.sender),
            "msg.sender is not the owner or approved for transfer"
        );

        require(owner == _from, "from address is not the owner");

        require(_to != address(0), "Address is the zero address");

        require(_owners[_tokenId] != address(0), "TokenID does not exist");

        approve(address(0), _tokenId);
        _balances[_from] -= 1;
        _balances[_to] += 1;
        _owners[_tokenId] = _to;
        emit Transfer(_from, _to, _tokenId);
    }

    //standard transferFrom method
    //check if the receiver smart contract is capable of receiving NFT
    function safeTransferFrom(address _from, address _to, uint256 _tokenId, bytes memory data) public payable {
        transferFrom(_from, _to, _tokenId);
        require(_checkOnERC721Received(), "Receiver not implemented");//nếu _from là 1 SM thì hàm này dùng để đảm bảo nó nhận NFT đc
    }

    //simple version to check for nft receivability of a smart contract
    function _checkOnERC721Received() private pure returns(bool) {
        return true;
    }

    //y chang
    function safeTransferFrom(address _from, address _to, uint256 _tokenId) external payable {
        safeTransferFrom(_from, _to, _tokenId, "");
    }

    //RẤT QUAN TRỌNG
    //EIP165 proposal: query if a contract implements another interface
    function supportInterface(bytes4 interfaceID) public pure virtual returns(bool) {//virtual là để mấy thằng kế thừa nó override lại
        //người gọi hàm này sẽ truyền vào 1 interfaceID để check xem Smart contract này có implement cái interface đó ko
        //khi deploy NFT lên 1 marketplace thì hàm này dùng để kiểm tra xem SM của mình có tương thích với môi trường đó hay ko
        return interfaceID == 0x80ac58cd; //this is interfaceID of ERC721  
    }
}