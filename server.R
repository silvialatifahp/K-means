library(shiny)
library(shinydashboard)

shinyServer(
  function(input, output, session) {
    df_kmeans <- reactive({
      req(input$path_df_kmeans)
      read_excel(input$path_df_kmeans$datapath)
    })

    output$df_kmeans <- DT::renderDataTable({
      datatable(df_kmeans(),
        options = list(scrollx = TRUE)
      )
    })

    observe({
      updateSelectInput(
        session = session,
        inputId = "var1",
        choices = colnames(df_kmeans())
      )

      updateSelectInput(
        session = session,
        inputId = "var2",
        choices = colnames(df_kmeans())
      )
    })

    df_kmeans_selected <- eventReactive(input$analyse, {
      req(input$var1)
      req(input$var2)
      df_kmeans()[, c(input$var1, input$var2), drop = FALSE]
    })

    res_clusters <- reactive({
      req(df_kmeans_selected())
      req(input$n_clusters)
      kmeans(
        df_kmeans_selected(),
        centers = input$n_clusters
      )
    })

    output$plot1 <- renderPlot({
      req(df_kmeans_selected())
      req(res_clusters())
      palette(c(
        "#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
        "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"
      ))
      par(mar = c(5.1, 4.1, 0, 1))
      plot(df_kmeans_selected(),
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
  }
)
