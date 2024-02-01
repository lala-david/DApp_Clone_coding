import { MINT_GEM_TOKEN_ADDRESS } from "@/caverConfig";
import { useAccount, useCaver } from "@/hooks";
import {
  Button,
  Modal,
  ModalBody,
  ModalCloseButton,
  ModalContent,
  ModalFooter,
  ModalHeader,
  ModalOverlay,
  Text,
  useDisclosure,
} from "@chakra-ui/react";
import { FC } from "react";

interface MintingModalProps {
  isOpen: boolean;
  onClose: () => void;
}

const MintingModal: FC<MintingModalProps> = ({ isOpen, onClose }) => {

    const {account} = useAccount();
    const {caver, mintGemTokenContract} = useCaver();

    const onClickMint = async () => {
        try{
            if(!account || !caver || !mintGemTokenContract) return;
            const response = await caver.ethereum.sendTransaction({
                type: "SMART_CONTRACT_EXECUTION",
                from: account,
                to: MINT_GEM_TOKEN_ADDRESS,
                value: caver.utils.converToPeb(0.001, "ETH"),
                gas:"300000",
                data: mintGemTokenContract.methods.mintGemToken().encodeABI(),
            })

        }catch(error){
            console.error(error);
        }
    }

  return (
    <Modal isOpen={isOpen} onClose={onClose}>
      <ModalOverlay />
      <ModalContent>
        <ModalHeader>Minting</ModalHeader>
        <ModalCloseButton />
        <ModalBody>
            <Text>Do you want to minting?</Text>
            <Text>(💵 0.1 ETH is consumed.)</Text>
        </ModalBody>

        <ModalFooter>
        <Button variant="ghost" colorScheme="pink">Minting</Button>
          <Button ml={2} mr={3} onClick={onClose}>
            Close
          </Button>
        </ModalFooter>
      </ModalContent>
    </Modal>
  );
};

export default MintingModal;
