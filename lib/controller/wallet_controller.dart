import 'dart:developer';

import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'package:ethers/ethers.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:mobile_web3_boilerplate/const.dart';
import 'package:mobile_web3_boilerplate/controller/app_controller.dart';
import 'package:web3dart/web3dart.dart';
import 'package:bip39/bip39.dart' as bip39;
import 'package:dart_bip32_bip44/dart_bip32_bip44.dart';
import 'package:web_socket_channel/io.dart';

class WalletController extends GetxController {
  RxString seed = "".obs;
  RxString wallet = "".obs;

  late String seedHex;
  late Chain chain;
  late ExtendedKey privateKey;
  late EthPrivateKey credentials;

  // encrypted shared preferences
  late EncryptedSharedPreferences encryptedSharedPreferences;

  AppController appController = AppController();

  late Web3Client ethClient;

  WalletController() {
    ethClient = Web3Client(rpcUrl, Client(), socketConnector: () {
      return IOWebSocketChannel.connect(wsUrl).cast<String>();
    });
  }

  // clear wallet data
  walletClear() async {
    encryptedSharedPreferences.clear().then((value) {
      log("Wallet clear");
      wallet.value = '';
      seed.value = '';
      update();
      return true;
    }).catchError((catchError) {
      return false;
    });
  }

  // check wallet exist
  Future<bool> walletExist() async {
    encryptedSharedPreferences = EncryptedSharedPreferences();
    //encryptedSharedPreferences.clear();
    final result = await encryptedSharedPreferences.getString("wallet");
    if (result.isEmpty) {
      log("wallet data - no");
      return false;
    } else {
      log("wallet data - yes");
      return true;
    }
  }

  // create wallet
  createWallet({String? mnemonic}) async {
    mnemonic ??= bip39.generateMnemonic();
    seedHex = bip39.mnemonicToSeedHex(mnemonic);
    chain = Chain.seed(seedHex);
    privateKey = chain.forPath("m/44'/60'/0'/0/0");
    credentials = EthPrivateKey.fromHex(privateKey.privateKeyHex());

    // save to encrypted share preference
    encryptedSharedPreferences = EncryptedSharedPreferences();

    // get wallet address
    credentials.extractAddress().then((address) {
      log('seed = $mnemonic');
      encryptedSharedPreferences.setString("seed", mnemonic!);

      log('address = ${address.hex}');
      encryptedSharedPreferences.setString("wallet", address.hex);

      // update data
      seed.value = mnemonic;
      wallet.value = address.hex;

      update();
    });
  }

  // load wallet data
  Future<void> getWalletData() async {
    walletExist().then((exist) async {
      encryptedSharedPreferences = EncryptedSharedPreferences();
      final wallet = await encryptedSharedPreferences.getString("wallet");
      final seed = await encryptedSharedPreferences.getString("seed");

      // log('get wallet = ${wallet}');
      // log('get seed = ${seed}');

      this.wallet.value = wallet;
      this.seed.value = seed;

      seedHex = bip39.mnemonicToSeedHex(this.seed.value);
      chain = Chain.seed(seedHex);
      privateKey = chain.forPath("m/44'/60'/0'/0/0");
      credentials = EthPrivateKey.fromHex(privateKey.privateKeyHex());

      update();
    });
  }

  // walletShortFormat
  getWalletShortFormat({required String address}) {
    if (address.isNotEmpty) {
      var first = address.substring(0, 5);
      var last = address.substring(address.length - 5, address.length);
      return "$first...$last";
    } else {
      return "";
    }
  }

  // get coin balance
  Future<EtherAmount> getCoinBalance() async {
    return await ethClient.getBalance(credentials.address);
  }

  // get coin balance stream
  Stream<EtherAmount> getCoinBalanceStream() async* {
    while (true) {
      await Future.delayed(const Duration(seconds: 5));
      EtherAmount balance = await getCoinBalance();
      yield balance;
    }
  }

  // send coin
  Future<String> sendCoin({required String to, required String amount}) async {
    final result = await ethClient.sendTransaction(
      credentials,
      Transaction(
        to: EthereumAddress.fromHex(to),
        gasPrice: EtherAmount.inWei(BigInt.one),
        maxGas: 100000,
        value: EtherAmount.fromUnitAndValue(EtherUnit.wei, ethers.utils.parseEther(amount)),
      ),
    );

    log('transaction result = $result ');

    return result;
  }
}
