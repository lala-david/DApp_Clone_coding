<h1>🛸 D.P.2 Clone Coding</h1> 

<H2>🐚 Index</H2>

[✅] #0 Introduce Dapp

[✅] #1 Smart Contract - NFT

[✅] #2 Smart Contract - Sale Contract

- [ ] #3 Dapp - React(NextJS) + Typescript

<H2>🐚 Customizing </H2>

[✔] 클레이튼 바오밥 테스트 넷 및 클레이튼 IDE 문제로 Remix IDE로 변경
```
// 터미널에 입력
remixd -s . --remix-ide https://remix.ethereum.org
```
[✔] 클레이튼 바오밥 테스트 넷에서 이더리움 테스트 넷으로 변경
```
// 해당 사이트에서 ETHEREUM SEPOLIA 받기
https://sepoliafaucet.com/
```
[✔] _METADATAURI 입력은 Pinta IPFS에 올린 MetaData Json파일의 CID를 입력
```
ipfs://<MetaData Json CID 입력>
```
[✔] 클레이튼 지갑 연결 안하고 metamask로 변경 
```
window.klaytn.enable(); ➡ window.ethereum.request({ method: 'eth_requestAccounts' });
if(window.klaytn){} ➡ if(window.ethereum){}
```

 <H2>🐚 Clone Coding Info </H2>
 
- [⛵ 강의 사이트](https://www.inflearn.com/course/%EB%94%94%EC%95%B1-%ED%94%84%EB%A1%9C%EC%A0%9D%ED%8A%B8-2)
- [⚗ 코드](https://github.com/h662/h662GemZ/tree/master) 
- [🧪 OpenSea Test.io](https://testnets.opensea.io/)
- [🧫 강의 이미지 및 JSON](https://drive.google.com/drive/folders/1U-zj2Cvv2w-BoIjsi28x_-PlNps_x6rn)
- [🔭 Pinta IPFS](https://app.pinata.cloud/pinmanager)
