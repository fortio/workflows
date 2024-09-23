# This is mostly to test the workflows, it doesn't produce anything useful beside a cli that has
# buildinfo and version
FROM scratch
COPY workflow_test /usr/bin/workflow_test
ENTRYPOINT ["/usr/bin/workflow_test"]
CMD ["buildinfo"]
