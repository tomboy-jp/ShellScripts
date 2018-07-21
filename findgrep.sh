#! /bin/bash

usage()
{
    #シェルスクリプトのファイル名を取得
    local script_name=$(basename "$0")

    #ヒアドキュメントでヘルプを表示
    cat << 'END'

Usage: $script_name PATTERN [PATH] [NAME_PATTERN]
Find file in current directory recursively, and print lines which match PATTERN.

PATH find file in PATH directory, instead of current directory.
NAME_PATTERN specify name pattern to find file.

Examples:
    $script_name return
    $script_name return~ '*.txt'

END

}

# コマンドラインの引数が0のとき
if [ $# -eq 0 ]; then
    usage
    exit 1
fi

# 引数を代入
pattern=$1
dir=$2
name=$3

# 第二引数が空文字ならばデフォルトとしてカレントディレクトリを指定。
if [ -z $dir ]; then
    dir='.'
fi

# 第三引数が空文字ならばデフォルト値としてアスタリスクを指定。
if [ -z $name ]; then
    name="*"
fi

# 検索ディレクトリが存在しない場合はエラーメッセージを表示して終了。
if [ ! -d $dir ]; then
    echo "$0: ${dir}: No such a directory" 1>&2
    exit 2
fi

# 実際に使用するコマンド
find "$dir" -name "$name" -type f | xargs grep -nH "$pattern"


