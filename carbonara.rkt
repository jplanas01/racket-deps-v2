(boiling-water
  ((water 5)
   (salt -1)))
(cut-guanciale
  ((guanciale 3)
   (clean-knife -1)
   (clean-cutting-board -1)))
(grated-cheese
  ((parmesan-cheese 3)
   (clean-grater -1)))
(whisked-eggs
  ((eggs -1)
   (egg-yolks 4)
   (pepper -1)
   (grated-cheese -1)))
(pasta-water
  ((semi-cooked-pasta -1)))
(crisp-guanciale
  ((cut-guanciale 7)
   (olive-oil -1)
   (clean-pot -1)))
(guanciale-fat
  ((crisp-guanciale -1)))
(semi-cooked-pasta
  ((pasta -1)
   (boiling-water 4)))
(cooked-pasta
  ((guanciale-fat -1)
   (semi-cooked-pasta 2)
   (dirty-guanciale-pot -1)
   (pasta-water -1)))
(water-eggs
  ((whisked-eggs 1)
   (pasta-water -1)))
(sauced-pasta
  ((cooked-pasta 2)
   (water-eggs -1)))
(finished-pasta
  ((crisp-guanciale -1)
   (sauced-pasta 2)
   (grated-cheese-2 -1)
   (pepper-2 -1)))
