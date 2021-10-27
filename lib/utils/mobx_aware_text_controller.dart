import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

class MobxAwareTextController extends TextEditingController {
  MobxAwareTextController({required String Function() listenTo}) : super(text: listenTo()) {
    reaction<String>(
      (_) => listenTo(),
      (newText) {
        if (newText != text) {
          text = newText;
        }
      },
    );
  }
}
