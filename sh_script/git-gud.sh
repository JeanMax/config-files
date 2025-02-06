#!/bin/bash

find_parent_branch() {
    echo TODO
}

find_least_advanced_branch() {
    echo TODO
}

get_ticket_desc() {
    echo TODO
}

get_ticket_id() {
    echo TODO
}

new_branch() {
    echo
    oldest_env_branch=$(find_least_advanced_branch)
    git checkout "$oldest_env_branch"
    feature_branch=$(get_ticket_id)_$(get_ticket_desc)
    git checkout -b "$feature_branch"
}

new_commit() {
    git commit -m "[$(get_ticket_id)] $*"
}
