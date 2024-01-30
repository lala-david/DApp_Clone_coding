// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import "contracts/MintGemToken.sol";

contract SaleGemToken {
    MintGemToken public mintGemToken;
    
    constructor(address _mintGemToken){
        mintGemToken = MintGemToken(_mintGemToken);
    }


    struct GemTokenData {
        uint tokenId;
        uint gemTokenRank;
        uint gemTokenType;
        uint tokenPrice;
    }


    mapping(uint => uint) public tokenPrice;

    uint[] public onSaleTokens;

    function setForSaleGemToken(uint _tokenId, uint _price) public {
        address tokenOwner = mintGemToken.ownerOf(_tokenId);

        require(tokenOwner == msg.sender, "Caller is not Gem token owner.");
        require(_price >= 0, "Price is zero or lower.");
        require(tokenPrice[_tokenId] == 0, "This Gem token is already on sale.");
        // msg.sender (판매 권한이 부여되어 있는 주소만 거래할 수 있음)
        require(mintGemToken.isApprovedForAll(msg.sender, address(this)), "Gem token onwer did not approve token.");

        tokenPrice[_tokenId] = _price;

        onSaleTokens.push(_tokenId);
    }

    function purchaseGemToken(uint _tokenId) public payable {
        address tokenOwner = mintGemToken.ownerOf(_tokenId);
        require(tokenOwner != msg.sender, "Caller is Gem token owner.");
        require(tokenPrice[_tokenId] >= 0, "This Gem token not for sale.");
        require(tokenPrice[_tokenId] <= msg.value, "Caller sent lower than price.");

        payable(tokenOwner).transfer(msg.value);

        mintGemToken.safeTransferFrom(tokenOwner, msg.sender, _tokenId);

        tokenPrice[_tokenId] = 0;

        popOnSaleToken(_tokenId);

    }

    function popOnSaleToken(uint _tokenId) private {
        for(uint i = 0; i < onSaleTokens.length; i++){
            if(onSaleTokens[i] == _tokenId) {
                onSaleTokens[i] = onSaleTokens[onSaleTokens.length - 1];
                onSaleTokens.pop();
            }
        }
    }

    function getGemTokens(address _tokenOwner) public view returns(GemTokenData[] memory) {
        uint balanceLength = mintGemToken.balanceOf(_tokenOwner);

        require(balanceLength >= 0, "Token owner did not have token.");

        GemTokenData[] memory gemTokens = new GemTokenData[](balanceLength);

        for(uint i = 0; i < balanceLength; i++) {
            uint tokenId = mintGemToken.tokenOfOwnerByIndex(_tokenOwner, i);
            
            (uint gemTokenRank, uint gemTokenType, uint tokenPrice) = getGemTokenInfo(tokenId);

            gemTokens[i] = GemTokenData(tokenId, gemTokenRank, gemTokenType, tokenPrice);
        }

        return gemTokens;
    }

    function getSaleGemTokens() public view returns(GemTokenData[] memory) {
        require(onSaleTokens.length >= 0, "Not exist on sale token.");

        GemTokenData[] memory gemTokens = new GemTokenData[](onSaleTokens.length);

        for(uint i = 0; i < onSaleTokens.length; i++) {
            uint tokenId = onSaleTokens[i];

            (uint gemTokenRank, uint gemTokenType, uint tokenPrice) = getGemTokenInfo(tokenId);

            gemTokens[i] = GemTokenData(tokenId, gemTokenRank, gemTokenType, tokenPrice);
        }

        return gemTokens;
    }

    function getLatestMintedGemToken(address _tokenOwner) public view returns(GemTokenData memory){

        uint balanceLength = mintGemToken.balanceOf(_tokenOwner);
        uint tokenId = mintGemToken.tokenOfOwnerByIndex(_tokenOwner, balanceLength - 1);
        (uint gemTokenRank, uint gemTokenType, uint gemTokenPrice) = getGemTokenInfo(tokenId);

        return GemTokenData(tokenId, gemTokenRank, gemTokenType, gemTokenPrice);
    }


    function getGemTokenInfo(uint _tokenId) public view returns(uint, uint, uint){
        uint gemTokenRank = mintGemToken.getGemTokenRank(_tokenId);
        uint gemTokenType = mintGemToken.getGemTokenType(_tokenId);
        uint tokenPrice = tokenPrice[_tokenId];

        return (gemTokenRank, gemTokenType, tokenPrice);
    }
}