# pull the tags from a remote.  this is needed to see if a branch starts from a tag.
git remote add upstream https://github.com/mvantellingen/python-zeep.git
git fetch upstream --tags
url=$(git remote get-url upstream)

while IFS= read -r branch; do
    # find the starting point of a branch
    started_at=$(git log --pretty=format:"%H" --boundary --ancestry-path main...$branch | tail -1)
    echo "branch $branch started at commit $started_at"

    # git-ls-remote is the only way to access tags from a remote and it only works with tags
    remote_tag=""
    while IFS= read -r local_tag; do
        remote_tag=$(git ls-remote --tags $url $local_tag)
        if [ -n "$remote_tag" ]; then
            echo "found remote tag $remote_tag"
        fi
    done < <(git tag --points-at $started_at)

    if [ -z "$remote_tag" ]; then
        echo "branch $branch is not associated with a tag from the parent project"
        exit 1
    fi
# git branch output is always indented by two characters
# validating the main branch is not necessary
done < <(git branch | sed -e "s/^..//" | grep -v "^main$")
