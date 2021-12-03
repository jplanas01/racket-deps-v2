A directed graph visualization of a process (usually cooking in my use cases). Requires dot, ed, and Racket. To run, modify produce.sh to point to the correct Racket and dot paths.

The deps-v2.rkt program takes in as an argument the Lisp file that contains the ingredients in the process and produces a directed graph with edge costs along with a report of the raw ingredients, utensils, and critical path. Several examples are provided.

Every input element is an S-expression where the first element is the name of the intermediate ingredient and the second is a list of inputs into that intermediate step. Each consists of the name of the input and an edge cost.

Conventions used in the input:
- Anything with a 'clean-' or 'dirty-' prefix and no inputs is considered an utensil
- Anything that is not an utensil and has no inputs is considered a raw ingredient (this can lead to a few things like water being considered a raw ingredient)
- Anything that is not an input to anything else is considered a final product
- Edge costs are cooking times and an edge cost of -1 means that that ingredient doesn't 'carry' the cooking time.
- Items with identical names are treated identically. This means that if you need to salt 2 ingredients separately, you should use salt-1 and salt-2 (see cordon-bleu.rkt for an example)
- The program reports the critical path, but I believe this will only work correctly if every intermediate step only has one output (i.e., not what carbonara.rkt does). The critical path is defined as the costliest path from a raw ingredient to the final product, so I'm not sure how this works for branches.

