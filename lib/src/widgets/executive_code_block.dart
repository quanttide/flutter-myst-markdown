import "package:flutter/material.dart";
import "package:provider/provider.dart";
import 'package:flutter_highlight/flutter_highlight.dart';


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
  final String defaultInput;
  final String defaultOutput;
  late TextEditingController textEditingController;

  CodeExecutingController({
    required this.codeExecutingHandler,
    this.defaultInput = '',
    this.defaultOutput = '',
  }) : super(defaultOutput){
    textEditingController = TextEditingController(text: defaultInput);
  }

  Future<void> execute() async {
    value = await codeExecutingHandler(textEditingController.text);
    notifyListeners();
  }
}


/// Widget for executive code block
///
/// ```dart
/// ExecutiveCodeBlock(
///   controller: CodeExecutingController(
///     codeExecutingHandler: mockCodeExecutingHandler,
///     defaultInput: "defaultInput",
///     defaultOutput: "defaultOutput",
///   )
/// )
/// ```
class ExecutiveCodeBlock extends StatelessWidget {
  final CodeExecutingController controller;

  const ExecutiveCodeBlock({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => controller,
      child: Column(
          children: [
            const ExecutiveCodeControlPanel(),
            ExecutiveCodeInput(controller: controller),
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
    return Row(
      children: const [
        ExecutiveCodeOutlinedRunButton()
      ],
    );
  }
}

/// Basic class for run button
class ExecutiveCodeRawMaterialRunButton extends StatelessWidget {
  const ExecutiveCodeRawMaterialRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(onPressed: () => context.read<CodeExecutingController>().execute());
  }
}

/// Run button for executive code block.
/// Placed in the control panel.
class ExecutiveCodeOutlinedRunButton extends ExecutiveCodeRawMaterialRunButton {
  const ExecutiveCodeOutlinedRunButton({super.key});

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
        onPressed: () => context.read<CodeExecutingController>().execute(),
        icon: const Icon(Icons.play_arrow_outlined),
        label: const Text('Run'),
    );
  }
}


/// Show the input of executive code block,
/// allow user to input its code.
class ExecutiveCodeInput extends StatefulWidget {
  final CodeExecutingController controller;

  const ExecutiveCodeInput({
    super.key,
    required this.controller
  });

  @override
  State<StatefulWidget> createState() => ExecutiveCodeInputState();
}

class ExecutiveCodeInputState extends State<ExecutiveCodeInput> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller.textEditingController,
      decoration: const InputDecoration(
        border: InputBorder.none,
      ),
      maxLines: null,
      onSubmitted: (String value) => widget.controller.textEditingController.text = value,
    );
  }

  @override
  void dispose() {
    widget.controller.textEditingController.dispose();
    widget.controller.dispose();
    super.dispose();
  }
}


/// Show the output of executive code block
class ExecutiveCodeOutput extends StatelessWidget {
  const ExecutiveCodeOutput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<CodeExecutingController>(
      builder: (context, controller, child){
        return HighlightView(
          // highlight code
          controller.value,
          // TODO: use arguments
          language: 'python',
        );
      }
    );
  }
}
