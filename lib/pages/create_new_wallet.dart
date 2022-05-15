import 'dart:developer';

import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';
import 'package:mobile_web3_boilerplate/widget/wide_button.dart';
import 'package:ms_undraw/ms_undraw.dart';

class CreateNewWalletPage extends StatefulWidget {
  const CreateNewWalletPage({Key? key}) : super(key: key);

  @override
  State<CreateNewWalletPage> createState() => _CreateNewWalletPageState();
}

class _CreateNewWalletPageState extends State<CreateNewWalletPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WalletController>(
          init: WalletController(),
          builder: (walletController) {
            return Center(
                child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // image
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: UnDraw(
                    width: MediaQuery.of(context).size.width * 0.6,
                    illustration: UnDrawIllustration.wallet,
                    color: Colors.blue,
                  ),
                ),

                // action button

                (walletController.wallet.value.isNotEmpty)
                    ? Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(walletController.seed.value),
                      )
                    : Container(),
                (walletController.wallet.value.isNotEmpty)
                    ? WideButton(
                        text: "Copy your seed to clipboard, and exit",
                        onPressed: () {
                          FlutterClipboard.copy(walletController.seed.value).then((value) {
                            Get.snackbar("Copied", "Copied seed words to clipboard");
                          });
                        },
                      )
                    : Container(),
                (walletController.wallet.value.isEmpty)
                    ? WideButton(
                        text: "Create new wallet",
                        onPressed: () {
                          walletController.createWallet();
                        },
                      )
                    : Container(),
              ],
            ));
          }),
    );
  }
}
