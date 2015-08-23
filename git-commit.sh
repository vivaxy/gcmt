#!/usr/bin/env bash
# vivaxy@20150823

gcmt(){
    echo "enter commit message : \c"
    read msg
    git add .
    git commit -m "${msg}"
    git push
}
