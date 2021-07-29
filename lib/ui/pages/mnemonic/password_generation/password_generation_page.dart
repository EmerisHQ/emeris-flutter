import 'package:flutter/material.dart';
import 'package:flutter_app/dependency_injection/app_component.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_initial_params.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_navigator.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_presentation_model.dart';
import 'package:flutter_app/ui/pages/mnemonic/password_generation/password_generation_presenter.dart';
import 'package:flutter_app/utils/strings.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

class PasswordGenerationPage extends StatefulWidget {
  final PasswordGenerationInitialParams initialParams;
  final PasswordGenerationPresenter? presenter;

  const PasswordGenerationPage({
    Key? key,
    required this.initialParams,
    this.presenter, // useful for tests
  }) : super(key: key);

  @override
  _PasswordGenerationPageState createState() => _PasswordGenerationPageState();
}

class _PasswordGenerationPageState extends State<PasswordGenerationPage> {
  late PasswordGenerationPresenter presenter;

  PasswordGenerationViewModel get model => presenter.viewModel;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    presenter = widget.presenter ??
        getIt(
          param1: PasswordGenerationPresentationModel(widget.initialParams),
          param2: getIt<PasswordGenerationNavigator>(),
        );
    presenter.navigator.context = context;
    _passwordController.addListener(() => presenter.passwordChanged(_passwordController.text));
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(strings.passwordGeneration),
      ),
      body: Observer(
        builder: (context) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: TextFormField(
                  obscureText: model.isPasswordVisible,
                  controller: _passwordController,
                  decoration: InputDecoration(
                    hintText: strings.enterPassword,
                    helperText: strings.passwordHelperText,
                    helperMaxLines: 3,
                    suffixIcon: InkWell(
                      onTap: presenter.togglePasswordVisibilityClicked,
                      child: Icon(model.isPasswordVisible ? Icons.visibility : Icons.visibility_off),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: presenter.importWalletClicked,
        child: const Icon(Icons.arrow_forward),
      ),
    );
  }
}
