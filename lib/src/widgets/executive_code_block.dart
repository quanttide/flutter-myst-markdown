import "package:flutter/material.dart";
import "package:provider/provider.dart";


/// Controller for executive code block
///
/// ```dart
/// controller = CodeExecutingController(
///   codeExecutingHandler: mockFunc,
/// )
/// ```
///
/// ref:
///   - https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple#changenotifier
///   - https://api.flutter.dev/flutter/foundation/ValueNotifier-class.html
///   - https://github.com/flutter/plugins/blob/main/packages/video_player/video_player/lib/video_player.dart
class CodeExecutingController extends ValueNotifier<String> {
  final Function codeExecutingHandler;
  final String defaultOutput;

  CodeExecutingController({
    required this.codeExecutingHandler,
    this.defaultOutput = ''
  }) : super(defaultOutput);

  Future<void> execute(String input) async {
    value = await codeExecutingHandler(input);
    notifyListeners();
  }
}


/// Widget for executive code block
class ExecutiveCodeBlock extends StatelessWidget {
  final CodeExecutingController codeExecutingController;
  final String? defaultInput;

  const ExecutiveCodeBlock({
    super.key,
    required this.codeExecutingController,
    this.defaultInput
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => codeExecutingController,
      child: Column(
          children: [
            const ExecutiveCodeControlPanel(),
            ExecutiveCodeInput(defaultInput: defaultInput),
            const ExecutiveCodeOutput(),
          ]
      )
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
class ExecutiveCodeInput extends StatelessWidget {
  final String? defaultInput;

  const ExecutiveCodeInput({
    super.key,
    this.defaultInput
  });

  @override
  Widget build(BuildContext context) {
    return EditableText(
      controller: TextEditingController(text: defaultInput),
      focusNode: FocusNode(),
      style: const TextStyle(),
      cursorColor: Colors.green,
      backgroundCursorColor: Colors.blue,
      maxLines: null,  // default is 1
    );
  }
}


/// Show the output of executive code block
class ExecutiveCodeOutput extends StatelessWidget {
  const ExecutiveCodeOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutingController>(
      builder: (context, controller, child){
        return const Text('');
      }
    );
  }
}
