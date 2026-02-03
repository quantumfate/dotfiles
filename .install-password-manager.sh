#!/bin/sh

type pass-cli >/dev/null 2>&1 && exit

case "$(uname -s)" in
Linux)
  curl -fsSL https://proton.me/download/pass-cli/install.sh | bash
  ;;
*)
  echo "Unsupported OS"
  exit 1
  ;;
esac
