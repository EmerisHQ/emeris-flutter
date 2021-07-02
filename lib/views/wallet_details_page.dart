import 'package:flutter/material.dart';
import 'package:flutter_app/data/api_calls/base_wallet_api.dart';
import 'package:flutter_app/data/model/emeris_wallet.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/domain/entities/balance.dart';
import 'package:flutter_app/domain/entities/paginated_list.dart';
import 'package:flutter_app/global.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/strings.dart';

class WalletDetailsPage extends StatefulWidget {
  final EmerisWallet wallet;
  final String alias;

  const WalletDetailsPage({
    required this.wallet,
    required this.alias,
  });

  @override
  _WalletDetailsPageState createState() => _WalletDetailsPageState();
}

class _WalletDetailsPageState extends State<WalletDetailsPage> {
  PaginatedList<Balance>? model;
  bool _isSendMoneyLoading = false;
  bool _isLoading = false;
  String _amount = '';
  String _toAddress = '';

  List<Widget> icons = const [
    Icon(Icons.wifi_tethering),
    Icon(Icons.workspaces_filled),
    Icon(Icons.workspaces_filled),
  ];

  String _errorText = '';

  BaseWalletApi? api;

  @override
  void initState() {
    super.initState();
    _fetchWalletDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          strings.walletDetailsTitle(widget.alias),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            title: Text(strings.walletAddress),
            subtitle: Text(widget.wallet.walletDetails.walletAddress),
          ),
          const Divider(),
          const Padding(padding: EdgeInsets.only(top: 16)),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            child: Row(
              children: [
                Text(
                  strings.balances,
                  textAlign: TextAlign.start,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                      color: widget.wallet.walletType == WalletType.Eth ? Colors.deepPurple : Colors.blueGrey,
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    widget.wallet.walletType.toString().split('.')[1],
                    style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                  ),
                )
              ],
            ),
          ),
          if (_isLoading)
            const Center(child: CircularProgressIndicator())
          else
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: model!.list.map((e) => _buildCard(e, context)).toList(),
              ),
            ),
          if (_isSendMoneyLoading)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                child: Text(
                  strings.sendingMoney,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          if (_errorText.isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Center(
                  child: Text(
                _errorText,
                textAlign: TextAlign.center,
              )),
            ),
        ],
      ),
    );
  }

  Card _buildCard(Balance e, BuildContext context) {
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text(e.denom.text),
        subtitle: Text(e.amount.displayText),
        leading: icons[model!.list.indexOf(
          model!.list.firstWhere((element) => element == e),
        )],
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          onPressed: _isSendMoneyLoading
              ? null
              : () async {
                  await showMoneyTransferBottomSheet(context, e);
                },
          child: Text(strings.transfer),
        ),
      ),
    );
  }

  Future showMoneyTransferBottomSheet(BuildContext context, Balance e) async {
    showModalBottomSheet(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(padding: EdgeInsets.only(top: 16)),
            Text(
              strings.sendDenom(e.denom),
              style: Theme.of(context).textTheme.headline6,
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: strings.enterWalletAddress,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _toAddress = value;
                },
              ),
            ),
            ListTile(
              title: TextFormField(
                decoration: InputDecoration(
                  labelText: strings.enterAmount,
                  border: const OutlineInputBorder(),
                ),
                onChanged: (value) {
                  _amount = value;
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _sendMoney(e);
              },
              style: ElevatedButton.styleFrom(
                shape: const StadiumBorder(),
              ),
              child: Text(strings.sendMoney),
            ),
          ],
        ),
      ),
    );
  }

  Future _sendMoney(Balance e) async {
    _isSendMoneyLoading = true;
    setState(() {});
    try {
      api = widget.wallet.walletType == WalletType.Cosmos ? cosmosApi : ethApi;
      await api!.sendAmount(
        denom: e.denom.text,
        amount: _amount,
        toAddress: _toAddress,
        fromAddress: widget.wallet.walletDetails.walletAddress,
      );
      await Future.delayed(const Duration(seconds: 2));
      _fetchWalletDetails();
      _isSendMoneyLoading = false;
      setState(() {});
    } catch (ex) {
      _isSendMoneyLoading = false;
      _errorText = ex.toString();
      setState(() {});
    }
  }

  Future<void> _fetchWalletDetails() async {
    _isLoading = true;
    setState(() {});
    final api = widget.wallet.walletType == WalletType.Cosmos ? cosmosApi : ethApi;
    final response = await api.getWalletBalances(widget.wallet.walletDetails.walletAddress);
    model = response;
    _isLoading = false;
    setState(() {});
  }
}

abstract class WalletDetailsRoute {
  BuildContext get context;

  AppNavigator get appNavigator;

  factory WalletDetailsRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> openWalletDetails(EmerisWallet wallet) => appNavigator.push(
        context,
        materialRoute(WalletDetailsPage(wallet: wallet, alias: wallet.walletDetails.walletAlias)),
      );
}
