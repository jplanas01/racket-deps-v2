#!/bin/sh
/Applications/Racket\ v6.12/bin/racket deps-v2.rkt $1
#apparently not needed when running from commandline
#echo ";}}" >> deps-graph.dot
ed deps-graph.dot < remove-weights.ed > /dev/null
dot -Tpng deps-graph.dot -o $(echo $1 | cut -d '.' -f 1).png
