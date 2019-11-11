###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("Nahrávání vlastních dat"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            fileInput(
                inputId = "my_file",
                label = "Vyberte .csv/.txt soubor",
                accept = c(
                    "text/csv",
                    "text/comma-separated-values,text/plain",
                    ".csv"
                ),
                placeholder = "Nevybrán žádný soubor"
            ),
            
            tags$hr(),
            
            radioButtons(
                inputId = "separator_option",
                label = "Oddělovač",
                choices = c(
                    "středník" = ";",
                    "čárka" = ",",
                    "tabulátor" = "\t"
                ),
                selected = ";"
            ),
            
            tags$hr(),
            
            checkboxInput(
                inputId = "my_header",
                label = "Jsou přítomny popisky sloupců?",
                value = TRUE
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            tableOutput(outputId = "my_content")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_content <- renderTable({
    
        if(is.null(input$my_file)){
            
            return(NULL)
            
        }
        
        read.table(
            input$my_file$datapath,
            header = input$my_header,
            sep = input$separator_option
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





