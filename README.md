# solver

This is a simple bit of code for solving arithmetic puzzles of the form
"How do can you make `x` using any of the operators `+`, `-`, `*`, `/`, or `**` (exponentiation)
and the four integers `a`, `b`, `c`, `d`?"

It works by iterating over all permutations of the integers, all ways to pick three operators, and all ways of grouping the four
integers, solving the arithmetic, and comparing the result to the goal. This is not the most efficient way to solve the problem
and it doesn't normalize away irrelevant variations in the grouping tree.
