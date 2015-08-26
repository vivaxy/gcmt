#!/usr/bin/env bash
# vivaxy@20150823
gcmt(){
    log(){
        ## clean color
        post="\033[0m"
        case "$1" in
            error) ## red
                pre="\033[31m"
                ;;
            warn) ## yellow
                pre="\033[33m"
                ;;
            info) ## clan
                pre="\033[36m"
                ;;
            debug) ## green # blue
                pre="\033[32m" # pre="\033[94m"
                ;;
            *) ## gray (white)
                pre="\033[37m"
                ;;
        esac
        ## chalk with color
        echo -e "${pre}$2${post}"
    }
    
    ## get commit message
    msg=""
    while [ -z "${msg}" ]
    do
        log info "enter commit message: \c"
        ## todo support arrow keys
        read -r msg
    done
    
    ## pull
    log debug "git pull"
    pullResult=`git pull`
    if [[ "${pullResult}" =~ "Aborting" ]]
    then
        ## conflict or something not committed
        log error "${pullResult}"
    elif [[ "${pullResult}" =~ "There is no tracking information for the current branch" ]]
    then
        log error "${pullResult}"
    else
        ## continue
        log verbose "${pullResult}"
        ## add
        log debug "git add ."
        git add .
        ## commit
        log debug "git commit -m \"${msg}\""
        commitResult=`git commit -m "${msg}"`
        log verbose "${commitResult}"
        if [[ ! "${commitResult}" =~ "nothing to commit, working directory clean" ]]
        then
            ## continue
            ## push
            log debug "git push"
            pushResult=`git push`
            log verbose "${pushResult}"
            ## done
            log info "done"
        fi
    fi
}
