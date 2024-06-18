# This is mostly to test the workflows, it doesn't produce anything useful beside a cli that has
# buildinfo and version
FROM scratch
COPY workflows /usr/bin/workflows
ENTRYPOINT ["/usr/bin/workflows"]
CMD ["buildinfo"]
