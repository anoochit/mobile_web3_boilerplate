import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mobile_web3_boilerplate/const.dart';
import 'package:mobile_web3_boilerplate/generated/faucet.g.dart';
import 'package:web3dart/web3dart.dart';

class FaucetContractController extends GetxController {
  // faucet contract
  late String abiCode;
  late DeployedContract contract;
  late ContractFunction withdrawFunction;

  final String faucetContractAddress = "0x0e664eaB0463697c4712D062E852E3c6c9c798dd";
  late EthereumAddress contractAddr;
  late Faucet faucet;

  FaucetContractController() {
    readFaucetContract();
  }

  readFaucetContract() async {
    // get abi
    abiCode = await rootBundle.loadString('lib/generated/faucet.abi.json');

    // get contract
    contractAddr = EthereumAddress.fromHex(faucetContractAddress);
    contract = DeployedContract(ContractAbi.fromJson(abiCode, 'Faucet'), contractAddr);

    // set contract function
    //withdrawFunction = contract.function('withdraw');

    // connect to contract
    final Web3Client ethClient = Web3Client(rpcUrl, Client());
    faucet = Faucet(address: contractAddr, client: ethClient);

    // listen for event
    // faucet.withdrawalEvents().take(1).listen((event) {
    //   log('Sent 1 ETH to ${event.to}');
    // });
  }

  Future<String> callFaucetWithdraw({required Credentials credentials}) async {
    try {
      String result = await faucet.withdraw(credentials: credentials);
      log('transaction result = $result');
      return result;
    } catch (e) {
      log('transaction result = $e');
      return '$e';
    }
  }
}
