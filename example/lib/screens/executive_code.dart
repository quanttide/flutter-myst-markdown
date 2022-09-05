import "package:flutter/material.dart";
import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import '../mock.dart';

class ExecutiveCodeScreen extends StatelessWidget {
  const ExecutiveCodeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return ExecutiveCodeBlock(
      controller: CodeExecutingController(
        codeExecutingHandler: mockCodeExecutingHandler,
        defaultInput: 'print("hello world")',
        defaultOutput: 'hello, world',
      ),
    );
  }
}