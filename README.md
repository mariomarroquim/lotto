# Lotto

This project is a set of single-file Ruby command-line scripts that generate tickets for Brazilian lotteries, currently Lotofácil and Mega-Sena. Each script is generated from a Markdown spec (`lotofacil.md` → `lotofacil.rb`, `megasena.md` → `megasena.rb`), and the spec is the source of truth for its behavior. The scripts need no gems.

## Instructions

This is a standard Ruby application. Run `bundle`, then the script you want.

### Mega-Sena examples

```bash
ruby megasena.rb              # 1 ticket, different mode
ruby megasena.rb 5            # 5 tickets, different mode
ruby megasena.rb 5 similar    # 5 tickets, similar mode
```

The script takes two optional arguments:

- **Quantity** (default `1`): how many tickets to print. Invalid values or values below 1 become 1.
- **Mode** (default `different`): the order in which tickets are chosen. Any unrecognized value becomes `different`.
  - `different` prefers tickets that share few numbers with the others.
  - `similar` prefers tickets that share many numbers with the others.

Example output of `ruby megasena.rb 3 similar`:

```text
Mega-Sena Ticket Generator
Amount: 3
Mode: similar
Rules: 6 unique numbers (01-60) | Odds: 1..5 | Sum: 104..267 | Unique tickets
--------------------------------------------------------------------------------
Ticket 01: [ 12 - 18 - 26 - 37 - 45 - 56 ] (Odds: 02, Sum: 194, Score: 00)
Ticket 02: [ 08 - 10 - 30 - 43 - 44 - 51 ] (Odds: 02, Sum: 186, Score: 05)
Ticket 03: [ 05 - 10 - 11 - 12 - 36 - 53 ] (Odds: 03, Sum: 127, Score: 05)
```

`Score` is the highest number of values a ticket shares with any ticket generated before it. The first ticket is always random and scores 0.

## Support

You can contact me at mariomarroquim@gmail.com.
