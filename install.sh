#!/bin/bash
set -e

# The install.sh script is the installation entrypoint for any dev container 'features' in this repository. 
#
# The tooling will parse the devcontainer-features.json + user devcontainer, and write 
# any build-time arguments into a feature-set scoped "devcontainer-features.env"
# The author is free to source that file and use it however they would like.
pwd
set -a
. /features-script.env
set +a


if [ ! -z ${_VSC_INSTALL_AWS_SAM} ]; then
    echo "Activating feature 'aws-sam'"
    
    # Build args are exposed to this entire feature set following the pattern:  _BUILD_ARG_<FEATURE ID>_<OPTION NAME>
    SAM_CLI_VERSION=${_BUILD_ARG_AWS_SAM_VERSION:-latest}
    
    curl -fsSL "https://github.com/aws/aws-sam-cli/releases/latest/download/aws-sam-cli-linux-x86_64.zip" -o "samcli.zip" && \
    unzip samcli.zip -d sam-installation && ./sam-installation/install && \
    rm samcli.zip && rm -rf sam-installation && sam --version
fi
