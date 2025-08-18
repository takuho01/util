#!/usr/bin/python3
import sys
import os
from pathlib import Path
import fnmatch

def build_find_command(patterns):
    """複数パターンに対応したfindコマンドを生成"""
    if len(patterns) == 1:
        return f"find . -name '*{patterns[0]}*'"
    
    # 複数パターンの場合はORで結合
    conditions = []
    for pattern in patterns:
        conditions.append(f"-name '*{pattern}*'")
    
    # \( condition1 -o condition2 -o condition3 \) の形式
    or_conditions = " -o ".join(conditions)
    return f"find . \\( {or_conditions} \\)"

def matches_any_pattern(path, patterns):
    """パスが任意のパターンにマッチするかチェック"""
    basename = os.path.basename(path)
    return any(fnmatch.fnmatch(basename, f'*{pattern}*') for pattern in patterns)

def filter_paths(paths, patterns):
    """パイプからの入力をフィルタリング"""
    for path in paths:
        path = path.strip()
        if matches_any_pattern(path, patterns):
            print(path)

def find_files(patterns):
    """ファイル検索"""
    for path in Path('.').rglob('*'):
        if matches_any_pattern(str(path), patterns):
            print(path)

def main():
    if len(sys.argv) < 2:
        print("Usage: f <pattern1> [pattern2] [pattern3] ... [--cmd]", file=sys.stderr)
        print("Examples:", file=sys.stderr)
        print("  f hoge                    # find files containing 'hoge'", file=sys.stderr)
        print("  f hoge hogo hogu          # find files containing 'hoge' OR 'hogo' OR 'hogu'", file=sys.stderr)
        print("  f hoge --cmd              # show equivalent find command", file=sys.stderr)
        print("  f hoge | f hogo           # find 'hoge' then filter by 'hogo'", file=sys.stderr)
        sys.exit(1)
    
    # --cmdオプションのチェック
    show_cmd = '--cmd' in sys.argv
    if show_cmd:
        sys.argv.remove('--cmd')
    
    patterns = sys.argv[1:]  # 複数のパターンを取得
    
    if not patterns:
        print("Error: No patterns specified", file=sys.stderr)
        sys.exit(1)
    
    # --cmdオプションが指定された場合
    if show_cmd:
        if not sys.stdin.isatty():
            print("# Note: --cmd option shows find command, but input is from pipe", file=sys.stderr)
        print(build_find_command(patterns))
        return
    
    if sys.stdin.isatty():
        # 標準的なfind処理
        find_files(patterns)
    else:
        # パイプからの入力を処理
        filter_paths(sys.stdin, patterns)

if __name__ == '__main__':
    main()