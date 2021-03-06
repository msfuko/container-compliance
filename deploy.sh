#!/bin/bash

set -e
set -x

## If we are in TRAVIS and NOT in a Pull Request, then we send a notification to the DockerHub
## Note that DOCKERHUB_AUTOBUILD_URL is a private value stored insde Travis
if [ "${TRAVIS_PULL_REQUEST}" == "false" -a "${TRAVIS}" == "true" ]; then
  curl -H "Content-Type: application/json" \
    --data '{"source_type": "Branch", "source_name": "'${TRAVIS_BRANCH}'"}' \
    -X POST "${DOCKERHUB_AUTOBUILD_URL}";
else
  echo "No deploy to do : not in Travis, or Pull-Request detected"
fi
