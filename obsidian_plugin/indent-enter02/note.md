
# 概要
obsidianのプラグイン。
リスト形式のテキスト編集において、
現在の行と同じ内容の行を次の行に挿入するコマンドを作成して

case01
    現在行がリスト形式かつ、
    リスト情報、スペース情報以外のテキストがない場合
    
    その行をduplicateする。

case02
    現在行がリスト形式かつ、
    リスト情報、スペース情報以外のテキストが含まれている場合
    
    改行後、次の行に、インデント情報のみを挿入する。
    ここで、リストのインデントの深さはン前の行に合わせる。


