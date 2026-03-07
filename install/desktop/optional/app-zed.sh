#!/bin/bash

if ! command -v zed &> /dev/null; then
  curl https://zed.dev/install.sh | sh
fi
