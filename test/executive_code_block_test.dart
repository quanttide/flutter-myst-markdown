import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import 'mock.dart';


void main(){
  group('CodeExecutingController', (){
    // https://docs.flutter.dev/development/data-and-backend/state-mgmt/simple#changenotifier
    test('CodeExecutingController.init', (){
      final controller = CodeExecutingController(
        codeExecutingHandler: mockCodeExecutingHandler,
        defaultInput: "defaultInput",
        defaultOutput: "defaultOutput"
      );
      expect(controller.value, "defaultOutput");
    });
    test('CodeExecutingController.execute', (){
      final controller = CodeExecutingController(
          codeExecutingHandler: mockCodeExecutingHandler,
          defaultInput: "defaultInput",
          defaultOutput: "defaultOutput"
      );
      String input = "print('Hello, world')";
      controller.addListener(() {
        expect(controller.value, input);
      });
      controller.textEditingController.text = input;
      controller.execute();
    });
  });
  group('ExecutiveCodeOutput', () {
    test('ExecutiveCodeOutput.init', () {

    });
  });
}