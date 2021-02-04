FROM debian:stretch

LABEL maintainer="makerspace-team@usgs.gov"

# Run updates and install curl
RUN apt-get update && \
      apt-get upgrade -y && \
      apt-get install curl -y && \
      apt-get purge -y --auto-remove && \
      apt-get clean

# Enable the NodeSource repository and install the latest nodejs
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && \
      apt-get install nodejs -y

# Create temp directory for building viz app
RUN mkdir -p /tmp/delaware-basin-story-CHANGE_THIS_TO_NAME_OF_PROJECT

# Copy source code
WORKDIR /tmp/delaware-basin-story-CHANGE_THIS_TO_NAME_OF_PROJECT
COPY . .
# Set environment variables for build target and tile source and then run config.sh
# to insert the correct S3 tile source URLs in the Mapbox configuration file.
ARG BUILDTARGET="test"
ARG VUE_BUILD_MODE="development"
ENV E_BUILDTARGET=$BUILDTARGET
ENV E_VUE_BUILD_MODE=$VUE_BUILD_MODE

# Build the Vue app.
RUN npm install
RUN chmod +x ./build.sh && ./build.sh

