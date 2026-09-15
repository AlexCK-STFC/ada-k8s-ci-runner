FROM python:3.12-slim

RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    git \
    openssh-client \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --no-cache-dir packaging ansible-core

COPY requirements.yml /tmp/requirements.yml
RUN if [ -f /tmp/requirements.yml ]; then \
      ansible-galaxy collection install -r /tmp/requirements.yml -p /usr/share/ansible/collections; \
    fi && rm -f /tmp/requirements.yml
