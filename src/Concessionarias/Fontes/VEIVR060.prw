/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

////////////////
// Versao 11  //
////////////////


#INCLUDE "veivr060.ch"
#INCLUDE "PROTHEUS.CH"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ VEIVR060 บ Autor ณ Ricardo Farinelli  บ Data ณ  04/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Entrada de Veiculos por Periodo.              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function VEIVR060()

Private cStr     := ""
Private nNroVei  := 0
Private nValTot  := 0 // Valor Total da Transacao (valida)
Private nValIpi  := 0 // Valor Total de Ipi (valida)
Private nValICM  := 0 // Valor Total de Icms (valida)
Private nValTotC := 0 // Valor Total da Transacao (cancelada)
Private nValICMC := 0 // Valor Total de Icms (cancelada)
Private nValIpiC := 0 // Valor Total de Ipi (cancelada)
Private lA2_IBGE := If(SA2->(FieldPos("A2_IBGE"))>0,.t.,.f.)

U_VR060R3() // Executa versใo anterior do fonte

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFuncao    ณ VR060R3  ณ Autor ณ ANDRE                 ณ Data ณ 23/02/06 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescricao ณ Executa a impressao do relatorio                           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณUso       ณ Oficina                                                    ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function VR060R3()

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

Local aOrd           := {}
Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir entradas"
Local cDesc2         := STR0002 //"de veiculos realizadas no periodo selecionado.   "
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "VEIVR060" // Coloque aqui o nome do arquivo usado para impressao em disco
Local cString        := "VVF"

Private titulo       := STR0003 //"Entradas de Veiculos no Periodo"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private cbtxt        := Space(10)
Private limite       := 220
Private tamanho      := "G"
Private Cabec1       := STR0004 //" [No.NF/Ser] [Situacao] [Dt Cpa] [Tipo Operacao------------]  [Fornecedor-----------------------------------] [Cidade------------------UF] [Comprador-------------------------------] [Tran.Ent]"
Private Cabec2       := STR0005 //" [C.In] [Marca------] [Fab/Mod] [Chassi do Veiculo------] [Codigo Modelo---------------] [Descricao Modelo------------] [Complemento Modelo] [Cor do Veiculo------------------------]"
Private nTipo        := 15
Private aReturn      := { STR0006, 1,STR0007 , 1, 2, 1, "", 1} //### //"Zebrado # Administracao"
Private nLastKey     := 0
Private cPerg        := "VEV060"
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01

dbSelectArea("VVF")
dbSetOrder(2)

//ValidPerg()
pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
  Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|lEnd| U_VEIVR60IMP(@lEnd,wnrel,cString)},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVEIVR60IMPบ Autor ณ Ricardo Farinelli  บ Data ณ  04/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio de entradas  บฑฑ
ฑฑบ          ณ no periodo informado.                                      บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function VEIVR60IMP(lEnd,wnrel,cString)

Local nwnk     := 1
Private nValTot  := 0 // Valor Total da Transacao (valida)
Private nValIpi  := 0 // Valor Total de Ipi (valida)
Private nValICM  := 0 // Valor Total de Icms (valida)

Private nValTotC := 0 // Valor Total da Transacao (cancelada)
Private nValICMC := 0 // Valor Total de Icms (cancelada)
Private nValIpiC := 0 // Valor Total de Ipi (cancelada)

Private cTipo  := ""

Private nNroVei := 0  // Nro Total de Veiculos

dbSelectArea(cString)
dbSetOrder(2)

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ SETREGUA -> Indica quantos registros serao processados para a regua ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SetRegua(RecCount())

// Imprime primeiro as vendas, depois as devolucoes caso o parametro esteja configurado para considerar devolucoes



/*BEGINDOC
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Data Inicial                                                                               ณ
//ณMV_PAR02 = Data Final                                                                                 ณ
//ณMV_PAR03 = Tipo Operacao = Normal, Ped.Fabrica,Remessa,Transferencia,Consignacao,Devolucao,Frete,Todasณ
//ณMV_PAR04 = Considera Situacao Nota Fiscal = Normal, Cancelada,Todas                                   ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
ENDDOC*/
Titulo += STR0008+Dtoc(MV_PAR01)+STR0009+Dtoc(MV_PAR02) //### //" de  #  a "
Titulo += STR0010+Iif(MV_PAR03=="0",STR0011,; //### //" Operacao:  # Normal"
                 IIf(MV_PAR03=="1",STR0012,; //"Ped.Fabrica"
                 IIf(MV_PAR03=="2",STR0013,; //"Remessa"
                 IIf(MV_PAR03=="3",STR0014,; //"Transferencia"
                 IIf(MV_PAR03=="4",STR0015,; //"Consignacao"
                 IIf(MV_PAR03=="5",STR0016,; //"Devolucao"
                 IIF(MV_PAR03=="6",STR0017,; //"Frete"
                 IIF(MV_PAR03=="*",STR0018,"")))))))) //"Todas"
                 
// Ou seleciona todas as opcoes ou imprime apenas a escolhida.

For nwnk := 1 to Iif(MV_PAR03=="*",7,1) 

  cTipo := Alltrim(Str(IIf(MV_PAR03=="*",nwnk-1,Val(MV_PAR03)),0))
  
  // Posiciona no primeiro registro conforme a data inicial informada
  VVF->(Dbseek(xFilial("VVF")+cTipo+Dtos(MV_PAR01),.T.))

  Do While !VVF->(Eof()) .and. xFilial("VVF") == VVF->VVF_FILIAL .and. VVF->VVF_OPEMOV == cTipo

    If lAbortPrint .or. lEnd
      @nLin,00 PSAY STR0019 //"*** CANCELADO PELO OPERADOR ***"
      Exit
    Endif

    If VVF->VVF_DATMOV > MV_PAR02
      Exit
    Endif

    If Empty(VVF->VVF_NUMNFI) // Se nao tiver numero de nota fiscal nao leva em consideracao
      VVF->(Dbskip())
      Loop
    Endif
    
    If MV_PAR04==1 .and. (VVF->VVF_SITNFI<>"1") // Se for apenas Normais
      VVF->(Dbskip())
      Loop 
    Endif  
    If MV_PAR04==2 .and. (VVF->VVF_SITNFI<>"0") // Se for apenas Cancelamentos
      VVF->(Dbskip())
      Loop 
    Endif  

    If nLin+3 > 58
      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
      nLin := 9
    Endif

    // Posiciona nos principais arquivos
    VEIVR60POS()
    if MV_PAR05 = 1 //NOVO

       if VVG->VVG_ESTVEI # "0"  //USADO
       VVF->(Dbskip())
         Loop 
       endif     

    elseif MV_PAR05 = 2 //USADO
    
       if VVG->VVG_ESTVEI # "1"  //NOVOO
       VVF->(Dbskip())
         Loop 
       endif     
    
    endif
    
    @ nLin,001 PSAY VVF->VVF_NUMNFI+"/"+ FGX_MILSNF("VVF", 2, "VVF_SERNFI") +" "
    @ nLin,017 PSAY Iif(VVF->VVF_SITNFI=="1",STR0020,Iif(VVF->VVF_SITNFI=="0",STR0021,"")) //### //"Valida # Cancelada"
    @ nLin,027 PSAY VVF->VVF_DATMOV
    @ nLin,037 PSAY IIf(cTipo=="0",STR0022,Iif(cTipo=="1",STR0023,Iif(cTipo=="1",STR0024,IIf(cTipo=="3",STR0025,Iif(cTipo=="4",STR0026,Iif(cTipo=="5",STR0027,STR0028)))))) //################## //"Entrada por Pedido Normal # Entrada por Pedido a Fabrica # Entrada por Simples Remessa # Entrada por Transferencia # Entrada por Consignacao # Entrada por Devolucao # Entrada por Frete"
    @ nLin,066 PSAY VVF->VVF_CODFOR+"/"+VVF->VVF_LOJA+"-"+Substr(SA2->A2_NOME,1,37)
    if  lA2_IBGE
      @ nLin,113 PSAY VAM->VAM_DESCID
      @ nLin,139 PSAY VAM->VAM_ESTADO
    else
      @ nLin,113 PSAY SA2->A2_MUN
      @ nLin,139 PSAY SA2->A2_EST    
    endif
    @ nLin,143 PSAY VVF->VVF_CODCOM+"-"+Substr(SY1->Y1_NOME,1,34)
    @ nLin,186 PSAY VVF->VVF_TRACPA

    do while !VV1->(EOF()) .and. VVG->VVG_CHAINT = VV1->VV1_CHAINT
      nLin++
        @ nLin,001 PSAY VV1->VV1_CHAINT
      @ nLin,009 PSAY VV1->VV1_CODMAR+"-"+Subs(VE1->VE1_DESMAR,1,10)
        @ nLin,023 PSAY Transform(VV1->VV1_FABMOD,"@R ####/####")
      @ nLin,033 PSAY VV1->VV1_CHASSI
        @ nLin,059 PSAY VV1->VV1_MODVEI
      @ nLin,090 PSAY VV2->VV2_DESMOD
        @ nLin,121 PSAY VV1->VV1_COMMOD
      @ nLin,142 PSAY VV1->VV1_CORVEI+"-"+VVC->VVC_DESCRI 
       nLin++
	    @ nLin,001 PSAY STR0056
        @ nLin,010 PSAY VV1->VV1_TIPMOT
       @ nLin,026 PSAY STR0057
        @ nLin,035 PSAY VV1->VV1_NUMMOT
       @ nLin,055 PSAY STR0058 
        @ nLin,065 PSAY VV1->VV1_POTMOT
       @ nLin,076 PSAY STR0059
        @ nLin,080 PSAY VV1->VV1_CAPTRA
       @ nLin,095 PSAY STR0060
        @ nLin,105 PSAY VV1->VV1_TANQUE
       @ nLin,160 PSAY STR0061 
        @ nLin,170 PSAY VV1->VV1_RELDIF
       @ nLin,176 PSAY STR0062
        @ nLin,185 PSAY VV1->VV1_TIPDIF
       nNroVei := nNroVei + 1
       VV1->(dbskip())
    enddo

    nLin++
    @ nLin,001 PSAY STR0029 //"Valor do Movimento:"
    @ nLin,021 PSAY Transform(VVF->VVF_VALMOV,TM(VVF->VVF_VALMOV,12))
    @ nLin,034 PSAY STR0030 //"Valor ICMS:"
    @ nLin,046 PSAY Transform(VVF->VVF_TOTICM,TM(VVF->VVF_TOTICM,12))
    @ nLin,059 PSAY STR0031 //"Aliquota:"
    @ nlin,070 PSAY Transform(VVF->VVF_ALIICM,TM(VVF->VVF_ALIICM,12))
    @ nLin,083 PSAY STR0032 //"Valor IPI:"
    @ nLin,095 PSAY Transform(VVF->VVF_VALIPI,TM(VVF->VVF_VALIPI,12))
    @ nLin,108 PSAY STR0033 //"Aliquota IPI:"
    @ nLin,122 PSAY Transform(VVF->VVF_ALIIPI,TM(VVF->VVF_ALIIPI,5))
    nLin++

    // Totaliza variaveis do relatorio
    VEI60TOT()

    If nLin > 58 
      Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
      nLin := 9
    Endif

    // Imprime Os Titulos Referentes a venda 
    If (!VVF->VVF_SITNFI$"023") // cancelamento ou devolucao ou devolucao parcial
      @ nLin,020 PSAY STR0034 //"Cond. Pagamento:"
      @ nLin,037 PSAY VVF->VVF_FORPAG+"-"+SE4->E4_DESCRI
      @ nLin,091 PSAY STR0035 //"Numero"
      @ nLin,103 PSAY STR0036 //"Parcela"
      @ nLin,111 PSAY STR0037 //"Vencimento"
      @ nLin,124 PSAY STR0038 //"Valor"
      nLin++

      If nLin > 58 
        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
        nLin := 9
      Endif

    DbSelectArea("SE2")
     DbSetOrder(6)
    DbSeek(xfilial("SE2")+ VVF->VVF_CODFOR + VVF->VVF_LOJA + VVF->VVF_SERNFI + VVF->VVF_NUMNFI)
      Do While !SE2->(Eof()) .and. SE2->E2_FILIAL==xFilial("SE2") .and. (SE2->E2_PREFIXO+SE2->E2_NUM+SE2->E2_FORNECE+SE2->E2_LOJA) == (VVF->VVF_SERNFI+VVF->VVF_NUMNFI+VVF->VVF_CODFOR+VVF->VVF_LOJA)
        @ nLin,091 PSAY SE2->E2_PREFIXO + "/" + SE2->E2_NUM
        @ nLin,107 PSAY SE2->E2_PARCELA
        @ nLin,111 PSAY SE2->E2_VENCTO
        @ nLin,121 PSAY Transform(SE2->E2_VALOR,TM(SE2->E2_VALOR,12))
        nLin++

        If nLin > 58
          Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
          nLin := 9
        Endif
      
        SE2->(Dbskip())
      Enddo
    
      If nLin > 58 
        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
        nLin := 9
      Endif
      @ nLin,001 PSAY Replicate("-",220)
      nLin++
      If nLin+3 > 58
        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
        nLin := 9
      Endif

    Else // outro tipo de transacao que nao seja a venda nao imprime os titulos
      @ nLin,001 PSAY Replicate("-",220)
      nLin++
      If nLin+3 > 58
        Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
        nLin := 9
      Endif
    Endif      
    IncRegua()
    VVF->(Dbskip())
    If VVF->VVF_DATMOV > MV_PAR02
      Exit
    Endif
  Enddo
Next

// Imprime Totais
If nLin+3 > 58
  Cabec(Titulo,"","",wnrel,Tamanho,nTipo)
  nLin := 9
  VEI60IMTOT()
Else
  If nLin > 9
    Cabec(Titulo,"","",wnrel,Tamanho,nTipo)
    nLin := 9
  Endif
  VEI60IMTOT()
Endif

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ Ricardo Farinelli  บ Data ณ  04/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)
aadd(aRegs,{cPerg,"01",STR0039,"","","mv_ch1","D", 8,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Inicial      ?"
aadd(aRegs,{cPerg,"02",STR0040,"","","mv_ch2","D", 8,0,0,"G","NaoVazio() .and. MV_par02>=Mv_PAR01","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Final        ?"
aadd(aRegs,{cPerg,"03",STR0041,"","","mv_ch3","C",1,0,0,"G","Pertence('0123456*')","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Tipo Operacao     ?"
aadd(aRegs,{cPerg,"04",STR0042,"","","mv_ch4","N",1,0,0,"C","NaoVazio()","STR(mv_par04,1)",STR0011,"","","","",STR0021,"","","","",STR0018,"","","","","","","","","","","","","","",""}) //"Cons.   Situacao  ? # Normal # Cancelada # Todas"
aadd(aRegs,{cPerg,"05",STR0049,"","","mv_ch5","N",1,0,0,"C","NaoVazio()","STR(mv_par05,1)",STR0050,"","","","",STR0051,"","","","",STR0052,"","","","","","","","","","","","","","",""}) //"Tipo de Veiculos # Novos # Usados # Todos"

For i:=1 to Len(aRegs)
    If !dbSeek(cPerg+aRegs[i,2])
        RecLock("SX1",.T.)
        For j:=1 to FCount()
            If j <= Len(aRegs[i])
                FieldPut(j,aRegs[i,j])
            Endif
        Next
        MsUnlock()
    Endif
Next

dbSelectArea(_sAlias)

Return
*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEIVR60POSบAutor  ณRicardo Farinelli   บ Data ณ  04/06/00   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPosiciona nos arquivos a serem utilizados pela rotina de    บฑฑ
ฑฑบ          ณimpressao                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Generico                                                   บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEIVR60POS()

  // Cadastro de Veiculos
  VVG->(DbsetOrder(1))
  VVG->(Dbseek(xFilial("VVG")+VVF->VVF_TRACPA))
  // Cadastro de Veiculos
  VV1->(DbsetOrder(1))
  VV1->(Dbseek(xFilial("VV1")+VVG->VVG_CHAINT))
  // Cadastro de Compradores
  SY1->(DbsetOrder(1))
  SY1->(Dbseek(xFilial("SY1")+VVF->VVF_CODCOM))
  // Titulos a Pagar 
  SF2->(DBSetOrder(1))
  SF2->(DBSeek(xFilial("SF2")+VVF->VVF_NUMNFI+VVF->VVF_SERNFI))
  SE2->(DbsetOrder(1))
  SE2->(Dbseek(xFilial("SE2")+SF2->F2_PREFIXO+VVF->VVF_NUMNFI))
  // Cadastro de Cores
  VVC->(DbsetOrder(1))
  VVC->(Dbseek(xFilial("VVC")+VV1->VV1_CODMAR+VV1->VV1_CORVEI))
  // Marca
  VE1->(DbsetOrder(1))
  VE1->(Dbseek(xFilial("VV1")+VV1->VV1_CODMAR))
  // Modelo
  VV2->(DbsetOrder(1))
  VV2->(Dbseek(xFilial("VV2")+VV1->VV1_CODMAR+VV1->VV1_MODVEI))
  // Condicao de Pagamento
  SE4->(DbsetOrder(1))
  SE4->(Dbseek(xFilial("SE4")+VVF->VVF_FORPAG))
  // Cadastro de Fornecedores
  SA2->(DbsetOrder(1))
  SA2->(Dbseek(xFilial("SA2")+VVF->VVF_CODFOR+VVF->VVF_LOJA))
  // Cadastro de Cidades
  if lA2_IBGE
    VAM->(DbsetOrder(1))
    VAM->(Dbseek(xFilial("VAM")+SA2->A2_IBGE))
  Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEI60TOT  บAutor  ณRicardo Farinelli   บ Data ณ  04/06/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณTotaliza as variaveis de rodape.                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEI60TOT()

  If VVF->VVF_SITNFI=="0" // Nf Cancelada
    nValTotC += VVF->VVF_VALMOV
    nValIpiC += VVF->VVF_VALIPI
    nValICMC += VVF->VVF_TOTICM
  Elseif VVF->VVF_SITNFI=="1" // Nf Valida
    nValTot  += VVF->VVF_VALMOV
    nValIpi  += VVF->VVF_VALIPI
    nValICM  += VVF->VVF_TOTICM
  Endif  
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVEI60IMTOTบAutor  ณRicardo Farinelli   บ Data ณ  05/30/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณImpressao da linha dos totais de entrada ou cancelamento    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VEI60IMTOT()
  @ nLin,001 PSAY Replicate("-",100)+STR0043+Replicate("-",100)  //"[-Resumo  Entradas-]"
  nLin++    
  @ nLin,017 PSAY STR0044 //"[-Total Entradas--]"
  @ nLin,047 PSAY STR0045 //"[---Total Icms----]"
  @ nLin,080 PSAY STR0046 //"[----Total Ipi----]"
  @ nLin,117 PSAY STR0049 //"[----Total Veiculos----]"  
  nLin++
  If MV_PAR04==1 .or. MV_PAR04==3
    @ nLin,001 PSAY STR0047 //"Normais........"
    @ nLin,017 PSAY Transform(nValTot,TM(nValTot,18))
    @ nLin,047 PSAY Transform(nValIcm,TM(nValIcm,18))
    @ nlin,080 PSAY Transform(nValIpi,TM(nValIpi,18))
    @ nlin,136 PSAY nNroVei
    nLin++ 
  Endif
  If MV_PAR04==2 .or. MV_PAR04==3  
    @ nLin,001 PSAY STR0048 //"Cancelamentos.."
    @ nLin,017 PSAY Transform(nValTotC,TM(nValTot,18))
    @ nLin,047 PSAY Transform(nValIcmC,TM(nValIcm,18))
    @ nlin,080 PSAY Transform(nValIpiC,TM(nValIpi,18))
    @ nlin,136 PSAY nNroVei    
    nLin++
  Endif  
  @ nLin,001 PSAY Replicate("-",220)
  nLin++    

Return  
