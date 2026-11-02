# Lotto

Lotto is a set of Ruby scripts that generate tickets for Brazilian lotteries, currently Lotofácil and Mega-Sena. Each script is generated from a Markdown spec (`lotofacil.md` → `lotofacil.rb`, `megasena.md` → `megasena.rb`), and the spec is the source of truth for its behavior. The scripts need no gems.

## Instructions

This is a standard Ruby application. Run the script you want (e.g., `megasena.rb`).

### Mega-Sena examples

```bash
ruby megasena.rb           # 1 ticket, different mode
ruby megasena.rb 5         # 5 tickets, different mode
ruby megasena.rb 5 similar # 5 tickets, similar mode
```

The script takes two optional arguments:

- **Quantity** (default `1`): how many tickets to print.
- **Mode** (default `different`):
  - `different` prefers tickets that share few numbers with the others.
  - `similar` prefers tickets that share many numbers with the others.

## Support

You can contact me at mariomarroquim@gmail.com.
