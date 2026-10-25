# Lotofácil

## Role and Task
Write a command-line Ruby script (`lotofacil.rb`) to generate valid tickets for the Brazilian lottery "Lotofácil".
Each ticket consists of 15 unique numbers from 1 to 25, sorted ascending. Delete `lotofacil.rb`, if it exists, before regenerating it.

## Command-Line Arguments
The script must accept two positional arguments:
1. `amount` (Integer): The number of tickets to print. Defaults to 1. Values below 1 (or non-numeric) are clamped to 1.
2. `mode` (String): `"different"` (default) or `"similar"`. Case-insensitive; any unrecognized value falls back to `"different"`.

## Strict Constraints
A valid ticket MUST meet all the following criteria:
* **Uniqueness:** No ticket can be identical to another ticket.
* **Odd Numbers:** The ticket must contain between 5 and 10 odd numbers (inclusive).
* **Sum Range:** The sum of the numbers must be strictly between 146 and 245 (i.e. 147..244).

## Algorithm Requirements
1. **Baseline:** Draw random tickets until one is valid. It gets score 0 and is always printed first.
2. **Candidates:** Draw 999 more random tickets. Skip invalid ones and duplicates of any already accepted ticket. Score each accepted candidate against every ticket accepted before it (the baseline plus earlier candidates), where overlap = count of shared numbers:
   * **"different":** score = HIGHEST overlap. Sort candidates by score ascending.
   * **"similar":** score = LOWEST overlap. Sort candidates by score descending.
3. **Selection:** Output the baseline followed by the sorted candidates, truncated to `amount`. If there are fewer valid tickets than `amount`, print what exists.

## Output Formatting
* First print the execution details: amount, mode, rules applied, then a separator line.
* Print each ticket on its own line, numbered `Ticket NN:`, with the numbers in brackets separated by ` - `.
* Zero-pad every number to two digits (ticket index, ticket numbers, odds, score).
* End each line with `(Odds: XX, Sum: YYY, Score: ZZ)`.
* Example line: `Ticket 01: [ 01 - 05 - 12 - ... ] (Odds: 08, Sum: 195, Score: 05)`.
