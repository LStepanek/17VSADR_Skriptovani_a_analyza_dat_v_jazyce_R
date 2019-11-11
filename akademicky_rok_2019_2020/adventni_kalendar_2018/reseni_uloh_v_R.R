###############################################################################
###############################################################################
###############################################################################

## úloha 1 --------------------------------------------------------------------

kolik_lamp <- 2018
svitici_lampy <- rep(FALSE, kolik_lamp)

for(i in c(1:kolik_lamp)){
    
    svitici_lampy[
        c(1:kolik_lamp) %% i == 0
    ] <- !svitici_lampy[
        c(1:kolik_lamp) %% i == 0
    ]
    
}

sum(svitici_lampy)      # 44
floor(sqrt(kolik_lamp)) # 44


## ----------------------------------------------------------------------------

###############################################################################

## úloha 2 --------------------------------------------------------------------

epsilon <- 0.0005
pocet_opakovani <- 1000
kandidati_na_p <- NULL

for(p in seq(0, 1, by = 0.0005)){
    
    kolik_hodu_trefilo_terc <- 0
    kolik_hodu_dal_nez_p_od_stredu <- 0
    
    for(i in 1:pocet_opakovani){
        
        souradnice <- runif(2)
        
        if(
            sqrt(souradnice[1] ^ 2 + souradnice[2] ^ 2) <= 1.0
        ){
            kolik_hodu_trefilo_terc <- sum(
                kolik_hodu_trefilo_terc,
                1
            )
        }
        
        if(
            sqrt(souradnice[1] ^ 2 + souradnice[2] ^ 2) <= 1.0 &
            sqrt(souradnice[1] ^ 2 + souradnice[2] ^ 2) >= p
        ){
            kolik_hodu_dal_nez_p_od_stredu <- sum(
                kolik_hodu_dal_nez_p_od_stredu,
                1
            )
        }
        
        if(
            !is.nan(
                kolik_hodu_dal_nez_p_od_stredu / kolik_hodu_trefilo_terc
            )
        ){
            
            if(
                abs(
                    kolik_hodu_dal_nez_p_od_stredu / kolik_hodu_trefilo_terc -
                    p
                ) < epsilon
            ){
                kandidati_na_p <- c(kandidati_na_p, p)
            }
            
        }
        
        flush.console()
        print(
            paste(
                "Proces hotov pro p = ",
                format(round(p, digits = 4), nsmall = 4),
                ", z ",
                format(
                    round(
                        i / pocet_opakovani * 100,
                        digits = 2
                    ),
                    nsmall = 2
                ),
                " %.",
                sep = ""
            )
        )
        
    }
    
}

kandidati_na_p                         # 0.618
round((sqrt(5) - 1) / 2, digits = 3)   # 0.618


## ----------------------------------------------------------------------------

###############################################################################

## úloha 3 --------------------------------------------------------------------

sum(
    1 - pchisq(q = 1, df = 1),
    1 - pchisq(q = 2, df = 1),
    1 - pchisq(q = 3, df = 1),
    1 - pchisq(q = 4, df = 1)
) * 0.25                     ## 0.1508436


## anebo

sum(
    1 - pnorm(1),
    1 - pnorm(sqrt(2)),
    1 - pnorm(sqrt(3)),
    1 - pnorm(2)
) * 0.25 * 2                 ## 0.1508436


## ----------------------------------------------------------------------------

###############################################################################

## úloha 4 --------------------------------------------------------------------

zbyle_petice <- combn(1:40, 5, simplify = FALSE)
length(zbyle_petice) == choose(40, 5)

NSD_zbylych_petic <- lapply(
    
    zbyle_petice,
    function(i){
        
        gcd <- 1
        
        for(j in 1:max(i)){
            
            if(
                i[1] %% j == 0 &
                i[2] %% j == 0 &
                i[3] %% j == 0 &
                i[4] %% j == 0 &
                i[5] %% j == 0
            ){
                
                gcd <- j
                
            }
            
        }
        
        return(gcd)
        
    }
    
)

sum(unlist(NSD_zbylych_petic) > 1) / choose(40, 5)    # 0.02559543


## ----------------------------------------------------------------------------

###############################################################################

## úloha 5 --------------------------------------------------------------------

my_p <- NULL

pocet_opakovani <- 10000

for(j in 1:pocet_opakovani){
    
    pocet_vyberu <- 10000
    pocet_hitu <- 0
    
    for(i in 1:pocet_vyberu){
        
        my_coordinates <- runif(2)
        
        x <- my_coordinates[1]
        y <- my_coordinates[2]
        
        if(max(c(x ^ 2, y ^ 2)) / min(c(x, y)) >= 2){
            
            pocet_hitu <- pocet_hitu + 1
            
        }
        
    }
    
    my_p <- c(my_p, pocet_hitu / pocet_vyberu)
    
}

mean(my_p)    # 0.3333


## ----------------------------------------------------------------------------

###############################################################################

## úloha 6 --------------------------------------------------------------------

n <- 2018
my_last_six_digits <- 1

for(i in 1:n){
    
    my_last_six_digits <- ((my_last_six_digits * 2) %% 1000000)
    
}

#### posledních šestičíslí tedy je --------------------------------------------

my_last_six_digits - 1


## ----------------------------------------------------------------------------

###############################################################################

## úloha 7 --------------------------------------------------------------------

getMyPavementsCount <- function(n){
    
    # '''
    # Vrací počet navzájem různých způsobů, jak vydláždit
    # chodník n x 1 pomocí pěti typů dlaždic, a sice:
    # 1 x 1,
    # 2 x 1,
    # 3 x 1,
    # 4 x 1,
    # 5 x 1.
    # Od každé dlaždice je dostatečný počet kusů.
    # '''
    
    if(n == 1){return(1)}    # [1 x 1]
    if(n == 2){return(2)}    # [1 x 1, 1 x 1],
                             # [2 x 1]
    if(n == 3){return(4)}    # [1 x 1, 1 x 1, 1 x 1],
                             # [2 x 1, 1 x 1],
                             # [1 x 1, 2 x 1],
                             # [3 x 1]
    if(n == 4){return(8)}    # [1 x 1, 1 x 1, 1 x 1, 1 x 1],
                             # [2 x 1, 1 x 1, 1 x 1],
                             # [1 x 1, 2 x 1, 1 x 1],
                             # [1 x 1, 1 x 1, 2 x 1],
                             # [2 x 1, 2 x 1],
                             # [1 x 1, 3 x 1],
                             # [3 x 1, 1 x 1],
                             # [4 x 1]
    if(n == 5){return(16)}   # [1 x 1, 1 x 1, 1 x 1, 1 x 1, 1 x 1],
                             # [2 x 1, 1 x 1, 1 x 1, 1 x 1],
                             # [1 x 1, 2 x 1, 1 x 1, 1 x 1],
                             # [1 x 1, 1 x 1, 2 x 1, 1 x 1],
                             # [1 x 1, 1 x 1, 1 x 1, 2 x 1],
                             # [2 x 1, 2 x 1, 1 x 1],
                             # [2 x 1, 1 x 1, 2 x 1],
                             # [1 x 1, 2 x 1, 2 x 1],
                             # [3 x 1, 1 x 1, 1 x 1],
                             # [1 x 1, 3 x 1, 1 x 1],
                             # [1 x 1, 1 x 1, 3 x 1],
                             # [3 x 1, 2 x 1],
                             # [2 x 1, 3 x 1],
                             # [4 x 1, 1 x 1],
                             # [1 x 1, 4 x 1],
                             # [5 x 1]
    
    if(n > 5){
        
        return(
            getMyPavementsCount(n - 1) +
            getMyPavementsCount(n - 2) +
            getMyPavementsCount(n - 3) +
            getMyPavementsCount(n - 4) +
            getMyPavementsCount(n - 5)
        )
        
    }
    
}


getMyPavementsSequence <- function(
    
    n,
    apply_precision = FALSE,
    precision = 1e10
    
){
    
    # '''
    # Vrací poslední člen
    # sekvence počtů navzájem různých způsobů, jak vydláždit
    # chodníky 1 x 1, 2 x 1, ..., n x 1 pomocí pěti typů dlaždic,
    # a sice:
    # 1 x 1,
    # 2 x 1,
    # 3 x 1,
    # 4 x 1,
    # 5 x 1.
    # Od každé dlaždice je dostatečný počet kusů.
    # Argument "precision" udává, kolik posledních cifer výsledku má
    # být vráceno.
    # '''
    
    my_sequence <- c(1, 2, 4, 8, 16)
    
    if(n <= 5){
        
        return(my_sequence[n])
        
    }else{
        
        for(i in 6:n){
            
            my_sequence <- c(
                
                my_sequence,
                if(apply_precision){
                    
                    (
                        sum(
                            my_sequence[
                                (length(my_sequence) - 4):
                                length(my_sequence)
                            ]
                        ) %% precision
                    )
                    
                }else{
                    
                    (
                        sum(
                            my_sequence[
                                (length(my_sequence) - 4):
                                length(my_sequence)
                            ]
                        )
                    )
                    
                }
                
            )
            
        }
        
        return(my_sequence[n])
        
    }
    
}

getMyPavementsSequence(2018, TRUE, 1e6)    # 859394


## ----------------------------------------------------------------------------

###############################################################################

## úloha 8 --------------------------------------------------------------------

my_count <- 0
writeLines(con = "my_counter.txt", text = as.character(my_count))

getMyTribonacci <- function(n){
    
    # '''
    # Vrací 'n'-té Tribonaccohpo číslo.
    # '''
    
    my_count <- as.integer(readLines(con = "my_counter.txt"))
    my_count <- my_count + 1
    writeLines(con = "my_counter.txt", text = as.character(my_count))
   
    if(n <= 3){
        return(1)
    }else{
        return(
            getMyTribonacci(n - 1) +
            getMyTribonacci(n - 2) +
            getMyTribonacci(n - 3)
        )
    }
    
}

## getMyTribonacci(i + 1) := http://oeis.org/A000213
## my_count pro i := http://oeis.org/A248098

getMyTribonacci(19)                              # 25281
as.integer(readLines(con = "my_counter.txt"))    # 37921


#getMyTribonacci(42)                             # 30883847113
#as.integer(readLines(con = "my_counter.txt"))   # 46325770669


## ----------------------------------------------------------------------------

###############################################################################

## úloha 9 --------------------------------------------------------------------

isTriangle <- function(x, y, z){
    
    # '''
    # Pro kladná čísla "x", "y", "z" vrací TRUE,
    # pokud mohou "x", "y", "z" tvořit strany trojúhelníka;
    # jinak vrací FALSE.
    # '''
    
    return(
        x + y + z > 2 * max(c(x, y, z))     # trojúhelníková nerovnost
    )
    
}


n <- 2018

count_of_triangles <- 0
count_of_addends <- 0

for(i in 1:(n - 2)){
    
    for(j in (i + 1):(n - 1)){
        
        a <- i
        b <- j - i
        c <- n - j
        
        count_of_addends <- sum(            
            count_of_addends,
            1            
        )
        
        if(isTriangle(a, b, c)){
            
            count_of_triangles <- sum(
                count_of_triangles,
                1
            )
            
        }
        
        flush.console()
        print(
            paste(
                "Hodnota a = ",
                a,
                ", b = ",
                b,
                ".",
                sep = ""
            )
        )
        
    }
    
}

count_of_triangles / count_of_addends



#### nejlepší algoritmus ------------------------------------------------------

n <- 2018

count_of_triangles <- 0

for(c in 1:(ceiling(n / 2) - 1)){
    
    count_of_triangles <- sum(
        count_of_triangles,
        if(
            (floor((n - 2 * c) / 2) + 1) <=
            ((n - c) - (floor((n - 2 * c) / 2) + 1))
        ){
            length(
                (floor((n - 2 * c) / 2) + 1) :
                ((n - c) - (floor((n - 2 * c) / 2) + 1))
            )
        }else{
            0
        }
    )
    
}

count_of_triangles / choose(n - 1, 2)  # 0.2496282
# (1008 * 1009 / 2) / (2016 * 2015 / 2)  # 0.2503722


## ----------------------------------------------------------------------------

###############################################################################

## úloha 10 -------------------------------------------------------------------

2018 %% 3      # 2018 dává po dělení 3 zbytek 2
(pocet_trojek <- (2018 - 2) / 3)
               # 672

## je proto vhodné číslo 2018 rozdělit na jednu dvojku a 672 trojek;
## součin oné jedné dvojky a oněch 672 trojek je maximální možný hledaný
## součin

my_product <- 2

for(i in 1:pocet_trojek){
    
    my_product <- (my_product * 3) %% 1e6
    
}

my_product     # 769282


## ----------------------------------------------------------------------------

###############################################################################

##

isTriangle <- function(x, y, z){
    
    # '''
    # Pro kladná čísla "x", "y", "z" vrací TRUE,
    # pokud mohou "x", "y", "z" tvořit strany trojúhelníka;
    # jinak vrací FALSE.
    # '''
    
    return(
        x + y + z > 2 * max(c(x, y, z))     # trojúhelníková nerovnost
    )
    
}


n <- 10

count_of_triangles <- 0

for(a in 1:n){
    
    for(b in 1:n){
        
        for(c in 1:n){
            
            if(isTriangle(a, b, c)){
                
                count_of_triangles <- sum(
                    count_of_triangles,
                    1
                )
                
                print(paste(a, b, c, sep = " "))
                
            }
            
            # flush.console()
            # print(
                # paste(
                    # "Hodnota a = ",
                    # a,
                    # ", b = ",
                    # b,
                    # ", c = ",
                    # c,
                    # ".",
                    # sep = ""
                # )
            # )
            
        }
        
    }
    
}

count_of_triangles / (n ^ 3)


#### více analytický přístup --------------------------------------------------

#### zvolím-li náhodně čísla a a b tak, že obě jsou z množiny {1, 2, ..., n},
#### pak třetí strana potenciálního trojúhelníka, c, musí splňovat

#### max(a, b) - min(a, b) < c < max(a, b) + min(a, b)
#### a současně c <= n

#### --------------------------------------------------------------------------

n <- 2017

n_of_triangles <- 0

for(a in 1:n){
    
    for(b in 1:n){
        
        n_of_triangles <- sum(
            
            n_of_triangles,
            length(
                c(
                    (max(c(a, b)) - min(c(a, b)) + 1) :
                    (max(c(a, b)) + min(c(a, b)) - 1)
                )[
                    c(
                        (max(c(a, b)) - min(c(a, b)) + 1) :
                        (max(c(a, b)) + min(c(a, b)) - 1)
                    ) <= n
                ]
            )
            
        )
        
        flush.console()
        print(
            paste(
                "Hodnota a = ",
                a,
                ", b = ",
                b,
                ".",
                sep = ""
            )
        )
        
    }
    
}

n_of_triangles / (n ^ 3)


#### efektivní přístup --------------------------------------------------------

library(pbapply)

n <- 2017

my_sides <- cbind(
    unlist(
        lapply(
            1:n,
            function(x) rep(x, n)
        )
    ),
    unlist(
        lapply(
            1:n,
            function(x) c(1:n)
        )
    )
)

number_of_triangles <- sum(
    (
        pbapply(
            my_sides,
            1,
            function(x){
                length(
                    c(
                        (max(x) - min(x) + 1) :
                        (max(x) + min(x) - 1)
                    )[
                        c(
                            (max(x) - min(x) + 1) :
                            (max(x) + min(x) - 1)
                        ) <= n
                    ]
                )
            }
        )
    )
)

number_of_triangles / (n ^ 3)


## ----------------------------------------------------------------------------

###############################################################################

## úloha 11 -------------------------------------------------------------------








## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





