#!/bin/bash

function usage() {
    echo "Provide environment variables to initialize the Gitlab Runner as follows:
    GITLAB_CI_TOKEN - the token to register as a runner, located in the Gitlab UI at /admin/runners
    GITLAB_CI_URL - the Gitlab host URL, e.g. https://gitlab.com/ci
    "
}

function should_exit() {
    set +x
    echo 'Stopping gitlab-runner now' >&2
    kill %1
    set -x
    gitlab-runner unregister --name "$GITLAB_CI_DESCRIPTION"
    set +x
    echo 'Exiting...' >&2
    exit 0
}

if [[ -z "$GITLAB_CI_URL" || -z "$GITLAB_CI_TOKEN" ]]; then
    usage
    exit 2
fi

GITLAB_CI_DESCRIPTION=${GITLAB_CI_DESCRIPTION:-"John Starich's Auto-Register Docker Runner"}

set -e
set -x
# Enable job control
set -m

if [[ "$1" == 'run' ]]; then
    gitlab-runner register -n \
        --url "$GITLAB_CI_URL" \
        --registration-token "$GITLAB_CI_TOKEN" \
        --executor docker \
        --description "$GITLAB_CI_DESCRIPTION" \
        --docker-image "docker:latest" \
        --docker-privileged \
        --docker-volumes /var/run/docker.sock:/var/run/docker.sock
fi

# Run parent entrypoint as usual
trap should_exit SIGTERM
/entrypoint $@ &
wait
