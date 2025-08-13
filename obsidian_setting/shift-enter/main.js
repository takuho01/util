const { Plugin } = require("obsidian");

// Obsidian plugin: Shift+Enter inserts a new line without continuing list markers

module.exports = class ShiftEnterPlugin extends Plugin {
  onload() {
    this.addCommand({
      id: "shift-enter-no-list",
      name: "Shift+Enter: New line without list marker",
      editorCallback: (editor, view) => {
        const cursor = editor.getCursor();
        const line = editor.getLine(cursor.line);

        // リスト記号の正規表現
        const listPattern = /^(\s*)([-*+]|\d+\.)\s+/;
        const match = line.match(listPattern);

        if (match) {
          // リスト記号の前のインデント＋2スペースを新しい行に挿入
          const baseIndent = match[1] || "";
          const newIndent = baseIndent + "  ";
          editor.replaceRange(
            "\n" + newIndent,
            { line: cursor.line, ch: line.length }
          );
          editor.setCursor({ line: cursor.line + 1, ch: newIndent.length });
        } else {
          // リストでない場合はインデントのみ保持して改行
          const indentMatch = line.match(/^(\s*)/);
          const indent = indentMatch ? indentMatch[1] : "";
          editor.replaceRange(
            "\n" + indent,
            { line: cursor.line, ch: line.length }
          );
          editor.setCursor({ line: cursor.line + 1, ch: indent.length });
        }
      }
    });
  }
};
