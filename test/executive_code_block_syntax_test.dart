import 'package:flutter_test/flutter_test.dart';
import 'package:markdown/markdown.dart';

import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
import 'utils.dart';


String executiveCodeExample = """
```{code-cell} python
print('Hello, world!')
```
""";


void main(){
  group('ExecutiveCodeBlockSyntax', (){
    BlockParser parser = generateParser(executiveCodeExample);
    test('ExecutiveCodeBlockSyntax.pattern', (){
      // without `^` and `$`
      RegExp pattern = RegExp(r'[ ]{0,3}(`{3,}|~{3,})\{code-cell\}(.*)');
      RegExpMatch? match = pattern.firstMatch(executiveCodeExample);
      String? codeFence = match?.group(1)!;
      String? infoString = match?.group(2);
      expect(codeFence, '```');
      expect(infoString, ' python');
    });
    test('ExecutiveCodeBlockSyntax.canParse', (){
      ExecutiveCodeBlockSyntax syntax = const ExecutiveCodeBlockSyntax();
      bool canParse = syntax.canParse(parser);
      expect(canParse, true);
    });
  });
}