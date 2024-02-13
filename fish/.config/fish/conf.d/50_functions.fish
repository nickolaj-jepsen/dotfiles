function git-wd-commit;
    set branch $argv[1]
    set commit_args $argv[2..-1]
    set safe_branch (echo $branch | sed 's/\//_/g')

    mkdir -p /tmp/$safe_branch
    and git worktree add --checkout /tmp/$safe_branch $branch
    and git diff HEAD | git -C /tmp/$safe_branch apply
    and git -C  /tmp/$safe_branch add .
    and git -C  /tmp/$safe_branch commit $commit_args
    and git -C  /tmp/$safe_branch pull --rebase origin $branch
    and git -C ../$branch push origin $branch
    and git worktree remove $branch
    and rm -rf /tmp/$safe_branch
end
