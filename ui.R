library(shiny)
library(shinydashboard)
library(DT)
library(readxl)

shinyUI(
  dashboardPage(
    skin = "green",
    dashboardHeader(title = "Sistem Informasi Kesehatan Kota Bandung", titleWidth = 425),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Beranda", tabName = "home", icon = icon("home")),
        menuItem("K-Means", tabName = "kmeans", icon = icon("database"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(
          tabName = "home",
          fluidRow(
            column(
              width = 4,
              wellPanel(
                img(src = "logo.png"),
                h3("Sistem Informasi Dinas Kesehatan Kota Bandung"),
                p("Jl. Citarum No. 34 Cihapit, Bandung Wetan, Kota Bandung, Jawa Barat 40114"),
                p("Telepon: (022) 4203752"),
                p("Email: dinaskesehatankotabdg@gmail.com")
              )
            ),
            column(
              width = 8,
              h1(strong("Sistem Informasi Dinas Kesehatan Kota Bandung")),
              p("Kesehatan menurut Kementerian Kesehatan yang ditulis didalam UU No. 23 Tahun 1992 adalah keadaan normal dan sejahtera anggota tubuh, sosial, dan jiwa pada seseorang yang dapat melakukan aktifitas tanpa gangguan. Untuk menyelenggarakan pendidikan yang bermutu diperlukan biaya yang cukup besar. Oleh karena itu, bagi setiap peserta didik pada setiap satuan pendidikan berhak mendapatkan biaya pendidikan bagi mereka yang orang tuanya tidak mampu membiayai pendidikannya, dan berhak mendapatkan beasiswa bagi mereka yang berprestasi."),
              h2("Hak Kesehatan"),
              p("Hak setiap warga Indonesia memperoleh kesehatan telah dijamin berdasarkan Undang-Undang Dasar 1945, Undang-Undang Nomor 36 tahun 2009 tentang kesehatan, dan Undang-Undang Nomor 39 Tahun 1999 tentang Hak Asasi Manusia dan Konvenan Internasional tentang Hak Ekonomi, Sosial, dan Budaya yang telah diratifikasi oleh Undang-Undang Nomor 12 Tahun 2005. "),
              p("Adapun hak-hak kesehatan yang dapat diperoleh masyarakat adalah sebagai berikut:"),
              tags$ol(
                tags$li("Hak memperoleh akses atas sumber daya di bidang kesehatan;"),
                tags$li("Hak memperoleh pelayanan kesehatan yang aman, bermutu, dan terjangkau;"),
                tags$li("Berhak secara mandiri dan bertanggung jawab menentukan sendiri pelayanan kesehatan yang diperlukan bagi dirinya;"),
                tags$li("Berhak mendapatkan lingkungan yang sehat bagi pencapaian derajat kesehatan;"),
                tags$li("Berhak mendapatkan informasi dan edukasi tentang kesehatan yang seimbang pendidikan kepada peserta didik yang orang tua atau walinya tidak mampu dan bertanggung jawab.")
              )
            )
          )
        ),
        tabItem(
          tabName = "kmeans",
          fluidRow(
            shinydashboard::box(
              width = 12,
              fileInput("path_df_raw",
                "Unggah file(.xlsx)",
                multiple = TRUE,
                accept = c(
                  "text/xlsx",
                  "text/extensible-stylesheet-language, text/plain",
                  ".xlsx"
                )
              ),
              helpText("File maksimal 5MB")
            ),
            tabBox(
              width = 12,
              tabPanel(
                "Data Uji",
                br(),
                DT::dataTableOutput("df_raw")
              ),
              tabPanel(
                "K-means",
                br(),
                sidebarLayout(
                  sidebarPanel(
                    selectInput("var1",
                      "Pilih Variabel 1",
                      choices = NULL
                    ),
                    selectInput("var2",
                      "Pilih Variabel 2",
                      choices = NULL
                    ),
                    numericInput("n_clusters",
                      "Berapa Banyak Cluster:",
                      value = 3,
                      min = 1,
                      max = 9,
                      step = 1
                    ),
                    actionButton(
                      "analyse",
                      "Analisis"
                    )
                  ),
                  mainPanel(
                    plotOutput("plot_kmeans"),
                    downloadButton("download_plot", "Unduh grafik"),
                    br(),
                    hr(),
                    br(),
                    DT::dataTableOutput("df_kmeans")
                  )
                )
              )
            )
          )
        )
      )
    )
  )
)
