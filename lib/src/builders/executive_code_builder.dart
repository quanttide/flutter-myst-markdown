/// Ref：
///   - API: https://pub.dev/documentation/flutter_markdown/latest/flutter_markdown/MarkdownElementBuilder/visitElementAfter.html
///   - Example: https://github.com/flutter/packages/blob/main/packages/flutter_markdown/example/lib/demos/subscript_syntax_demo.dart#L147


import "package:flutter/material.dart";
import "package:markdown/markdown.dart" as md;
import "package:flutter_markdown/flutter_markdown.dart";
import 'package:flutter_highlight/flutter_highlight.dart';


/// MarkdownElementBuilder for Executive Code
///
/// ```dart
/// Markdown(
///   builders: {
///     'code-cell': ExecutiveCodeBuilder(),
///   }
/// )
/// ```
///
/// where `Markdown` can be replaced by `MarkdownBody` or `MarkdownBuilder`.
///
class ExecutiveCodeBuilder extends MarkdownElementBuilder {
  final Function codeExecutingHandler;

  ExecutiveCodeBuilder({
    required this.codeExecutingHandler
  });

  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // input
    String input = element.textContent;
    // run code and render result
    return build(input);
  }

  /// build layout
  Widget build(String input){
    return Column(
        children: [
          buildInput(input),
          buildOutput(input),
        ]
    );
  }

  /// build input widget
  Widget buildInput(String input){
    return HighlightView(
      // 代码高亮
      input,
      language: 'python',  // TODO: use arguments set by user
    );
  }

  /// build output widget
  Widget buildOutput(String input) {
    return FutureBuilder(
      future: codeExecutingHandler(input),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        switch (snapshot.connectionState){
          case ConnectionState.none:
          // 初始
            return buildOutputNone(context);
          case ConnectionState.waiting:
          // 加载
            return buildOutputWaiting(context);
          default:
          // 异常
            if (snapshot.hasError){
              return buildOutputWithError(context, snapshot.error);
            }
            // 正常
            return buildOutputWithData(context, snapshot.data);
        }
      },
    );
  }

  /// build output withData
  Widget buildOutputWithData(BuildContext context,String output){
    return HighlightView(
      // highlight code
      output,
      language: 'python',  // TODO: use arguments set by user
    );
  }

  /// build output none
  Widget buildOutputNone(BuildContext context){
    return const Text('');

  }

  /// build output waiting
  Widget buildOutputWaiting(BuildContext context){
    return const LinearProgressIndicator();
  }

  /// build error
  Widget buildOutputWithError(BuildContext context, dynamic error){
    return Center(child: ErrorWidget(error));
  }
}