import 'package:ethers/ethers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mobile_web3_boilerplate/const.dart';
import 'package:mobile_web3_boilerplate/generated/swap.g.dart';
import 'package:web3dart/web3dart.dart';

class SwapTokenController extends GetxController {
  // faucet contract
  late String abiCode;
  late DeployedContract contract;

  final String swapContractAddress = "0x824724e43F3268a5E4f6c529e724Bc1Ad535044A";
  late EthereumAddress contractAddr;
  late Swap swap;

  late Web3Client ethClient;

  late ContractFunction buyTokenFunction;

  SwapTokenController() {
    readContract();
  }

  readContract() async {
    // get abi
    abiCode = await rootBundle.loadString('lib/generated/swap.abi.json');

    // get contract
    contractAddr = EthereumAddress.fromHex(swapContractAddress);
    contract = DeployedContract(ContractAbi.fromJson(abiCode, 'Swap'), contractAddr);

    buyTokenFunction = contract.function('buyToken');

    // connect to contract
    ethClient = Web3Client(rpcUrl, Client());
    swap = Swap(address: contractAddr, client: ethClient);
  }

  Future<BigInt> callCoinSupply() async {
    return await swap.coinSupply();
  }

  Future<BigInt> callTokenSupply() async {
    return await swap.tokenSupply();
  }

  Future<String> callBuyToken({required Credentials credentials, required String amount}) async {
    return await swap.buyToken(
      credentials: credentials,
      transaction: Transaction(
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, ethers.utils.parseEther(amount)),
      ),
    );
  }

  Future<String> callSellToken({required Credentials credentials, required String amount}) async {
    return await swap.sellToken(
      ethers.utils.parseEther(amount),
      credentials: credentials,
    );
  }
}
