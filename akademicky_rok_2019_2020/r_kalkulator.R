###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("R kalkulátor"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            textInput(
                inputId = "my_input",
                label = "Sem vložte výraz, který má být spočítán",
                placeholder = "2+1"
            ),
            
            submitButton(text = "Spočítej!")
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            strong("Výsledek výrazu:"),
            tags$br(),
            tags$br(),
            textOutput(outputId = "my_result")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    output$my_result <- renderText({
        
        try(
            eval(
                parse(
                    text = input$my_input
                )
            ),
            silent = TRUE
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





