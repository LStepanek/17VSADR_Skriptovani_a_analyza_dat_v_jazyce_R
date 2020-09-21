###############################################################################
###############################################################################
###############################################################################

## hello world ----------------------------------------------------------------

print("hello world")


## ----------------------------------------------------------------------------

###############################################################################

## práce s nápovědou ----------------------------------------------------------

help(print)
?print
???print  # fulltextové prohledávání offline souborů s nápovědou


## numerická hodnota ----------------------------------------------------------

5; -13.8; 4.5578e15
is.numeric(-13.8)   # TRUE
class(-13.8)        # "numeric"
class(Inf)          # "numeric"


## celé číslo -----------------------------------------------------------------

5L; 13L; -5L
is.integer(-13L)   # TRUE
class(-13L)        # "integer"
is.integer(-13)    # FALSE
class(-13)         # "numeric"

x <- 5L
class(x)           # "integer"
x <- as.numeric(x)
class(x)           # "numeric"


## logická hodnota ------------------------------------------------------------

TRUE; FALSE; T; F
is.logical(TRUE)     # TRUE
class(FALSE)         # "logical"
class("TRUE")        # "character"
class(T)             # "logical"
class(F)             # "logical"


## textový řetězec ------------------------------------------------------------

"ahoj"; 'xweiwogw23425ng'; ""
is.character("ahoj")  # TRUE
class("bla bla")      # "character"
class("123")          # "character"
class(123)            # "numeric"
is.numeric(Inf)       # TRUE
is.numeric("Inf")     # FALSE

x <- 123
class(x)              # "numeric"
x <- as.character(x)
class(x)              # "character"


## chybějící hodnota, NULL, Not a Number --------------------------------------

log(-1)          # NaN
is.na(NaN)       # TRUE
is.nan(NA)       # FALSE
is.nan(1 / 0)    # FALSE
1 / 0            # Inf


## přiřazení hodnoty k proměnné -----------------------------------------------

x = 5

# nebo
x <- 5
5 -> x     # totéž

# nebo
assign("x", 5)  # analogické k x <- 5 či x = 5


## ----------------------------------------------------------------------------

###############################################################################

## vektory a operace s nimi ---------------------------------------------------

###############################################################################

## tvorba vektorů a základní příkazy ------------------------------------------

c()              # prázdný vektor
length(c())      # 0
c(3, 1, 2)       # vektor o délce 3 a prvcích 3, 1, 2
c("a", "d")      # vektor o dél. 2 a prvcích "a", "d"
c(c(3, 1, 2), 4) # vektor o prvcích 3, 1, 2, 4
c(3, 1, 2, 4)    # zkráceně totéž


x <- c(3, 1, 2)
length(x)       # 3
y <- 1
z <- c(2)
w <- c(5, 7)
x <- c(x, y)    # prodloužení vektoru x
                # o hodnotu y
w <- c(w, z)    # prodloužení vektoru w
                # o vektor z
                # jednoprvkový vektor je
                # skalárem, jednou hodnotou
c <- c(1, 2, 3)
c               # vektor o prvcích 1, 2, 3
                # byť je c referovaný termín,
                # funkce c je zachována
                # a vznikl vektor c


## vektory textových řetězců --------------------------------------------------

x <- c(3, 1, 2)
y <- c("a", "b", "c")
names(x) <- y    # pojmenuje prvky
                 # vektoru x
x
unname(x)        # zbaví prvky vektoru
                 # x jeho jejich jmen
setNames(x, y)   # opět pojmenuje
                 # prvky vektoru x


## subvektory, indexování, adresace -------------------------------------------

x <- 1:10    # vektor o prvcích 1, 2, ..., 10
y <- 5:1     # vektor o prvcích 5, 4, ..., 1
z <- seq(from = 2, to = 10, by = 2)
             # vektor o prvcích 2, 4, 6, 8, 10
w <- seq(2, 10, 2)
             # totéž


x <- c(4, 2, 6, -3)
x[1]            # 4
x[1:2]          # c(4, 2)
x[5]            # NA
x[length(x)]    # -3
x[c(1, 3, 4)]   # c(4, 6, -3)
x[length(x):1]  # c(-3, 6, 2, 4)
rev(x)          # totéž, c(-3, 6, 2, 4)


## logické vektory ------------------------------------------------------------

y <- c(TRUE, TRUE, FALSE, TRUE) # logický vektor
x <- c(3, 1, 2, 5)
x[y]                 # (sub)vektor c(3, 1)
x[c(F, T, F, T)]     # subvektor c(1, 5)

z <- c("R", "G", "E", "F", "I")
z[c(T, F)]    # vybere pouze hodnoty
              # na lichých pozicích,
              # tedy "R", "E", "I"
              # neboli vektor
              # c("R", "E", "I")


## faktory --------------------------------------------------------------------

x <- factor(
  c("muž", "žena", "muž", "muž")
)        # pořadí kategorií je defaultně
         # abecední
x <- factor(
  c("muž", "žena", "muž", "muž"),
  levels = c("žena", "muž")
)        # zde si pořadí kategorií
         # určíme sami

table(x)
# x
# žena  muž 
#    1    3 


## aritmetické operace --------------------------------------------------------

2 + 3                   # 5
15 + 25 + 35            # 75
c(1, 2) + c(10, 20)     # c(11, 22)

12 * 3                  # 36
35 * 25 * 15            # 13125
c(12, 25) * c(3, 6)     # c(36, 150)

12 / 3                  # 4
45 / 5 / 3              # 3
c(12, 25) / c(3, 5)     # c(4, 5)

2 ^ 3                   # 8
2 ** 3                  # 8; Python-like notace
4 ^ 3 ** 2              # 262144
4 ^ (3 ** 2)            # 262144
(4 ^ 3) ** 2            # 4096; pozor na
                        # uzávorkování !!!
c(25, 36) ^ 0.5         # c(5, 6); odmocňování
c(5, 3) ^ c(2, 3)       # c(25, 27)
c(5, 3) ** c(2, 3)      # c(25, 27)

12 %% 3                 # 0
10 %% 3                 # 1
10 %% -3                # -2
5 %% 0                  # NaN; n nesmí
                        # být nula !
17 %% 23                # 17

12 %/% 3                   # 4
10 %/% 3                   # 3
10 %/% -3                  # -2
5 %/% 0                    # Inf
17 %/% 23                  # 0
23 %/% 17                  # 1
17 %/% 5                   # 3; celočíselné
                           # dělení
(17 - 17 %% 5) / 5         # 3; explicitní
                           # výpočet
(17 %/% 5) * 5 + (17 %% 5) # 17



## logické operace ------------------------------------------------------------

c(FALSE, FALSE, TRUE, TRUE) &
c(FALSE, TRUE, FALSE, TRUE)
    # c(FALSE, FALSE, FALSE, TRUE)

c(FALSE, FALSE, TRUE, TRUE) |
c(FALSE, TRUE, FALSE, TRUE)
    # c(FALSE, TRUE, TRUE, TRUE)

! TRUE              # FALSE
! 2 > 3             # TRUE 

all(c(3 > 2, 7 %% 3 == 1, 1 == 0))  # FALSE
all(c(3 > 2, 7 %% 3 == 1, 1 >= 0))  # TRUE

any(c(3 < 2, 7 %% 3 <= 0, FALSE))   # FALSE
any(c(3 < 2, 7 %% 3 >= 1, FALSE))   # TRUE


## operace porovnávání --------------------------------------------------------

2 == 3             # FALSE
`==`("a", "a")     # TRUE; prefix notace
all.equal(c(1, 2), c(1, 2 + 1e-13),
          tolerance = 1e-12)
                   # TRUE; porovnává vektory
                   # volitelnou danou tolerancí
identical(c(1, 2), c(1, 2 + 1e-13))
                   # FALSE, porovnává objekty
                   # a vrací TRUE jen při úplné
                   # shodě

2 < 3              # TRUE
"b" <= "a"         # FALSE; porovnává pořadí
                   # v abecedě
`>`(12, 11)        # TRUE; prefix notace
FALSE >= TRUE      # FALSE; porovnává hodnotu
                   # v booelovské aritmetice
                   # (TRUE := 1, FALSE := 0)
2 != 3             # TRUE     
TRUE != FALSE      # TRUE
`!=`(FALSE, FALSE) # FALSE; prefix notace

c(2, 6) %in% c(1:5)      # c(TRUE, FALSE)
"k" %in% LETTERS         # FALSE
"J" %in% letters         # FALSE
"May" %in% month.name    # TRUE
`%in%`("Jan", month.abb) # TRUE; prefix notace
"a" %in% "abeceda"       # FALSE

is.element(c(2, 6), c(1:5))
                         # c(TRUE, FALSE)
is.element(c(1:5), c(2, 6))
                         # c(FALSE, TRUE,
                         # FALSE, FALSE, FALSE)

isTRUE(3^2 > 2^3)        # TRUE


## zaokrouhlování, formátování čísel ------------------------------------------

round(1.4, digits = 0)     # 1
round(-146.655, 2)         # -146.66

signif(1.458, digits = 1)  # 1
signif(1.458, digits = 2)  # 1.5
signif(1.458, digits = 3)  # 1.46
signif(1.458, digits = 4)  # 1.458

format(1.45, nsmall = 1)   # "1.45"
format(1.45, nsmall = 2)   # "1.45"
format(1.45, nsmall = 3)   # "1.450"


## ----------------------------------------------------------------------------

###############################################################################

## tvorba matic a základní příkazy --------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2,
            ncol = 2)
B <- matrix(c(1, 3, 2, 4), nrow = 2,
            ncol = 2)
B <- matrix(c(1, 2, 3, 4), nrow = 2,
            ncol = 2, byrow = TRUE)
# vždy jeden z argumentů "nrow", či "ncol" je zbytný


## manipulace s maticemi ------------------------------------------------------

C <- matrix(letters[1:12], nrow = 3,
            byrow = T)
          
is.matrix(C)  # TRUE
class(C)      # "matrix"
mode(C)       # "character"; datový typ prvků
str(C)        # chr [1:3, 1:4] "a" "e" "i" ...
dim(C)        # c(3, 4); rozměry matice C

colnames(C) <- c("c1", "c2", "c3", "c4")
rownames(C) <- c("r1", "r2", "r3")
        # přidá jmenovky sloupcům i řádkům
C <- unname(C)
        # zbaví sloupce i řádky jmenovek
dimnames(C) <- list(
    c("r1", "r2", "r3"),
    c("c1", "c2", "c3", "c4")
)       # opět přidá jmenovky sloupcům i řádkům

rbind(C, c("x", "x", "x", "x"))
        # přidání řádku c("x", "x", "x", "x")
        # k matici C
cbind(C, c("x", "x", "x"))
        # přidání sloupce c("x", "x", "x")
        # k matici C
C[-1, ]   # odebrání 1. řádku matici C
C[, -2]   # odebrání 2. sloupce matici C


## submatice, indexování, adresace --------------------------------------------

C <- matrix(letters[1:12],
            nrow = 3,
            byrow = T,
            dimnames = list(
                c("r1", "r2", "r3"),
                c("c1", "c2", "c3", "c4")
            ))

C[2, 3]       # "g"; prvek 2. řádku, 3. sloupce
C["r2", "c3"] # "g"; prvek 2. řádku, 3. sloupce
C[1, ]        # c("a", "b", "c", "d");
              # tedy vektor 1. řádku matice C
              # s popisky

C[, 3]        # c("c", "g", "k");
              # tedy vektor 3. sloupce matice C
              # s popisky
C[c(1, 3), c(2, 4)]
              # matrix(c("b", "j", "d", "l"), 2)
              # submatice 1. a 3. řádku,
              # 2. a 4. sloupce matice C
              # s popisky
C["r2", ]     # c("e", "f", "g", "h");
              # tedy vektor 2. řádku matice C
              # s popisky

C[dim(C)[1], dim(C)[2]]
           # "l"; obecná adresace prvku
           # vpravo dole (např. neznáme-li
           # číselné rozměry matice)
C[5]       # "f"; major-column ordering
C[c(8, 9)] # c("g", "k")
C[13]      # NA
diag(C)    # c("a", "f", "k"); hlavní diagonála
diag(C[, dim(C)[2]:1])
           # c("d", "g", "j"); vedlejší diagonála


## ----------------------------------------------------------------------------

## <OPTIONAL>

## maticová algebra -----------------------------------------------------------

A <- matrix(c(1, 2, 3, 4), nrow = 2)
B <- matrix(c(5, 6, 7, 8), nrow = 2)

A * B     # matrix(c(5, 12, 21, 32), 2)
A %*% B   # matrix(c(23, 34, 31, 46), 2)

t(A)      # matrix(c(1, 3, 2, 4), 2)


## </OPTIONAL>


## ----------------------------------------------------------------------------

## tvorba datových tabulek a základní příkazy ---------------------------------

mtcars
str(mtcars)
class(mtcars)          # "data.frame"
mode(mtcars)           # "list"
is.data.frame(mtcars)  # TRUE      
str(iris)
  # 'data.frame': 150 obs. of 5 variables
  # ...
dim(iris)              # c(150, 5)


## manipulace s datovými tabulkami --------------------------------------------

data <- mtcars
colnames(data)
colnames(data) <- paste("c",
                      1:dim(data)[2],
                      sep = "_")
rownames(data) <- paste("r",
                      1:dim(data)[1],
                      sep = "_")
              # změní jmenovky sloupcům i řádkům
head(data)    # náhled na prvních 6 řádků
head(data, 10)
              # náhled na prvních 10 řádků
tail(data)    # náhled na posledních 6 řádků
tail(data, 10)
              # náhled na posledních 10 řádků

rbind(data, rep(0, dim(data)[2]))
              # přidání řádku c(0, 0, ..., 0)
              # k data.frameu "data"
cbind(data, rep(0, dim(data)[1]))
              # přidání sloupce c(0, 0, ..., 0)
              # k data.frameu "data"
data.frame(data,
           "ahoj" = rep(0, dim(data)[1]))
              # přidání sloupce c(0, 0, ..., 0)
              # se jménem "ahoj" k data.frameu
              # "data"
data[-1, ]    # odebrání 1. řádku data.frameu
              # "data"
data[, -1]    # odebrání 1. sloupce data.frameu
              # "data"


## indexování, adresace -------------------------------------------------------

data[2, 3]    # 160; prvek 2. řádku, 3. sloupce
data["r_2", "c_3"]
              # 160; prvek pod danými popisky
data[1, ]     # c(21, 6, 160, 110, ...);
              # tedy vektor 1. řádku data.frameu
              # "data" s popisky
data[, 2]     # c(6, 6, 4, 6, ...);
              # tedy vektor 2. sloupce
              # data.frameu "data" s popisky                    
data$c_5      # c(3.90, 3.90, 3.85, 3.08, ...);
              # tedy vektor 2. sloupce
              # data.frameu "data" s popisky
data$c_5[1]   # 3.9;
              # tedy první prvek 2. sloupce
              # data.frameu "data"

data[dim(data)[1], dim(data)[2]]
                 # 2; obecná adresace prvku
                 # vpravo dole (např. neznáme-li
                 # číselné rozměry tabulky)
      data[5]    # 5. sloupec, nikoliv major-column
                 # ordering


## sloupcové přehledy ---------------------------------------------------------

colSums(data)
         # součty všech sloupců
apply(data, 2, sum)
         # totéž
colMeans(data)
         # průměry všech sloupců
apply(data, 2, mean)
         # totéž
data <- rbind(data, rep(NA, dim(data)[2]))
         # přidán řádek c(NA, NA, ...)
colMeans(data)
         # c(NA, NA, ...); pro získání průměrů
         # nutné přidat argument na.rm = TRUE
colMeans(data, na.rm = TRUE)
apply(data, 2, mean, na.rm = TRUE)
         # už funguje


## ----------------------------------------------------------------------------

## tvorba seznamů a základní příkazy ------------------------------------------

my_list <- list("a" = c(1:10),
                "b" = mtcars,
                "c" = matrix(1:8, 2),
                "z" = "ahoj")
str(my_list)
class(my_list)         # "list"
mode(my_list)          # "list"
is.list(my_list)       # TRUE


## manipulace se seznamy ------------------------------------------------------

names(my_list)      
names(my_list) <- LETTERS[
    1:length(my_list)
]           # přejmenovávám prvky listu

my_list[[length(my_list) + 1]] <- c(T, F)
names(length(my_list)) <- "XY"
            # přidání vektoru c(T, F)
            # k listu "my\_list" pod jménem
            # "XY"


## indexování, adresace -------------------------------------------------------

my_list[[2]]  # 2. prvek listu
my_list[["B"]]
              # prvek listu pod jmenovkou "B"
              # jde o původní datový typ
              # (data.frame)
my_list["B"]  # prvek listu pod jmenovkou "B"
              # jde (vždy) o list
my_list[c(2, 4)]
              # 2. a 4. prvek listu
my_list$C     # prvek listu pod jmenovkou "C"
my_list[[1]][2]
              # 2; 2. prvek 1. prvku listu
my_list[[2]][3, 5]
              # 3.85; z 2. prvku listu vybírám
              # prvek o souřadnicích (3, 5)


set.seed(1)
my_long_list <- lapply(
    sample(c(80:120), 100, TRUE),
    function(x) sample(
        c(50:150),
        x,
        replace = TRUE
    )
)   # list vektorů náhodné délky
    # generovaných z náhodných čísel

lapply(my_long_list, "[[", 14)
    # z každého prvku listu (vektoru)
    # vybírám jen jeho 14. prvek


## prvkové přehledy -----------------------------------------------------------

lapply(my_long_list, mean)
    # pro každý prvek listu (vektor)
    # vracím jeho průměr
  
lapply(my_long_list, length)
    # pro každý prvek listu (vektor)
    # vracím jeho délku


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





