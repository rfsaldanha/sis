# Podcast: Eventos de saúde

**Livro:** Sistemas de Informação em Saúde no Brasil



**Capítulo:** Eventos de saúde



**Formato:** diálogo entre apresentadora e estudante



**Tom:** natural, conversado e didático



**Duração:** 26 minutos e 5 segundos



## Roteiro

**APRESENTADORA:** Vamos começar com uma cena bem comum. Alguém abre três bases sobre dengue e diz: "tem algo errado". O SINAN mostra um número, o SIH mostra outro, o SIM mostra outro. Mas será que eles estavam tentando contar a mesma coisa?

**ESTUDANTE:** Olhando de fora, parece tudo dengue. Então dá vontade de comparar direto.

**APRESENTADORA:** Pois é. E é aí que entra a ideia central deste capítulo: os Sistemas de Informação em Saúde registram eventos. Eles não registram "a doença" como uma coisa abstrata. Registram notificações, atendimentos, procedimentos, internações, óbitos, nascimentos, doses aplicadas.

**ESTUDANTE:** Então a pergunta muda. Em vez de "qual sistema tem dengue?", eu pergunto: "qual evento relacionado à dengue eu quero observar?".

**APRESENTADORA:** Exatamente. Essa mudança parece pequena, mas muda toda a análise.

**ESTUDANTE:** Porque uma pessoa com dengue pode gerar vários registros.

**APRESENTADORA:** Sim. Ela pode sentir sintomas, procurar atendimento, ser notificada como caso suspeito, fazer exame, ser internada se piorar e, em uma situação extrema, evoluir para óbito. É uma trajetória clínica, mas cada pedaço pode aparecer em um sistema diferente.

**ESTUDANTE:** Então os sistemas não são versões imperfeitas da mesma informação. São janelas diferentes da trajetória.

**APRESENTADORA:** Perfeito. O SIA pode mostrar atendimentos, exames e procedimentos ambulatoriais. O SINAN pode mostrar suspeitas, investigação, confirmação ou descarte. O SIH mostra internações financiadas pelo SUS. O SIM mostra óbitos. Se os números não batem, isso pode ser exatamente o esperado.

**ESTUDANTE:** O primeiro passo é reconstruir a história possível do problema.

**APRESENTADORA:** Isso. Antes de abrir a planilha, vale perguntar: que acontecimentos esse problema pode produzir? Onde eles são registrados? Quem registra? Com qual finalidade? Em que momento?

**ESTUDANTE:** Parece uma investigação de rastros.

**APRESENTADORA:** É uma boa imagem. Cada registro é um rastro institucional. Uma ficha de notificação, uma autorização de internação, uma declaração de óbito, um procedimento lançado no sistema. Todos podem falar do mesmo tema, mas não dizem a mesma coisa.

**ESTUDANTE:** Então a tabela que liga pergunta, evento e sistema funciona como mapa de decisão.

**APRESENTADORA:** Exatamente. Se a pergunta é sobre suspeita ou confirmação de doença de notificação, o caminho provável é o SINAN. Se é atendimento, exame ou procedimento no SUS, olhamos para o SIA. Se é hospitalização no SUS, SIH. Se é morte, SIM. Se é nascimento, SINASC. Se é vacinação, SI-PNI.

**ESTUDANTE:** Mas a tabela não substitui a pergunta metodológica.

**APRESENTADORA:** Não substitui. Ela só orienta a entrada. Depois ainda precisamos conferir cobertura, campos disponíveis, período, versão da base e unidade de análise.

**ESTUDANTE:** Vamos falar dessa unidade de análise, porque é onde muita coisa dá errado.

**APRESENTADORA:** Dá mesmo. Um evento de saúde nem sempre equivale a uma pessoa. No SIA, uma linha pode ser um procedimento. Uma pessoa pode fazer vários exames. No SIH, a unidade operacional é a AIH, e uma pessoa pode ter mais de uma autorização. No SINAN, uma ficha pode ser uma suspeita que será descartada. No SIM, cada registro corresponde a um óbito.

**ESTUDANTE:** "Quantos registros existem?" não é a mesma pergunta que "quantas pessoas tiveram o problema?".

**APRESENTADORA:** Exato. Às vezes as respostas se aproximam. Às vezes ficam muito distantes. Antes de contar, precisamos dizer se estamos falando de pessoa, evento, procedimento, autorização, documento ou episódio de cuidado.

**ESTUDANTE:** E ainda existe a diferença entre duplicidade e recorrência.

**APRESENTADORA:** Sim. Dois registros parecidos podem ser erro de digitação, duplicação da ficha, transferência entre serviços, novo atendimento ou novo episódio clínico. A decisão de deduplicar não é automática. Ela depende do sistema e da pergunta.

**ESTUDANTE:** Então limpar a base também é uma decisão conceitual.

**APRESENTADORA:** Exatamente. Não é só técnica. Se eu apago registros achando que são duplicados, posso eliminar recorrências reais. Se mantenho duplicidades verdadeiras, posso inflar o resultado. O método precisa explicar a regra.

**ESTUDANTE:** Agora vamos ao tempo. O evento acontece em um momento, mas o dado aparece depois.

**APRESENTADORA:** Entre a ocorrência e o dado analisável existe um ciclo. O evento acontece; alguém registra; pode haver investigação, crítica, validação, digitação, envio, consolidação; e só depois vem a disseminação em TabNet, microdados, painel ou base aberta.

**ESTUDANTE:** Cada etapa pode ter uma data.

**APRESENTADORA:** Sim. Data de início de sintomas, data de atendimento, data de notificação, data de internação, data de óbito, data de digitação, data de disponibilização. Elas respondem a perguntas diferentes.

**ESTUDANTE:** Em uma epidemia, trocar a data de sintomas pela data de digitação pode mudar a curva.

**APRESENTADORA:** Pode mudar bastante. A data de sintomas tenta se aproximar do início clínico. A data de notificação mostra quando o sistema tomou conhecimento. A data de digitação informa parte do fluxo administrativo. Nenhuma é universalmente melhor.

**ESTUDANTE:** A melhor data é a que responde à pergunta declarada.

**APRESENTADORA:** Perfeito. E essa escolha precisa aparecer no método, porque muda a interpretação.

**ESTUDANTE:** Isso explica por que dados recentes mudam depois?

**APRESENTADORA:** Também. Dados preliminares chegam mais rápido, mas podem receber registros atrasados, correções, investigação e consolidação. Em surtos, esse atraso pode aumentar porque as equipes estão atendendo, investigando, preenchendo e digitando ao mesmo tempo.

**ESTUDANTE:** Então uma queda nos últimos dias de uma curva pode ser atraso, não melhora real.

**APRESENTADORA:** Exatamente. Os últimos pontos de uma série recente costumam ser os mais instáveis. Por isso, em epidemias, técnicas de correção de atraso ou nowcasting podem ajudar, mas também precisam ser explicadas.

**ESTUDANTE:** E um painel rápido não tem a mesma função que uma base consolidada.

**APRESENTADORA:** Isso. Painéis oportunos apoiam alerta, resposta rápida e gestão de risco. Bases consolidadas ajudam mais em avaliação, séries históricas e indicadores oficiais. O erro é exigir de uma fonte a função da outra.

**ESTUDANTE:** Vamos trazer território para a conversa. Residência, notificação, atendimento e infecção não são a mesma coisa.

**APRESENTADORA:** Não são. Imagine uma pessoa que mora no Rio de Janeiro, provavelmente se infecta no Oiapoque e procura atendimento em Belém. Residência, local provável de infecção e local de notificação são territórios diferentes.

**ESTUDANTE:** Cada campo responde uma pergunta.

**APRESENTADORA:** Sim. Residência ajuda a falar de risco para a população residente. Local provável de infecção ajuda a investigar transmissão. Notificação mostra onde o sistema tomou conhecimento. Atendimento mostra onde o cuidado aconteceu.

**ESTUDANTE:** E aí entram casos autóctones e alóctones.

**APRESENTADORA:** Um caso autóctone provavelmente se infectou no território analisado. Um caso alóctone provavelmente se infectou em outro território. Essa distinção muda mapas, surtos e prioridade de resposta.

**ESTUDANTE:** Sem isso, posso culpar um município que apenas notificou ou atendeu.

**APRESENTADORA:** Exato. Em análise espacial, o campo territorial é parte do argumento.

**ESTUDANTE:** Vamos voltar ao exemplo da dengue com tudo isso em mente.

**APRESENTADORA:** Vamos. Se usamos o SINAN, vemos notificações, investigação e classificação. Se usamos o SIH, vemos internações financiadas pelo SUS, que tendem a representar uma fração mais grave. Se usamos o SIM, olhamos o desfecho fatal, com regras próprias de declaração e codificação.

**ESTUDANTE:** Então notificações, internações e óbitos podem ter curvas diferentes.

**APRESENTADORA:** E devem ser lidas como curvas diferentes. Notificações respondem à transmissão, mas também à procura por atendimento, sensibilidade da vigilância e definição de caso. Internações refletem gravidade, acesso e capacidade hospitalar. Óbitos dependem da ocorrência da morte, da Declaração de Óbito, da codificação e da consolidação.

**ESTUDANTE:** Comparar essas curvas é útil, mas não para decidir qual está certa.

**APRESENTADORA:** Exatamente. Elas dialogam, mas não substituem umas às outras.

**ESTUDANTE:** Se notificações sobem e internações não sobem, o que posso pensar?

**APRESENTADORA:** Pode ser aumento de casos leves, melhor captação ambulatorial, mudança na definição de caso, atraso até aparecerem internações ou diferença de território. O dado abre hipóteses; ele não entrega a explicação pronta.

**ESTUDANTE:** E se internações sobem sem aumento de notificações?

**APRESENTADORA:** Eu investigaria subnotificação, atraso no SINAN, seleção de códigos diagnósticos, mudança na rede hospitalar ou diferença entre município de residência e de internação. Também checaria se as bases cobrem o mesmo período e a mesma população.

**ESTUDANTE:** Isso deixa a conclusão mais humilde.

**APRESENTADORA:** Mais humilde e mais forte. A boa análise não força compatibilidade onde ela não existe.

**ESTUDANTE:** O capítulo usa também acidente de trânsito como exemplo.

**APRESENTADORA:** Sim, porque a lógica de eventos não vale só para doença infecciosa. Um acidente pode gerar atendimento ambulatorial, internação por lesão, óbito por causa externa e uso de serviços específicos.

**ESTUDANTE:** No SIA, eu posso ver procedimentos. No SIH, internações. No SIM, mortalidade. No CNES, estrutura de serviços.

**APRESENTADORA:** Isso. Um estudo sobre mortalidade no trânsito não responde automaticamente sobre volume de atendimentos de urgência. Um estudo sobre internações não mede todos os acidentes ocorridos. Cada fonte ilumina uma dimensão.

**ESTUDANTE:** E em causas externas tem a diferença entre lesão e circunstância.

**APRESENTADORA:** Sim. A lesão descreve o dano físico: fratura, traumatismo, queimadura. A causa externa descreve a circunstância: atropelamento, colisão, queda, agressão. Para prevenção, essa diferença é decisiva.

**ESTUDANTE:** Saber que houve fratura é importante, mas não diz sozinho como evitar o próximo acidente.

**APRESENTADORA:** Exatamente. A prevenção depende de entender a circunstância.

**ESTUDANTE:** Vamos entrar nos casos de doenças e agravos.

**APRESENTADORA:** No Brasil, muitos agravos seguem regras de notificação. O SINAN é central nesse processo, mas é importante lembrar: uma ficha pode começar com uma suspeita.

**ESTUDANTE:** Notificação não é confirmação.

**APRESENTADORA:** Essa frase precisa acompanhar qualquer análise do SINAN. Depois da investigação, o caso pode ser confirmado, descartado, inconclusivo ou permanecer em acompanhamento. A análise precisa dizer o que está contando.

**ESTUDANTE:** Suspeitos? Confirmados? Prováveis? Descartados?

**APRESENTADORA:** Exatamente. Em resposta rápida, contar prováveis ou suspeitos pode ser adequado. Em análise retrospectiva, talvez a classificação final seja melhor. Em gestão do serviço, o volume de suspeitas também pode ser relevante porque mede demanda e sensibilidade da vigilância.

**ESTUDANTE:** A pergunta define o recorte.

**APRESENTADORA:** Sempre. E o momento de extração também importa, porque classificações podem mudar.

**ESTUDANTE:** O SINAN traz vários campos territoriais e temporais, certo?

**APRESENTADORA:** Sim. Pode trazer dados da pessoa, residência, município de notificação, local provável de infecção, datas de sintomas, notificação, investigação, digitação, critério de confirmação, classificação final e evolução. Cada campo tem uma função.

**ESTUDANTE:** O erro é tratar a ficha como se tudo tivesse o mesmo significado e a mesma maturidade.

**APRESENTADORA:** Perfeito.

**ESTUDANTE:** Vamos falar do SIA. O que é um evento ambulatorial nesse contexto?

**APRESENTADORA:** Procedimentos ambulatoriais incluem consultas, exames, terapias, atendimentos especializados, ações de diagnóstico e outros procedimentos realizados sem internação. No SIA, a unidade costuma ser o procedimento ou instrumento de produção.

**ESTUDANTE:** Então ele é muito útil para oferta e produção.

**APRESENTADORA:** Muito. Permite observar onde procedimentos são realizados, quais estabelecimentos produzem determinado cuidado, como a produção varia no tempo e como políticas alteram acesso a exames e terapias.

**ESTUDANTE:** Mas maior produção não significa automaticamente maior doença.

**APRESENTADORA:** Exato. Pode indicar maior necessidade, maior oferta, melhor registro, mudança de financiamento, campanha específica ou expansão de acesso. O número de procedimentos precisa ser lido com contexto.

**ESTUDANTE:** Internações têm lógica parecida?

**APRESENTADORA:** Têm uma mistura de cuidado e administração. No SIH, a AIH organiza a informação da internação e tem finalidade assistencial e administrativa. Ela ajuda a estudar gravidade, uso da rede, tempo de permanência, procedimentos e deslocamentos.

**ESTUDANTE:** Mas o SIH registra internações financiadas pelo SUS, não todas as internações do país.

**APRESENTADORA:** Isso precisa ficar claro. Perguntas sobre toda a rede hospitalar brasileira exigem outras fontes ou limitações explícitas.

**ESTUDANTE:** No SIM, o evento é o óbito. Parece mais direto.

**APRESENTADORA:** É mais delimitado, mas ainda complexo. O óbito tem município de residência, município de ocorrência, idade, sexo, raça ou cor e causa de morte. A causa básica é a condição que iniciou a cadeia que levou à morte.

**ESTUDANTE:** Então "parada cardiorrespiratória" não costuma ser uma explicação suficiente.

**APRESENTADORA:** Exatamente. Ela descreve um mecanismo final, mas a análise precisa da causa que iniciou a cadeia. Em causas externas, a circunstância também importa: queda, atropelamento, agressão, colisão.

**ESTUDANTE:** Nascimentos entram pelo SINASC.

**APRESENTADORA:** Sim. O SINASC registra nascidos vivos a partir da Declaração de Nascido Vivo. Ele permite analisar peso ao nascer, idade gestacional, tipo de parto, características da pessoa gestante, local de ocorrência e outros elementos materno-infantis.

**ESTUDANTE:** E também serve como denominador.

**APRESENTADORA:** Isso é central. Muitos indicadores usam nascidos vivos como denominador. Mortalidade infantil, por exemplo, combina óbitos de menores de um ano no SIM com nascidos vivos no SINASC.

**ESTUDANTE:** E óbito fetal não entra do mesmo jeito.

**APRESENTADORA:** Não. Se houve sinal de vida, há nascimento vivo e, se a criança morre depois, óbito infantil. Se não houve sinal de vida, é óbito fetal. Essa diferença muda numerador, denominador e interpretação da atenção ao pré-natal, parto e recém-nascido.

**ESTUDANTE:** Vacinação também exige separar níveis.

**APRESENTADORA:** Sim. Uma dose aplicada é um evento. Uma pessoa vacinada é uma unidade individual. Um esquema completo combina doses esperadas. Cobertura vacinal é uma razão entre registros e população-alvo.

**ESTUDANTE:** Misturar dose aplicada com pessoa protegida pode gerar erro.

**APRESENTADORA:** Pode, especialmente em vacinas com múltiplas doses, reforços e campanhas. Uma cobertura acima de cem por cento, por exemplo, não significa automaticamente sucesso perfeito. Pode refletir denominador inadequado, população flutuante, duplicidade, vacinação de pessoas fora do recorte ou erro de registro.

**ESTUDANTE:** Então denominador não é detalhe matemático.

**APRESENTADORA:** Não. Denominador é parte da pergunta. Indicadores precisam de numerador, denominador, período, território, população de referência e regra de inclusão.

**ESTUDANTE:** Óbitos de residentes com população residente. Óbitos infantis com nascidos vivos do mesmo recorte.

**APRESENTADORA:** Exatamente. E procedimentos realizados em um município não devem ser automaticamente divididos pela população residente se o serviço atende pessoas de outros municípios. Para carga da rede, local de atendimento pode ser adequado. Para risco populacional, residência costuma fazer mais sentido.

**ESTUDANTE:** Vamos detalhar mortalidade infantil como exemplo de indicador combinado.

**APRESENTADORA:** O numerador são óbitos em menores de um ano no SIM. O denominador são nascidos vivos no SINASC. O indicador só faz sentido se os eventos estiverem compatíveis em território e período.

**ESTUDANTE:** Então até indicador clássico é uma costura entre sistemas.

**APRESENTADORA:** Sim. E essa costura precisa aparecer no método.

**ESTUDANTE:** E letalidade entre notificados?

**APRESENTADORA:** Também exige cuidado. O numerador pode ser óbitos entre casos notificados ou confirmados. O denominador pode ser casos notificados, prováveis ou confirmados. Cada escolha muda a medida. Se misturo suspeitos no denominador com óbitos confirmados no numerador, posso distorcer a interpretação.

**ESTUDANTE:** A fórmula parece simples, mas o conceito não é.

**APRESENTADORA:** Exatamente.

**ESTUDANTE:** Essa lógica vale para outros temas além de dengue e acidentes?

**APRESENTADORA:** Vale muito. Pense em COVID-19. Podemos olhar casos notificados, testes realizados, atendimentos respiratórios, internações, ocupação de leitos, vacinação e óbitos. Todos se relacionam ao mesmo problema, mas cada um é um evento diferente.

**ESTUDANTE:** Então um aumento de testes pode aumentar casos detectados sem significar, sozinho, a mesma coisa que aumento de internações.

**APRESENTADORA:** Exatamente. E em tuberculose acontece algo parecido. Posso estudar notificação do caso, início de tratamento, acompanhamento, cura, abandono ou óbito. Cada etapa fala de uma parte diferente da linha de cuidado.

**ESTUDANTE:** E em doenças crônicas, como diabetes ou hipertensão?

**APRESENTADORA:** Aí a pergunta pode ser sobre cadastro, consultas, exames, dispensação de medicamentos, internações por complicações ou óbitos. Se eu escolho apenas internações, estou olhando uma ponta mais grave. Se escolho consultas ou exames, estou olhando contato com o serviço. O evento escolhido define a história que o indicador consegue contar.

**ESTUDANTE:** Então o capítulo não está ensinando só a escolher uma base. Está ensinando a decompor um problema em eventos observáveis.

**APRESENTADORA:** Sim. Essa decomposição é o que transforma um tema amplo em uma pergunta analisável.

**ESTUDANTE:** Em algum momento, relacionar sistemas vira inevitável.

**APRESENTADORA:** Muitas perguntas exigem isso. SIM e SINASC para mortalidade infantil. SINAN e SIM para óbitos entre notificados. SINAN e SIH para internações após notificação. SIA, SIH e CNES para relacionar produção e estrutura da rede.

**ESTUDANTE:** Relacionamento de bases resolve tudo?

**APRESENTADORA:** Não. Ele amplia a análise, mas aumenta a responsabilidade. Um nascimento, uma internação e um óbito continuam sendo eventos distintos, produzidos em sistemas diferentes. Relacionar não apaga a origem dos registros.

**ESTUDANTE:** Também tem a dimensão ética.

**APRESENTADORA:** Sim. Quando aproximamos eventos de uma mesma pessoa, precisamos observar regras de acesso, sigilo, minimização de dados, finalidade clara e proteção contra identificação indevida. Quanto mais detalhado o pareamento, maior o cuidado.

**ESTUDANTE:** E metodologicamente, o que pode dar errado?

**APRESENTADORA:** Campos incompletos, nomes com grafias diferentes, datas erradas, municípios inconsistentes, duplicidades e registros que não aparecem na outra base. Registros não pareados não são só falha técnica; podem revelar subregistro, diferença de fluxo ou limite do método.

**ESTUDANTE:** Os não pareados também contam uma história.

**APRESENTADORA:** Contam. Uma boa análise informa quantos registros foram pareados, quantos ficaram fora, quais critérios foram usados e se as perdas se concentram em algum território, período ou perfil.

**ESTUDANTE:** Parece que relacionar sistemas aumenta o poder da pergunta e o peso da documentação.

**APRESENTADORA:** Essa é uma boa síntese. Bases relacionadas podem produzir evidências muito ricas, mas a documentação precisa acompanhar a complexidade.

**ESTUDANTE:** Se eu tivesse que levar um checklist deste episódio, qual seria?

**APRESENTADORA:** Primeiro: qual evento quero observar? Segundo: qual sistema registra esse evento? Terceiro: qual é a unidade de análise? Quarto: qual data representa minha pergunta? Quinto: qual território faz sentido? Sexto: qual cobertura a fonte tem? Sétimo: qual denominador é coerente?

**ESTUDANTE:** Esse checklist evita tratar procedimentos como pessoas, notificações como casos confirmados, internações SUS como todas as internações e atendimento como residência.

**APRESENTADORA:** Exatamente. A maioria dos tropeços vem de pular a tradução entre problema de saúde e evento registrado.

**ESTUDANTE:** Então a pergunta "qual base eu uso?" vem depois da pergunta "o que estou tentando contar?".

**APRESENTADORA:** Sim. E, quando alguma resposta for incerta, a incerteza deve aparecer no texto. Podemos dizer que a fonte aproxima uma dimensão do problema, que cobre a rede SUS, que reflete casos notificados, que pode ter atraso ou que exige cautela territorial.

**ESTUDANTE:** Isso não enfraquece a análise.

**APRESENTADORA:** Não. Torna a interpretação mais transparente e mais útil.

**ESTUDANTE:** Então dois números diferentes não são necessariamente uma contradição.

**APRESENTADORA:** Muitas vezes são duas respostas para perguntas diferentes. Um número pode contar suspeitas; outro, internações; outro, óbitos. O trabalho analítico é declarar a pergunta, preservar a diferença entre eventos e construir indicadores coerentes.

**ESTUDANTE:** Os sistemas de informação deixam de ser depósitos de números e passam a ser registros de acontecimentos.

**APRESENTADORA:** Essa é a mensagem central. Do evento ao registro, do registro à base, da base ao indicador e do indicador à interpretação, cada etapa importa.

**ESTUDANTE:** Da próxima vez que dois números não baterem, antes de dizer que um está errado, eu vou perguntar: eles estão contando o mesmo evento?

**APRESENTADORA:** Essa pergunta já melhora metade da análise. No próximo capítulo, a gente aplica essa lógica a um sistema específico: o SIM, e o percurso do óbito até virar estatística de mortalidade.
