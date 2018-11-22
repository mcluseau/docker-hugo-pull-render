#! /bin/ash

: ${PULL_DELAY:=10m}

trap exit TERM INT

cd /git

[ -e .git ] || git clone ${GIT_URL} .

git checkout ${GIT_BRANCH:-master}

ref() {
    git rev-list --max-count=1 HEAD
}

commit=""

while true
do
    echo "pulling ($(date))"
    git pull

    new_commit=$(ref)

    if ! [ "$commit" = "$new_commit" ]; then
        hugo -d /output
        commit=$new_commit
    fi

    sleep $PULL_DELAY
done
