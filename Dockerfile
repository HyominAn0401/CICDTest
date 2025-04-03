FROM hashicorp/packer:light
RUN apk add --no-cache python3 py3-pip bash curl unzip aws-cli