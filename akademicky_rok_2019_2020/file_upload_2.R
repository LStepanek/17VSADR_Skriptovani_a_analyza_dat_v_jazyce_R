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
                value = FALSE
            ),
            
            tags$hr(),
            
            uiOutput(
                outputId = "my_variable_selection"
            )
            
        ),
        
        ## výstupy; pravý panel -----------------------------------------------
        
        mainPanel(
            
            tableOutput(outputId = "my_content"),
            plotOutput(outputId = "my_plot")
            
        )
        
    )
    
)


## serverová strana -----------------------------------------------------------

server <- function(input, output){
    
    my_data <- reactive({
        
        if(is.null(input$my_file)){
            
            return(NULL)
            
        }
        
        return(
            read.table(
                input$my_file$datapath,
                header = input$my_header,
                sep = input$separator_option
            )
        )
        
    })
    
    output$my_content <- renderTable({
    
        my_data()
        
    })
    
    observe(
        
        if(!is.null(input$my_file) & input$my_header){
            
            output$my_variable_selection <- renderUI({
                
                selectInput(
                    inputId = "my_variable",
                    label = "Vyberte proměnnou k analýze",
                    choices = c(
                        colnames(my_data())
                    ),
                    selected = colnames(my_data())[1]
                )
                
            })
            
        }else{
            
            output$my_variable_selection <- renderUI({
                NULL
            })
            
        }
        
    )
    
    output$my_plot <- renderPlot({
        
        if(class(my_data()[, input$my_variable]) != "numeric"){
            
            return(NULL)
            
        }
        
        hist(
            my_data()[, input$my_variable],
            main = "",
            col = "grey",
            xlab = input$my_variable,
            ylab = "absolutní četnost"
        )
        
    })
    
}


## zavolání aplikace ----------------------------------------------------------

shinyApp(ui, server)


## ----------------------------------------------------------------------------

###############################################################################
###############################################################################
###############################################################################





