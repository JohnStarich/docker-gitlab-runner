# docker-gitlab-runner
A simplified auto-registering Gitlab CI runner

To quickly create a runner and test it out, run something like the following. Remember to use your Gitlab for the environment variables:

```bash
docker run --detach \
    --name gitlab-runner-tmp \
    --env GITLAB_CI_URL=$YOUR_GITLAB \
    --env GITLAB_CI_TOKEN=$YOUR_GITLAB_TOKEN \
    --privileged \
    --volume /var/run/docker.sock:/var/run/docker.sock \
    johnstarich/gitlab-runner:latest
```

## Example stack file

To deploy this runner as a service, create a stack file `runners.yml` like the following:

```yaml
version: "3"

services:
  runner:
    image: johnstarich/gitlab-runner:latest
    privileged: true
    environment:
      - GITLAB_CI_URL=https://{{your.gitlab.url.here}}
      - GITLAB_CI_TOKEN={{some_magical_token_gitlab_gives_you}}
    volumes:
      - /var/run/docker.sock:/var/run/docker.sock
    deploy:
      replicas: 2
      restart_policy:
        condition: on-failure
```

And then run `docker stack deploy -c runners.yml runners`

## Note

If you would like a stable version of this image, choose a tag instead of using `latest`.
