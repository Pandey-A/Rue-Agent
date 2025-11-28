#!/usr/bin/env bash
set -euo pipefail

MAIN_FILE="frontend/electron/main.js"

start_date="2025-04-24"
end_date="2025-06-24"

# how many commits per day
COMMITS_PER_DAY=5

current_date="$start_date"

# NOTE: current script was already used to generate commits for 2025-04-24.
# If you want to regenerate for the whole range, we should fix date handling first.

while [ "$current_date" = "$start_date" ]; do
  echo "=== $current_date ==="

  for i in $(seq 1 "$COMMITS_PER_DAY"); do
    # Make a tiny deterministic change to main.js
    echo "// tweak $current_date commit #$i" >> "$MAIN_FILE"

    # Pick a time during the day (9:00 + i*5 minutes)
    hour=9
    minute=$((i * 5))
    commit_time=$(printf "%sT%02d:%02d:00" "$current_date" "$hour" "$minute")

    export GIT_AUTHOR_DATE="$commit_time"
    export GIT_COMMITTER_DATE="$commit_time"

    git add "$MAIN_FILE"
    git commit -m "chore: tweak main.js on $current_date (#$i)"

    echo "  committed: $current_date (#$i) at $commit_time"
  done

  # next day
  current_date=$(date -jf "%Y-%m-%d" "$current_date" -v+1d +%Y-%m-%d)
done

echo "All commits created. Remember to push with:"
echo "  git push origin main"
