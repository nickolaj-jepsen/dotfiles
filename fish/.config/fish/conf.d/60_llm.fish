function llm-diff
    set GIT_DIFF $(git diff);

    echo "\
suggest 3 commit messages based on the following diff:

$(git diff HEAD)

commit messages should:
 - follow conventional commits, always WITHOUT SCOPE
 - message format should be: <type>: <description>
 - do not include filenames
 - be brief
 - max length 60 characters" | llm $argv # 72 - space for scope
end
