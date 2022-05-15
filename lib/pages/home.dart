import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';
import 'package:ms_undraw/ms_undraw.dart';

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
        title: const Text("Boilerplate"),
        actions: [
          TextButton(
            onPressed: () {
              log("Goto wallet page");
            },
            child: Obx(
              () => Text(
                walletController.getWalletShortFormat(address: walletController.wallet.value),
              ),
            ),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // image
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: UnDraw(
                width: MediaQuery.of(context).size.width * 0.6,
                illustration: UnDrawIllustration.nature,
                color: Colors.blue,
              ),
            ),

            Text(
              "Boilerplate",
            ),
          ],
        ),
      ),
    );
  }
}
