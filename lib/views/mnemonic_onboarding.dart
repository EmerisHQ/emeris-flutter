import 'package:flutter/material.dart';
import 'package:flutter_app/helpers/mnemonic_generator.dart';
import 'package:flutter_app/navigation/app_navigator.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_app/views/password_generation.dart';

abstract class MnemonicOnboardingRoute {
  AppNavigator get appNavigator;

  BuildContext get context;

  factory MnemonicOnboardingRoute._() => throw UnsupportedError("This class is meant to be mixed in");

  Future<void> openMnemonicOnboarding() async => appNavigator.push(context, materialRoute(MnemonicOnboarding()));
}

class MnemonicOnboarding extends StatefulWidget {
  @override
  _MnemonicOnboardingState createState() => _MnemonicOnboardingState();
}

class _MnemonicOnboardingState extends State<MnemonicOnboarding> {
  String mnemonic = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: mnemonic.isNotEmpty
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GridView.count(
                        crossAxisCount: (MediaQuery.of(context).size.width * 0.005).ceil(),
                        shrinkWrap: true,
                        childAspectRatio: 5,
                        children: mnemonic
                            .split(' ')
                            .map(
                              (e) => buildChoiceChip(e, context),
                            )
                            .toList(),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        strings.mnemonicHelperText,
                        textAlign: TextAlign.center,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PasswordGenerationPage(mnemonic: mnemonic),
                            ),
                          );
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(strings.proceed),
                            const SizedBox(width: 4),
                            const Icon(Icons.arrow_forward),
                          ],
                        ),
                      )
                    ],
                  )
                : ElevatedButton(
                    onPressed: () {
                      mnemonic = MnemonicGenerator.generateMnemonic();
                      setState(() {});
                    },
                    child: Text(strings.createNewWallet),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildChoiceChip(String e, BuildContext context) {
    return ChoiceChip(
      label: Text(e),
      selected: true,
      avatar: CircleAvatar(
        backgroundColor: Theme.of(context).primaryColorLight,
        child: Text(
          (mnemonic.split(' ').indexOf(e) + 1).toString(),
          style: const TextStyle(fontSize: 12),
        ),
      ),
      labelStyle: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
      selectedColor: Theme.of(context).primaryColorDark,
    );
  }
}
