# originally taken from, now changed: https://github.com/astral-sh/uv-docker-example/blob/main/Dockerfile
# Python image with uv pre-installed: ghcr.io/astral-sh/uv:0.13.1-python3.11-trixie-slim
# Pinned by its index digest (covers all platforms); the platform itself is chosen in docker-compose.yml.
FROM ghcr.io/astral-sh/uv:0.13.1-python3.11-trixie-slim@sha256:0f2d0e6d745eb7f9cc9bc3a8f3bec70f398b39f38c8a1c7fa2967ddbe91af8bd AS base

# Non-root user. UID 1000 matches the usual first user on Linux/WSL, so bind-mounted
# files and fresh volumes line up without devcontainer's UID remapping.
ARG USER_UID=1000
RUN groupadd --gid ${USER_UID} nonroot \
 && useradd --uid ${USER_UID} --gid ${USER_UID} --create-home nonroot --shell /bin/bash

WORKDIR /app

# PYTHONUNBUFFERED: logs appear immediately, even if the app crashes.
# UV_COMPILE_BYTECODE: precompile .pyc at install time.
# UV_LINK_MODE=copy: the uv cache is a mount on another filesystem, so hardlinks fail.
# UV_TOOL_BIN_DIR: installed uv tools land on PATH.
# ||NOT INCLUDED:
# ENV UV_NO_DEV: Omit development dependencies (this persists across build stages - bad, we want to control this using uv sync flags)
# UV_COMPILE_BYTECODE=1: moved away from base, left out of dev for quicked container startup, remains in dependencies
ENV PYTHONUNBUFFERED=1 \
    UV_LINK_MODE=copy \
    UV_TOOL_BIN_DIR=/usr/local/bin

# The uv image's entrypoint invokes uv; reset it here so every stage inherits the reset
# (otherwise compose's `command: sleep infinity` would run as `uv sleep infinity`).
ENTRYPOINT []


# ── dev: the named volume + the lifecycle sync (devcontainer.json) own the venv ──
FROM base AS dev
# Dev-only tools: git for VS Code's source control (and its credential forwarding),
# openssh-client for git over SSH, ca-certificates for git over HTTPS. Not in runtime.
RUN apt-get update \
 && apt-get install -y --no-install-recommends git openssh-client ca-certificates \
 && rm -rf /var/lib/apt/lists/*
# Fresh volumes copy this owner and mode, so any UID set by updateRemoteUserUID can write. Dev-only.
RUN mkdir -p /app/workspace/.venv /home/nonroot/.cache/uv \
 && chown -R nonroot:nonroot /app/workspace /home/nonroot/.cache \
 && chmod 0777 /app/workspace/.venv /home/nonroot/.cache/uv
# SYNC_EXTRAS is set at runtime by docker-compose.yml (environment:), so changing extras
# needs only a recreated container, not a rebuilt image.
WORKDIR /app/workspace
ENV PATH="/app/workspace/.venv/bin:$PATH"
USER nonroot


# ── dependencies → runtime: the image owns the venv, baked at /app/.venv ──
FROM base AS dependencies
ENV UV_COMPILE_BYTECODE=1
ARG EXTRAS
# Dependencies only: slow, rarely invalidated.
# --no-dev on the command line (not ENV UV_NO_DEV), so it doesn't leak into later stages.
RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --locked --no-install-project --no-dev --extra ${EXTRAS} 

FROM dependencies AS runtime
# redeclared ARG as it doesn't carry across stages (across FROM)
ARG EXTRAS
# Source arrives (.dockerignore must exclude .venv), then the project itself is installed: fast.
COPY . /app
RUN --mount=type=cache,target=/root/.cache/uv \
    uv sync --locked --no-dev --extra ${EXTRAS}
ENV PATH="/app/.venv/bin:$PATH"
USER nonroot
