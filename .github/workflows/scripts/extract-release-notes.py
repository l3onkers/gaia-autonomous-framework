#!/usr/bin/env python3
"""
Extract release notes for a given version from CHANGELOG.md
Usage: python3 extract-release-notes.py <version>
Example: python3 extract-release-notes.py 1.1.0
"""

import sys
import os

if len(sys.argv) < 2:
    print("Error: version argument required", file=sys.stderr)
    sys.exit(1)

target = sys.argv[1].lstrip("v")
repo_root = os.path.abspath(os.path.join(os.path.dirname(__file__), "../../.."))
changelog_path = os.path.join(repo_root, "CHANGELOG.md")

if not os.path.exists(changelog_path):
    print(f"Error: {changelog_path} not found", file=sys.stderr)
    sys.exit(1)

found = False
notes = []

with open(changelog_path, "r", encoding="utf-8") as f:
    for line in f:
        if line.startswith(f"## [{target}]"):
            found = True
            continue
        elif found and line.startswith("## ["):
            break
        elif found:
            notes.append(line)

content = "".join(notes).strip()
if not content:
    content = f"GAIA Autonomous Framework release v{target}."

print(content)
