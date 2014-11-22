#!/bin/bash

# Environment(Global variables)
readonly base_dir="${HOME}/ops/repos"
readonly repo_dir="${base_dir}/server_config.svn"
readonly work_dir="${base_dir}/svn_worktree"

# Cleanup
[ -d "${repo_dir}" ] && rm -rf "${repo_dir}"
[ -d "${work_dir}" ] && rm -rf "${work_dir}"

# SVN Repository Create
cd "${base_dir}" && svnadmin create server_config.svn

# Checkout/Commit
mkdir "${work_dir}" && cd "${work_dir}"
if [ -d "${repo_dir}" ]; then
    svn co file://${repo_dir}
    cd "${work_dir}/server_config.svn" && mkdir {trunk,branches,tags}
    svn add *
    svn ci -m'inital commit'
else
    echo '[Error] No such file: ${repo_dir}'
fi
