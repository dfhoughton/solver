# solver

This is a simple bit of code for solving arithmetic puzzles of the form
"How do can you make `x` using any of the operators `+`, `-`, `*`, `/`, or `**` (exponentiation)
and the four integers `a`, `b`, `c`, `d`?"

It works by iterating over all permutations of the integers, all ways to pick three operators, and all ways of grouping the four
integers, solving the arithmetic, and comparing the result to the goal. This is not the most efficient way to solve the problem
and it doesn't normalize away irrelevant variations in the grouping tree. It gets the job done, though.

## example

```
solver (master=) $ ruby -I. solutions.rb
give me a number to look for:
24
give me 4 integers separated by spaces:
7 8 9 10
looking for ways to make 24 out of [7, 8, 9, 10]

SOLUTIONS:
( ( 8 * 9 ) / ( 10 - 7 ) )
( 8 * ( 9 / ( 10 - 7 ) ) )
( ( 8 / ( 10 - 7 ) ) * 9 )
( 8 / ( ( 10 - 7 ) / 9 ) )
( ( 9 * 8 ) / ( 10 - 7 ) )
( 9 * ( 8 / ( 10 - 7 ) ) )
( ( 9 / ( 10 - 7 ) ) * 8 )
( 9 / ( ( 10 - 7 ) / 8 ) )

again? [Yn]

give me a number to look for:
24
give me 4 integers separated by spaces:
8 9 10 11
looking for ways to make 24 out of [8, 9, 10, 11]

SOLUTIONS:
none found

again? [Yn]
n
solver (master=) $ 
```
