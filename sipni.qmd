# SI-PNI -- Sistema de Informações do Programa Nacional de Vacinação

## Resumo

-  Ano de criação: 1975 (institucionalização do PNI)
-  Cobertura: Dimensões pública e privada do SUS
-  Unidade: dados agregados e notificações de imunização
-  Divulgação de dados: 

## Histórico e organização

A criação do SI-PNI se dá em 1975, com a institucionalização do Programa Nacional de Imunizações (PNI), sendo desenvolvido pelo DataSUS.

Até 2023, o SI-PNI se organizava em um conjunto de sistemas:

-  Avaliação do Programa de Imunizações (API)
-  Estoque e Distribuição de Imunobiológicos (EDI)
-  Eventos Adversos Pós-Vacinação (EAPV)
-  Programa de Avaliação do Instrumento de Supervisão em Sala de Vacinação (PAISSV)
-  Apuração dos Imunobiológicos Utilizados (AIU)
-  Programa de Avaliação do Instrumento de Supervisão (PAIS)
-  Sistema de Informações dos Centros de Referência em Imunobiológicos Especiais (SICRIE)

Durante a pandemia de SARS-CoV-2, o SI-PNI foi completamente reformulado visando ter capacidade de resposta para a imunização massiva da população. O novo SI-PNI já surge integrado à [Rede Nacional de Dados de Saúde](https://www.gov.br/saude/pt-br/composicao/seidigi/rnds), alinhado a Estratégia de Saúde Digital (e-SAÚDE) do Ministério da Saúde, tão como a proposta de um Registro Nominal de Vacinação Eletrônico (RNVe) da Organização Mundial de Saúde (OMS). Em [31 de maio de 2023](https://www.gov.br/saude/pt-br/centrais-de-conteudo/publicacoes/estudos-e-notas-informativas/2023/sei_ms-0033542444-nota-informativa-conjunta.pdf) foi publicado o módulo para vacinação de rotina, encerrando por fim as versões Web e desktop do antigo SI-PNI. 

## Estrutura dos dados

O antigo SI-PNI disponibiliza dados agregados do quantitativo de doses aplicadas e de cobertura vacinal. Já o novo PNI disponibiliza dados desagregados de doses aplicadas, onde cada registro é uma dose aplicada.

O registro de vacinações é direcionado para o novo SI-PNI (RNDS) se o sistema de registro estiver devidamente integrado. Caso não esteja, o registro vacinal é direcionado para o SISAB e posteriormente migra para a RNDS (em torno de 30 dias).

## Acesso aos dados

Os dados do antigo SI-PNI estão disponíveis no DataSUS, na área de Assistência a Saúde, compreendendo os anos de 1994 a 2022.

Os dados do novo SI-PNI estão disponíveis no OpenDataSUS:

-  [Campanha Nacional de Vacinação contra Covid-19 ](https://opendatasus.saude.gov.br/dataset/covid-19-vacinacao)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2025](https://opendatasus.saude.gov.br/dataset/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2025)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2024](https://opendatasus.saude.gov.br/dataset/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2024)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2023](https://opendatasus.saude.gov.br/dataset/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2023)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2022](https://opendatasus.saude.gov.br/dataset/dataset-doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni_2022)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2021](https://opendatasus.saude.gov.br/dataset/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2021)
-  [Doses aplicadas pelo Programa de Nacional de Imunizações (PNI) - 2020](https://opendatasus.saude.gov.br/dataset/doses-aplicadas-pelo-programa-de-nacional-de-imunizacoes-pni-2020)
-  [Dados sobre Eventos Supostamente Atribuíveis a Vacinação -- ESAVI](https://opendatasus.saude.gov.br/dataset/esavi)


## Bibliografia recomendada

### Avaliação da qualidade dos dados

-  Artigo *Confiabilidade das informações registradas no Sistema de Informação do Programa Nacional de Imunizações* [@moraesConfiabilidadeInformacoesRegistradas2024]. Disponível [aqui](https://doi.org/10.1590/S2237-96222024v33e20231309.especial2.pt).
-  Artigo *Tendência temporal do preenchimento do campo raça/cor nos registros de hospitalização, vacinação e mortalidade pela Covid-19 no Brasil* [@araujoTendenciaTemporalPreenchimento2024]. Disponível [aqui](https://doi.org/10.1590/1414-462X202432040012).