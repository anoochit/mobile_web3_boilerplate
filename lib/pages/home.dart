import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile_web3_boilerplate/controller/wallet_controller.dart';
import 'package:mobile_web3_boilerplate/data/networks_list.dart';
import 'package:ms_undraw/ms_undraw.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  WalletController walletController = Get.find<WalletController>();
  List<Map<String, String>> coins = networks;

  //function to update the list of the coins every time user changes the query in search box
  void filterList(String query) {
    coins = networks;
    if (query.isNotEmpty) {
      List<Map<String, String>> temp = [];
      for (var coin in coins) {
        {
          if (coin['name']!.toLowerCase().contains(query.toLowerCase()) ==
              true) {
            temp.add(coin);
          }
        }
      }

      coins = temp;
    }
  }

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
                walletController.getWalletShortFormat(
                    address: walletController.wallet.value),
              ),
            ),
          )
        ],
      ),
      // body: Center(
      //   child: Column(
      //     mainAxisSize: MainAxisSize.min,
      //     children: [
      //       // image
      //       Padding(
      //         padding: const EdgeInsets.all(16.0),
      //         child: UnDraw(
      //           width: MediaQuery.of(context).size.width * 0.6,
      //           illustration: UnDrawIllustration.nature,
      //           color: Colors.green,
      //         ),
      //       ),
      //       const Text(
      //         "Boilerplate",
      //       ),
      //     ],
      //   ),
      // ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        children: [
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black, width: 2),
              borderRadius: BorderRadius.circular(15),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: TextField(
              //search box
              decoration: const InputDecoration(
                labelText: 'Search coin',
                contentPadding: EdgeInsets.symmetric(vertical: 0),
                border: InputBorder.none,
                errorBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                floatingLabelBehavior: FloatingLabelBehavior.never,
              ),
              onChanged: (query) {
                filterList(query);
                setState(() {});
              },
            ),
          ),
          //list of all the coin networks
          ListView.builder(
            shrinkWrap: true,
            physics: const BouncingScrollPhysics(),
            itemCount: coins.length,
            itemBuilder: (context, index) => Material(
              child: ListTile(
                onTap: () {
                  //pass all the required arguments related to a particular network through here
                  Navigator.of(context).pushNamed('/transaction', arguments: {
                    'coinName': coins[index]['name'],
                    'balance': 100.0,
                    'symbol': coins[index]['symbol'],
                    'walletAddress': walletController.getWalletShortFormat(
                        address: walletController.wallet.value),
                  });
                },
                style: ListTileStyle.drawer,
                dense: true,
                //each list item
                title: Row(
                  children: [
                    Expanded(
                      child: Hero(
                        tag: coins[index]['name'].toString(),
                        child: Text(
                          coins[index]['name'].toString(),
                          style: const TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      coins[index]['symbol'].toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
