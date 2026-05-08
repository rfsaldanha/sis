# Podcast: CNES -- Cadastro Nacional de Estabelecimentos de Saúde

**Livro:** Sistemas de Informação em Saúde no Brasil  
**Capítulo:** CNES -- Cadastro Nacional de Estabelecimentos de Saúde  
**Formato:** conversa entre apresentadora e estudante  
**Tom:** acadêmico, mas relaxado

## Roteiro

**APRESENTADORA:** Olá. Neste episódio, vamos conversar sobre o CNES, o Cadastro Nacional de Estabelecimentos de Saúde.

**ESTUDANTE:** O CNES é a base usada para identificar os estabelecimentos de saúde no Brasil?

**APRESENTADORA:** Exatamente. O CNES é uma base estruturante para identificar e caracterizar estabelecimentos de saúde. Ele informa localização, natureza jurídica, gestão, tipo de estabelecimento, serviços, equipamentos, leitos, equipes, habilitações, profissionais e vínculos relacionados à oferta de atenção à saúde.

**ESTUDANTE:** Então ele é diferente de sistemas como SIM, SINASC, SIH, SIA e SINAN.

**APRESENTADORA:** Sim. O CNES não registra eventos assistenciais. Ele não registra consultas, internações, óbitos, nascimentos ou notificações. Ele descreve a estrutura da rede em determinada competência.

**ESTUDANTE:** Por isso ele costuma ser combinado com outros sistemas.

**APRESENTADORA:** Perfeito. O código CNES permite relacionar produção ambulatorial, internações, notificações, nascimentos e óbitos à estrutura da rede onde esses eventos foram registrados.

**ESTUDANTE:** Quando devo usar o CNES?

**APRESENTADORA:** Use o CNES quando a pergunta envolve oferta, capacidade instalada, localização de serviços, composição da rede, vínculos profissionais, leitos, equipamentos, equipes, habilitações ou caracterização de estabelecimentos.

**ESTUDANTE:** Então, se eu quero saber quantas internações ocorreram, uso SIH. Se quero caracterizar os hospitais dessas internações, uso CNES.

**APRESENTADORA:** Exatamente. O SIH mede produção hospitalar financiada pelo SUS. O CNES ajuda a descrever o estabelecimento, seus leitos, tipo, natureza jurídica, gestão e outros atributos.

**ESTUDANTE:** Como o CNES surgiu?

**APRESENTADORA:** Houve esforços anteriores de cadastro, como a Pesquisa da Assistência Médico-Sanitária e sistemas administrativos ligados ao pagamento de contas hospitalares. Depois da implantação do SIA e da identificação de inconsistências nos dados de estabelecimentos, foi criada a Ficha de Cadastro de Estabelecimentos de Saúde. Em 2000, a Portaria SAS/MS número 403 definiu o CNES.

**ESTUDANTE:** Então o CNES também tem origem administrativa, mas virou uma base essencial para pesquisa e gestão.

**APRESENTADORA:** Isso. Hoje ele é referência para caracterizar a rede assistencial e para vincular estabelecimentos a diferentes sistemas de informação em saúde.

**ESTUDANTE:** O capítulo define estabelecimento de saúde como espaço físico delimitado e permanente.

**APRESENTADORA:** Sim. É o espaço onde são realizadas ações e serviços de saúde humana sob responsabilidade técnica. Essa definição ajuda a entender por que o código CNES identifica uma unidade da rede, e não uma pessoa, procedimento ou evento.

**ESTUDANTE:** O CNES é atualizado mensalmente?

**APRESENTADORA:** Sim, por competência. Isso permite acompanhar mudanças na rede ao longo do tempo. Mas também exige cuidado: uma competência é uma fotografia cadastral, não uma medida de produção assistencial nem de disponibilidade em tempo real.

**ESTUDANTE:** Como funciona o fluxo cadastral?

**APRESENTADORA:** O estabelecimento preenche ou atualiza a FCES, o gestor municipal ou estadual valida as informações, há críticas cadastrais, e a base é disseminada por competência. A qualidade depende de preenchimento correto, atualização regular e coerência entre estabelecimento, serviços, leitos, equipamentos e profissionais.

**ESTUDANTE:** Qual é a unidade de análise do CNES?

**APRESENTADORA:** Depende do arquivo. Esse é o principal cuidado. A unidade pode ser estabelecimento, profissional, equipe, equipamento, leito, serviço especializado, habilitação ou outro módulo cadastral.

**ESTUDANTE:** Então não posso somar linhas de arquivos diferentes como se fossem a mesma coisa.

**APRESENTADORA:** Exatamente. Uma linha no arquivo ST representa estabelecimento. Uma linha no PF representa vínculo profissional. Uma linha no LT representa leito. Uma linha no EQ representa equipamento. Misturar essas unidades gera erro.

**ESTUDANTE:** Qual arquivo costuma ser o ponto de partida?

**APRESENTADORA:** Em geral, o ST, que contém os atributos gerais dos estabelecimentos. Depois você combina outros arquivos apenas se a pergunta exigir recursos específicos, como leitos, equipamentos, equipes, serviços ou profissionais.

**ESTUDANTE:** Quais são alguns prefixos importantes?

**APRESENTADORA:** ST para estabelecimentos, PF para profissionais, LT para leitos, EQ para equipamentos, EP para equipes, SR para serviços especializados e HB para habilitações. Também há arquivos como EE, EF, GM, IN, RC e DC para dimensões específicas.

**ESTUDANTE:** E a competência precisa estar sempre presente.

**APRESENTADORA:** Sim. Em séries históricas, a competência é o eixo principal. Estabelecimentos podem abrir, sair da base, mudar de município, tipo, gestão, natureza jurídica, serviços, habilitações e leitos.

**ESTUDANTE:** Então usar o CNES atual para classificar eventos antigos pode ser um erro.

**APRESENTADORA:** Exatamente. Se uma internação ocorreu em 2015, o ideal é caracterizar o estabelecimento com o CNES da competência da internação ou com uma regra temporal documentada.

**ESTUDANTE:** O código CNES permite acompanhar estabelecimentos ao longo do tempo.

**APRESENTADORA:** Permite, mas não significa que o estabelecimento permaneceu igual. O mesmo código pode estar associado a mudanças de perfil, gestão, serviços ou capacidade. Por isso, em estudos longitudinais, é melhor tratar o CNES como um painel por competência.

**ESTUDANTE:** Vamos falar de leitos.

**APRESENTADORA:** Leitos são um uso muito frequente do CNES. A análise deve separar leitos existentes, leitos SUS, tipo de leito, competência, município e estabelecimento.

**ESTUDANTE:** Leito cadastrado é o mesmo que leito disponível todos os dias?

**APRESENTADORA:** Não. Leito cadastrado é uma medida de capacidade instalada. Para analisar ocupação, disponibilidade diária, demanda reprimida ou pressão assistencial, é preciso combinar com outras fontes operacionais, como SIH, censo hospitalar ou regulação.

**ESTUDANTE:** E leitos SUS não devem ser misturados automaticamente com leitos não SUS.

**APRESENTADORA:** Isso. O recorte precisa estar claro. Leitos existentes, leitos SUS e tipos de leito respondem a perguntas diferentes.

**ESTUDANTE:** E profissionais?

**APRESENTADORA:** No arquivo PF, a unidade prática é o vínculo profissional no estabelecimento. Um mesmo profissional pode aparecer em mais de um estabelecimento, em mais de uma ocupação ou em mais de um vínculo.

**ESTUDANTE:** Então contar vínculos não é contar profissionais únicos.

**APRESENTADORA:** Perfeito. Ao escrever resultados, use termos precisos: vínculos de médicos, carga horária cadastrada de enfermeiros ou profissionais únicos, quando houver deduplicação adequada.

**ESTUDANTE:** Como o CNES se relaciona com o SIH?

**APRESENTADORA:** Uma integração comum é usar o CNES para caracterizar estabelecimentos que registraram internações no SIH. A junção deve respeitar o CNES e a competência. Também é importante agregar arquivos como LT antes da junção, para não multiplicar linhas de AIH.

**ESTUDANTE:** O mesmo vale para SIA?

**APRESENTADORA:** Sim. A produção ambulatorial deve ser agregada por estabelecimento e competência antes de relacionar com ST, SR, EQ ou HB. Serviço cadastrado e produção realizada são dimensões diferentes.

**ESTUDANTE:** O capítulo também fala de geocodificação.

**APRESENTADORA:** Sim. O CNES é muito usado para mapas de serviços e análise de acesso geográfico. Mas a qualidade espacial depende de endereço, coordenadas, geocodificação e validação local.

**ESTUDANTE:** Que problemas podem aparecer nos mapas?

**APRESENTADORA:** Coordenadas ausentes, coordenadas zero, pontos fora do município, coordenadas repetidas em endereços genéricos, endereço incompleto e mudanças temporais de localização. Tudo isso precisa ser verificado antes de calcular distância ou mapear serviços.

**ESTUDANTE:** Distância em linha reta pode ser inadequada, certo?

**APRESENTADORA:** Sim. Para acesso geográfico, a rede viária, barreiras naturais, transporte e tempo de deslocamento podem ser mais informativos que distância euclidiana.

**ESTUDANTE:** Como avaliar qualidade no CNES?

**APRESENTADORA:** Verifique atualização, completitude, consistência territorial, coerência de recursos, duplicidade, mudanças históricas e compatibilidade entre cadastro e produção quando isso fizer sentido.

**ESTUDANTE:** O CNES depende muito da atualização local.

**APRESENTADORA:** Exatamente. Como é cadastro administrativo, dados podem estar defasados ou inconsistentes se o processo local de atualização não estiver regular.

**ESTUDANTE:** Como posso acessar os dados?

**APRESENTADORA:** Por consulta direta no site do CNES, TabNet, TabWin e arquivos DBC, OpenDataSUS, ElasticCNES, R com microdatasus, Python com PySUS e PCDaS.

**ESTUDANTE:** O CNES cobre rede pública, privada, filantrópica e conveniada.

**APRESENTADORA:** Sim. Por isso, o recorte institucional precisa ser declarado. Rede SUS, rede pública, rede privada, filantrópica e suplementar não são sinônimos.

**ESTUDANTE:** Um hospital privado pode produzir para o SUS.

**APRESENTADORA:** Exatamente. E um estabelecimento público pode ter papéis assistenciais muito diferentes. O critério de recorte deve seguir a pergunta: atendimento SUS, leitos SUS, convênio, gestão, natureza jurídica ou produção SUS.

**ESTUDANTE:** O CNES pode ser usado como denominador?

**APRESENTADORA:** Pode, mas com cuidado. Você pode calcular internações por leito SUS, procedimentos por serviço cadastrado, notificações por unidade notificadora, profissionais por população ou equipamentos por estabelecimento.

**ESTUDANTE:** Mas o denominador precisa ser nomeado corretamente.

**APRESENTADORA:** Isso. O denominador pode ser estabelecimento, vínculo, leito, serviço, equipe ou equipamento. Trocar uma unidade pela outra muda completamente o indicador.

**ESTUDANTE:** Quais são limitações importantes?

**APRESENTADORA:** Cadastro não é produção. Cadastro não é disponibilidade em tempo real. A atualização depende da gestão local. Profissionais podem ter múltiplos vínculos. Classificações mudam historicamente. Endereços e coordenadas podem ter erro. E a competência importa.

**ESTUDANTE:** Então o CNES é essencial, mas não deve ser tratado como retrato perfeito da rede em funcionamento.

**APRESENTADORA:** Exatamente. Ele é uma base poderosa para estudar estrutura, oferta cadastrada, distribuição territorial e vínculos da rede. Mas a interpretação precisa reconhecer que cadastro, produção e disponibilidade operacional são coisas diferentes.

**ESTUDANTE:** Quais erros comuns devem ser evitados?

**APRESENTADORA:** Contar vínculos profissionais como pessoas, somar arquivos diferentes sem harmonização, usar CNES atual para eventos antigos, tratar leito cadastrado como leito disponível, mapear sem validar coordenadas, misturar rede SUS, pública e privada sem critério e relacionar eventos com recursos linha a linha.

**ESTUDANTE:** Para fechar, qual é a mensagem central?

**APRESENTADORA:** O CNES é a base de referência para entender a estrutura da rede de saúde no Brasil. Para usá-lo bem, defina a competência, escolha o arquivo adequado à unidade de análise, preserve a diferença entre estabelecimento, recurso e vínculo, valide qualidade e geocodificação, e relacione com outros sistemas respeitando tempo, chave e granularidade.
