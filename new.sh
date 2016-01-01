#! /bin/bash
SELF_DIR=$(dirname $BASH_SOURCE)
if [ ${#1} = 0 ]; then
    echo "アプリケーション名を第1引数に指定してください。"
    exit 1
fi

rails new $1 -O --skip-bundle -m "${SELF_DIR}/rails-akiroom-template.rb"
