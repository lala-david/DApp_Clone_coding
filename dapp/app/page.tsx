"use client";
import type {NextPage} from "next";
import {Box} from "@chakra-ui/react" 
import React from "react";
import { useEffect } from "react";
import { useAccount } from "@/hooks";


const Home: NextPage = () => {
    const { account } = useAccount();
    useEffect(() => console.log(account), [account]);
    
    return <Box>Home</Box>
};

export default Home;