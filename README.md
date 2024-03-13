# Documentação do Projeto

## 1. Descrição do Projeto
### 1.1 Cenário do Negócio

O objetivo deste projeto é fornecer um dashboard informativo sobre o Tour de France, uma das mais famosas provas de ciclismo do mundo, realizada na França. Os dados históricos fornecidos abrangem o período de 1903 a 2022 e incluem informações sobre as etapas da prova, distâncias percorridas, participantes, finalizadores e vencedores de cada ano. O dashboard visa oferecer uma visão geral e detalhada da evolução do Tour de France ao longo do tempo, destacando insights, curiosidades e comportamentos relevantes.

### 1.2 Dados Utilizados

Os dados fornecidos consistem numa visão abrangente do Tour de France ao longo dos anos:

- **Tabela de finalistas [tdf_finishers.csv]:** Este conjunto de dados inclui informações sobre os ciclistas que finalizaram a prova em cada edição do Tour de France. Inclui detalhes como nome do ciclista, posição final, tempo total de prova, entre outros.

- **Estágios da prova [tdf_stages.csv]:** Este conjunto fornece informações sobre as etapas individuais de cada Tour de France, incluindo a data, a distância percorrida, o tipo de terreno e outras características relevantes.

- **Tours realizados [tdf_tours.csv]:** Este conjunto lista todas as edições do Tour de France, fornecendo detalhes como ano, distância total percorrida, número de etapas e outras informações gerais.

- **Vencedores [tdf_winners.csv]:** Este conjunto apresenta os vencedores de cada edição do Tour de France, incluindo o nome do ciclista vencedor, sua nacionalidade, o tempo total de prova e outras informações relacionadas à vitória.

## 2. Arquitetura
<img src="https://i.ibb.co/hs7vBYY/db-tour-france.png" alt="db-tour-france">

O processo de construção do dashboard segue a seguinte arquitetura:

1. **Recebimento dos dados:** Os dados fornecidos são recebidos no formato de arquivos CSV.
2. **Armazenamento no S3 da Amazon:** Os arquivos são transferidos para o Amazon S3 para armazenamento seguro e escalável.
3. **Processamento no Redshift:** Os arquivos são então carregados no Amazon Redshift, um data warehouse baseado em nuvem, onde serão processados e transformados.
4. **Tratamento com DBT (Data Build Tool):** Utilizando o DBT, as camadas de dados são construídas e modeladas, proporcionando uma estrutura organizada e otimizada para análise.
5. **Conexão com o Power BI:** Após o processamento no DBT, os dados são disponibilizados materializados em tabela para conexão com o Power BI tendo em vista este processo como melhor forma de desempenho.
6. **Criação do Dashboard:** O Power BI é utilizado para criar o dashboard interativo, que fornecerá informações relevantes e visuais sobre o Tour de France ao longo dos anos.

## 3. Conclusão e Possíveis Melhorias

O projeto apresenta diversos pontos positivos que contribuem para sua eficácia e utilidade:

- **Estruturação dos Dados:** A utilização do DBT permite uma modelagem eficiente dos dados, facilitando a análise e visualização no Power BI. A separação em camadas lógicas proporciona uma organização clara e flexível dos dados.

- **Conexão com o Power BI:** O uso do Power BI como ferramenta de visualização permite a criação de dashboards interativos e intuitivos. A integração com o DBT simplifica o processo de obtenção e atualização dos dados, garantindo a consistência e precisão das análises.

- **Armazenamento na Nuvem:** A escolha de armazenar os dados no Amazon S3 e processá-los no Redshift aproveita os benefícios da computação em nuvem, como escalabilidade e segurança. Isso garante um ambiente robusto para manipulação e análise dos dados do Tour de France.

### 3.2 Possíveis Melhorias

Apesar dos pontos positivos, há algumas áreas que podem ser aprimoradas para aumentar a eficiência e qualidade do projeto:

- **Testes Automatizados no DBT:** A inclusão de testes automatizados no DBT seria fundamental para garantir a qualidade dos dados e a integridade das transformações. Testes de validação de esquema, integridade referencial e lógica de negócios ajudariam a evitar erros e inconsistências nos dados processados.

- **Governança de Dados:** A implementação de hooks no DBT para governança de dados seria benéfica para aplicar políticas de qualidade e conformidade aos dados. Isso inclui validação de formatos, detecção de valores ausentes ou inválidos e aplicação de regras de negócios específicas.

- **Monitoramento e Rastreabilidade:** Apesar te conter a Lineage, a utilização das funcionalidades de logs do DBT permitiria rastrear e monitorar as transformações dos dados, proporcionando uma visão detalhada do processo. Isso facilitaria a identificação de falhas, otimização de desempenho e auditoria das operações realizadas.

- **Agendamento Automatizado:** A implementação de um scheduler no DBT ou em uma ferramenta como Airflow permitiria automatizar as tarefas de processamento e atualização dos dados. Isso garantiria a atualização regular do dashboard e a disponibilidade de informações em tempo hábil para os usuários.