import "package:flutter/material.dart";


/// Widget for executive code block
class ExecutiveCodeBlock extends StatelessWidget {
  final String? defaultInput;

  const ExecutiveCodeBlock({
    super.key,
    this.defaultInput
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const ExecutiveCodeControlPanel(),
        ExecutiveCodeInput(defaultInput: defaultInput),
        const ExecutiveCodeOutput(),
      ]
    );
  }
}


/// Control panel for executive code block.
/// Users can control the running of the code.
class ExecutiveCodeControlPanel extends StatelessWidget {
  const ExecutiveCodeControlPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text('');
  }

}


/// Show the input of executive code block,
/// allow user to input its code.
class ExecutiveCodeInput extends StatefulWidget {
  final String? defaultInput;

  const ExecutiveCodeInput({
    super.key,
    this.defaultInput
  });

  @override
  State<StatefulWidget> createState() => ExecutiveCodeInputState();

}

class ExecutiveCodeInputState extends State<ExecutiveCodeInput> {
  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}


/// Show the output of executive code block
class ExecutiveCodeOutput extends StatefulWidget {
  const ExecutiveCodeOutput({super.key});

  @override
  State<StatefulWidget> createState() => ExecutiveCodeOutputState();
}

class ExecutiveCodeOutputState extends State<ExecutiveCodeOutput>{
  @override
  Widget build(BuildContext context) {
    return const Text('');
  }
}
