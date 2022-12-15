# kobragen docker
#
# Commands:
# podman build -t kobragen:local .
# podman build --no-cache -t ghcr.io/kobrakeyboards/kobragen:"$(git rev-parse --short HEAD)" -t ghcr.io/kobrakeyboards/kobragen:latest .
# podman run --rm -it -v ${PWD}:/build kobragen:latest /bin/bash
# podman run --rm -v ${PWD}:/build kobragen:latest kobragen example output

FROM ubuntu:22.04@sha256:817cfe4672284dcbfee885b1a66094fd907630d610cab329114d036716be49ba

RUN apt-get update

# common
RUN apt-get install -y \
    git \
    curl

# kicad
RUN apt-get install -y \
    kicad

# kicad automation scripts
RUN apt-get install -y \
    python-pip \
    xvfb \
    recordmydesktop \
    xdotool \
    xclip \
    && \
    git clone -b specctra_dsn_import_export --single-branch https://github.com/kbdmk/kicad-automation-scripts-fork.git /kas && \
    sed -i 's/psutil==5.6.1/psutil==5.9.4/g' /kas/src/requirements.txt && \
    pip2 install -r /kas/src/requirements.txt && \
    mkdir -p /root/.config/kicad && \
    cp /kas/config/* /root/.config/kicad && \
    cp -r /kas/src /usr/lib/python2.7/dist-packages/kicad-automation && \
    update-alternatives --install /usr/bin/python python /usr/bin/python2.7 1 && \
    apt-get -y remove python-pip

# patch kicad automation scripts and config
COPY copy-files/kicad/config/6.0 /root/.config/kicad/6.0
COPY copy-files/kicad/patch/export_dsn.py /usr/lib/python2.7/dist-packages/kicad-automation/pcbnew_automation/export_dsn.py
COPY copy-files/kicad/patch/import_ses.py /usr/lib/python2.7/dist-packages/kicad-automation/pcbnew_automation/import_ses.py

# ergogen
RUN apt-get install -y \
    nodejs \
    npm \
    && \
    npm i -g ergogen@3.1.0

# freerouting
RUN apt-get install -y \
    openjdk-17-jre && \
    curl -o /opt/freerouting_cli.tar.gz http://repo.hu/projects/freerouting_cli/releases-jar/freerouting_cli-1.tar.gz && \
    tar -xf /opt/freerouting_cli.tar.gz -C /opt && \
    rm -rf /opt/freerouting_cli.tar.gz
ENV PATH="${PATH}:/opt/freerouting_cli/bin/"

# bundle kobragen script
COPY kobragen /opt/kobra/bin/kobragen
ENV PATH="${PATH}:/opt/kobra/bin"

# configure environment
ENV LANG C.UTF-8

# cleanup
RUN rm -rf /var/lib/apt/lists/*

WORKDIR /build
