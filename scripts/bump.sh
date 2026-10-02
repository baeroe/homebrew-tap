#!/usr/bin/env bash
# Update Formula/<name>.rb to the latest GitHub release of <owner/repo>.
# Usage: scripts/bump.sh <formula-name> <owner/repo>
# Prints "updated <old> -> <new>" or "up to date <version>". Needs curl, shasum or sha256sum, and gh or GH_TOKEN for the API.
set -euo pipefail

name="$1"
repo="$2"
formula="Formula/${name}.rb"
[ -f "$formula" ] || { echo "missing $formula" >&2; exit 1; }

if command -v gh >/dev/null 2>&1; then
  tag="$(gh api "repos/${repo}/releases/latest" --jq .tag_name)"
else
  tag="$(curl -fsSL ${GH_TOKEN:+-H "Authorization: Bearer ${GH_TOKEN}"} "https://api.github.com/repos/${repo}/releases/latest" | sed -n 's/.*"tag_name": *"\([^"]*\)".*/\1/p')"
fi
case "$tag" in
  v[0-9]*) ;;
  *) echo "unexpected tag '${tag}'" >&2; exit 1 ;;
esac

url="https://github.com/${repo}/archive/refs/tags/${tag}.tar.gz"
current_url="$(sed -n 's/^  url "\(.*\)"$/\1/p' "$formula")"
if [ "$current_url" = "$url" ]; then
  echo "up to date ${tag}"
  exit 0
fi

tmp="$(mktemp)"
trap 'rm -f "$tmp"' EXIT
curl -fsSL "$url" -o "$tmp"
if command -v sha256sum >/dev/null 2>&1; then
  sha="$(sha256sum "$tmp" | cut -d' ' -f1)"
else
  sha="$(shasum -a 256 "$tmp" | cut -d' ' -f1)"
fi

sed -i.bak -e "s|^  url \".*\"$|  url \"${url}\"|" -e "s|^  sha256 \".*\"$|  sha256 \"${sha}\"|" "$formula"
rm -f "${formula}.bak"
echo "updated ${current_url##*/} -> ${tag}.tar.gz"
