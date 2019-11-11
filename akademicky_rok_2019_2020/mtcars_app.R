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
            
            tableOutput(outputId = "my_table")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_table <- renderTable(
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
        rownames = TRUE
    )
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





