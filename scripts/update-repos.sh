#!/bin/sh
# `git pull` all the repos in a directory

SOURCE_CODE_ROOT=${1%/}
ORIGIN_REPO=origin
MASTER_BRANCH=master

if [ "$USER" == "vagrant" ]; then
    echo "This script must be run on the host, not inside the VM"
fi

if [ ! -d "${SOURCE_CODE_ROOT}" ]; then
    echo "USAGE: $0 ~/path-to-the-folder-you-store-all-your-repos [--commit]"
    exit 1
fi

if [ "--commit" = "$2" ]; then
    DRY_RUN="no"
else
    echo "Doing a dry-run so you can see what would happen. If all looks good, use --commit to make the changes."
    echo
    DRY_RUN="yes"
fi


for repo_name in ${SOURCE_CODE_ROOT}/*; do
    git_dir="${repo_name}/.git"

    if [ ! -d "${git_dir}" ]; then
        continue
    fi

    current_branch=$(git "--git-dir=${git_dir}" rev-parse --abbrev-ref HEAD)

    do_pull=no
    if [ "$current_branch" = "$MASTER_BRANCH" ]; then
        do_pull=yes
    fi
    do_submodules=no
    if [ -f "${repo_name}/.gitmodules" ]; then
        do_submodules=yes
    fi

    if [ ${DRY_RUN} = "no" ]; then
        if [ ${do_pull} = "yes" ]; then
            git "--git-dir=${git_dir}" pull --ff-only $ORIGIN_REPO $MASTER_BRANCH > /dev/null
            echo "done    git pull ${ORIGIN_REPO} ${MASTER_BRANCH}    for   ${repo_dir}"
            if [ ${do_submodules} = "yes" ]; then
                git "--git-dir=${git_dir}" submodule update > /dev/null
                echo "done    git submodule update    for   ${repo_dir}"
            fi
        else
            git "--git-dir=${git_dir}" fetch $ORIGIN_REPO $MASTER_BRANCH > /dev/null
            echo "done git fetch ${ORIGIN_REPO} ${MASTER_BRANCH} for ${repo_dir}"
            if [ ${do_submodules} = "yes" ]; then
                >&2 echo "still need    git submodule update    for   ${repo_name}"
            fi
        fi
    else
        if [ ${do_pull} = "yes"  ]; then
            echo "cd ${repo_name} && git pull $ORIGIN_REPO $MASTER_BRANCH"
            if [ ${do_submodules} = "yes" ]; then
                echo "   && git submodule update"
            fi
        else
            echo "cd ${repo_name} && git fetch $ORIGIN_REPO $MASTER_BRANCH"
        fi
    fi
done
