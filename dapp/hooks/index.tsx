import { MINT_GEM_TOKEN_ABI, MINT_GEM_TOKEN_ADDRESS, SALE_GEM_TOKEN_ABI, SALE_GEM_TOKEN_ADDRESS } from "@/caverConfig";
import Caver, {Contract} from "caver-js";
import { useEffect, useState } from "react";

export const useAccount = () => {
    const [account, setAccount] = useState<string>("");

    const getAccount = async () => {
        try{
            const accounts = await window.ethereum.request({ method: 'eth_requestAccounts' });

            setAccount(accounts[0]);
        }catch(error){
            console.error(error);
        }
    };

    useEffect(() => {
        if(window.ethereum){
            getAccount();
        }
    }, []);
    return {account};
};


export const useCaver = () => {
    const [caver, setCaver] = useState<Caver | undefined>(undefined);
    const [mintGemTokenContract, setMintGemTokenContract] = useState<Contract | undefined>(undefined);
    const [saleGemTokenContract, setSaleGemTokenContract] = useState<Contract | undefined>(undefined);

    useEffect(()=> {
        if(window.ethereum){
            setCaver(new Caver(window.ethereum));
    }
    },[]);

    useEffect(() => {
        if(!caver) return;

        setMintGemTokenContract(caver.contract.create(MINT_GEM_TOKEN_ABI, MINT_GEM_TOKEN_ADDRESS)
        );
        setSaleGemTokenContract(caver.contract.create(SALE_GEM_TOKEN_ABI, SALE_GEM_TOKEN_ADDRESS)
        );
    }, [caver]);

    return{caver, mintGemTokenContract, saleGemTokenContract};
};