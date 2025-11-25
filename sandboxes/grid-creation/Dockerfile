#Python <=3.12 raises SyntaxWarning
FROM ghcr.io/astral-sh/uv:python3.11-bookworm-slim

ENV PATH="/grid-creation/.venv/bin:$PATH"

#can be any, but must be the same as above
WORKDIR /grid-creation

ENV PYTHONUNBUFFERED=1 \
    UV_COMPILE_BYTECODE=0 \
    UV_LINK_MODE=copy

RUN --mount=type=cache,target=/root/.cache/uv \
    --mount=type=bind,source=uv.lock,target=uv.lock \
    --mount=type=bind,source=pyproject.toml,target=pyproject.toml \
    uv sync --frozen --no-install-project

COPY . . 

CMD ["python", "trivial_test.py"]