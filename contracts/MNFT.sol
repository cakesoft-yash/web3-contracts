// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MNFT is ERC721URIStorage {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;
    address public owner;
    mapping(uint256 => string) private membershipStatus;

    constructor() ERC721("Membership NFT", "MNFT") {
        owner = msg.sender;
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        //static code to stop token transfer
        require(false, "Transfer not allowed");
        safeTransferFrom(from, to, tokenId, "");
    }

    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory data
    ) public virtual override {
        //static code to stop token transfer
        require(false, "Transfer not allowed");
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller is not token owner or approved"
        );
        _safeTransfer(from, to, tokenId, data);
    }

    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public virtual override {
        //static code to stop token transfer
        require(false, "Transfer not allowed");
        require(
            _isApprovedOrOwner(_msgSender(), tokenId),
            "ERC721: caller is not token owner or approved"
        );
        _transfer(from, to, tokenId);
    }

    function mintMembership(string memory _tokenURI, uint256 _tokenId)
        public
        returns (uint256)
    {
        require(_tokenIds.current() < 10000, "No more NFTs can be minted");
        _tokenIds.increment();
        _mint(msg.sender, _tokenId);
        _setTokenURI(_tokenId, _tokenURI);
        membershipStatus[_tokenId] = "pending";
        return _tokenId;
    }

    function updateTokenURI(uint256 tokenId, string memory _tokenURI) public {
        _setTokenURI(tokenId, _tokenURI);
    }

    function getMembershipStatus(uint256 _tokenId)
        public
        view
        returns (string memory _membershipStatus)
    {
        return membershipStatus[_tokenId];
    }

    function updateMembershipStatus(uint256 _tokenId, string memory status)
        public
    {
        membershipStatus[_tokenId] = status;
    }
}
