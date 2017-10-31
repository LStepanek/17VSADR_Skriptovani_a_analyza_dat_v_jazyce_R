###############################################################################
###############################################################################
###############################################################################

## instaluji a loaduji balíček ------------------------------------------------

for(my_package in c(
    
    "openxlsx"
    
)){
    
    if(!(my_package %in% rownames(installed.packages()))){
    
        install.packages(
            my_package,
            dependencies = TRUE,
            repos = "http://cran.us.r-project.org"
        )
        
    }
    
    library(my_package, character.only = TRUE)
    
}


## nastavuji handling se zipováním v R ----------------------------------------

#### !!! nutné předem nainstalovat Rtools z adresy
#### https://cran.r-project.org/bin/windows/Rtools/ ---------------------------

Sys.setenv(R_ZIPCMD = "C:/Rtools/bin/zip")


## ----------------------------------------------------------------------------

###############################################################################

## vytvářím sešit -------------------------------------------------------------

my_workbook <- createWorkbook()


## tohle jsou moje data, je to věstavěný dataset mtcars -----------------------

my_table <- mtcars


## vytvářím excelový list -----------------------------------------------------
    
addWorksheet(
    wb = my_workbook,
    sheetName = "můj první list"
)


## ukládám do listu data ------------------------------------------------------

writeData(
    wb = my_workbook,
    sheet = "můj první list",
    rowNames = FALSE,
    colNames = TRUE,
    x = my_table
)


## nastavuji automatickou šířku sloupce ---------------------------------------
 
setColWidths(
    wb = my_workbook,
    sheet = "můj první list",
    cols = 1:dim(my_table)[2],
    widths = "auto"
)


## vytvářím dva své styly - jednak tučné písmo, jednak písmo zarovnané
## doprava v rámci buňky ------------------------------------------------------

my_bold_style <- createStyle(textDecoration = "bold")
right_halign_cells <- createStyle(halign = "right")

addStyle(
    wb = my_workbook,
    sheet = "můj první list",
    style = my_bold_style,
    rows = c(1:(dim(my_table)[1] + 1), rep(1, (dim(my_table)[2]))),
    cols = c(rep(1, dim(my_table)[1] + 1), 1:(dim(my_table)[2])),
    stack = TRUE
)

addStyle(
    wb = my_workbook,
    sheet = "můj první list",
    style = right_halign_cells,
    rows = 1:(dim(my_table)[1]),
    cols = 2:(dim(my_table)[2] + 1),
    gridExpand = TRUE,
    stack = TRUE
)


## ukládám workbook -----------------------------------------------------------

saveWorkbook(
    wb = my_workbook,
    file = "moje_tabulka_je_ted_v_excelu.xlsx",
    overwrite = TRUE
)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





