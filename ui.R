library(shiny)
library(shinydashboard)
library(DT)
library(readxl)
library(plotly)

shinyUI(
  dashboardPage( skin = "green",
    dashboardHeader(title = "Sistem Informasi Kesehatan Kota Bandung", titleWidth = 800),
    dashboardSidebar(
      sidebarMenu(
        menuItem(text = "Beranda", tabName = "home", icon = icon("home")),
        menuItem("K-Means", tabName = "kmeans", icon = icon("database"))
      ) #sidebarmenu
    ), #dashboardsidebar
    
    dashboardBody(
      tabItems(
        tabItem(tabName = "home",
                sidebarLayout(
                  sidebarPanel(
                    br(),
                    br(),
                    img(src = "logo.png", height = 125, width = 250),
                    h3("Sistem Informasi Dinas Kesehatan Kota Bandung"),
                    p("Jl. Citarum No. 34",
                      "Cihapit, Bandung Wetan, Kota Bandung, Jawa Barat 40114"),
                    p("Telepon  : (022) 4203752"),
                    p("Email    : dinaskesehatankotabdg@gmail.com"),
                    br(),
                    br(),
                    br()
                  ), #sidebarpanel
                  mainPanel(
                    h1("Sistem Informasi Dinas Kesehatan Kota Bandung"),
                    p("Kesehatan menurut Kementerian Kesehatan yang ditulis didalam UU No. 23 Tahun 1992  ", 
                      "adalah keadaan normal dan sejahtera anggota tubuh, sosial, dan jiwa pada seseorang
                      yang dapat melakukan aktifitas tanpa gangguan. ", 
                      "Untuk menyelenggarakan pendidikan yang
                      bermutu diperlukan biaya yang cukup besar. Oleh karena itu, bagi setiap peserta didik
                      pada setiap satuan pendidikan berhak mendapatkan biaya pendidikan bagi mereka yang
                      orang tuanya tidak mampu membiayai pendidikannya, dan berhak mendapatkan beasiswa
                      bagi mereka yang berprestasi."),
                    h2("Hak Kesehatan"),
                    p("Hak setiap warga Indonesia memperoleh kesehatan
                      telah dijamin berdasarkan Undang-Undang Dasar 1945, Undang-Undang Nomor 36
                      tahun 2009 tentang kesehatan, dan Undang-Undang Nomor 39 Tahun 1999 tentang Hak
                      Asasi Manusia dan Konvenan Internasional tentang Hak Ekonomi, Sosial, dan Budaya
                      yang telah diratifikasi oleh Undang-Undang Nomor 12 Tahun 2005. "),
                    p("Adapun hak-hak kesehatan yang dapat diperoleh masyarakat adalah sebagai berikut:"),
                    p("1. Hak memperoleh akses atas sumber daya di bidang kesehatan;"),
                    p("2. Hak memperoleh pelayanan kesehatan yang aman, bermutu, dan terjangkau;"), 
                    p("3. Berhak secara mandiri dan bertanggung jawab menentukan sendiri pelayanan
                      kesehatan yang diperlukan bagi dirinya;"),
                    p("4. Berhak mendapatkan lingkungan yang sehat bagi pencapaian derajat kesehatan;"),
                    p("5. Berhak mendapatkan informasi dan edukasi tentang kesehatan yang seimbang
                      pendidikan kepada peserta didik yang orang tua atau walinya tidak mampu
                      dan bertanggung jawab.")
                    ))),
        
        tabItem(tabName = "kmeans",
                fluidRow(
                  
                  tabBox(id="filekmeans", width = 20,
                         fileInput("data_uji","Unggah file(.xlsx)",
                                   multiple = TRUE,
                                   accept = c("text/xlsx",
                                              "text/extensible-stylesheet-language, text/plain",
                                              ".xlsx")),
                         helpText("File maksimal 5MB")),
                  tabBox(id="keterangankmeans", width = 20,
                         mainPanel(
                           tabsetPanel(
                             tabPanel("Data Uji", dataTableOutput("tablekmeans")),
                             tabPanel("Hasil Kmeans",
                                      sidebarLayout(
                                        sidebarPanel(
                                          selectInput("var1", "Pilih Variabel 1", choices = c("Penduduk"=1, "Penyakit_DBD"=2, "Penyakit_Diare"=3, "Penyakit_TB"=4, "Penyakit_HIV"=5), selected = "Penduduk"),
                                          selectInput("var2", "Pilih Variabel 2", choices = c("Penduduk"=1, "Penyakit_DBD"=2, "Penyakit_Diare"=3, "Penyakit_TB"=4, "Penyakit_HIV"=5), selected = "Penyakit_DBD"),
                                          numericInput("clusters", "Berapa Banyak Cluster:", value = 3,
                                                       min = 1, max = 9, step=1)),
                                     mainPanel(plotOutput("plot1"))
                                      )
                                     ), #tabPanelHASIL
                            tabPanel("Pengujian Data",
                                     sidebarLayout(
                                       sidebarPanel(width = 8,
                                                    tabBox(id="filevalidasikm", width = 20,
                                                           fileInput("data_valid", "Input Data Pengujian (.xlsx):",
                                                                     multiple = TRUE,
                                                                     accept = c("text/xlsx",
                                                                                "text/extensible-stylesheet-language,text/plain",
                                                                                ".xlsx")), 
                                                           helpText("File Maksimal 5 MB")),
                                                           dataTableOutput("tablevalidkm")
                                                           ),
                                                    mainPanel(width=4,
                                                              verticalLayout(
                                                                h5("Accuracy:", verbatimTextOutput("akurasikm")),
                                                                h5("Error Rate:", verbatimTextOutput("erorkm"))
                                                              )
                                        ) 
                                        ) 
                                      ) 
                                      ) 
                                     ) #mainpanel keterangan kmeans
                                    ) #tabbox keterangan kmeans
                ) #fluidrow tabitem kmeans
        ) #tabitem kmeans
      ) #tabitems
    ) #dashboardbody
  ) #dashboardpage
) #closeshinyUI
