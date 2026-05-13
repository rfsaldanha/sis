# Podcast: RNDS -- Rede Nacional de Dados em Saúde

**Livro:** Sistemas de Informação em Saúde no Brasil  
**Capítulo:** RNDS -- Rede Nacional de Dados em Saúde  
**Formato:** conversa entre apresentadora e estudante  
**Tom:** acadêmico, mas relaxado

## Roteiro

**APRESENTADORA:** Olá. Neste episódio, vamos conversar sobre a RNDS, a Rede Nacional de Dados em Saúde.

**ESTUDANTE:** A RNDS é mais um sistema de informação em saúde, como SIM, SINASC ou SI-PNI?

**APRESENTADORA:** Não exatamente. A RNDS não é apenas mais uma base de dados. Ela é a plataforma nacional de interoperabilidade do Ministério da Saúde.

**ESTUDANTE:** Interoperabilidade no sentido de sistemas conversarem entre si?

**APRESENTADORA:** Exatamente. A ideia é permitir que sistemas diferentes troquem informações de saúde de forma segura, padronizada e compreensível.

**ESTUDANTE:** Então a RNDS não substitui todos os sistemas existentes.

**APRESENTADORA:** Isso. Ela não substitui SIM, SINASC, SIH, SIA, SINAN, CNES, SISAPS ou SI-PNI. Ela cria uma camada de integração para que registros produzidos em diferentes sistemas possam circular com governança.

**ESTUDANTE:** Qual é a função central da RNDS?

**APRESENTADORA:** Apoiar continuidade do cuidado, acesso do cidadão aos próprios registros, apoio à decisão clínica, gestão, vigilância e transformação digital do SUS.

**ESTUDANTE:** O cidadão acessa isso pelo Meu SUS Digital?

**APRESENTADORA:** Sim. Quando os registros estão integrados e disponíveis, o cidadão pode consultar informações pelo Meu SUS Digital, como vacinas, atendimentos, medicamentos e outros registros.

**ESTUDANTE:** E profissionais de saúde?

**APRESENTADORA:** Profissionais autorizados podem consultar informações em contexto assistencial, por ferramentas como o SUS Digital Profissional. Mas o acesso depende de perfil, finalidade e regras de segurança.

**ESTUDANTE:** Então a RNDS não é dado aberto.

**APRESENTADORA:** Esse é um ponto essencial. A RNDS lida com dados pessoais sensíveis. Muitos registros são individuais e protegidos. Dados abertos podem ser produtos derivados, anonimizados ou agregados, mas a RNDS em si não é uma base pública irrestrita.

**ESTUDANTE:** Quando a RNDS foi instituída?

**APRESENTADORA:** Em 2020, no contexto do Programa Conecte SUS, pela Portaria número 1.434, de 28 de maio de 2020.

**ESTUDANTE:** O que essa portaria estabeleceu?

**APRESENTADORA:** Ela instituiu o Programa Conecte SUS e a Rede Nacional de Dados em Saúde como componente do Sistema Nacional de Informações em Saúde, voltado à integração e interoperabilidade entre estabelecimentos públicos, privados e órgãos gestores.

**ESTUDANTE:** A pandemia teve impacto nesse processo?

**APRESENTADORA:** Sim. A pandemia de Covid-19 acelerou a necessidade de integrar resultados laboratoriais, vacinação e outros registros de forma mais oportuna.

**ESTUDANTE:** O capítulo diz que a RNDS é uma infraestrutura. O que isso quer dizer?

**APRESENTADORA:** Quer dizer que ela organiza a troca de dados. O registro nasce em um sistema de origem, como um prontuário, sistema laboratorial, sistema vacinal ou sistema de regulação. Depois é convertido para um modelo padronizado, autenticado, enviado, validado e disponibilizado conforme regras de acesso.

**ESTUDANTE:** Então existem várias etapas antes de um dado aparecer para consulta.

**APRESENTADORA:** Sim. Registro local, mapeamento, codificação, autenticação, envio, validação e consulta. Falhas em qualquer etapa podem gerar atraso ou ausência de informação.

**ESTUDANTE:** Isso muda a interpretação de ausência de registro.

**APRESENTADORA:** Muito. Ausência de registro na RNDS não prova ausência de cuidado. Pode indicar que o serviço não está integrado, que houve atraso, rejeição técnica ou problema de identificação.

**ESTUDANTE:** O capítulo fala em modelos de informação. O que são?

**APRESENTADORA:** Modelos de informação definem quais dados devem ser enviados, sua estrutura, significado, obrigatoriedade e regras. Eles dizem, por exemplo, quais campos compõem um registro de atendimento clínico ou de imunização.

**ESTUDANTE:** Quais modelos aparecem no capítulo?

**APRESENTADORA:** REL, para Resultado de Exames Laboratoriais; RAC, para Registro de Atendimento Clínico; RIA-C e RIA-R, para imunobiológicos administrados em campanha e rotina; e RIRA ou MIRA, ligados à regulação assistencial.

**ESTUDANTE:** Então o SI-PNI conversa com a RNDS por modelos de imunização.

**APRESENTADORA:** Exatamente. Registros de imunização podem circular pela RNDS por modelos como o Registro de Imunobiológico Administrado.

**ESTUDANTE:** E o padrão FHIR?

**APRESENTADORA:** FHIR significa Fast Healthcare Interoperability Resources. É um padrão usado para representar e trocar informações de saúde. Ele ajuda sistemas diferentes a entenderem recursos como paciente, organização, profissional, atendimento, observação e imunização.

**ESTUDANTE:** FHIR resolve tudo?

**APRESENTADORA:** Não. Ele ajuda muito na interoperabilidade técnica, mas ainda é preciso garantir interoperabilidade semântica. Ou seja, os sistemas precisam atribuir o mesmo significado aos campos e códigos.

**ESTUDANTE:** Por isso entram as terminologias.

**APRESENTADORA:** Sim. Terminologias controladas, como LOINC para exames laboratoriais, ajudam a reduzir ambiguidade. Mas código correto não substitui qualidade do registro no ponto de cuidado.

**ESTUDANTE:** Quais identificadores são essenciais?

**APRESENTADORA:** Identificação do cidadão, geralmente por CNS ou CPF quando o modelo exige; CNES para estabelecimento; identificação do profissional ou papel assistencial quando aplicável; sistema de origem; documento ou evento; e datas.

**ESTUDANTE:** Datas no plural.

**APRESENTADORA:** Sim. Data do evento, data do registro, data de envio e data de atualização podem ser diferentes. Confundir essas datas prejudica séries temporais e monitoramento.

**ESTUDANTE:** E se a pessoa estiver identificada errado?

**APRESENTADORA:** Isso pode fragmentar a trajetória do cidadão, duplicar registros ou associar informações ao contexto errado. É um problema clínico, operacional e analítico.

**ESTUDANTE:** Como pensar no acesso à RNDS?

**APRESENTADORA:** Por perfis. O cidadão acessa seus próprios registros. O profissional acessa em contexto assistencial. O gestor acompanha informações para planejamento e monitoramento. O integrador usa guias e APIs. O pesquisador depende de governança específica para uso secundário.

**ESTUDANTE:** Então a finalidade de uso é central.

**APRESENTADORA:** Exatamente. O fato de um dado estar tecnicamente disponível não significa que ele pode ser usado para qualquer finalidade.

**ESTUDANTE:** Como avaliar qualidade dos dados na RNDS?

**APRESENTADORA:** Verifique completitude, conformidade com o modelo, consistência, oportunidade, identificação, duplicidade, retificação e rastreabilidade.

**ESTUDANTE:** Integração técnica não garante qualidade clínica.

**APRESENTADORA:** Perfeito. Um recurso pode estar tecnicamente válido, mas ainda ter erro de preenchimento, código inadequado, data inconsistente ou contexto incompleto.

**ESTUDANTE:** Como a privacidade aparece nessa discussão?

**APRESENTADORA:** A RNDS trabalha com dados pessoais sensíveis. O uso deve respeitar LGPD, sigilo profissional, segurança da informação, finalidade, necessidade, controle de acesso, rastreabilidade e governança.

**ESTUDANTE:** A RNDS se relaciona com vários sistemas do livro.

**APRESENTADORA:** Sim. Com SI-PNI para imunização, SISAPS para registros da Atenção Primária, CNES para estabelecimentos, SINAN para vigilância, SIA e SIH para produção e internação, além de interfaces como Meu SUS Digital.

**ESTUDANTE:** Mas cada sistema tem uma lógica própria.

**APRESENTADORA:** Exatamente. A RNDS integra informações, mas não apaga a diferença entre notificação, atendimento clínico, produção ambulatorial, internação, imunização e cadastro de estabelecimento.

**ESTUDANTE:** Pode dar um exemplo de continuidade do cuidado?

**APRESENTADORA:** Uma pessoa pode ser atendida em uma UBS, depois em um serviço especializado e depois em outro município. Se os sistemas estiverem integrados, profissionais autorizados podem acessar parte da trajetória de cuidado de forma mais segura e oportuna.

**ESTUDANTE:** Isso pode evitar repetição de exames?

**APRESENTADORA:** Pode contribuir para isso, especialmente quando resultados e documentos estão disponíveis. Mas depende da integração, da qualidade dos registros e do uso efetivo pelos profissionais.

**ESTUDANTE:** E para gestores?

**APRESENTADORA:** Gestores podem monitorar estabelecimentos integrados, registros enviados, registros rejeitados, tempo até envio e completitude por campo. Esses indicadores ajudam a acompanhar a maturidade da integração.

**ESTUDANTE:** Quais erros comuns devemos evitar?

**APRESENTADORA:** Tratar a RNDS como prontuário único completo, interpretar ausência de registro como ausência de cuidado, ignorar versões dos modelos, confundir evento clínico com produção administrativa e usar dados identificáveis sem governança.

**ESTUDANTE:** Quando não usar a RNDS sozinha?

**APRESENTADORA:** Para estimar incidência de doença, medir toda a produção do SUS, avaliar qualidade do cuidado, provar ausência de atendimento ou treinar algoritmos sem base ética e jurídica. Nesses casos, ela precisa ser combinada com outras fontes e regras de governança.

**ESTUDANTE:** Quais são as principais limitações?

**APRESENTADORA:** Integração progressiva, dependência do registro local, mudanças de modelos, identificação inconsistente, acesso restrito, diferenças entre uso assistencial e uso analítico, retificações e limitações semânticas.

**ESTUDANTE:** Qual é a mensagem final do capítulo?

**APRESENTADORA:** A RNDS é uma infraestrutura estratégica para conectar a informação em saúde no Brasil. Para usá-la bem, é preciso entender modelos, fluxos, identificadores, finalidade, privacidade e qualidade do dado.

**ESTUDANTE:** Então a RNDS não é só tecnologia.

**APRESENTADORA:** Exatamente. Ela é tecnologia, mas também governança, padronização, segurança, processo de trabalho e política pública de saúde digital.
