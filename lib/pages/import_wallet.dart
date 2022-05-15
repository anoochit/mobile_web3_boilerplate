import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';
import 'package:mobile_web3_boilerplate/widget/wide_button.dart';
import 'package:ms_undraw/ms_undraw.dart';

class ImportWalletPage extends StatelessWidget {
  ImportWalletPage({Key? key}) : super(key: key);

  final TextEditingController textEditingController = TextEditingController();

  final WalletController walletController = Get.find<WalletController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
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

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: TextFormField(
                controller: textEditingController,
                maxLines: null,
                decoration: const InputDecoration(
                  hintText: 'Enter your mnemonic here!',
                  border: InputBorder.none,
                ),
              ),
            ),
            WideButton(
              text: "Import Wallet",
              onPressed: () async {
                final mnemonic = textEditingController.text.trim();
                if (mnemonic.isNotEmpty) {
                  // import wallet
                  await walletController.createWallet(mnemonic: mnemonic);
                  // goto home page
                  Get.offAllNamed('/home');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
