const { Plugin } = require("obsidian");

// Obsidian plugin: Duplicate or indent list line on command
// - If the current line is a list and contains only list marker/indent, duplicate the line
// - If the current line is a list and contains text, insert a new line with only the indent/list marker

module.exports = class IndentEnterPlugin extends Plugin {
  onload() {
    this.addCommand({
      id: "indent-enter-duplicate-or-indent",
      name: "Indent Enter: Duplicate or Insert Indent in List",
      editorCallback: (editor) => {
        const cursor = editor.getCursor();
        const lineNum = cursor.line;
        const line = editor.getLine(lineNum);

        // Regex: matches leading spaces + list marker (-, *, +, or numbered) + optional space
        const listRegex = /^(\s*)([-*+]|\d+\.)\s*/;
        const match = line.match(listRegex);

        if (!match) {
          // Not a list line, do nothing
          return;
        }

        const indent = match[1] || "";
        const marker = match[2] || "";
        const afterMarker = line.slice(match[0].length);

        if (afterMarker.trim() === "") {
          // case01: Only list marker/indent, no text → duplicate the line
          editor.replaceRange(
            "\n" + line,
            { line: lineNum, ch: line.length }
          );
          // Move cursor to new line, after marker
          editor.setCursor({ line: lineNum + 1, ch: match[0].length });
        } else {
          // case02: List line with text → insert new line with only indent + marker + space
          editor.replaceRange(
            "\n" + indent + marker + " ",
            { line: lineNum, ch: line.length }
          );
          // Move cursor to new line, after marker
          editor.setCursor({ line: lineNum + 1, ch: (indent + marker + " ").length });
        }
      },
    });
  }
};
