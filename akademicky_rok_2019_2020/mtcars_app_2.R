###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("Dataset mtcars"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            checkboxGroupInput(
                inputId = "my_multiple_checkbox",
                label = "Vyberte proměnné k zobrazení",
                choices = c(
                    "cylinders" = "cyl",
                    "transmission" = "am",
                    "gears" = "gear"
                ),
                selected = NULL
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            dataTableOutput(outputId = "my_table")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_table <- renderDataTable(
        {
            
            mtcars[
                ,
                c(
                    "mpg",
                    input$my_multiple_checkbox
                ),
                drop = FALSE
            ]
            
        },
        options = list(
            
            scrollX = TRUE,
            #dom = "t",      # odkomentování zruší možnost prohledávat tabulku
            paging = TRUE    # paging = TRUE vede na stránkování tabulky
            
        )
    )
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





