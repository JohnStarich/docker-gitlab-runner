FROM gitlab/gitlab-runner:alpine-v9.4.2

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

COPY entrypoint.sh /
