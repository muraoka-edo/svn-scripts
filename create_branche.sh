#!/bin/bash

# Environment(Global variables)
readonly prg_name=$(basename $0)
readonly base_dir="${HOME}/ops/repos"
readonly repo_dir="${base_dir}/server_config.svn"
readonly work_dir="${base_dir}/svn_worktree"
readonly work_co_dir="${work_dir}/server_config.svn"
branch=''
branch_dir=''

# Check Args
if [ "$1" ]; then
    branch="$1"
    branch_dir="${repo_dir}/branches/${branch}"
    echo "[Info] Branch Name: ${branch}"
else
    echo "[Error] Usage: bash ${prg_name} <branch name>"
    exit 1
fi

# Check SVN Worktree
[ -d "${work_dir}" ] || mkdir "${work_dir}"

if [ -d "${work_co_dir}" ]; then
    cd "${work_co_dir}" 
    svn info > /dev/null 2>&1 && svn update >/dev/null
else
    cd "${work_dir}" && svn co file://${base_dir}
    cd "${work_co_dir}" 
fi

# Create/Switch Branch
if [ -d "branches/${branch}" ]; then
    echo "[Warn] Already Exist: ${branch}"
else
    svn cp trunk branches/${branch} || \
      echo "[Error] Can not create new brache: ${branch_dir}"
    svn ci -m"create new branche, ${branch}" || \
      echo "[Error] Can not commit: ${branch_dir}"
fi
