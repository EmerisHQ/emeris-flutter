import 'package:flutter/material.dart';
import 'package:flutter_app/utils/strings.dart';

class SendMoney extends StatefulWidget {
  final String denom;
  final Function(String, String) onMoneySend;

  const SendMoney({
    Key? key,
    required this.denom,
    required this.onMoneySend,
  }) : super(key: key);

  @override
  _SendMoneyState createState() => _SendMoneyState();
}

class _SendMoneyState extends State<SendMoney> {
  String _toAddress = '';
  String _amount = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Padding(padding: EdgeInsets.only(top: 16)),
        Text(
          strings.sendDenom(widget.denom),
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
            widget.onMoneySend(_amount, _toAddress);
          },
          style: ElevatedButton.styleFrom(
            shape: const StadiumBorder(),
          ),
          child: Text(strings.sendMoney),
        ),
      ],
    );
  }
}
