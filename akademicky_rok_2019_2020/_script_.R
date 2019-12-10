###############################################################################
###############################################################################
###############################################################################

## instaluji a loaduji balíčky ------------------------------------------------

invisible(
    lapply(c(
            "openxlsx",
            "xtable",
            "HSAUR2",
            "gamair",
            "survival",
            "coin",
            "ipred",
            "TH.data",
            "party",
            "e1071",
            "rpart",
            "tree",
            "neuralnet"
        ),
        function(my_package){
            
            if(!(my_package %in% rownames(installed.packages()))){
                
                install.packages(
                    my_package,
                    dependencies = TRUE,
                    repos = "http://cran.us.r-project.org"
                )
                        
            }
            
            library(my_package, character.only = TRUE)
            
        }
    )
)


## ----------------------------------------------------------------------------

###############################################################################

## nastavuji handling se zipováním v R ----------------------------------------

Sys.setenv(R_ZIPCMD = "C:/Rtools/bin/zip")


## ----------------------------------------------------------------------------

###############################################################################

## nastavuji pracovní složku --------------------------------------------------

while(!"_script_.R" %in% dir()){
    
    setwd(choose.dir())
    
}

mother_working_directory <- getwd()


## ----------------------------------------------------------------------------

###############################################################################

## vytvářím posložky pracovní složky ------------------------------------------

setwd(mother_working_directory)

for(my_subdirectory in c("vystupy")){
    
    if(!file.exists(my_subdirectory)){

        dir.create(file.path(
        
            mother_working_directory, my_subdirectory
            
        ))
        
    }
    
}


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################

## helper funkce --------------------------------------------------------------

getMyPrintableLinearModel <- function(
    
    my_summary_of_lm,
    which_to_omit = NULL,
    digits = rep(
        3,
        dim(
            as.data.frame(my_summary_of_lm$coefficients)[,
                setdiff(
                    colnames(as.data.frame(my_summary_of_lm$coefficients)),
                    which_to_omit                     
                )
            ]
        )[2]
    ),
    scientific_notation = FALSE,
    decimal_separator = ".",
    category_separator = " = "
    
){
    
    # '''
    # Vrací tisknutelný výstup sumáře lineárního modelu;
    # rovněž ve výstupu vynechává parametry uvedené v "which_to_omit",
    # digits je vektor délky počtu sloupců výsledného výstupu,
    # který každému sloupci určuje počet cifer, na které budou
    # hodnoty v něm zaokrouhleny.
    # '''
    
    output <- as.data.frame(my_summary_of_lm$coefficients)[,
            setdiff(
                colnames(
                    as.data.frame(my_summary_of_lm$coefficients)
                ),
                which_to_omit                     
            )
        ]
    
    for(i in 1:dim(output)[2]){
        output[, i] <- format(
            round(
                as.data.frame(my_summary_of_lm$coefficients)[,
                    setdiff(
                        colnames(
                            as.data.frame(
                                my_summary_of_lm$coefficients
                            )
                        ),
                        which_to_omit                     
                    )
                ][, i],
                digits = digits[i]
            ),
            nsmall = digits[i],
            digits = digits[i],
            scientific = scientific_notation,
            trim = TRUE
        )
    }
    
    for(i in 1:length(rownames(output))){
        
        for(
            var_label in sort(
                attributes(my_summary_of_lm$terms)$term.labels,
                decreasing = TRUE
            )
        ){
            
            if(
                grepl(
                    paste("^", var_label, sep = ""),
                    rownames(output)[i]
                ) &
                rownames(output)[i] != var_label &
                ! grepl(
                    category_separator,
                    rownames(output)[i]
                )
            ){
                
                rownames(output)[i] <- paste(
                    var_label,
                    category_separator,
                    gsub(
                        paste("^", var_label, sep = ""),
                        "",
                        rownames(output)[i]
                    ),
                    sep = ""
                )
                
            }
            
        }
        
    }
    
    for(i in 1:dim(output)[2]){
        
        output[, i] <- gsub(
            "\\.",
            decimal_separator,
            output[, i]
        )
        
    }
    
    return(output)
    
}


## ----------------------------------------------------------------------------

getMyAccuracy <- function(
    
    my_table

){
    
    # '''
    # Vrací přesnost pro konfuzní matici "my_table".
    # '''
    
    return(
        sum(diag(my_table)) / sum(my_table)
    )
    
}


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################

## lineární regrese -----------------------------------------------------------

#### přímková regrese ---------------------------------------------------------

data(hubble)  # inicializuji data
?hubble

colnames(hubble) <- c(
    "galaxy",
    "velocity",
    "distance"
)


###### diagram ----------------------------------------------------------------

plot(
    velocity ~ distance,
    data = hubble
)
abline(lm(velocity ~ distance,
    data = hubble))


###### model přímkové regrese -------------------------------------------------

my_model <- lm(
    formula = "velocity ~ distance",
    data = hubble
)


my_model <- lm(
    formula = "velocity ~ distance + distance^2",
    data = hubble
)


summary(
    my_model
)

sink("sumar.txt")
summary(
    my_model
)
sink()


coef(
    my_model
)

coef(
    my_model
)[1]

confint(
    my_model
)


###### diagram znovu ----------------------------------------------------------

plot(
    velocity ~ distance,
    data = hubble
)

abline(
    my_model,
    col = "red"
)


###### diagnostika modelu -----------------------------------------------------

plot(my_model)
plot(my_model, which = 1)


###### model přímkové regrese bez absolutního členu ---------------------------

my_model_wo_interpcet <- lm(
    formula = "velocity ~ distance - 1", # big no no
    data = hubble
)

summary(
    my_model_wo_interpcet
)


#### jiný model ---------------------------------------------------------------

data(clouds)
clouds
?clouds

clouds_formula <- rainfall ~
    seeding +
    seeding:sne +
	seeding:cloudcover +
	seeding:prewetness +
	seeding:echomotion +
    time

X_star <- model.matrix(clouds_formula, data = clouds)
attr(X_star, "contrasts")

clouds_lm <- lm(
    clouds_formula,
    data = clouds
)

summary(clouds_lm)

boxplot(
    rainfall ~ seeding,
    data = clouds,
    ylab = "rainfall",
    xlab = "seeding"
)

boxplot(
    rainfall ~ echomotion,
    data = clouds,
    ylab = "rainfall",
    xlab = "echo motion"
)


plot(
    rainfall ~ sne, data = clouds, pch = as.numeric(clouds$seeding),
    xlab = "sne criterion"
)
abline(
    lm(rainfall ~ sne, data = clouds,
    subset = seeding == "no")
)
abline(
    lm(rainfall ~ sne, data = clouds,
    subset = seeding == "yes"), lty = 2
)
legend(
    "topright", legend = c("no seeding", "seeding"),
    pch = 1:2, lty = 1:2, bty = "n"
)


(clouds_resid <- residuals(clouds_lm))
(clouds_fitted <- fitted(clouds_lm))


###### diagnostika modelu -----------------------------------------------------

plot(
    clouds_fitted, clouds_resid, xlab = "fitted values",
    ylab = "residuals", type = "n",
    ylim = max(abs(clouds_resid)) * c(-1, 1)
)
abline(h = 0, lty = 2)
text(
    clouds_fitted, clouds_resid, labels = rownames(clouds)
)

qqnorm(clouds_resid, ylab = "residuals")
qqline(clouds_resid)

plot(clouds_lm)


## ----------------------------------------------------------------------------

###############################################################################

## zobecněné lineární modely, generalized linear models (GLM's) ---------------

#### logistická regrese -------------------------------------------------------

data("plasma", package = "HSAUR2")

plasma
str(plasma)
?plasma

layout(matrix(1:2, ncol = 2))
cdplot(ESR ~ fibrinogen, data = plasma)
cdplot(ESR ~ globulin, data = plasma)


###### model ------------------------------------------------------------------

plasma_glm_1 <- glm(
    formula = "ESR ~ fibrinogen",
    data = plasma,
    family = binomial("logit")
)

confint(plasma_glm_1)
confint(
    plasma_glm_1,
    parm = "fibrinogen"
)


exp(coef(plasma_glm_1)["fibrinogen"])
exp(confint(plasma_glm_1, parm = "fibrinogen"))


###### další model ------------------------------------------------------------

plasma_glm_2 <- glm(
    ESR ~ fibrinogen + globulin,
    data = plasma,
    family = binomial()
)

summary(plasma_glm_2)

anova(
    plasma_glm_1,
    plasma_glm_2,
    test = "Chisq"
)   # porovnání obou předchozích modelů


## diagnostika ----------------------------------------------------------------

my_prediction <- predict(
    plasma_glm_2,
    plasma,
    type = "response"
)

plot(
    globulin ~ fibrinogen,
    data = plasma,
    xlim = c(2, 6),
    ylim = c(25, 55),
    pch = "."
)
symbols(
    plasma$fibrinogen,
    plasma$globulin,
    circles = my_prediction,  # pravděpodobnost
    add = TRUE
)


print(
    xtable(
        plasma_glm_2
    )
)

print(
    xtable(
        table(
            plasma[, "ESR"],
            my_prediction > 0.5
        )
    )
)


#### počítám poměr šancí (OR = odds ratio) a 2,5 % a 97,5 % kvantil -----------

exp(
    cbind(
        "OR" = coef(plasma_glm_2),
        confint(plasma_glm_2)
    )
)


print( # matice záměn, confusion matrix
    table(
        plasma[, "ESR"],
        ifelse(my_prediction > 0.5, "ESR > 20", "ESR < 20"),
        dnn = list(
            "pozorované hodnoty",
            "predikované hodnoty"
        )
    )
)

print(
    getMyAccuracy(
        table(
            plasma[, "ESR"],
            ifelse(my_prediction > 0.5, "ESR > 20", "ESR < 20"),
            dnn = list(
                "pozorované hodnoty",
                "predikované hodnoty"
            )
        )
    )
)


#### poissonská regrese -------------------------------------------------------

data("polyps", package = "HSAUR2")

par(mfrow = c(1, 2))
plot(
    number ~ age,
    data = subset(polyps, treat == "placebo")
)
plot(
    number ~ age,
    data = subset(polyps, treat == "drug")
)

plot(number ~ age, data = polyps, pch = as.numeric(polyps$treat))
legend(40, 40, legend = levels(polyps$treat), pch = 1:2, bty = "n")


polyps_glm_1 <- glm(
    number ~ treat + age, data = polyps,
    family = poisson("log")
)
summary(polyps_glm_1)

exp(coef(polyps_glm_1))


mean(polyps$number)
var(polyps$number)


polyps_glm_2 <- glm(
    number ~ treat + age, data = polyps,
    family = quasipoisson()
)
summary(polyps_glm_2)

exp(coef(polyps_glm_2))


#### podmodel logitu ----------------------------------------------------------

backpain_glm <- clogit(
    I(status == "case") ~ driver + suburban + strata(ID),
    data = backpain
)
print(backpain_glm)


## ----------------------------------------------------------------------------

#### analýza přežití ----------------------------------------------------------

data("glioma", package = "coin")
glioma
str(glioma)
?glioma

layout(matrix(1:2, ncol = 2))
g3 <- subset(coin::glioma, histology == "Grade3")
plot(
    survfit(Surv(time, event) ~ group, data = g3),
    main = "Grade III Glioma", lty = c(2, 1),
    ylab = "Probability", xlab = "Survival Time in Month",
    legend.text = c("Control", "Treated"),
    legend.bty = "n"
)
g4 <- subset(coin::glioma, histology == "GBM")
plot(
    survfit(Surv(time, event) ~ group, data = g4),
    main = "Grade IV Glioma", ylab = "Probability",
    lty = c(2, 1), xlab = "Survival Time in Month",
    xlim = c(0, max(glioma$time) * 1.05)
)


survdiff(
    Surv(time, event) ~ group,
    data = g3
)

logrank_test(
    Surv(time, event) ~ group,
    data = g3,
    distribution = "exact"
)

logrank_test(
    Surv(time, event) ~ group | histology,
    data = glioma,
    distribution = approximate(B = 10000)
)



###### data hormonální terapie karcinomu prsu ---------------------------------

data("GBSG2", package = "TH.data")
plot(
    survfit(Surv(time, cens) ~ horTh, data = GBSG2),
    lty = 1:2, mark.time = FALSE, ylab = "Probability",
    xlab = "Survival Time in Days"
)
legend(
    250, 0.2, legend = c("yes", "no"), lty = c(2, 1),
    title = "hormonal therapy", bty = "n"
)


###### model Coxovy regrese ---------------------------------------------------

GBSG2_coxph <- coxph(Surv(time, cens) ~ ., data = GBSG2)
GBSG2_coxph
summary(GBSG2_coxph)

ci <- confint(GBSG2_coxph)
exp(cbind(coef(GBSG2_coxph), ci))["horThyes",]


GBSG2_zph <- cox.zph(GBSG2_coxph)
GBSG2_zph

plot(GBSG2_zph, var = "age")

layout(matrix(1:3, ncol = 3))
res <- residuals(GBSG2_coxph)    # martingale reziduály
plot(
    res ~ age, data = GBSG2, ylim = c(-2.5, 1.5),
    pch = ".", ylab = "Martingale Residuals"
)
abline(h = 0, lty = 3)
plot(
    res ~ pnodes, data = GBSG2, ylim = c(-2.5, 1.5),
    pch = ".", ylab = ""
)
abline(h = 0, lty = 3)
plot(
    res ~ log(progrec), data = GBSG2, ylim = c(-2.5, 1.5),
    pch = ".", ylab = ""
)
abline(h = 0, lty = 3)



GBSG2_ctree <- ctree(Surv(time, cens) ~ ., data = GBSG2)
plot(GBSG2_ctree)  # podmíněný strom


## ----------------------------------------------------------------------------

###############################################################################

## polynomická regrese --------------------------------------------------------

load("USTemp.RData")

my_model <- lm(
    temp ~ poly(long, degree = 3, raw = TRUE) +
           poly(lat, degree = 3, raw = TRUE),
           data = USTemp
) 
model.matrix(my_model)


## polynomická regrese jinak --------------------------------------------------

my_mode <- lm(
    temp ~ long + I(long^2) + I(long^3) + lat + I(lat^2) + I(lat^3),
    data = USTemp
)


# ortogonální polynomická regrese ---------------------------------------------

my_model <- lm(
    temp ~ poly(long, degree = 3) + poly(lat, degree = 3),
    data = USTemp
)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################

## naivni Bayesův klasifikátor ------------------------------------------------

## loaduji data "HouseVotes84"
data(HouseVotes84, package = "mlbench")

head(HouseVotes84[, 1:16], 4)
## Class V1 V2 V3 V4 V5 V6 V7 V8 V9 V10 V11 V12 V13 V14 V15
## 1 republican n y n y y y n n n y <NA> y y y n
## 2 republican n y n y y y n n n n n y y y n
## 3 democrat <NA> y y <NA> y y n n n n y n y y n
## 4 democrat n y y n <NA> y n n n n y n y n n

## náhodně rozděluji data "HouseVotes84" do trénovací
## a testovací množiny

set.seed(2018)
train_set_indices <- sample(
    1:dim(HouseVotes84)[1],
	floor(0.6 * dim(HouseVotes84)[1]),
	replace = FALSE
)
train_set <- HouseVotes84[train_set_indices, ]
test_set <- HouseVotes84[-train_set_indices, ]

## vytvářím model
my_bayes <- e1071::naiveBayes(Class ~ ., data = train_set)


## a dívám se na první z predikovaných hodnot
head(
    predict(my_bayes, test_set, type = "class")#"class")
)
## [1] republican democrat democrat republican republican republican
## Levels: democrat republican

head(predict(my_bayes, test_set, type = "raw"), 2)
## democrat republican
## [1,] 2.506697e-08 0.9999999749
## [2,] 9.997932e-01 0.0002068392

## vytvářím a dívám se na konfuzní matici
(confusion_matrix <- table(test_set$Class, predict(my_bayes, test_set)))
##
## democrat republican
## democrat 89 13
## republican 5 67


## počítám přesnost
sum(diag(confusion_matrix)) / sum(confusion_matrix) # 0.8965517


##

as.numeric(HouseVotes84[, c(2:17)])

adist(HouseVotes84[, c(2:17)])
?adist

my_data <- HouseVotes84[, c(2:17)]
for(i in 1:dim(my_data)[2]){
    
	my_data[, i] <- ifelse(HouseVotes84[, i] == "y", 1, 0)
	
}

cor(my_data, method = "spearman")

my_hclust <- hclust(
    dist(t(my_data), method = "manhattan")
)

plot(my_hclust)

corrgram(my_data)


## rozhodovací stromy ---------------------------------------------------------

# library(rpart)

fit <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis)
fit2 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              parms = list(prior = c(.65,.35), split = "information"))
fit3 <- rpart(Kyphosis ~ Age + Number + Start, data = kyphosis,
              control = rpart.control(cp = 0.05))
par(mfrow = c(1,2), xpd = NA) # otherwise on some devices the text is clipped
plot(fit)
text(fit, use.n = TRUE)
plot(fit2)
text(fit2, use.n = TRUE)

prune(fit)


# library(tree)

data(cpus, package="MASS")
cpus.ltr <- tree(log10(perf) ~ syct+mmin+mmax+cach+chmin+chmax, cpus)
cpus.ltr
summary(cpus.ltr)
plot(cpus.ltr);  text(cpus.ltr)

ir.tr <- tree(Species ~., iris)
ir.tr
summary(ir.tr)



## neuronové sítě -------------------------------------------------------------

AND <- c(rep(0,7),1)
OR <- c(0,rep(1,7))
binary.data <- data.frame(expand.grid(c(0,1), c(0,1), c(0,1)), AND, OR)
print(net <- neuralnet(AND+OR~Var1+Var2+Var3,  binary.data, hidden=c(5, 5), 
             rep=10, err.fct="ce", linear.output=FALSE))

			 prediction(net)
			 
data(infert, package="datasets")
print(net.infert <- neuralnet(case~parity+induced+spontaneous, infert, 
                    err.fct="ce", linear.output=FALSE, likelihood=TRUE))
                    
plot(net)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





