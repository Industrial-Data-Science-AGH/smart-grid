"""Unzip RL2Grid's pre-computed topology action spaces for the requested grids.

Usage:  python scripts/setup_action_spaces.py [env_id ...]    (default: bus14)

Only the requested grids are unzipped: bus14 is 139 kB, the 118-bus files are
hundreds of MB. Safe to run repeatedly: files already present are skipped.
"""

import sys
import zipfile
from pathlib import Path

ENV_DIR = Path(__file__).resolve().parents[1] / "third_party" / "RL2Grid" / "env" # ../ is root


def main(env_ids: list[str]) -> None:
    with zipfile.ZipFile(ENV_DIR / "action_spaces.zip", mode="r") as archive:
        for env_id in env_ids:
            member = f"action_spaces/{env_id}_action_space.npy"
            if (ENV_DIR / member).exists():
                print(f"ok    {member} (already unzipped)")
                continue
            try:
                archive.extract(member, ENV_DIR)
            except KeyError:
                sys.exit(f"error: no action space for {env_id!r} in {archive.filename}")
            print(f"done  {member}")


if __name__ == "__main__":
    main(sys.argv[1:] or ["bus14"]) # every script argument which are the streing env ids
