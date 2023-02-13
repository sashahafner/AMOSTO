# R function for AMOSTO model for ammonia loss from stored animal slurry

# Define mass transfer resistances
mtr <- matrix(c(118, 303, 100, 131, 262, 156), nrow = 3, 
              dimnames = list(man.type = c('cattle', 'pig', 'digestate'),
                              stor.type = c('lagoon', 'tank')))

# Define cover reductions
cvrred <- c(straw = 0.33, `surface crust, natural` = 0.45, `clay pebbles` = 0.41, 
            `floating PVC (non porous)` = 0.16, `biocover (porous sheet)` = 0.66, 
            `corrugated sheets` = 0.46, lid = 0.06, tent = 0.17, oil = 0.14, 
            peat = 0.24, `wood chips` = 0.53, none = 1)
  

amosto <- function(
  man.type = 'pig', 
  slurry.prod,
  TAN,
  pH,
  stor.type,
  stor.surf,
  cover = 'none',
  temp,
  R = NA,
  days = c(`1` = 31, `2` = 28.25, `3` = 31, `4` = 30, `5` = 31, `6` = 30, `7` = 31, `8` = 31, `9` = 30, `10` = 31, `11` = 30, `12` = 31)
  ) {

  if (is.na(R)) {
    man.type <- tolower(man.type)
    stor.type <- tolower(stor.type)
    R <- mtr[man.type, stor.type] 
  }

  if (!is.na(cover) | tolower(cover) != 'none') {
    cover <- tolower(cover)
    if (cover %in% names(cvrred)) {
      R <- R / cvrred[cover]
    } else {
      stop('Value of cover argument,', cover, 'not recognized.\nOptions are:', names(cvrred))
    }
  }

  # Constants
  tempk <- temp + 273.15
  ka <- exp((14.01708 - (10294.83 / (tempk)) - 0.039282 * (tempk)) - (191.97 - 8451 / (tempk) - 31.4335 * log(tempk) + 0.0152123 * (tempk)))
  kh <- exp(-(160.559 - (8621.06 / (tempk)) - (25.6767 * log(tempk)) + (0.035388 * (tempk))))
  hnry <- kh * 0.08205746 * tempk

  # Equilibrium NH3 (g) at surface (g/L)
  cNH3 <- TAN / (1 + (10^(-pH)) / ka) /hnry

  # Flux (g/d-m2)
  jNH3 <- 1000 * cNH3/R * 86400 

  # Monthly loss (kg)
  mm <- jNH3 * days * stor.surf / 1000
  total = sum(mm)
  frac <- total / (slurry.prod * TAN) 

  return(list(monthly = mm, total = total, frac = frac))

}

