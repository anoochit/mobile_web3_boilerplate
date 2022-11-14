import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WalletController walletController = Get.find<WalletController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Wallet"),
        centerTitle: true,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // wallet address
          Obx(
            () => Center(
              child: Chip(
                label: Text(
                  walletController.getWalletShortFormat(address: walletController.wallet.value),
                ),
              ),
            ),
          ),
          // actions buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.north_east),
                label: const Text("Send"),
              ),
              TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.sync),
                label: const Text("Swap"),
              )
            ],
          ),
        ],
      ),
    );
  }
}
