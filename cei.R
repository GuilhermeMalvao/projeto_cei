library(openxlsx)
library(lubridate)
library(tidyr)
library(dplyr)
library(stringr)
dados <- read.xlsx("cei.xlsx") %>% 
  select(-c(3,4,6)) %>% 
  mutate(Data.do.Negócio = as_date(Data.do.Negócio,origin = "1899-12-30 00:00:00")) %>% 
  mutate(ano_mes = str_sub(Data.do.Negócio,1,7))

dados1 <- dados %>%
  mutate(Quantidade = if_else(`Compra/Venda` == "V",-Quantidade,Quantidade))


