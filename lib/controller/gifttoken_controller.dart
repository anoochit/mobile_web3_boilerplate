import 'package:ethers/ethers.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mobile_web3_boilerplate/const.dart';
import 'package:mobile_web3_boilerplate/generated/gift.g.dart';
import 'package:web3dart/web3dart.dart';
import 'package:web_socket_channel/io.dart';

class GiftTokenController extends GetxController {
  // gift contract
  late String abiCode;
  late DeployedContract contract;

  final String giftContractAddress = "0xE557638C01f783b9124A5F354bC256229f1ea431";
  late EthereumAddress contractAddr;
  late Gift gift;
  late Web3Client ethClient;

  GiftTokenController() {
    readContract();
  }

  readContract() async {
    // get abi
    abiCode = await rootBundle.loadString('lib/generated/gift.abi.json');

    // get contract
    contractAddr = EthereumAddress.fromHex(giftContractAddress);
    contract = DeployedContract(ContractAbi.fromJson(abiCode, 'Gift'), contractAddr);

    // connect to contract
    //ethClient = Web3Client(rpcUrl, Client());
    ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
    gift = Gift(address: contractAddr, client: ethClient);
  }

  Future<BigInt> callBalanceOf({required String address}) async {
    return await gift.balanceOf(EthereumAddress.fromHex(address));
  }

  // get coin balance stream
  Stream<BigInt> getGiftBalanceStream({required String address}) async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      BigInt balance = await callBalanceOf(address: address);
      yield balance;
    }
  }

  Future<String> callApprove(EthereumAddress spender, Credentials credentials, String amount) async {
    return await gift.approve(
      spender,
      ethers.utils.parseEther(amount),
      credentials: credentials,
    );
  }

  Future<String> callSendGift({
    required EthereumAddress to,
    required Credentials credentials,
    required String amount,
  }) async {
    return gift.transfer(to, ethers.utils.parseEther(amount), credentials: credentials);
  }
}
