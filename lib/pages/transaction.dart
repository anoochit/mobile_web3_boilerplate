import 'package:flutter/material.dart';

class Transaction extends StatelessWidget {
  Transaction({Key? key}) : super(key: key);

  String? coinName;

  String? symbol;

  double? balance;

  String? walletAddress;

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments
        as Map; //all the parameters are extracted through here

    coinName = args['coinName'];
    balance = args['balance'];
    symbol = args['symbol'];
    walletAddress = args['walletAddress'];

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Hero(
            tag: coinName.toString(),
            child: Text(
              coinName.toString(),
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            const SizedBox(height: 50),
            Center(
              child: Text(
                '${balance.toString()} $symbol',
                style: const TextStyle(
                  fontSize: 50,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Center(
              child: Text(
                walletAddress.toString(),
              ),
            ),
            const SizedBox(height: 50),
            SizedBox(
              height: 50,
              child: AppBar(
                bottom: TabBar(
                  tabs: [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Assets', style: TextStyle(color: Colors.black)),
                          Icon(Icons.attach_money, color: Colors.black),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text('Activity',
                              style: TextStyle(color: Colors.black)),
                          Icon(Icons.timeline_sharp, color: Colors.black),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            //widgets for each tab can be modified here
            const Expanded(
              child: TabBarView(
                children: [
                  // first tab bar view widget
                  Center(
                    child: Text(
                      'Assets',
                    ),
                  ),
                  // second tab bar view widget
                  Center(
                    child: Text(
                      'Activity',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
