#!/usr/bin/env bash
# 在本机终端运行：bash upload-to-github.sh
set -euo pipefail

SOURCE_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd -P)"
REMOTE_URL="git@github.com:awu520119/AI_prototype_skill.git"
STAGING_DIR="$(mktemp -d "${TMPDIR:-/tmp}/ai-prototype-upload.XXXXXX")"
CHECKOUT_DIR="$STAGING_DIR/repo"

echo "上传模式：以 $SOURCE_DIR 的文件覆盖仓库现有内容"
echo "克隆 $REMOTE_URL"
git clone "$REMOTE_URL" "$CHECKOUT_DIR"

echo "移除仓库中现有的已跟踪文件，准备以本地项目内容替换"
git -C "$CHECKOUT_DIR" rm -r -q --ignore-unmatch -- .

echo "复制本地项目文件"
rsync -a \
  --exclude='.git' \
  --exclude='.DS_Store' \
  --exclude='node_modules' \
  --exclude='dist' \
  --exclude='share' \
  --exclude='__pycache__' \
  --exclude='*.pyc' \
  "$SOURCE_DIR/" "$CHECKOUT_DIR/"

if ! git -C "$CHECKOUT_DIR" config user.name >/dev/null; then
  read -r -p 'Git 提交名称 [awu520119]: ' COMMIT_NAME
  git -C "$CHECKOUT_DIR" config user.name "${COMMIT_NAME:-awu520119}"
fi
if ! git -C "$CHECKOUT_DIR" config user.email >/dev/null; then
  read -r -p 'Git 提交邮箱: ' COMMIT_EMAIL
  if [[ -z "$COMMIT_EMAIL" ]]; then
    echo '提交邮箱不能为空；可设置 GitHub 隐私邮箱后重试。' >&2
    exit 1
  fi
  git -C "$CHECKOUT_DIR" config user.email "$COMMIT_EMAIL"
fi

git -C "$CHECKOUT_DIR" add -A
if git -C "$CHECKOUT_DIR" diff --cached --quiet; then
  echo '远端已包含当前项目内容，无需上传。'
  exit 0
fi

echo '即将提交的文件：'
git -C "$CHECKOUT_DIR" --no-pager diff --cached --stat
git -C "$CHECKOUT_DIR" commit -m 'Add AI prototype skills and viewer'
git -C "$CHECKOUT_DIR" push -u origin HEAD
echo "上传完成：https://github.com/awu520119/AI_prototype_skill"
