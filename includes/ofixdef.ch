// …ÕÕÕÕÕÕÕÕÀÕÕÕÕÕÕÕÕª //                     --------
// ∫ Versao ∫ 12     ∫ // ABRIR UM CHAMADO NO   GCAD   PARA ATUALIZACAO NA TOTVS
// »ÕÕÕÕÕÕÕÕ ÕÕÕÕÕÕÕÕº //                     --------

// ------------------------------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------ //
// Email com orientaÁıes da TOTVS recebido em 20/06/2014 ( Daiane Santos Nunes )              // 
// Toda vez que atualizar o CH, abrir chamado para o GCAD informando o local do mesmo,        // 
// para que baixemos do TFS e atualizemos manualmente no diretÛrio de includes do Robopatch   // 
// ------------------------------------------------------------------------------------------ //
// ------------------------------------------------------------------------------------------ //


#DEFINE TT_STATUS_ABERTO    "A" // Status do Tipo de Tempo - Aberto
#DEFINE TT_STATUS_CANCELADO "C" // Status do Tipo de Tempo - Cancelado
#DEFINE TT_STATUS_LIBERADO  "D" // Status do Tipo de Tempo - Liberado
#DEFINE TT_STATUS_FECHADO   "F" // Status do Tipo de Tempo - Fechado

#DEFINE TT_ABERTO    "A" // Status do Tipo de Tempo - Aberto
#DEFINE TT_CANCELADO "C" // Status do Tipo de Tempo - Cancelado
#DEFINE TT_LIBERADO  "D" // Status do Tipo de Tempo - Liberado
#DEFINE TT_FECHADO   "F" // Status do Tipo de Tempo - Fechado

#DEFINE TT_TPO_PUBLICO  "1" // Situacao do Tempo - Publico
#DEFINE TT_TPO_GARANTIA "2" // Situacao do Tempo - Garantia
#DEFINE TT_TPO_INTERNO  "3" // Situacao do Tempo - Interno
#DEFINE TT_TPO_REVISAO  "4" // Situacao do Tempo - Revisao

#DEFINE TSER_MOBRAGRATUITA "0" // Por Mao-de-Obra Gratuita
#DEFINE TSER_MOBRA         "1" // Por Mao-de-Obra
#DEFINE TSER_TERCEIRO      "2" // Srv de Terceiro
#DEFINE TSER_VLLIVRE       "3" // Valor Livre c/Base na Tabela
#DEFINE TSER_RETORNO       "4" // Retorno de Servico
#DEFINE TSER_KM            "5" // Km Socorro
#DEFINE TSER_FRANQUIA      "6" // Franquia

#DEFINE TSER_TPO_FABRICA    "1" // Fabrica
#DEFINE TSER_TPO_CONCESS    "2" // Concessionaria
#DEFINE TSER_TPO_TRABALHADO "3" // Trabalhado
#DEFINE TSER_TPO_INFORMADO  "4" // Informado

// Arquivo de DEFINE's utilizados pela OFIXFUNA              

#DEFINE PECA_NTAM_RETORNO   42
#DEFINE PECA_GRUITE         01      // Grupo do Item
#DEFINE PECA_CODITE         02      // Codigo do Item
#DEFINE PECA_TIPTEM         03      // Tipo de Tempo
#DEFINE PECA_NUMOSV         04      // Numero da Ordem de Servico
#DEFINE PECA_QTDREQ         05      // Qtde da Peca Requisitada
#DEFINE PECA_VALVO3         06      // Valor do Item Gravado na VO3
#DEFINE PECA_VALDES         07      // Valor do Desconto
#DEFINE PECA_PERDES         08      // Percentual de Desconto
#DEFINE PECA_VALOR          09      // Valor do Item no Fechamento (Pode ser diferente do VO3 dependendo do Tipo de Tempo )
#DEFINE PECA_VALBRU         10      // Valor Bruto Total do Item
#DEFINE PECA_DEPINT         11      // Departamento Interno
#DEFINE PECA_DEPGAR         12      // Departamento Garantia
#DEFINE PECA_DESCRICAO      13      // Descricao do Produto
#DEFINE PECA_MOV            14      // Matriz com movimentacoes de produto
#DEFINE PECA_MOV_NOSNUM   /*14*/ 01 // Nosso Numero Requisicao (VO2_NOSNUM)
#DEFINE PECA_MOV_DATREQ   /*14*/ 02 // Data da Requisicao
#DEFINE PECA_MOV_REQDEV   /*14*/ 03 // Requisicao/Devolucao (VO2_DEVOLU)
#DEFINE PECA_MOV_QTDREQ   /*14*/ 04 // Quantidade requisitada
#DEFINE PECA_MOV_RECVO3   /*14*/ 05 // Recno da VO3
#DEFINE PECA_MOV_VALPEC   /*14*/ 06 // Valor da Peca 
#DEFINE PECA_MOV_FUNREQ   /*14*/ 07 // Funcionario que requisitou 
#DEFINE PECA_MOV_PROREQ   /*14*/ 08 // Produtivo que esta utilizando a peca  
#DEFINE PECA_CLIENTE        15      // Codigo do Cliente // Faturar Para
#DEFINE PECA_LOJA           16      // Loja do Cliente // Faturar Para
#DEFINE PECA_DATLIB         17      // Data de Liberacao
#DEFINE PECA_DATCAN         18      // Data de Cancelamento
#DEFINE PECA_DATFEC         19      // Data de Fechamento
#DEFINE PECA_INCONV_GRUPO   20      // Inconveniente // Grupo
#DEFINE PECA_INCONV_CODIGO  21      // Inconveniente // Codigo
#DEFINE PECA_INCONV_SEQ     22      // Inconveniente // Sequencia
#DEFINE PECA_INCONV_DESCR   23      // Inconveniente // Descricao
#DEFINE PECA_TES            24      // TES
#DEFINE PECA_LIBVOO         25      // Numero da Liberacao do Tipo de Tempo (VOO_LIBVOO)
#DEFINE PECA_OPER           26      // Tipo de Operacao (TES Inteligente)
#DEFINE PECA_FORMULA        27      // Formula
#DEFINE PECA_VALIMP         28      // Total de Impostos
#DEFINE PECA_NUMNFI         29      // Numero da Nota Fiscal
#DEFINE PECA_SERNFI         30      // Serie da Nota Fiscal
#DEFINE PECA_CUSTOT         31      // Custo da Mercadoria 
#DEFINE PECA_FUNFEC         32      // Funcionario que fechou o Tipo de Tempo
#DEFINE PECA_ICMST          33      // ICMS ST                                 
#DEFINE PECA_QTDREM         34      // Saldo de Pecas em remessa para atendimento externo
#DEFINE PECA_ACRESC         35      // Acrescimo no valor da peca
#DEFINE PECA_PROCFEC        36      // Indica se foi processado no levantamento de VEC (Uso interno)
#DEFINE PECA_VECREL         37      // Relacionamento com a VEC
#DEFINE PECA_STATUS         38      // Status do Tipo de Tempo
#DEFINE PECA_CENCUS         39      // Centro de Custo
#DEFINE PECA_CONTA          40      // Conta
#DEFINE PECA_ITEMCTA        41      // Item da Conta
#DEFINE PECA_CLVL           42      // Classe de Valor Cont·bil

#DEFINE SRVC_NTAM_RETORNO   53
#DEFINE SRVC_GRUSER         01      // Grupo de Servico
#DEFINE SRVC_CODSER         02      // Codigo do Servico
#DEFINE SRVC_NUMOSV         03      // Numero da Ordem de Servico
#DEFINE SRVC_TIPTEM         04      // Tipo de Tempo
#DEFINE SRVC_TIPSER         05      // Tipo de Servico
#DEFINE SRVC_INCMOB         06      // Tipo de Cobranca (VOK_INCMOB)
#DEFINE SRVC_VALBRU         07      // Valor do Servico (Valor Bruto)
#DEFINE SRVC_VALDES         08      // Valor do Desconto
#DEFINE SRVC_VALLIQ         09      // Valor do Servico (Valor Liquido)
#DEFINE SRVC_TEMPAD         10      // Tempo Padrao (MINUTOS CENTESIMAL)
#DEFINE SRVC_TEMTRA         11      // Tempo Trabalhado (MINUTOS CENTESIMAL)
#DEFINE SRVC_TEMCOB         12      // Tempo Cobranca (MINUTOS CENTESIMAL)
#DEFINE SRVC_TEMVEN         13      // Tempo Vendido (MINUTOS CENTESIMAL)
#DEFINE SRVC_APONT          14      // Matriz de Apontamentos do Servico / Req. de Servico de Terceiros
#DEFINE SRVC_APONT_CODIGO /*14*/ 01 // Codigo do Produtivo
#DEFINE SRVC_APONT_DATINI /*14*/ 02 // Data Inicial
#DEFINE SRVC_APONT_HORINI /*14*/ 03 // Hora Inicial
#DEFINE SRVC_APONT_DATFIN /*14*/ 04 // Data Final
#DEFINE SRVC_APONT_HORFIN /*14*/ 05 // Hora Final
#DEFINE SRVC_APONT_HOTFIN /*14*/ 05 // Hora Final -- REMOVER.....
#DEFINE SRVC_APONT_TEMTRA /*14*/ 06 // Tempo Trabalhado (MINUTOS CENTESIMAL)
#DEFINE SRVC_APONT_SEQUEN /*14*/ 07 // Sequencia (VO4_SEQUEN)
#DEFINE SRVC_APONT_RECVO4 /*14*/ 08 // Recno da VO4
#DEFINE SRVC_APONT_NOSNUM /*14*/ 09 // Nosso Numero Requisicao (VO4_NOSNUM)
#DEFINE SRVC_APONT_VALLIQ /*14*/ 10 // Valor Liquido do Servico (Por Apontamento)
#DEFINE SRVC_APONT_RECVSC /*14*/ 11 // Recno da VSC
#DEFINE SRVC_APONT_NOME   /*14*/ 12 // Nome do Produtivo
#DEFINE SRVC_APONT_TEMCOB /*14*/ 13 // Tempo cobrado proporcional ao Tempo Trabalhado
#DEFINE SRVC_APONT_FUNREQ /*14*/ 14 // Funcionario que requisitou 
#DEFINE SRVC_APONT_MPAUSA /*14*/ 15 // Motivo da Pausa
#DEFINE SRVC_APONT_PERRAT /*14*/ 16 // Perc. de Rateio
#DEFINE SRVC_APONT_CODFOR /*14*/ 17 // (Srvc. Terceiros) - Fornecedor
#DEFINE SRVC_APONT_FOLOJA /*14*/ 18 // (Srvc. Terceiros) - Loja
#DEFINE SRVC_APONT_NUMTIT /*14*/ 19 // (Srvc. Terceiros) - Numero do Titulo (Financeiro)
#DEFINE SRVC_APONT_TIPTIT /*14*/ 20 // (Srvc. Terceiros) - Tipo do Titulo (Financeiro)
#DEFINE SRVC_APONT_DATPAG /*14*/ 21 // (Srvc. Terceiros) - Data do Pagamento
#DEFINE SRVC_APONT_CODPAG /*14*/ 22 // (Srvc. Terceiros) - Cond. de Pagamento
#DEFINE SRVC_APONT_NATURE /*14*/ 23 // (Srvc. Terceiros) - Natureza
#DEFINE SRVC_APONT_VALCUS /*14*/ 24 // (Srvc. Terceiros) - Valor do Custo
#DEFINE SRVC_APONT_VALVEN /*14*/ 25 // (Srvc. Terceiros) - Valor da Venda
#DEFINE SRVC_APONT_CUSHOR /*14*/ 26 // Custo da Hora Trabalhada (Custo de Hora por Produtivo)
#DEFINE SRVC_DESCRICAO      15      // Descricao do Servico
#DEFINE SRVC_DESCRTIPSER    16      // Descricao do Tipo de Servico
#DEFINE SRVC_PERDES         17      // Percentual de Desconto
#DEFINE SRVC_CODSEC         18      // Codigo da Secao
#DEFINE SRVC_KILROD         19      // Kilometros Rodados (Fechamento por KM)
#DEFINE SRVC_CLIENTE        20      // Codigo do Cliente - Faturar Para
#DEFINE SRVC_LOJA           21      // Loja do Cliente - Faturar Para
#DEFINE SRVC_DATLIB         22      // Data de Liberacao
#DEFINE SRVC_DATCAN         23      // Data de Cancelamento
#DEFINE SRVC_DATFEC         24      // Data de Fechamento
#DEFINE SRVC_CODFOR         25      // (Srvc. Terceiros) - Fornecedor
#DEFINE SRVC_FOLOJA         26      // (Srvc. Terceiros) - Loja
#DEFINE SRVC_NUMTIT         27      // (Srvc. Terceiros) - Numero do Titulo (Financeiro)
#DEFINE SRVC_TIPTIT         28      // (Srvc. Terceiros) - Tipo do Titulo (Financeiro)
#DEFINE SRVC_DATPAG         29      // (Srvc. Terceiros) - Data do Pagamento
#DEFINE SRVC_CODPAG         30      // (Srvc. Terceiros) - Cond. de Pagamento
#DEFINE SRVC_NATURE         31      // (Srvc. Terceiros) - Natureza
#DEFINE SRVC_VALCUS         32      // (Srvc. Terceiros) - Valor do Custo
#DEFINE SRVC_INCONV_GRUPO   33      // Inconveniente - Grupo
#DEFINE SRVC_INCONV_CODIGO  34      // Inconveniente - Codigo
#DEFINE SRVC_INCONV_SEQ     35      // Inconveniente - Sequencia
#DEFINE SRVC_INCONV_DESCR   36      // Inconveniente - Descricao
#DEFINE SRVC_SERINT         37      // Codigo Interno do Servico
#DEFINE SRVC_LIBVOO         38      // Numero da Liberacao do Tipo de Tempo (VOO_LIBVOO)
#DEFINE SRVC_VALIMP         39      // Total de Impostos (VEC_TOTIMP)
#DEFINE SRVC_NUMNFI         40      // Numero da Nota Fiscal
#DEFINE SRVC_SERNFI         41      // Serie da Nota Fiscal
#DEFINE SRVC_FUNFEC         42      // Funcionario que fechou o Tipo de Tempo
#DEFINE SRVC_VALHOR         43      // Valor da Hora
#DEFINE SRVC_VALSER         44      // Valor Fixo do Servico (quando gravado do VO4)
#DEFINE SRVC_DEPINT         45      // Departamento Interno
#DEFINE SRVC_DEPGAR         46      // Departamento Garantia
#DEFINE SRVC_STATUS         47      // Status do Tipo de Tempo
#DEFINE SRVC_CENCUS         48      // Centro de Custo
#DEFINE SRVC_CONTA          49      // Conta
#DEFINE SRVC_ITEMCTA        50      // Item da Conta
#DEFINE SRVC_CLVL           51      // Classe de Valor Cont·bil
#DEFINE SRVC_INCTEM         52      // Tempo para Calculo
#DEFINE SRVC_GENERICO       53      // Servico Generico ?