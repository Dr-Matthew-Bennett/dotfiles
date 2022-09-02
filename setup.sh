#!/bin/bash

# get path the this script
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

source "${SCRIPT_DIR}/link_dotfiles.sh"
source "${SCRIPT_DIR}/install_programs.sh"

