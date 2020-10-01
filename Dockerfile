FROM gitlab/gitlab-runner:alpine-v13.2.4

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

COPY entrypoint.sh /
