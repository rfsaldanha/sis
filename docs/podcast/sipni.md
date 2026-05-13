# Podcast: SI-PNI -- Sistema de Informações do Programa Nacional de Imunizações

**Livro:** Sistemas de Informação em Saúde no Brasil  
**Capítulo:** SI-PNI -- Sistema de Informações do Programa Nacional de Imunizações  
**Formato:** conversa entre apresentadora e estudante  
**Tom:** acadêmico, mas relaxado

## Roteiro

**APRESENTADORA:** Olá. Neste episódio, vamos conversar sobre o SI-PNI, o Sistema de Informações do Programa Nacional de Imunizações.

**ESTUDANTE:** Esse capítulo ficou bem mais detalhado. Qual é a ideia central?

**APRESENTADORA:** A ideia central é simples, mas muito importante: o SI-PNI registra ações de vacinação. Para transformar esses registros em indicadores, precisamos definir dose, pessoa, esquema, calendário, território, período e denominador.

**ESTUDANTE:** Então não basta contar registros e chamar isso de cobertura vacinal.

**APRESENTADORA:** Exatamente. Cobertura vacinal depende de numerador e denominador compatíveis. Uma contagem de doses aplicadas mede produção registrada. Uma cobertura mede a relação entre doses ou pessoas elegíveis e uma população-alvo.

**ESTUDANTE:** O capítulo começa distinguindo o PNI do SI-PNI.

**APRESENTADORA:** Sim. O PNI é o Programa Nacional de Imunizações, responsável por coordenar a política de vacinação. O SI-PNI é o sistema de informação que organiza registros relacionados às ações de vacinação.

**ESTUDANTE:** E ele não mede diretamente imunidade.

**APRESENTADORA:** Isso. O SI-PNI registra doses, produtos, datas, lotes, estratégias, pessoas e estabelecimentos, quando esses campos estão disponíveis e preenchidos. Ele não mede sozinho proteção imunológica, efetividade vacinal, hesitação vacinal, qualidade técnica da aplicação ou causalidade de eventos adversos.

**ESTUDANTE:** Para quem esse capítulo é útil?

**APRESENTADORA:** Para estudantes, gestores, pesquisadores e analistas de dados. Estudantes devem focar nos conceitos. Gestores, no fluxo de registro e na oportunidade da informação. Pesquisadores, nas unidades de análise, denominadores e vieses. Analistas, nos campos, filtros, datas, território, duplicidades e reprodutibilidade.

**ESTUDANTE:** Quando devo usar o SI-PNI?

**APRESENTADORA:** Use quando a pergunta envolve doses aplicadas, pessoas vacinadas, esquemas vacinais, campanhas, cobertura vacinal, registros de imunobiológicos ou eventos relacionados à vacinação.

**ESTUDANTE:** E quando não devo usar sozinho?

**APRESENTADORA:** Não use sozinho para responder perguntas sobre efetividade vacinal, proteção imunológica individual, causas de eventos adversos, motivos da não vacinação, barreiras de acesso ou qualidade técnica da sala de vacina. Para essas perguntas, ele precisa ser combinado com outras fontes e desenhos de estudo.

**ESTUDANTE:** Como o SI-PNI se organizava antes?

**APRESENTADORA:** O SI-PNI antigo tinha diferentes módulos e aplicações, como API, EDI, EAPV, PAISSV, AIU, PAIS e SICRIE. Eles apoiavam avaliação do programa, estoque e distribuição, eventos adversos, supervisão e centros de referência.

**ESTUDANTE:** E o que mudou com o novo SI-PNI?

**APRESENTADORA:** A mudança principal é a centralidade do registro nominal e da integração com a Rede Nacional de Dados em Saúde, a RNDS. Isso permite acompanhar melhor pessoas e esquemas, mas também exige mais cuidado com deduplicação, integração, privacidade e comparabilidade histórica.

**ESTUDANTE:** A transição aconteceu depois da pandemia de Covid-19?

**APRESENTADORA:** A pandemia acelerou a necessidade de registro oportuno e nominal. Em 31 de maio de 2023, foi encerrada a inserção de dados nos módulos web e desktop para o registro individualizado e movimentação de imunobiológicos. Em 1º de junho de 2023, entrou o módulo de vacinação de rotina no novo SI-PNI.

**ESTUDANTE:** Então séries históricas podem ter quebras.

**APRESENTADORA:** Podem. Uma mudança na série pode refletir mudança real na vacinação, mas também mudança de sistema, fluxo, prazo, integração, deduplicação ou forma de divulgação.

**ESTUDANTE:** Como o dado chega ao sistema?

**APRESENTADORA:** O registro pode ser feito diretamente no novo SI-PNI ou em sistemas locais integrados. Quando há integração, o evento de imunização segue para a RNDS. Em alguns contextos, registros da Atenção Primária podem passar por fluxos intermediários, como e-SUS APS e SISAB.

**ESTUDANTE:** Então competências recentes podem estar incompletas.

**APRESENTADORA:** Exatamente. Antes de interpretar queda recente de doses como queda real da vacinação, verifique atraso de envio, processamento, integração e data de extração.

**ESTUDANTE:** O capítulo fala bastante de unidade de análise.

**APRESENTADORA:** Porque esse é o coração da análise. Uma dose aplicada é um registro. Uma pessoa vacinada é um indivíduo com pelo menos uma dose. Um esquema completo é uma sequência de doses que cumpre regras. Uma dose válida precisa respeitar idade, intervalo, produto e calendário.

**ESTUDANTE:** Então uma pessoa pode aparecer várias vezes.

**APRESENTADORA:** Sim. Ela pode receber várias doses do mesmo imunobiológico, vacinas diferentes no mesmo dia, reforços em momentos posteriores ou registros duplicados. Por isso, dose, pessoa e esquema não são a mesma coisa.

**ESTUDANTE:** Como pensar no dicionário de dados?

**APRESENTADORA:** Procure grupos de campos. Campos de pessoa, como identificador anonimizado, idade, sexo, raça/cor e residência. Campos de vacinação, como vacina, dose, estratégia e data. Campos de produto, como fabricante e lote. Campos de estabelecimento, como CNES e município de aplicação. E campos de tempo e fonte.

**ESTUDANTE:** Os nomes das variáveis são sempre os mesmos?

**APRESENTADORA:** Não necessariamente. Bases, anos, campanhas e versões podem mudar. Por isso, uma análise reprodutível deve salvar o dicionário, a URL, o período, o formato, a data de extração e as regras de renomeação.

**ESTUDANTE:** Vamos voltar para cobertura vacinal. Qual é o erro mais comum?

**APRESENTADORA:** Chamar qualquer contagem de dose de cobertura. Cobertura administrativa exige numerador e denominador. O numerador pode ser uma dose específica, uma pessoa com dose válida ou uma pessoa com esquema completo. O denominador deve representar a população-alvo correta.

**ESTUDANTE:** Quais denominadores aparecem com frequência?

**APRESENTADORA:** Nascidos vivos para vacinas do calendário infantil, população residente para faixas etárias amplas, população-alvo de campanha, cadastro da APS, populações específicas, como povos indígenas, ou grupos definidos por norma.

**ESTUDANTE:** E cobertura acima de 100 por cento?

**APRESENTADORA:** É um sinal para investigação. Pode ocorrer por denominador subestimado, vacinação de residentes de outros territórios, duplicidade, migração, população-alvo mal definida ou mistura de campanha com rotina.

**ESTUDANTE:** O capítulo diferencia cobertura administrativa e cobertura de inquérito.

**APRESENTADORA:** Sim. A cobertura administrativa vem de registros do SI-PNI divididos por uma população-alvo. Inquéritos usam amostras, cadernetas, entrevistas ou registros verificados. As duas fontes respondem perguntas próximas, mas não são intercambiáveis.

**ESTUDANTE:** Se o SI-PNI e um inquérito discordam, qual está certo?

**APRESENTADORA:** A pergunta melhor é: por que discordam? Pode haver perda de registro, erro de denominador, duplicidade, dose fora da janela, problema de identificação, diferença territorial ou diferença no período observado.

**ESTUDANTE:** Como seria um exemplo de cobertura infantil?

**APRESENTADORA:** Primeiro defina a coorte, por exemplo crianças nascidas em determinado ano e residentes em um município. Depois selecione a vacina e a dose do calendário, valide idade e intervalo, conte pessoas uma única vez e use um denominador compatível, como nascidos vivos residentes da mesma coorte.

**ESTUDANTE:** E para campanha de influenza em idosos?

**APRESENTADORA:** Defina o público-alvo, o período da campanha, o território, o numerador como pessoas do grupo-alvo vacinadas e o denominador como população estimada do grupo. Doses duplicadas da mesma pessoa não devem virar duas pessoas cobertas.

**ESTUDANTE:** O capítulo também fala de raça/cor.

**APRESENTADORA:** Sim. Antes de estudar desigualdades, avalie a completitude do campo raça/cor. Veja se o preenchimento varia por UF, município, período, serviço ou sistema de origem. Campo incompleto pode limitar muito a análise de iniquidades.

**ESTUDANTE:** Como separar rotina, campanha e Covid-19?

**APRESENTADORA:** Use filtros de estratégia, produto, dose, público-alvo e período. Covid-19 teve regras próprias, produtos diferentes, reforços e grupos que mudaram rapidamente. Misturar Covid-19 com rotina pode distorcer séries e coberturas.

**ESTUDANTE:** E o território?

**APRESENTADORA:** Para cobertura populacional, geralmente use residência. Para produção do serviço, use local de aplicação ou CNES. Município de residência e município de aplicação respondem perguntas diferentes.

**ESTUDANTE:** E as datas?

**APRESENTADORA:** Data de vacinação mostra quando a dose foi aplicada. Data de registro mostra quando entrou no sistema. Mês do arquivo organiza a base aberta. Essas datas não são equivalentes.

**ESTUDANTE:** Como validar a qualidade dos dados?

**APRESENTADORA:** Verifique registros sem vacina, dose, data, residência ou CNES. Procure duplicidades. Avalie idade incompatível, intervalo incompatível entre doses, mudanças abruptas em meses recentes e completitude de campos sociais.

**ESTUDANTE:** A reprodutibilidade parece bem importante.

**APRESENTADORA:** Muito. Documente conjunto de dados, ano, meses, formato, data e horário de extração, versão do dicionário, filtros, regra de deduplicação, fonte do denominador e tratamento de registros incompletos.

**ESTUDANTE:** Como a privacidade entra nessa discussão?

**APRESENTADORA:** O novo SI-PNI trabalha com registros individualizados, mas a base pública precisa proteger dados pessoais. Por isso, há anonimização ou pseudonimização e limites para linkage individual público.

**ESTUDANTE:** Com quais sistemas o SI-PNI costuma ser combinado?

**APRESENTADORA:** Com SINASC para cobertura infantil, POP para denominadores populacionais, SISAPS ou SISAB para Atenção Primária, CNES para estabelecimentos, SINAN para agravos, SIVEP-Gripe e SIM para estudos de eventos graves e mortalidade, sempre com desenho adequado.

**ESTUDANTE:** Quais erros comuns devemos evitar?

**APRESENTADORA:** Contar doses como pessoas, misturar residência e aplicação, misturar rotina e campanha, usar denominador genérico, ignorar idade e intervalo, interpretar mês recente como definitivo e tratar ESAVI como causalidade.

**ESTUDANTE:** ESAVI significa evento supostamente atribuível à vacinação ou imunização.

**APRESENTADORA:** Isso. A palavra supostamente é essencial. Notificação de ESAVI é ponto de partida para investigação, não prova automática de relação causal.

**ESTUDANTE:** Qual é a principal limitação do SI-PNI?

**APRESENTADORA:** Não há uma única. As principais são sub-registro, atraso de envio, duplicidade, identificação inconsistente, denominador incerto, mudança de calendário, diferença entre residência e aplicação, transição de sistemas e limites de privacidade.

**ESTUDANTE:** Para fechar, qual é a mensagem prática?

**APRESENTADORA:** Use o SI-PNI com respeito à sua lógica. Ele é essencial para monitorar vacinação no Brasil, mas todo indicador precisa declarar unidade de análise, numerador, denominador, território, período, regra de validade, data de extração e limitações.

**ESTUDANTE:** Então o capítulo ensina menos a apertar botões e mais a pensar corretamente sobre dados de vacinação.

**APRESENTADORA:** Exatamente. Em vacinação, uma boa análise começa antes da base: começa na pergunta, na definição da população-alvo e na distinção entre dose, pessoa, esquema e cobertura.
