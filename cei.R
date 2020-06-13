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
  filter(codigo_negociacao == "B3SA3F") %>% 
  group_by(ano_mes, compra_venda, codigo_negociacao) %>% 
  summarise(pm = sum(quantidade*preco_r)/sum(quantidade),
            qtd = sum(quantidade), 
            v_total = sum(valor_total_r)) %>%  
  ungroup() %>% 
  mutate(aux = if_else(compra_venda == "C",1,-1),
         qtd_acumulada = cumsum(qtd*aux),
         
         v_total1 = cumsum(lag(qtd_acumulada,default = 0)*pm*aux))

write.xlsx(dados1,"d.xlsx")



(11*32.53+30*39.87133)/41
43.1833-37.9017
(43.1833-37.9017)*30

