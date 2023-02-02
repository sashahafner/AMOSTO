
source('amosto.R')

man.type <- 'pig'
slurr.prod <- 2.73
TAN <- 3.3
pH <- 7.2
stor.type <- 'tank'
stor.surf <- 333
cover <- 'none'
temp <- c(0, 0, 2.1, 5.7, 10.8, 14.3, 15.6, 15.7, 12.7, 9.1, 4.7, 1.6)

args(amosto)

amosto(man.type = 'pig',
       slurry.prod = 2.73,
       TAN = 3.3,
       pH = 7.2,
       stor.type = 'tank',
       stor.surf = 333,
       cover = 'none',
       temp = c(0, 0, 2.1, 5.7, 10.8, 14.3, 15.6, 15.7, 12.7, 9.1, 4.7, 1.6))


amosto(man.type = 'pig',
       slurry.prod = 2.73,
       TAN = 3.3,
       pH = 7.2,
       stor.type = 'tank',
       stor.surf = 333,
       cover = 'lid',
       temp = c(0, 0, 2.1, 5.7, 10.8, 14.3, 15.6, 15.7, 12.7, 9.1, 4.7, 1.6))

amosto(man.type = 'cattle',
       slurry.prod = 2.73,
       TAN = 3.3,
       pH = 7.2,
       stor.type = 'lagoon',
       stor.surf = 333,
       cover = 'lid',
       temp = c(0, 0, 2.1, 5.7, 10.8, 14.3, 15.6, 15.7, 12.7, 9.1, 4.7, 1.6))


