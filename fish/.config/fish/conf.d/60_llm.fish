function llm-diff
    set GIT_DIFF $(git diff);

    echo "\
suggest 3 commit messages based on the following diff:

$(git diff)

commit messages should:
 - follow conventional commits
 - message format should be: <type>(scope): <description>
 - do not include filenames
 - max length 72 characters" | llm $argv
end
