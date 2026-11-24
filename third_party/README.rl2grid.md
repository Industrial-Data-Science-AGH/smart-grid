# Vendored: RL2Grid

- URL: <https://github.com/emarche/RL2Grid>
- Revision: 6cd81a1426422feffcd997a51b16d2f6e4f49e00
- Update mechanism: Manual, git subtree --squash (see below)
- License: MIT, see LICENSE
- Description: RL baselines for Grid2Op power-grid control; our training runs build on it.

## Local modifications

None.
<!-- One line per change: what and why, with the commit, e.g.
     "Checkpoints also save observation normalization statistics (a1b2c3d)". -->

## Rules and commands

- Bug fixes here are fine (commit message starting `rl2grid:`); new features go in src/core.
- Don't reformat these files: it makes every upstream update conflict.
- Update: `git subtree pull --prefix=third_party/RL2Grid <https://github.com/emarche/RL2Grid.git> <commit> --squash`,
  merge with a merge commit, then update Revision here and COMMIT in src/core/rl2grid.py.
- Exact diff against upstream (takes into account our project structure):
  `git diff --stat $(git log -1 --grep="Squashed 'third_party/RL2Grid/'" --format=%h) HEAD:third_party/RL2Grid`
