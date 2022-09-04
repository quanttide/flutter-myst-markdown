import "package:flutter/material.dart";
import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';


class ExecutiveCodeScreen extends StatelessWidget {
  const ExecutiveCodeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return const ExecutiveCodeInput(defaultInput: 'print("hello world")');
  }
}