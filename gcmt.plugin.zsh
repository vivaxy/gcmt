#!/usr/bin/env bash
# vivaxy@20150823
gcmt(){
    log(){
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

    log info "enter commit message: \c"
    read msg
    log debug "git add ."
    git add .
    log debug "git commit -m \"${msg}\""
    git commit -m "${msg}"
    log debug "git push"
    git push
    log info "done"
}
