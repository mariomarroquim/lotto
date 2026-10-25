# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A single-file Ruby CLI that generates tickets for the Brazilian lottery Lotofácil. There are no gems and no test suite.

## Specs prevail

`Lotofacil.md` is the source of truth. `lotofacil.rb` is generated from it.
- When code and spec disagree, the spec wins: fix the code or ask, and never change the spec to match the code.
- Change behavior by editing the spec first. Keep it tight, but complete enough to regenerate the script from scratch: any behavior the code relies on must be written there.
- To regenerate, delete `lotofacil.rb` and rewrite it from the spec (don't patch it in place).

## Running

```bash
ruby lotofacil.rb [amount] [mode]   # mode: different (default) | similar
```

The output is random. To verify a change, run the script and check every ticket against the spec's constraints and output format.
