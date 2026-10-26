# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

Single-file Ruby CLIs that generate tickets for Brazilian lotteries, one per spec: `lotofacil.md` → `lotofacil.rb`, `megasena.md` → `megasena.rb`. There are no gems and no test suite.

## Specs prevail

Each `<game>.md` spec is the source of truth, and its `<game>.rb` script is generated from it.
- When code and spec disagree, the spec wins: fix the code or ask, and never change the spec to match the code.
- Change behavior by editing the spec first. Keep it tight, but complete enough to regenerate the script from scratch: any behavior the code relies on must be written there.
- To regenerate, delete the script and rewrite it from the spec (don't patch it in place).
- The specs share one structure and differ only in game parameters (pool, ticket size, odd and sum ranges). Keep them in sync when changing shared behavior.

## Running

```bash
ruby lotofacil.rb [amount] [mode]   # mode: different (default) | similar
ruby megasena.rb [amount] [mode]
```

The output is random. To verify a change, run the script and check every ticket against the spec's constraints and output format.
