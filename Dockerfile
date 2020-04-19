FROM nikolaik/python-nodejs:python2.7-nodejs12

ENV KUBECTL_VERSION=v1.17.3
ENV AWS_IAM_AUTHENTICATOR_VERSION=1.13.7/2019-06-11
ENV CLOUD_SDK_VERSION=289.0.0

RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add - && \
  apt-get update && \
  apt-get install -y --no-install-recommends apt-transport-https ca-certificates gnupg && \
  wget https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl && \
  chmod a+x ./kubectl && \
  mv ./kubectl /usr/local/bin && \
  wget https://amazon-eks.s3-us-west-2.amazonaws.com/${AWS_IAM_AUTHENTICATOR_VERSION}/bin/linux/amd64/aws-iam-authenticator && \
  chmod +x ./aws-iam-authenticator && \
  mv ./aws-iam-authenticator /usr/local/bin && \
  cd / && curl -O https://dl.google.com/dl/cloudsdk/channels/rapid/downloads/google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  tar xzf google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  rm google-cloud-sdk-${CLOUD_SDK_VERSION}-linux-x86_64.tar.gz && \
  ln -s /lib /lib64 && \
  ln -s /google-cloud-sdk/bin/gcloud /usr/bin/gcloud && \
  gcloud config set core/disable_usage_reporting true && \
  gcloud config set component_manager/disable_update_check true && \
  gcloud config set metrics/environment github_docker_image && \
  gcloud --version
