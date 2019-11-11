###############################################################################
###############################################################################
###############################################################################

## loaduju balíčky ------------------------------------------------------------

library(shiny)
library(shinyjs)


## ----------------------------------------------------------------------------

###############################################################################

## helper funkce --------------------------------------------------------------

updateMyScores <- function(

  index_of_problem,
  user_nickname,
  user_password,
  user_solution,
  correct_solution,
  score_table,
  passwords_table,
  attempt_counts_table

){

  #### flow-control -----------------------------------------------------------

  if(is.null(user_solution)){return(NULL)}

  # if(grepl(";", user_nickname)){
    # user_nickname <- paste("xy", floor(runif(1) * 10000), sep = "_")
  # }
  if(grepl(";", user_nickname)){
    user_nickname <- gsub(";", "", user_nickname)
  }
  if(grepl(";", user_password)){
    return(
        list(
          score_table,
          passwords_table,
          attempt_counts_table
        )
    )
  }
  if(grepl(";", user_solution)){
    user_solution <- "wrong_solution"
  }

  # if(user_nickname == ""){
    # user_nickname <- paste("xy", floor(runif(1) * 10000), sep = "_")
  # }
  if(user_nickname == ""){
    return(
        list(
          score_table,
          passwords_table,
          attempt_counts_table
        )
    )
  }
  if(user_password == ""){
    return(
        list(
          score_table,
          passwords_table,
          attempt_counts_table
        )
    )
  }
  if(user_solution == ""){
    user_solution <- "wrong_solution"
  }
  
  
  #### pokud je řešitel známý a použije špatné heslo, funkce nic neupdatuje ---
  
  if(
    user_nickname %in% score_table[, 1]
  ){
      
      if(
          user_password != passwords_table[
              passwords_table[, 1] == user_nickname,
              2
          ]
      ){
          
          return(
            list(
              score_table,
              passwords_table,
              attempt_counts_table
            )
          )
          
      }
      
  }
  
  
  #### je-li řešitel již známý ------------------------------------------------

  if(
    user_nickname %in% score_table[, 1]
  ){


    #### a odpoví-li správně --------------------------------------------------

    if(
      user_solution %in% correct_solution
    ){

      #### je mu případně zvednut počet pokusů o jeden, pokud již
      #### předtím neodpověděl správně ----------------------------------------

      if(
        score_table[
          score_table[, 1] == user_nickname,
          1 + index_of_problem
        ] %in% c("0", "")
      ){

        if(
          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
          ] == ""
        ){

          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
          ] <- "1"

        }else{

          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
          ] <- as.integer(
            attempt_counts_table[
              attempt_counts_table[, 1] == user_nickname,
              1 + index_of_problem
            ]
          ) + 1

        }

      }


      #### pak dostane za danou úlohu bod -------------------------------------

      score_table[
        score_table[, 1] == user_nickname,
        1 + index_of_problem
      ] <- 1


    }else{


      #### jinak dostane nula bodů, ale to jen tehdy, pokud ještě
      #### nikdy předtím správně neodpověděl ----------------------------------

      if(
        score_table[
          score_table[, 1] == user_nickname,
          1 + index_of_problem
        ] %in% c("0", "")
      ){

        score_table[
          score_table[, 1] == user_nickname,
          1 + index_of_problem
        ] <- 0

      }


      #### a je mu případně zvednut počet pokusů z nula na jeden --------------

      if(
        score_table[
          score_table[, 1] == user_nickname,
          1 + index_of_problem
        ] %in% c("0", "")
      ){

        if(
          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
          ] == ""
        ){

          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
          ] <- "1"

        }else{

          attempt_counts_table[
            attempt_counts_table[, 1] == user_nickname,
            1 + index_of_problem
            ] <- as.integer(
              attempt_counts_table[
                attempt_counts_table[, 1] == user_nickname,
                1 + index_of_problem
              ]
            ) + 1

        }

      }


    }


  }else{

    #### když však ještě v tabulce není, je do ní přidán ----------------------

    score_table <- rbind(

      score_table,
      rep("", dim(score_table)[2])

    )

    score_table[
      dim(score_table)[1],
      1
    ] <- user_nickname

    
    #### také je uloženo jeho heslo -------------------------------------------
    
    passwords_table <- rbind(

      passwords_table,
      c(user_nickname, user_password)

    )
    
    
    #### je mu přidán i jeden pokus do tabulky pokusů, ať už byl
    #### tento správný, nebo nesprávný ----------------------------------------

    attempt_counts_table <- rbind(

      attempt_counts_table,
      rep("", dim(attempt_counts_table)[2])

    )

    attempt_counts_table[
      dim(attempt_counts_table)[1],
      1
    ] <- user_nickname

    attempt_counts_table[
      attempt_counts_table[, 1] == user_nickname,
      1 + index_of_problem
    ] <- "1"


    #### a odpoví-li správně --------------------------------------------------

    if(
      user_solution %in% correct_solution
    ){


      ### pak dostane za danou úlohu bod --------------------------------------

      score_table[
        score_table[, 1] == user_nickname,
        1 + index_of_problem
      ] <- 1

    }else{


      #### jinak dostane nula bodů --------------------------------------------

      score_table[
        score_table[, 1] == user_nickname,
        1 + index_of_problem
      ] <- 0

    }

  }


  #### tabulku je nutné nejen updatovat, ale i uložit -------------------------

  write.table(
    file = "my_solvers_table.csv",
    x = score_table,
    col.names = TRUE,
    row.names = TRUE,
    sep = ";"
  )
  
  write.table(
    file = "my_solvers_passwords_table.csv",
    x = passwords_table,
    col.names = TRUE,
    row.names = TRUE,
    sep = ";"
  )

  write.table(
    file = "my_solvers_attempts_table.csv",
    x = attempt_counts_table,
    col.names = TRUE,
    row.names = TRUE,
    sep = ";"
  )


  #### výstupy funkce ---------------------------------------------------------

  return(
    list(
      score_table,
      passwords_table,
      attempt_counts_table
    )
  )

}


## ----------------------------------------------------------------------------

###############################################################################

## ----------------------------------------------------------------------------

function(input, output, session){
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## zavádím counter --------------------------------------------------------
    
    output$my_counter <- renderText({
        
        if (!file.exists("my_counter.Rdata")){
            my_counter <- 0
        }else{
            load(file = "my_counter.Rdata")
        }
        
        my_counter <- my_counter + 1
        
        save(my_counter, file = "my_counter.Rdata")
        
        paste(
            "Počet návštěv: ",
            my_counter,
            sep = ""
        )
        
    })
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## nahrávám tabulku s řešiteli --------------------------------------------
    
    my_values <- reactiveValues(
      
      my_solvers_table = read.table(
        file = "my_solvers_table.csv",
        header = TRUE,
        sep = ";",
        check.names = FALSE,
        colClasses = "character"
      ),
      my_solvers_attempts_table = read.table(
        file = "my_solvers_attempts_table.csv",
        header = TRUE,
        sep = ";",
        check.names = FALSE,
        colClasses = "character"
      ),
      my_solvers_passwords_table = read.table(
        file = "my_solvers_passwords_table.csv",
        header = TRUE,
        sep = ";",
        check.names = FALSE,
        colClasses = "character"
      )
      
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## záložka s úvodem -------------------------------------------------------
    
    observeEvent(
        input$jump_to_about_tab,
        {
            updateTabsetPanel(
                session,
                inputId = "my_navbar_page_set",
                selected = "about_tab"
            )
        }
    )
    
    observeEvent(
        input$jump_to_calendar_tab,
        {
            updateTabsetPanel(
                session,
                inputId = "my_navbar_page_set",
                selected = "calendar_tab"
            )
        }
    )
    
    observeEvent(
      input$jump_to_solvers_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## záložka s adventním kalendářem -----------------------------------------
    
    output$today_date <- renderUI(
      
      HTML(paste(
        "<b><center>Který den je dnes? No přeci ",
        gsub("(^0)(.*)", "\\2", format(Sys.Date(), "%d. %B %Y")),
        " (CET).</center></b>",
        sep = ""
      ))
      
    )
    
    
    ## ------------------------------------------------------------------------
    
    observeEvent(
      input$jump_to_problem_1_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_1_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_2_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_2_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_3_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_3_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_4_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_4_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_5_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_5_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_6_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_6_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_7_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_7_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_8_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_8_tab"
        )
      }
    )
    
    observeEvent(
      input$jump_to_problem_9_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_9_tab"
        )
      }
    )
	
	observeEvent(
      input$jump_to_problem_10_tab,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "problem_10_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## záložka s úlohou 1 -----------------------------------------------------
    
    observeEvent(
      input$problem_1_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_1_output <- updateMyScores(
          
          index_of_problem = 1,
          user_nickname = input$problem_1_nickname,
          user_password = input$problem_1_password,
          user_solution = input$problem_1_solution,
          correct_solution = "44",
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_1_output[[1]]
        my_values$my_solvers_passwords_table <- problem_1_output[[2]]
        my_values$my_solvers_attempts_table <- problem_1_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------

    observeEvent(
      input$jump_to_solvers_tab_from_problem_1,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 2 -----------------------------------------------------
    
    observeEvent(
      input$problem_2_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_2_output <- updateMyScores(
          
          index_of_problem = 2,
          user_nickname = input$problem_2_nickname,
          user_password = input$problem_2_password,
          user_solution = input$problem_2_solution,
          correct_solution = c(
            "0.618", "0,618"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_2_output[[1]]
        my_values$my_solvers_passwords_table <- problem_2_output[[2]]
        my_values$my_solvers_attempts_table <- problem_2_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_2,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 3 -----------------------------------------------------
    
    observeEvent(
      input$problem_3_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_3_output <- updateMyScores(
          
          index_of_problem = 3,
          user_nickname = input$problem_3_nickname,
          user_password = input$problem_3_password,
          user_solution = input$problem_3_solution,
          correct_solution = c(
            "0.15084", "0,15084",
            "0.15085", "0,15084"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_3_output[[1]]
        my_values$my_solvers_passwords_table <- problem_3_output[[2]]
        my_values$my_solvers_attempts_table <- problem_3_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_3,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 4 -----------------------------------------------------
    
    observeEvent(
      input$problem_4_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_4_output <- updateMyScores(
          
          index_of_problem = 4,
          user_nickname = input$problem_4_nickname,
          user_password = input$problem_4_password,
          user_solution = input$problem_4_solution,
          correct_solution = c(
            "0.0256", "0,0256"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_4_output[[1]]
        my_values$my_solvers_passwords_table <- problem_4_output[[2]]
        my_values$my_solvers_attempts_table <- problem_4_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_4,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 5 -----------------------------------------------------
    
    observeEvent(
      input$problem_5_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_5_output <- updateMyScores(
          
          index_of_problem = 5,
          user_nickname = input$problem_5_nickname,
          user_password = input$problem_5_password,
          user_solution = input$problem_5_solution,
          correct_solution = c(
            "0.3333", "0,3333"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_5_output[[1]]
        my_values$my_solvers_passwords_table <- problem_5_output[[2]]
        my_values$my_solvers_attempts_table <- problem_5_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_5,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 6 -----------------------------------------------------
    
    observeEvent(
      input$problem_6_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_6_output <- updateMyScores(
          
          index_of_problem = 6,
          user_nickname = input$problem_6_nickname,
          user_password = input$problem_6_password,
          user_solution = input$problem_6_solution,
          correct_solution = c(
            "742143"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_6_output[[1]]
        my_values$my_solvers_passwords_table <- problem_6_output[[2]]
        my_values$my_solvers_attempts_table <- problem_6_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_6,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 7 -----------------------------------------------------
    
    observeEvent(
      input$problem_7_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_7_output <- updateMyScores(
          
          index_of_problem = 7,
          user_nickname = input$problem_7_nickname,
          user_password = input$problem_7_password,
          user_solution = input$problem_7_solution,
          correct_solution = c(
            "859394"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_7_output[[1]]
        my_values$my_solvers_passwords_table <- problem_7_output[[2]]
        my_values$my_solvers_attempts_table <- problem_7_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_7,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 8 -----------------------------------------------------
    
    observeEvent(
      input$problem_8_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_8_output <- updateMyScores(
          
          index_of_problem = 8,
          user_nickname = input$problem_8_nickname,
          user_password = input$problem_8_password,
          user_solution = input$problem_8_solution,
          correct_solution = c(
            "46325770669"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_8_output[[1]]
        my_values$my_solvers_passwords_table <- problem_8_output[[2]]
        my_values$my_solvers_attempts_table <- problem_8_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_8,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 9 -----------------------------------------------------
    
    observeEvent(
      input$problem_9_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_9_output <- updateMyScores(
          
          index_of_problem = 9,
          user_nickname = input$problem_9_nickname,
          user_password = input$problem_9_password,
          user_solution = input$problem_9_solution,
          correct_solution = c(
            "0.249628", "0,249628"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_9_output[[1]]
        my_values$my_solvers_passwords_table <- problem_9_output[[2]]
        my_values$my_solvers_attempts_table <- problem_9_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_9,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
	
	## ------------------------------------------------------------------------
    
    ###########################################################################
    
    ## záložka s úlohou 10 ----------------------------------------------------
    
    observeEvent(
      input$problem_10_submitting,  ## je-li zmáčknuto subtmittování
      {
        
        problem_10_output <- updateMyScores(
          
          index_of_problem = 10,
          user_nickname = input$problem_10_nickname,
          user_password = input$problem_10_password,
          user_solution = input$problem_10_solution,
          correct_solution = c(
            "769282"
          ),
          score_table = read.table(
            file = "my_solvers_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          passwords_table = read.table(
            file = "my_solvers_passwords_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          ),
          attempt_counts_table = read.table(
            file = "my_solvers_attempts_table.csv",
            header = TRUE,
            sep = ";",
            check.names = FALSE,
            colClasses = "character"
          )
          
        )
        
        my_values$my_solvers_table <- problem_10_output[[1]]
        my_values$my_solvers_passwords_table <- problem_10_output[[2]]
        my_values$my_solvers_attempts_table <- problem_10_output[[3]]
        
      }
      
    )
    
    
    #### handler, pokud řešitel zmáčkne "přejít na záložku Řešitelé" ----------
    
    observeEvent(
      input$jump_to_solvers_tab_from_problem_10,
      {
        updateTabsetPanel(
          session,
          inputId = "my_navbar_page_set",
          selected = "solvers_tab"
        )
      }
    )
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    
	
	
	
	
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    
    
    
    
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    
    
    
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    
    
    
    
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    ## záložka s řešiteli -----------------------------------------------------
    
    output$my_solvers_table_display <- renderTable({
      
      body_celkem <- NULL
      
      for(i in 1:dim(my_values$my_solvers_table)[1]){
        
        body_celkem <- c(
          body_celkem,
          sum(my_values$my_solvers_table[i, -1] == "1")
        )
        
      }
      
      
      my_power <- NULL
      
      for(i in 1:dim(my_values$my_solvers_table)[1]){
        
        my_power <- c(
          my_power,
          sum(1 / pmax(1, as.integer(my_values$my_solvers_attempts_table[
            i,
            1 + which(my_values$my_solvers_table[i, -1] == "1")
            ]) - 2))
        )
        
      }
      
      
      cbind(
        my_values$my_solvers_table,
        "celkem bodů" = body_celkem,
        "power" = my_power
      )
      
      
    }, include.rownames = FALSE, align = "r", width = "auto")
    
    
    output$my_solvers_attempts_table_display <- renderTable({
      
      #my_values$my_solvers_attempts_table
      
      my_average_attempts <- NULL
      
      for(i in 1:dim(my_values$my_solvers_attempts_table)[1]){
          
          my_average_attempts <- c(
              my_average_attempts,
              mean(
                  as.numeric(
                      my_values$my_solvers_attempts_table[i, -1]
                  ),
                  na.rm = TRUE
              )
          )
          
      }
      
      cbind(
          my_values$my_solvers_attempts_table,
          "průměrný počet pokusů na úlohu" = my_average_attempts
      )
      
    }, include.rownames = FALSE, align = "r", width = "auto")
    
    
    ## ------------------------------------------------------------------------
    
    ###########################################################################
    ###########################################################################
    ###########################################################################
    
    
}


###############################################################################
###############################################################################
###############################################################################





