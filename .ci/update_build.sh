#!/usr/bin/env bash
BRANCH=build
TARGET_REPO=tanxpyox/OpenLex.git

if [ "$TRAVIS_PULL_REQUEST" == "false" ]; then
    echo -e "Starting to deploy to Build Branch\n"
    if [ "$TRAVIS" == "true" ]; then
        git config --global user.email "travis@travis-ci.org"
        git config --global user.name "Travis"
    fi
    # using token clone build branch
    git clone --quiet --branch=$BRANCH https://${GITHUB_TOKEN}@github.com/$TARGET_REPO build> /dev/null
    # go into directory and copy data we're interested in to that directory
    cd build
    cp ../*.pdf .
    # add, commit and push files
    git add -f .
    git commit -m "Travis build $TRAVIS_BUILD_NUMBER pushed to Build Branch"
    git push -fq origin HEAD:$BRANCH > /dev/null
    echo -e "Deploy completed\n"
fi
