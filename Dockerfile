FROM hashicorp/terraform:light as terraform_stage
FROM amazonlinux:2 as aws_stage

WORKDIR /awscli-build
COPY ./aws-gpg.pub ./aws-gpg.pub

RUN yum upgrade -y \
  && yum install -y unzip-6.0 \
  && curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip" \
  && curl -o awscliv2.sig https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip.sig \
  && gpg --import aws-gpg.pub \
  && gpgv --keyring pubring.gpg awscliv2.sig awscliv2.zip \
  && unzip awscliv2.zip \
  && mkdir /awscli \
  && ./aws/install --install-dir /awscli \
  && yum clean all

FROM amazonlinux:2 as ci_stage

RUN yum upgrade -y && yum install -y \
  jq-1.5 \
  git-2.37.1 \
  && yum clean all

COPY --from=terraform_stage /bin/terraform /usr/local/bin/terraform
COPY --from=aws_stage /awscli /awscli

RUN ln -s /awscli/v2/current/bin/aws /usr/local/bin/aws

WORKDIR /ci-build

ENTRYPOINT ["sh"]
