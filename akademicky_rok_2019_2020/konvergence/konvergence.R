###############################################################################
###############################################################################
###############################################################################

library("shiny")


## uživatelské rozhraní -------------------------------------------------------

ui <- fluidPage(
    
    # "nadpis" aplikace -------------------------------------------------------
    
    titlePanel("Zobrazení histogramu"),
    
    sidebarLayout(
        
        # ovládací prvky aplikace (vstupy; levý panel) ------------------------
        
        sidebarPanel(
            
            actionButton(
                inputId = "plus_one_button",
                label = "Zvyš počet pozorování o 1!"
            ),
            
      			tags$br(),
      			tags$br(),
			
            sliderInput(
                inputId = "y_lim",
                label = "Hranice svislé osy diagramu",
                min = 0,
                max = 5,
                value = 1,
                step = 0.1
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            plotOutput(outputId = "my_plot")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    my_values <- reactiveValues(
        
        my_mean = NULL,
        n_of_observations = 0
        
    )
    
    observeEvent(
        input$plus_one_button,
        {
            
            my_values$my_mean <- c(
                
                my_values$my_mean,
                mean(
                    c(
                        my_values$my_mean,
                        rnorm(1)
                    )
                )
                
            )
            
            my_values$n_of_observations <- sum(
                
                my_values$n_of_observations,
                1
                
            )
            
        }
    )
    
    output$my_plot <- renderPlot({
        
        plot(
            x = 1:my_values$n_of_observations,
            y = my_values$my_mean,
            xlab = "počet pozorování ve výběru",
            ylab = "bodový odhad průměru",
            type = "b",
            ylim = c(-input$y_lim, input$y_lim)
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





