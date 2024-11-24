#!/usr/bin/bash

# Hide item(s) with cmd's 'attrib' command

program_name=$(basename $0)

function print_usage() {
    echo "Usage: $program_name [OPTIONS] [item1 item2 ...]"
    echo
    echo "Options:"
    echo "  -h, --help: show this help message"
    echo "  -s, --system: set system attribute"
}

function main() {
    if [[ $# < 1 ]]; then
        print_usage
        return 0
    fi

    local system=false
    local files=()

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)
                print_usage
                return 0
                ;;
            -s|--system)
                system=true
                shift
                ;;
            *)
                files+=("$(cygpath -w $1)")
                shift
                ;;
        esac
    done

    if [[ ${#files[@]} < 1 ]]; then
        print_usage
        return 0
    fi

    cmd="cmd /C attrib /D /L +H"
    if $system; then
        cmd="$cmd +S"
    fi
    for file in "${files[@]}"; do
        MSYS2_ARG_CONV_EXCL="*" $cmd "$file"
    done
}

main "$@"
exit $?

# vim: fdm=indent
