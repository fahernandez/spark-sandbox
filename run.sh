#!/bin/bash
# Exit on most errors
set -o errexit

# colors. Example usage: printf "${YELLOW}yellow text ${NC}reset color"
GREEN='\033[0;32m'
NC='\033[0m' # No Color
RED='\033[0;31m'
YELLOW='\033[1;33m'

# DESC: Usage help
function script_usage() {
    cat << EOF
               _
 _           _| |_
| |         |_   _|
| |__  _   _| |_|
| '_ \| | | | | |
| | | | |_| | | |
|_| |_|\__,_|_|_|
Usage: ./run.sh COMMAND
Commands:
    build                      Run the project build
    down                       Brings services down
    ps                         List available services
    help -h --help             Displays this help
    logs                       Show the services logs. Usage: ./run.sh logs SERVICE
    pull                       Pull the latest images
    sh                         Run sh inside a container. Usage: ./run.sh sh SERVICE
    up                         Brings services up (basic + platform)
EOF
}

# DESC: Parameter parser
# ARGS: $@ (optional): Arguments provided to the script
# OUTS: Variables indicating command-line parameters and options
function parse_params() {
    local param
    if [ $# -eq 0 ]; then
        script_usage
        exit 1
    fi

    while  [[ $# -gt 0 ]]; do
        param="$1"
        shift
        case $param in
            build)
                build "${@:1}"
                exit 0
                ;;
            down)
                down "${@:1}"
                exit 0
                ;;
            ps)
                ps "${@:1}"
                exit 0
                ;;
            logs)
                logs "${@:1}"
                exit 0
                ;;
            pull)
                pull "${@:1}"
                exit 0
                ;;
            sh)
                sh "${@:1}"
                exit 0
                ;;
            up)
                up "${@:1}"
                exit 0
                ;;
            help|-h|--help)
                script_usage
                exit 0
                ;;
            *)
                printf "Invalid parameter was provided: $param\n\n"
                script_usage
                exit 1
                ;;
        esac
    done
}

# DESC: Run the project build
# ARGS: $@ (optional): Arguments provided to the script
function build() {
    docker-compose -f build/docker-compose.yml  build "$@"
}

# DESC: Brings services down
# ARGS: $@ (optional): Arguments provided to the script
function down() {
    docker-compose \
        -f build/docker-compose.yml \
        down "$@"
}


# DESC: Show the services logs. Usage: ./run.sh logs SERVICE
# ARGS: $@ (optional): Arguments provided to the script
function logs() {
    docker-compose \
        -f build/docker-compose.yml \
        logs "$@"
}

# DESC: List the services and their status
# ARGS: $@ (optional): Arguments provided to the script
function ps() {
    docker-compose -f build/docker-compose.yml ps "$@"
}

# DESC: Pull the latest images
# ARGS: $@ (optional): Arguments provided to the script
function pull() {
    docker-compose \
        -f build/docker-compose.yml \
        pull "$@"
}

# DESC: Run sh inside a container. Usage: ./run.sh sh SERVICE
# ARGS: $@ (optional): Arguments provided to the script
function sh() {
    if [ -z "$1" ]; then
        service=${PWD##*/}
        command=bash
    else
        service="$1"
        command=sh
    fi

    printf "${YELLOW}INFO: ${NC} Running sh inside "$service".\n\n"

    docker-compose -f build/docker-compose.yml exec "$service" $command
}

# DESC: Brings services up (basic + platform)
# ARGS: $@ (optional): Arguments provided to the script
function up() {
    docker-compose \
        -f build/docker-compose.yml \
        up -d "$@"
}

#
# DESC: Main control flow
# ARGS: $@ (optional): Arguments provided to the script
function main() {
    parse_params "$@"
}

# Make it rain
main "$@"
