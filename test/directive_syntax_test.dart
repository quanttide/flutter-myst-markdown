import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import 'utils.dart';


class CustomDirectiveSyntax extends DirectiveSyntax {
  @override
  String get directiveName => 'directive-name';
}


void main(){
  CustomDirectiveSyntax syntax = CustomDirectiveSyntax();

  String exampleMarkdownString = """
```{directive-name} arguments
line 1
line 2
```
""";

  group('DirectiveSyntax.pattern property', (){
    test('Common example', (){
      String directiveSyntaxLine = "```{directive-name} arguments";
      RegExpMatch? match = syntax.pattern.firstMatch(directiveSyntaxLine);
      expect(match!=null, true);
      expect(match!.group(1), '```');
      expect(match.group(2), 'directive-name');
      expect(match.group(3), 'arguments');
    });
    test('With blank in the end', (){
      String directiveSyntaxLine = "```{directive-name} arguments ";
      RegExpMatch? match = syntax.pattern.firstMatch(directiveSyntaxLine);
      expect(match!=null, true);
      expect(match!.group(1), '```');
      expect(match.group(2), 'directive-name');
      expect(match.group(3), 'arguments');
    });
  });
  group('DirectiveSyntax.endBlockPattern property', (){
    test('Common example', (){
      String directiveSyntaxLine = "```";
      RegExpMatch? match = syntax.endBlockPattern.firstMatch(directiveSyntaxLine);
      expect(match!=null, true);
      expect(match!.group(1), '```');
    });
    test('With blank in the end', (){
      String directiveSyntaxLine = "```  ";
      RegExpMatch? match = syntax.endBlockPattern.firstMatch(directiveSyntaxLine);
      expect(match!=null, true);
      expect(match!.group(1), '```');
    });
  });
  test('ExecutiveCodeSyntax.canParse method', (){
    BlockParser parser = generateBlockParser(exampleMarkdownString);
    bool canParse = syntax.canParse(parser);
    expect(canParse, true);
  });
  test('ExecutiveCodeSyntax.parseChildLines method', (){
    BlockParser parser = generateBlockParser(exampleMarkdownString);
    List<String> childLines = syntax.parseChildLines(parser, '```');
    expect(childLines.length, 2);
    expect(childLines[0], "line 1");
    expect(childLines[1], "line 2");
  });
  test('ExecutiveCodeSyntax.parse method',(){
    BlockParser parser = generateBlockParser(exampleMarkdownString);
    Element element = syntax.parse(parser) as Element;
    expect(element.tag, 'pre');
    Element directiveElement = element.children![0] as Element;
    expect(directiveElement.tag, 'directive-name');
    expect(directiveElement.textContent, 'line 1\nline 2\n');
  });
}