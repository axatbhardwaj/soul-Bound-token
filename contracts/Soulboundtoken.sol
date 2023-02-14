// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// SOUL BOUND TOKEN ATTEMPT WITH ERC-721 Interface

error TransferNotAllowed();
error ApprovalNotAllowed();
error alreadyMember();

interface ERC721 {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );
    event Approval(
        address indexed _owner,
        address indexed _approved,
        uint256 indexed _tokenId
    );
    event ApprovalForAll(
        address indexed _owner,
        address indexed _operator,
        bool _approved
    );

    function balanceOf(address _owner) external view returns (uint256);

    function ownerOf(uint256 _tokenId) external view returns (address);

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory data
    ) external;

    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;

    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) external;

    function approve(address _approved, uint256 _tokenId) external;

    function setApprovalForAll(address _operator, bool _approved) external;

    function getApproved(uint256 _tokenId) external view returns (address);

    function isApprovedForAll(address _owner, address _operator)
        external
        view
        returns (bool);

    function name() external view returns (string memory _name);

    function symbol() external view returns (string memory _symbol);

    function tokenURI(uint256 _tokenId) external view returns (string memory);

    function totalSupply() external view returns (uint256);
}

contract MembershipNFT {
    event Transfer(
        address indexed _from,
        address indexed _to,
        uint256 indexed _tokenId
    );

    constructor() {
        _uri = "https://github.com/axatbhardwaj";
        _symbol = "VD-MNFT";
        _name = "VOTING DAO MEMBERSHIP";
    }

    uint256 private _tokenCount;
    string private _uri;
    string private _symbol;
    string private _name;

    //Mappings
    mapping(address => uint256) private ownerShip;
    mapping(uint256 => address) private ownerShipByTokenId;

    function mint() public {
        if (ownerShip[msg.sender] >= 1) revert alreadyMember();
        _tokenCount = _tokenCount + 1;
        ownerShip[msg.sender] = _tokenCount;

        emit Transfer(address(this), msg.sender, _tokenCount);
    }

    function balanceOf(address _owner) public view virtual returns (uint256) {
        return ownerShip[_owner];
    }

    function ownerOf(uint256 _tokenId) public view virtual returns (address) {
        return ownerShipByTokenId[_tokenId];
    }

    // this function is disabled since we don;t want to allow transfers
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public virtual {
        revert TransferNotAllowed();
    }

    // this function is disabled since we don;t want to allow transfers
    function safeTransferFrom(
        address _from,
        address _to,
        uint256 _tokenId,
        bytes memory _data
    ) public virtual {
        revert TransferNotAllowed();
    }

    // this function is disabled since we don;t want to allow transfers
    function transferFrom(
        address _from,
        address _to,
        uint256 _tokenId
    ) public virtual {
        revert TransferNotAllowed();
    }

    // this function is disabled since we don;t want to allow transfers
    function approve(address _to, uint256 _tokenId) public virtual {
        revert TransferNotAllowed();
    }

    // this function is disabled since we don;t want to allow transfers
    function setApprovalForAll(address _operator, bool _approved)
        public
        virtual
    {
        revert ApprovalNotAllowed();
    }

    // this function is disabled since we don;t want to allow transfers
    function getApproved(uint256 _tokenId) public view returns (address) {
        return address(0x0);
    }

    // this function is disabled since we don;t want to allow transfers
    function isApprovedForAll(address _owner, address _operator)
        public
        view
        returns (bool)
    {
        return false;
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        returns (string memory)
    {
        if (_tokenId > _tokenCount) revert("Token doesn't exist");
        return _uri;
    }

    function symbol() external view returns (string memory) {
        return _symbol;
    }

    function totalSupply() external view returns (uint256) {
        return _tokenCount;
    }

    function name() external view returns (string memory) {
        return _name;
    }
}
