import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';

class PasscodeTextField extends StatefulWidget {
  const PasscodeTextField({
    required this.onSubmit,
    Key? key,
    this.digits = 6,
    this.text = '',
    this.focusOnTextReset = true,
  }) : super(key: key);

  final int digits;
  final ValueChanged<String> onSubmit;
  final String text;
  final bool focusOnTextReset;

  @override
  State<PasscodeTextField> createState() => _PasscodeTextFieldState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(IntProperty('digits', digits))
      ..add(ObjectFlagProperty<ValueChanged<String>>.has('onSubmit', onSubmit))
      ..add(StringProperty('text', text))
      ..add(DiagnosticsProperty<bool>('focusOnTextReset', focusOnTextReset));
  }
}

class _PasscodeTextFieldState extends State<PasscodeTextField> {
  late TextEditingController _textController;
  late FocusNode _focusNode;

  BoxDecoration get _pinPutDecoration {
    return BoxDecoration(
      border: Border.all(color: Theme.of(context).colorScheme.secondary),
      borderRadius: BorderRadius.circular(CosmosTheme.of(context).radiusS),
    );
  }

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.text);
    _focusNode = FocusNode();
    _focusNode.requestFocus();
  }

  @override
  void didUpdateWidget(covariant PasscodeTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text == '' && oldWidget.text != widget.text && widget.focusOnTextReset) {
      _focusNode.requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return PinPut(
      focusNode: _focusNode,
      controller: _textController,
      onSubmit: widget.onSubmit,
      onChanged: _onTextChanged,
      fieldsCount: widget.digits,
      submittedFieldDecoration: _pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(20),
      ),
      selectedFieldDecoration: _pinPutDecoration,
      followingFieldDecoration: _pinPutDecoration.copyWith(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.deepPurpleAccent.withOpacity(.5),
        ),
      ),
    );
  }

  void _onTextChanged(String text) {
    // if (text.length >= widget.digits) {
    //   widget.onSubmit(text);
    //   _focusNode.unfocus();
    // }
  }
}
