import "package:flutter/material.dart";
import "package:markdown/markdown.dart" as md;
import "package:flutter_markdown/flutter_markdown.dart";


/// 抽象类
abstract class ExecutiveCodeBlockBuilder extends MarkdownElementBuilder {

  /// 运行输入得到输出并渲染
  ///
  /// 参考资料：
  ///   - API文档：https://pub.dev/documentation/flutter_markdown/latest/flutter_markdown/MarkdownElementBuilder/visitElementAfter.html
  ///   - 样例：https://github.com/flutter/packages/blob/main/packages/flutter_markdown/example/lib/demos/subscript_syntax_demo.dart#L147
  @override
  Widget? visitElementAfter(md.Element element, TextStyle? preferredStyle) {
    // 输入
    String input = element.textContent;
    // 运行和渲染输出
    return buildExecutiveCodeBlock(input);
  }

  /// 渲染输入组件和输出组件的布局
  Widget buildExecutiveCodeBlock(String input);

  /// 渲染输入组件
  Widget buildInput(String input);

  /// 渲染输出组件
  Widget buildOutput(BuildContext context, AsyncSnapshot<dynamic> snapshot) {
    switch (snapshot.connectionState){
      case ConnectionState.none:
      // 初始
        return buildOutputNone();
      case ConnectionState.waiting:
      // 加载
        return buildOutputWaiting();
      default:
      // 异常
        if (snapshot.hasError){
          return buildOutputWithError(snapshot.error);
        }
        // 正常
        return buildOutputWithData(snapshot.data);
    }
  }

  /// 渲染正常输出
  Widget buildOutputWithData(String output);

  /// 渲染初始状态
  Widget buildOutputNone();

  /// 渲染加载状态
  Widget buildOutputWaiting();

  /// 渲染异常输出
  Widget buildOutputWithError(dynamic error);

}