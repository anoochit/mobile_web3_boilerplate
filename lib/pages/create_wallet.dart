import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/widget/wide_button.dart';
import 'package:ms_undraw/ms_undraw.dart';

class CreateWalletPage extends StatefulWidget {
  const CreateWalletPage({Key? key}) : super(key: key);

  @override
  State<CreateWalletPage> createState() => _CreateWalletPageState();
}

class _CreateWalletPageState extends State<CreateWalletPage> {
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
                illustration: UnDrawIllustration.digital_currency,
                color: Colors.blue,
              ),
            ),

            WideButton(
              text: "Create New Wallet",
              onPressed: () {
                Get.toNamed('/create_new_wallet');
              },
            ),
            WideButton(
              text: "Import Wallet",
              onPressed: () {
                Get.toNamed('/import_wallet');
              },
            ),
          ],
        ),
      ),
    );
  }
}
