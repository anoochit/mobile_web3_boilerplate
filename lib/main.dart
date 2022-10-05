import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/app_controller.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';
import 'package:mobile_web3_boilerplate/pages/create_new_wallet.dart';
import 'package:mobile_web3_boilerplate/pages/create_wallet.dart';
import 'package:mobile_web3_boilerplate/pages/home.dart';
import 'package:mobile_web3_boilerplate/pages/import_wallet.dart';
import 'package:mobile_web3_boilerplate/pages/transaction.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

// mnemonic = scale habit artwork bag mail electric demand section evoke cost promote wonder

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppController appController = Get.put(AppController());
  WalletController walletController = Get.put(WalletController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Web3 Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: Scaffold(
        body: FutureBuilder<bool>(
          future: walletController.walletExist(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data) {
                walletController.getWalletData();
                return const HomePage();
              } else {
                return const CreateWalletPage();
              }
            }
            return Container();
          },
        ),
      ),
      routes: {
        '/home': (context) => const HomePage(),
        '/create_wallet': (context) => const CreateWalletPage(),
        '/create_new_wallet': (context) => const CreateNewWalletPage(),
        '/import_wallet': (context) => ImportWalletPage(),
        '/transaction': (context) => Transaction(),
      },
    );
  }
}
