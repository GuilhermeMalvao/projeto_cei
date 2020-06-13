library(openxlsx)
library(lubridate)
library(tidyr)
library(dplyr)
library(stringr)
library(janitor)

dados <- read.xlsx("cei.xlsx") %>%
  clean_names() %>% 
  select(-c(3,4,6,10)) %>% 
  mutate(data_do_negocio = as_date(data_do_negocio,origin = "1899-12-30 00:00:00")) %>% 
  mutate(ano_mes = str_sub(data_do_negocio,1,7)) 

dados %>% glimpse()

dados1 <- dados %>%
  filter(codigo_negociacao == "B3SA3") %>% 
  group_by(ano_mes,compra_venda,codigo_negociacao) %>% 
  
  summarise(pm = (quantidade*preco_r)/sum(quantidade))

dados1 <- dados %>%
  mutate(Quantidade = if_else(`Compra/Venda` == "V",-Quantidade,Quantidade))


