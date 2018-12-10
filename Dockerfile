FROM gitlab/gitlab-runner:alpine-v11.5.1

ENTRYPOINT ["/entrypoint.sh"]
CMD ["run", "--user=gitlab-runner", "--working-directory=/home/gitlab-runner"]

COPY entrypoint.sh /
