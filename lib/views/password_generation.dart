import 'package:flutter/material.dart';
import 'package:flutter_app/data/model/wallet_type.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/domain/entities/import_wallet_form_data.dart';
import 'package:flutter_app/domain/use_cases/import_wallet_use_case.dart';
import 'package:flutter_app/presentation/wallets_list/wallets_list_initial_params.dart';
import 'package:flutter_app/ui/pages/wallets_list/wallets_list_page.dart';
import 'package:flutter_app/utils/strings.dart';

class PasswordGenerationPage extends StatefulWidget {
  final String mnemonic;

  const PasswordGenerationPage({required this.mnemonic});

  @override
  _PasswordGenerationPageState createState() => _PasswordGenerationPageState();
}

class _PasswordGenerationPageState extends State<PasswordGenerationPage> {
  bool isPasswordVisible = true;
  IconData visibility = Icons.visibility;
  IconData invisibility = Icons.visibility_off;

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.passwordGeneration),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: TextFormField(
                obscureText: isPasswordVisible,
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: strings.enterPassword,
                  helperText: strings.passwordHelperText,
                  helperMaxLines: 3,
                  suffixIcon: InkWell(
                    onTap: () {
                      isPasswordVisible = !isPasswordVisible;
                      setState(() {});
                    },
                    child: Icon(isPasswordVisible ? visibility : invisibility),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await getIt<ImportWalletUseCase>().execute(
              walletFormData: ImportWalletFormData(
            mnemonic: widget.mnemonic,
            name: "First wallet",
            password: passwordController.text,
            walletType: WalletType.Cosmos,
          ));
          await getIt<ImportWalletUseCase>().execute(
              walletFormData: ImportWalletFormData(
            mnemonic: widget.mnemonic,
            name: "Another wallet",
            password: passwordController.text,
            walletType: WalletType.Eth,
          ));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const WalletsListPage(initialParams: WalletsListInitialParams()),
            ),
          );
        },
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
