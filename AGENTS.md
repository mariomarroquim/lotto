# Lotto

Single-file Ruby CLIs that generate tickets for Brazilian lotteries, one per spec: `lotofacil.md` → `lotofacil.rb`, `megasena.md` → `megasena.rb`.

## Project details

Each `<game>.md` spec is the source of truth, and its `<game>.rb` script is generated from it.
- When code and spec disagree, the spec wins: fix the code or ask, and never change the spec to match the code.
- Change behavior by editing the spec first. Keep it tight, but complete enough to regenerate the script from scratch.
- To regenerate, delete the script and rewrite it from the spec (don't patch it in place).
- The specs share one structure and differ only in the game's name and parameters (pool, ticket size, odd and sum ranges).

## Code conventions

- The scripts use no gems. Don't add any dependencies without asking first.
- If the code changes, sync both `AGENTS.md` and `README.md` as well.
- Run the (re)generated scripts to check for errors before every commit.
- This project only uses the `main` branch; commit and push directly to it.
