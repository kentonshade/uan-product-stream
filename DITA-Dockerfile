# Use the latest DITA-OT image ↓ as parent:
FROM ghcr.io/dita-ot/dita-ot:3.7.2
# COPY ./entrypoint.sh ./
# Copy the repo uan repo to the container (using symlink here locally to test - change for prod)
# COPY ./uan/docs ./
RUN ls -la
# RUN chmod +x ./entrypoint.sh
# ENV PATH=$PATH:/home/dita-ot/DITA-OT/bin
# RUN ./entrypoint.sh \
#     ./image-os-info.sh

# Become root as fallback (some images wre enot created to start as root)
USER root

# Test apt commands
RUN apt update -y \
    apt -y install libxml2-utils git

# ENTRYPOINT ["./root/entrypoint.sh"]
# Below is merely to allow the container to keep running for testing
# Method 1
# ENTRYPOINT ["tail", "-f", "/dev/null"]
# Method 2
ENTRYPOINT ["watch", "ls"]
CMD ["/bin/bash"]