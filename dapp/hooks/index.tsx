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