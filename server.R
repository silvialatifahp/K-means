library(shiny)
library(shinydashboard)

shinyServer(
  function(input, output, session) {
    df_raw <- reactive({
      req(input$path_df_raw)
      read_excel(input$path_df_raw$datapath)
    })

    output$df_raw <- DT::renderDataTable({
      datatable(df_raw(),
        options = list(scrollx = TRUE)
      )
    })

    observe({
      updateSelectInput(
        session = session,
        inputId = "var1",
        choices = colnames(df_raw())
      )

      updateSelectInput(
        session = session,
        inputId = "var2",
        choices = colnames(df_raw())
      )
    })

    df_raw_selected <- eventReactive(input$analyse, {
      req(input$var1)
      req(input$var2)
      df_raw()[, c(input$var1, input$var2), drop = FALSE]
    })

    res_clusters <- eventReactive(input$analyse,{
      req(df_raw_selected())
      req(input$n_clusters)
      kmeans(
        df_raw_selected(),
        centers = input$n_clusters
      )
    })

    output$plot_kmeans <- renderPlot({
      req(df_raw_selected())
      req(res_clusters())
      palette(c(
        "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
        "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"
      ))
      par(mar = c(5.1, 4.1, 0, 1))
      plot(df_raw_selected(),
        col = res_clusters()$cluster,
        pch = 20,
        cex = 1
      )
      points(res_clusters()$centers,
        pch = 4,
        cex = 1,
        lwd = 3
      )
    })
    
    output$df_kmeans <- DT::renderDataTable({
      req(df_raw_selected())
      req(res_clusters())
      df_kmeans <- cbind(df_raw_selected(), Klaster = res_clusters()$cluster)
      datatable(df_kmeans[order(df_kmeans$Klaster), ], rownames = FALSE)
    })
  }
)
