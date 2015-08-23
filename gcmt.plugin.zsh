#!/usr/bin/env bash
# vivaxy@20150823
gcmt(){
    console(){
        post="\033[0m"
        case "$1" in
            error)
                pre="\033[91m"
                ;;
            warn)
                pre="\033[93m"
                ;;
            info)
                pre="\033[92m"
                ;;
            debug)
                pre="\033[94m"
                ;;
            *)
                pre="\033[90m"
                ;;
        esac
        echo "${pre}$2${post}"
    }

    console info "enter commit message: \c"
    read msg
    console debug "git add ."
    git add .
    console debug "git commit -m \"${msg}\""
    git commit -m "${msg}"
    console debug "git push"
    git push
}
