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
> [TODO](https://github.com/Industrial-Data-Science-AGH/smart-grid-agent/issues/2): Describe quickstart

## **Project Structure**
- **`sandboxes/`**: Transient notebooks, prototyping scripts, and exploratory analysis.
- **`core/`**: Stable, production-ready implementation of the project's main components.
> [TODO](https://github.com/Industrial-Data-Science-AGH/smart-grid-agent/issues/2): add and describe final project structure

Core functionality lives in the top-level folders. Keep experiments and quick prototypes inside `sandboxes/` to avoid polluting the main implementation.

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

- Grid2Op project: https://github.com/Grid2op/grid2op
- Grid2Op documentation: https://grid2op.readthedocs.io/en/latest/

