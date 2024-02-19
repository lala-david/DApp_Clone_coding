// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract MyNft is ERC721URIStorage, Ownable {
    using Counters for Counters.Counter;
    Counters.Counter private _tokenIds;

    constructor() ERC721("MetaPoint", "SeongJun") Ownable(msg.sender) {}

    struct Trait {
        string name;
        string value;
    }

    mapping(uint256 => Trait[]) private _tokenTraits;

    function mintNFT(address recipient, string memory name, uint256 metaPoint, string memory class, string memory major)
        public onlyOwner
        returns (uint256)
    {
        _tokenIds.increment();

        uint256 newItemId = _tokenIds.current();
        _mint(recipient, newItemId);

        // 메타데이터 JSON 문자열에 한글 직접 사용
        string memory metadata = string(abi.encodePacked(
            '{"name": "', name, '", ',
                unicode'"description": "📑 군산대학교 소프트웨어중심대학에서 발급한 메타포인트 인증서입니다.", ',
            '"image": "https://fuchsia-rainy-porpoise-241.mypinata.cloud/ipfs/QmXxkLh47fZfcJ9vpxx7Sp6VbY8Y7ZxRk92saGaTbsaQoj", ',
            '"attributes": [',
                '{"trait_type": "MetaPoint", "value": "', uintToString(metaPoint), '"}, ',
                '{"trait_type": "Class", "value": "', class, '"}, ',
                '{"trait_type": "Major", "value": "', major, '"}', 
            ']}'
        ));

        _setTokenURI(newItemId, metadata);

        _addTrait(newItemId, "NAME", name);
        _addTrait(newItemId, "MetaPoint", uintToString(metaPoint));
        _addTrait(newItemId, "Class", class);
        _addTrait(newItemId, "Major", major);

        return newItemId;
    }

    function _addTrait(uint256 tokenId, string memory traitName, string memory traitValue) internal {
        _tokenTraits[tokenId].push(Trait(traitName, traitValue));
    }

    function uintToString(uint256 value) internal pure returns (string memory) {
        if (value == 0) {
            return "0";
        }
        uint256 temp = value;
        uint256 digits;
        while (temp != 0) {
            digits++;
            temp /= 10;
        }
        bytes memory buffer = new bytes(digits);
        while (value != 0) {
            digits -= 1;
            buffer[digits] = bytes1(uint8(48 + value % 10));
            value /= 10;
        }
        return string(buffer);
    }

    function getTokenTraits(uint256 tokenId) public view returns (Trait[] memory) {
        return _tokenTraits[tokenId];
    }
}
