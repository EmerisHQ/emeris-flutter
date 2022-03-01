import 'package:cosmos_ui_components/cosmos_ui_components.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/ui/pages/send_tokens/send_tokens_form_step.dart';

class SendTokensWizardForm extends StatefulWidget {
  const SendTokensWizardForm({
    required this.step,
    required this.steps,
    Key? key,
  })  : assert(
          steps.length == SendTokensFormStep.values.length,
          'you have to specify as many steps as there are values in SendTokensFormStep',
        ),
        super(key: key);

  final List<Widget> steps;

  // ignore: diagnostic_describe_all_properties
  final SendTokensFormStep step;

  @override
  State<SendTokensWizardForm> createState() => _SendTokensWizardFormState();
}

class _SendTokensWizardFormState extends State<SendTokensWizardForm> {
  late PageController _controller;

  @override
  void initState() {
    super.initState();
    _controller = PageController(initialPage: widget.step.index);
  }

  @override
  void didUpdateWidget(covariant SendTokensWizardForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.step != widget.step) {
      _controller.animateToPage(
        widget.step.index,
        duration: const ShortDuration(),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _controller,
      physics: const NeverScrollableScrollPhysics(),
      children: widget.steps,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<SendTokensFormStep>('step', widget.step));
  }
}
