###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("Kalendářový vstup"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            dateInput(
                inputId = "first_date",
                label = "Zvolte datum",
                format = "dd. mm. yyyy",
                startview = "month",
                weekstart = 0,
                language = "cs"
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            strong("Rozdíl mezi dneškem a zvoleným datem je [ve dnech]:"),
            tags$br(),
            tags$br(),
            textOutput(outputId = "my_difference")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_difference <- renderText({
        
        as.numeric(
            Sys.Date() - input$first_date
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





