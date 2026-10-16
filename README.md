# Smart Grid RL Agent

This project builds a reinforcement learning (RL) agent to manage electric power grid operations in a simulated environment using Grid2Op. The agent's goals are to optimize power flows, minimize overload and contingency risks, and increase grid resilience through autonomous decision-making. The development environment and experiments are fully containerized with Docker to ensure reproducibility across contributors.

## **Key goals:**

- **Optimize:** reduce losses and improve operational metrics.
- **Safeguard:** avoid line overloads and prevent cascading failures.
- **Automate:** evaluate RL approaches for real-time or near-real-time control.

**Disclaimer:** This repository is for research and simulation only. Do not use the code for live production systems without extensive validation and domain expert review.

## **Table of Contents**

- **Overview**
- **Quickstart (Docker)**
- **Project Structure**
- **Contributing Guidelines**
- **Experimental/Test Work**
- **References**

## **Overview**

The environment is provided by [Grid2Op](https://github.com/Grid2op/grid2op), which simulates power grid physics and operational constraints. Agents interact with the environment via actions (topology changes, redispatch, curtailment, etc.) and receive observations and rewards. This repo contains baseline RL agents, environment wrappers, utilities for reward shaping, training and evaluation scripts, and notebooks for analysis.

## **Quickstart**
>
> [TODO](https://github.com/Industrial-Data-Science-AGH/smart-grid-agent/issues/2): Describe quickstart

## Project Structure

- **`core/`** – main Python package with the project’s implementation  
  - **`core/envs/`** – environment wrappers around Grid2Op, configuration and registration of environments  
  - **`core/agents/`** – agent interfaces and implementations (baseline agents, RL agents, heuristics)  
  - **`core/training/`** – training loops, callbacks (logging, checkpointing), and integration with configs  
  - **`core/evaluation/`** – evaluation pipelines, metrics, and reporting utilities  
  - **`core/utils/`** – shared helpers (logging, seeding, config loading, path utilities, etc.)  
  - **`core/scripts/`** – Python entrypoints for running training/evaluation (e.g. `train_agent.py`, `evaluate_agent.py`)  
  - **`core/tests/`** – tests for the modules inside `core/` (unit and integration tests)

- **`sandboxes/`** – transient notebooks, prototyping scripts, and exploratory analysis.  
  Use this for experiments that are **not** yet production-ready; once stabilized, code should be promoted into `core/`.

- **Root files**  
  - **`README.md`** – main documentation and quickstart  
  - **`pyproject.toml`** – Python dependencies and project metadata (managed via `uv`)  
  - **`Dockerfile` / `docker-compose.yml`** (planned) – containerized development and execution environment

## **Contributing Guidelines**

- **Commits:** Please follow the Conventional Commits specification for all commit messages.

 Example: `feat(agent): add PPO baseline for top-5 grid`

 Quick cheatsheet:

- `feat(...)`: a new feature
- `fix(...)`: a bug fix
- `docs(...)`: documentation only changes
- `chore(...)`: build or tooling changes

- **Branches:**
  - `main`: stable code only.
  - Feature branches: `feature/<short-descriptor>` (e.g., `feature/rl-agent-baseline`).
  - Fix branches: `fix/<short-descriptor>`.

- **Pull Requests:** Open a PR from your feature branch into `main`. Include a clear description and motivation.

## **Experimental/Test Work**

    Place transient or prototype code in `sandboxes/` (use descriptive subfolders, e.g., `sandboxes/grid_creation`, `sandboxes/public_grid2op_caseA`). Ensure each sandbox contains a short `README.md` describing purpose, entrypoint scripts, config file names, and any external references. Promote any stable or shared utilities back to `experiments/` or `agent/` once they are no longer experimental.

## **References**

- Grid2Op project: <https://github.com/Grid2op/grid2op>
- Grid2Op documentation: <https://grid2op.readthedocs.io/en/latest/>
