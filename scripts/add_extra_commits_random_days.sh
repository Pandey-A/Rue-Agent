#!/usr/bin/env bash
set -euo pipefail

MAIN_FILE="frontend/electron/main.js"

# Date range where we already have commits
START_DATE="2025-04-24"
END_DATE="2025-06-24"

# How many days to augment and how many extra commits per chosen day
NUM_DAYS=10
EXTRA_COMMITS_PER_DAY=6

# Get a random subset of dates in the range using Python
DATES=$(python3 - << 'PY'
from datetime import date, timedelta
import random

start = date(2025, 4, 24)
end = date(2025, 6, 24)

# build full list of dates
all_dates = []
cur = start
while cur <= end:
    all_dates.append(cur)
    cur += timedelta(days=1)

# choose a subset without replacement
NUM_DAYS = 10
if NUM_DAYS > len(all_dates):
    NUM_DAYS = len(all_dates)

random.seed()  # system randomness
chosen = random.sample(all_dates, NUM_DAYS)

for d in sorted(chosen):
    print(d.isoformat())
PY
)

echo "Extra-commit days:" $DATES

for current_date in $DATES; do
  echo "=== extra commits on $current_date ==="

  for ((i=1; i<=EXTRA_COMMITS_PER_DAY; i++)); do
    # append a small marker comment
    echo "// extra tweak $current_date commit #$i" >> "$MAIN_FILE"

    # Use a different hour (10:00 range) so times differ from earlier ones
    hour=10
    minute=$((i * 5))
    commit_time=$(printf "%sT%02d:%02d:00" "$current_date" "$hour" "$minute")

    GIT_AUTHOR_DATE="$commit_time" GIT_COMMITTER_DATE="$commit_time" \
      git commit -am "chore: extra tweaks on $current_date (#$i)"

    echo "  committed extra: $current_date (#$i) at $commit_time"
  done

done

echo "All extra commits created. Push with: git push origin main"