# `flutter_myst_markdown`

MyST Markdown for Flutter 

## Features

- `BlockSyntax` subclasses of `markdown`.
- `MarkdownElementBuilder` subclasses of `flutter_markdown`.

## Usage

Import the packages

```dart
import "package:flutter/material.dart";
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_myst_markdown/flutter_myst_markdown.dart';
```

Suppose the markdown text is

````dart
const markdownText = """
This is a fenced code block:

```python
print("Hello, world!")
```

This is an executive code block:

```{code-cell} python
1 + 2
```
""";
````

Then 

```dart
Scaffold(
  body: Markdown(
    key: const Key("notebook-example"),
    data: markdownText,
    selectable: true,
    builders: {
      'code-cell': ExecutiveCodeBuilder(
          codeExecutingHandler: (input) async {
            return input;
          }
      ),
    },
    extensionSet: mystMarkdown
  )
)
```

Set the `codeExecutingHandler` by your own.

Note that the `ExecutiveCodeBuilder` has to be used in Material wrapper such as `Scaffold`, `Card`, etc. 
