#!/bin/bash

# Environment(Global variables)
readonly prg_name=$(basename $0)
readonly base_dir="${HOME}/ops/repos"
readonly repo_dir="${base_dir}/server_config.svn"
readonly work_dir="${base_dir}/svn_worktree"
readonly work_co_dir="${work_dir}/server_config.svn"
branch=''
branch_wt_dir=''

# Check Args
if [ "$1" ]; then
    branch="$1"
    branch_wt_dir="${repo_dir}/branches/${branch}"
    echo "[Info] Branch Name: ${branch}"
else
    echo "[Error] Usage: bash ${prg_name} <branch name>"
    exit 1
fi

# Check SVN Worktree
cd "${work_co_dir}"
svn switch file://${branch_wt_dir} branches/${branch}
if [ $? -eq 0 ]; then
    cd branches/${branch}
    echo "--------------------------------------------"
    echo " Swtiched Branch: ${branch}"
    echo " Workspace: $(pwd)"
    echo "--------------------------------------------"
else
    echo "[Error] SVN Swtich fail: svn switch file:///${branch_wt_dir} branches/${branch}"
    exit 1
fi

