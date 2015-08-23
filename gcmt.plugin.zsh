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
        echo -e "${pre}$2${post}"
    }
    
    msg=""
    while [ -z "${msg}" ]
    do
        log info "enter commit message: \c"
        # todo support arrow keys
        read msg
    done
    log debug "git pull"
    pullResult=`git pull`
    log verbose "${pullResult}"
    if [[ "${pullResult}" =~ "CONFLICT" ]]
    then
        log error "merge first"
    else
        log debug "git add ."
        git add .
        log debug "git commit -m \"${msg}\""
        if [[ ! "`git commit -m "${msg}"`" =~ "nothing to commit, working directory clean" ]]
        then
            log debug "git push"
            pushResult=`git push`
            log verbose "${pushResult}"
        fi
        log info "done"
    fi
}
