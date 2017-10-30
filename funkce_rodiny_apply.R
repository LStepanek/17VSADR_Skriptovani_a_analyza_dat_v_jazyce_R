###############################################################################
###############################################################################
###############################################################################

## skript pro účely uvedení do funkcí rodiny apply() --------------------------

###############################################################################

## apply() funkce, vhodná především pro matice --------------------------------

(my_matrix <- matrix(1:(5 * 7), nrow = 5))


apply(
    my_matrix,
    1,
    sum
)    ## součty nad řádky

apply(
    my_matrix,
    2,
    mean
)    ## průměry nad sloupci

apply(
    my_matrix,
    1,
    paste,
    collapse = "_"
)    ## pastování čísel z řádků pomocí oddělovače "_"

apply(
    my_matrix,
    2,
    function(x) sum(x) ^ 2 
)    ## definování anonymní funkce nad sloupci

apply(
    my_matrix,
    2,
    function(x, a, b) a * x + b,
    a = 2,
    b = 1
)    ## definování anonymní funkce nad sloupci má-li však funkce
     ## další argumenty v hlavičce


## ----------------------------------------------------------------------------

###############################################################################

## lapply() funkce, vhodná především pro vektory či listy ---------------------

getMyFifthPower <- function(x){

    # '''
    # vrací pátou mocninu čísla "x"
    # '''
    
    x ^ 5
    
}


## testuji lapply() vs. for cyklus nad stejnou operací ------------------------

my_n <- 10000000


## nejdřív lapply() -----------------------------------------------------------

beginning_lapply <- proc.time()

output_lapply <- lapply(list(1:my_n), getMyFifthPower)

end_lapply <- proc.time()


## nyní for() cyklus ----------------------------------------------------------

beginning_for <- proc.time()

output_for <- rep(0, my_n)

for(i in 1:my_n){
    output_for[i] <- getMyFifthPower(i)
}

end_for <- proc.time()


## porovnání obou časů --------------------------------------------------------

end_lapply - beginning_lapply
end_for - beginning_for
     ## lapply() je značně rychlejší než for()


## ----------------------------------------------------------------------------

###############################################################################

## pokusy s lapply() ----------------------------------------------------------

set.seed(1)

my_list <- lapply(
    sample(c(80:120), 100, TRUE),
    function(x) sample(c(50:150), x, replace = TRUE)
)    ## list vektorů náhodné délky generovaných z náhodných čísel

    
lapply(my_list, "[[", 3)
lapply(my_list, "[[", 14)
     ## vybírám jen 14-tý prvek z každého vektoru
     ## listu "my_list"

	 
lapply(
    my_list,
    sum
)    ## součty vektorů listu "my_list"


set.seed(1)
my_long_list <- lapply(
    sample(c(80:120), 100, TRUE),
    function(x) sample(
        c(50:150), x, replace = TRUE
    )
)    # list vektorů náhodné délky
     # generovaných z náhodných čísel

lapply(my_long_list, "[[", 14)
     # z každého prvku listu (vektoru)
     # vybírám jen jeho 14. prvek

lapply(my_long_list, mean)
     # pro každý prvek listu (vektor)
     # vracím jeho průměr

## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





