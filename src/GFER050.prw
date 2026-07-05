/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "GFER050.ch"

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} GFER050
Relatorio de Romaneio de Carga
Generico.

@sample
U_GFER050()

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
User Function GFER050()

Local oReport                   //objeto que contem o relatorio
Local aArea := GetArea()
Private cCDMTR, cNMMTR, cCDMTR2, cNMMTR2, cEMISDC, cNMEMIS, cCDREM, cNMREM, cCDDEST2, cNMREM2, cNRCDREM, cNMCDREM, cUFCDREM, cNRCDDES, cNMCDDES, cUFCDDES, cDESUNI,cDSTRP
Private nTotTrans := 0, nTotVol := 0, nTotPeso  := 0, nTotPesoC := 0
Private nGW1Trans := 0, nGW1Vol := 0, nGW1Peso  := 0, nGW1PesoC := 0
Private cGWNTab
Private cGWTTrp, cGWTTpVc, cGWTOpVp

If TRepInUse() // teste padrão
	//-- Interface de impressao
	oReport := ReportDef()
	oReport:PrintDialog()
EndIf

If Select(cGWNTab) > 0
	(cGWNTab)->(dbCloseArea())
EndIf

RestArea( aArea )

Return

/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportDef
Relatorio de Documentos de Carga
Generico.

@sample
ReportDef()

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportDef()
Local oReport, oSection1, oSection2, oSection3, oSection4, oSection5
Local aOrdem    := {}
Local aSituacao := RetSX3Box(Posicione('SX3',2,'GWN_SIT','X3CBox()'),,,1)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao do componente de impressao                                      ³
//³                                                                        ³
//³TReport():New                                                           ³
//³ExpC1 : Nome do relatorio                                               ³
//³ExpC2 : Titulo                                                          ³
//³ExpC3 : Pergunte                                                        ³
//³ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  ³
//³ExpC5 : Descricao                                                       ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:= TReport():New("GFER050","Listagem de Romaneios de Carga","GFER050", {|oReport| ReportPrint(oReport)},STR0002)  //"Romaneios de Carga"###"Emite a listagem dos Romaneios de Carga conforme os parâmetros informados."
oReport:SetLandscape()     // define se o relatorio saira deitado
oReport:HideParamPage()    // Desabilita a impressao da pagina de parametros.
oReport:SetTotalInLine(.F.)
Pergunte("GFER050",.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da secao utilizada pelo relatorio                               ³
//³                                                                        ³
//³TRSection():New                                                         ³
//³ExpO1 : Objeto TReport que a secao pertence                             ³
//³ExpC2 : Descricao da seçao                                              ³
//³ExpA3 : Array com as tabelas utilizadas pela secao. A primeira tabela   ³
//³        sera considerada como principal para a seção.                   ³
//³ExpA4 : Array com as Ordens do relatório                                ³
//³ExpL5 : Carrega campos do SX3 como celulas                              ³
//³        Default : False                                                 ³
//³ExpL6 : Carrega ordens do Sindex                                        ³
//³        Default : False                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Criacao da celulas da secao do relatorio                                ³
//³                                                                        ³
//³TRCell():New                                                            ³
//³ExpO1 : Objeto TSection que a secao pertence                            ³
//³ExpC2 : Nome da celula do relatório. O SX3 será consultado              ³
//³ExpC3 : Nome da tabela de referencia da celula                          ³
//³ExpC4 : Titulo da celula                                                ³
//³        Default : X3Titulo()                                            ³
//³ExpC5 : Picture                                                         ³
//³        Default : X3_PICTURE                                            ³
//³ExpC6 : Tamanho                                                         ³
//³        Default : X3_TAMANHO                                            ³
//³ExpL7 : Informe se o tamanho esta em pixel                              ³
//³        Default : False                                                 ³
//³ExpB8 : Bloco de código para impressao.                                 ³
//³        Default : ExpC2                                                 ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ


Aadd( aOrdem, STR0024 ) // "Sequência" //"Codigo"

oSection1 := TRSection():New(oReport,STR0001,{"(cGWNTab)","GU7","GUU"},aOrdem)  //"Romaneios de Carga"
oSection1:SetLineStyle() //Define a impressao da secao em linha
oSection1:SetTotalInLine(.F.)

TRCell():New(oSection1,"GWN_FILIAL","(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_FILIAL               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_NRROM" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_NRROM                }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_CDTRP" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_CDTRP                }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"cDSTRP"    ,""         ,STR0003   ,"@!"       ,50         ,/*lPixel*/, {||  cDSTRP                             }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_CDTPOP","(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_CDTPOP               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_PRIOR" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,5          ,/*lPixel*/, {|| (cGWNTab)->GWN_PRIOR                }/*{|| code-block de impressao }*/, "LEFT" )
TRCell():New(oSection1,"GWN_SIT"   ,"(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| aSituacao[Val((cGWNTab)->GWN_SIT),3]}/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_DTIMPL","(cGWNTab)",/*cTitle*/,/*Picture*/,13         ,/*lPixel*/, {|| StoD((cGWNTab)->GWN_DTIMPL)         }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_HRIMPL","(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_HRIMPL               }/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"GWN_DTSAI" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,13         ,/*lPixel*/, {|| StoD((cGWNTab)->GWN_DTSAI)          }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_HRSAI" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_HRSAI                }/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"cCDMTR"    ,""          ,STR0004  ,"@!"       ,10         ,/*lPixel*/, {||cCDMTR                               }/*{|| code-block de impressao }*/, "LEFT" ) //"Motorista."
TRCell():New(oSection1,"cNMMTR"    ,""          ,STR0005  ,"@!"       ,50         ,/*lPixel*/, {||cNMMTR                               }/*{|| code-block de impressao }*/, "LEFT" ) //"Nome Motorista"
TRCell():New(oSection1,"cCDMTR2"   ,""          ,STR0006  ,"@!"       ,10         ,/*lPixel*/, {||cCDMTR2                              }/*{|| code-block de impressao }*/, "LEFT" ) //"Motorista 02"
TRCell():New(oSection1,"cNMMTR2"   ,""          ,STR0007  ,"@!"       ,50         ,/*lPixel*/, {||cNMMTR2                              }/*{|| code-block de impressao }*/, "LEFT" ) //"Nome Motorista 02"

TRCell():New(oSection1,"GWN_PLACAD","(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_PLACAD               }/*{|| code-block de impressao }*/, "LEFT" )
TRCell():New(oSection1,"GWN_PLACAT","(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_PLACAT               }/*{|| code-block de impressao }*/, "LEFT" )
TRCell():New(oSection1,"GWN_PLACAM","(cGWNTab)",/*cTitle*/,/*Picture*/,10         ,/*lPixel*/, {|| (cGWNTab)->GWN_PLACAM               }/*{|| code-block de impressao }*/, "LEFT" )
TRCell():New(oSection1,"GWN_LACRE" ,"(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_LACRE                }/*{|| code-block de impressao }*/)

TRCell():New(oSection1,"GWN_CDTPVC","(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_CDTPVC               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_CDCLFR","(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_CDCLFR               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_DSCLFR","(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_DSCLFR               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GWN_NRCIDD","(cGWNTab)",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/, {|| (cGWNTab)->GWN_NRCIDD               }/*{|| code-block de impressao }*/)
TRCell():New(oSection1,"GU7_NMCID" ,"GU7"      ,/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/)
TRCell():New(oSection1,"GWN_CEPD " ,"(cGWNTab)",/*cTitle*/,/*Picture*/,13         ,/*lPixel*/, {|| (cGWNTab)->GWN_CEPD                 }/*{|| code-block de impressao }*/, "LEFT")
TRCell():New(oSection1,"GWN_DISTAN","(cGWNTab)",/*cTitle*/,/*Picture*/,15         ,/*lPixel*/, {|| (cGWNTab)->GWN_DISTAN               }/*{|| code-block de impressao }*/, "LEFT" )

TRCell():New(oSection1,"nTotTrans" ,""   ,STR0008 ,"@E 99,999,999.99" ,15         ,/*lPixel*/, {|| nTotTrans                           }/*{|| code-block de impressao }*/, "LEFT" ) //"Tot Valor"
TRCell():New(oSection1,"nTotVol"   ,""   ,STR0009 ,"@E 99,999.999.99" ,15         ,/*lPixel*/, {|| nTotVol                             }/*{|| code-block de impressao }*/, "LEFT" ) //"Vol Tot"
TRCell():New(oSection1,"nTotPeso"  ,""   ,STR0010 ,"@E 99,999.99999"  ,15         ,/*lPixel*/, {|| nTotPeso                            }/*{|| code-block de impressao }*/, "LEFT" ) //"Peso Tot"
TRCell():New(oSection1,"nTotPesoC" ,""   ,STR0011 ,"@E 9,999,999.9999",15         ,/*lPixel*/, {|| nTotPesoC                           }/*{|| code-block de impressao }*/, "LEFT" ) //"Peso Cub Tot"

TRPosition():New(oSection1,"GU7",1,{|| xFilial("GU7") + (cGWNTab)->GWN_NRCIDD})

/***************************************************************************/

oSection2 := TRSection():New(oSection1,STR0012,{"GW1"},aOrdem) //  //"Documentos de Carga"
oSection2:SetTotalInLine(.F.)
oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
//cEMISDC, cNMEMIS, cCDREM, cNMREM, cCDDEST2, cNMREM2

TRCell():New(oSection2,"GW1_SERDC" ,"GW1",/*cTitle*/  ,/*Picture*/         ,5 ,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"GW1_NRDC"  ,"GW1",/*cTitle*/  ,/*Picture*/         ,12,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection2,"cEMISDC"   ,""   ,STR0013     ,/*Picture*/         ,14,/*lPixel*/,  {|| cEMISDC                 }  ) //"Emissor"
TRCell():New(oSection2,"cNMEMIS"   ,""   ,STR0014     ,/*Picture*/         ,15,/*lPixel*/,  {|| cNMEMIS                 }  ) //"Nome "
TRCell():New(oSection2,"GW1_CDTPDC","GW1",STR0015     ,/*Picture*/         ,15,/*lPixel*/,/*{|| code-block de impressao }*/) //"Tp Docto"

TRCell():New(oSection2,"cCDREM"    ,""   ,STR0016     ,/*Picture*/         ,16,/*lPixel*/,  {|| cCDREM                  }  ) //"Remetente"
TRCell():New(oSection2,"cNMCDREM"  ,""   ,STR0017     ,/*Picture*/         ,15,/*lPixel*/,  {|| cNMCDREM                }  ) //"Cidade"
TRCell():New(oSection2,"cUFCDREM"  ,""   ,STR0019     ,/*Picture*/         ,2 ,/*lPixel*/,  {|| cUFCDREM                }  ) //UF

TRCell():New(oSection2,"cCDDEST2"  ,""   ,STR0018     ,/*Picture*/         ,16,/*lPixel*/,  {|| cCDDEST2                }  ) //"Destinatário"
TRCell():New(oSection2,"cNMCDDES"  ,""   ,STR0017     ,/*Picture*/         ,15,/*lPixel*/,  {|| cNMCDDES                }  ) //"Cidade"
TRCell():New(oSection2,"cUFCDDES"  ,""   ,STR0019     ,/*Picture*/         ,2 ,/*lPixel*/,  {|| cUFCDDES                }  ) //"UF"

TRCell():New(oSection2,"nGW1Trans" ,""   ,STR0008     ,"@E 99,999,999.99"  ,10,/*lPixel*/,  {|| nGW1Trans               }  ) //"Tot Valor"
TRCell():New(oSection2,"nGW1Vol"   ,""   ,STR0009     ,"@E 99,999.999.99"  ,10,/*lPixel*/,  {|| nGW1Vol                 }  ) //"Vol Tot"
TRCell():New(oSection2,"nGW1Peso"  ,""   ,STR0010     ,"@E 99,999.99"      ,10,/*lPixel*/,  {|| nGW1Peso                }  ) //"Peso Tot"
TRCell():New(oSection2,"nGW1PesoC" ,""   ,STR0011     ,"@E 9,999,999.99"   ,10,/*lPixel*/,  {|| nGW1PesoC               }  ) //"Peso Cub Tot"

//TRPosition():New(oSection2,"GU3",1,{|| xFilial("GU3") + GW1->GW1_EMISDC})
//TRPosition():New(oSection2,"GV5",1,{|| xFilial("GV5") + GW1->GW1_CDTPDC})

/*************************************************************************/

oSection3 := TRSection():New(oSection2,STR0020,{"GW8"},aOrdem) // //"Itens dos Documentos"
oSection3:SetTotalInLine(.F.)
oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção

TRCell():New(oSection3,"GW8_ITEM"   ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_DSITEM" ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_CDCLFR" ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_QTDE"   ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_VOLUME" ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_PESOR"  ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_PESOC"  ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection3,"GW8_VALOR"  ,"GW8",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


/**************************************************************************/


oSection4 := TRSection():New(oSection2,STR0021,{"GWB"},aOrdem) //  //"Unitizadores"
oSection4:SetTotalInLine(.F.)
oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção

TRCell():New(oSection4,"GWB_CDUNIT ","GWB",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection4,"cDESUNI"    ,""   ,STR0022  ,"@!",50,/*lPixel*/, {||cDESUNI} ) //"Descrição Unit."
TRCell():New(oSection4,"GWB_QTDE"   ,"GWB",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)


/*************************************************************************************************************************************/

oSection5 := TRSection():New(oSection2,STR0023,{"GWU","GU3","GU7"},aOrdem) //  //"Trechos do Itinerário"
oSection5:SetTotalInLine(.F.)
oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção

TRCell():New(oSection5,"GWU_SEQ"   ,"GWU",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GWU_CDTRP" ,"GWU",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GU3_NMEMIT","GU3",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection5,"GU7_NRCID" ,"GU7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GU7_NMCID" ,"GU7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GU7_CDUF"  ,"GU7",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRCell():New(oSection5,"GWU_DTPENT","GWU",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GWU_DTENT" ,"GWU",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection5,"GWU_PAGAR" ,"GWU",/*cTitle*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

TRPosition():New(oSection5,"GU3",1,{|| xFilial("GU3") + GWU->GWU_CDTRP})

/*************************************************************************************************************************************/

oSection6 := TRSection():New(oSection1,"Pedágio do Romaneio",{"GWT","GU3"},aOrdem) //  //"Adiantamento de Pedágio"
oSection6:SetTotalInLine(.F.)
oSection6:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção

TRCell():New(oSection6,"GWT_SEQ"   	,"GWT",/*cTitle*/,/*Picture*/,3  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_CDTRP"  ,"GWT",/*cTitle*/,/*Picture*/,5  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"cGWTTrp"  	,"", "Nome Transportador" /*cTitle*/,/*Picture*/,30 /*Tamanho*/,/*lPixel*/, {||cGWTTrp} /*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_TPTRP"  ,"GWT",/*cTitle*/,/*Picture*/,7  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_CDTPVC" ,"GWT",/*cTitle*/,/*Picture*/,5  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"cGWTTpVc" 	,"", "Descrição Tip. Veic." /*cTitle*/,/*Picture*/,30 /*Tamanho*/,/*lPixel*/, {||cGWTTpVc} /*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_ADTPDG" ,"GWT",/*cTitle*/,/*Picture*/,5  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_VPVAL"  ,"GWT",/*cTitle*/,/*Picture*/,10 /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_VPNUM"  ,"GWT",/*cTitle*/,/*Picture*/,5  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_VPCDOP" ,"GWT",/*cTitle*/,/*Picture*/,5  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oSection6,"cGWTOpVp" 	,"", "Nome Oper. Val. Ped." /*cTitle*/,/*Picture*/,30 /*Tamanho*/,/*lPixel*/, {||cGWTOpVp} /*{|| code-block de impressao }*/)
TRCell():New(oSection6,"GWT_VALEP"  ,"GWT",/*cTitle*/,/*Picture*/,10  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

Return(oReport)
/*************************************************************************************************************************************/


/*/--------------------------------------------------------------------------------------------------
{Protheus.doc} ReportPrint
Relatorio de Romaneio
Generico.

@sample
ReportPrint(oReport,cAliasQry)

@author Felipe M.
@since 14/10/09
@version 1.0
--------------------------------------------------------------------------------------------------/*/
Static Function ReportPrint(oReport)
Local oSection1 := oReport:Section(1)
Local oSection2 := oReport:Section(1):Section(1)
Local oSection3 := oReport:Section(1):Section(1):Section(1)
Local oSection4 := oReport:Section(1):Section(1):Section(2)
Local oSection5 := oReport:Section(1):Section(1):Section(3)
Local oSection6	:= oReport:Section(1):Section(2)
Local nRegs     := 0
Local cQuery
Local cTabSum
Local cAliasGW1 := Nil
Local cWhere    := Nil

CarregaDados()

(cGWNTab)->( dbGoTop() )

//Calcula a quantidade de registros para utilizar na regra de progressão
( cGWNTab )->( dbEval( { || nRegs ++ },,{ || ( cGWNTab )->( !Eof() ) } ) )

oReport:SetMeter( nRegs )

dbSelectArea(cGWNTab)
(cGWNTab)->( dbGoTop() )
While !oReport:Cancel() .And. !(cGWNTab)->( Eof() )
	oSection1:Init()

	oReport:IncMeter()

	dbSelectArea("GUU")
	GUU->(dbSetOrder(1))
	GUU->(dbSeek(xFilial("GUU") + (cGWNTab)->GWN_CDMTR))
	cCDMTR  := GUU->GUU_CDMTR
	cNMMTR  := GUU->GUU_NMMTR

	GUU->(dbSeek(xFilial("GUU") + (cGWNTab)->GWN_CDMTR2))
	cCDMTR2  := GUU->GUU_CDMTR
	cNMMTR2  := GUU->GUU_NMMTR

	nTotTrans := 0
	nTotVol   := 0
	nTotPeso  := 0
	nTotPesoC := 0

	cQuery := ""
	cQuery += " SELECT SUM(ISNULL(GW8.GW8_VALOR,0))  AS GW8_VALOR, "
	cQuery += "        SUM(ISNULL(GW8.GW8_VOLUME,0)) AS GW8_VOLUME,  "
	cQuery += "        SUM(ISNULL(GW8.GW8_PESOR,0))  AS GW8_PESOR, "
	cQuery += "        SUM(ISNULL(GW8.GW8_PESOC,0)) AS GW8_PESOC "
	cQuery += " FROM " + RetSQLName("GW1") + " GW1 "
	cQuery += " LEFT JOIN " + RetSQLName("GW8") + " GW8 ON (GW8.GW8_FILIAL = GW1.GW1_FILIAL AND "
	cQuery += "                          GW8.GW8_CDTPDC = GW1.GW1_CDTPDC AND "
	cQuery += "                          GW8.GW8_EMISDC = GW1.GW1_EMISDC AND "
	cQuery += "                          GW8.GW8_SERDC  = GW1.GW1_SERDC  AND "
	cQuery += "                          GW8.GW8_NRDC   = GW1.GW1_NRDC   AND "
	cQuery += "                          GW8.D_E_L_E_T_ = ' ') "
	If GFXCP1212210('GW1_FILROM')
		cQuery += " WHERE GW1.GW1_FILROM = '" + (cGWNTab)->GWN_FILIAL + "'"
	Else
		cQuery += " WHERE GW1.GW1_FILIAL = '" + (cGWNTab)->GWN_FILIAL + "'"
	EndIf
	cQuery += " AND   GW1.GW1_NRROM  = '" + (cGWNTab)->GWN_NRROM + "'"
	cQuery += " AND   GW1.D_E_L_E_T_ = ' ' "

	cTabSum := GetNextAlias()
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cTabSum, .F., .T.)
	dbSelectArea((cTabSum))
	
	nTotTrans := (cTabSum)->GW8_VALOR
	nTotVol   := (cTabSum)->GW8_VOLUME
	nTotPeso  := (cTabSum)->GW8_PESOR
	nTotPesoC := (cTabSum)->GW8_PESOC
	
	If Select(cTabSum) > 0
		(cTabSum)->(dbCloseArea())
	EndIf

	cDSTRP := (cGWNTab)->GU3_NMEMITTRP

	oSection1:PrintLine()

	//Secção 2
	If GFXCP1212210('GW1_FILROM')
		cWhere := "GW1.GW1_FILROM = '" + (cGWNTab)->GWN_FILIAL + "'"
	Else
		cWhere := "GW1.GW1_FILIAL = '" + (cGWNTab)->GWN_FILIAL + "'"
	EndIf
	cWhere := "%" + cWhere + "%"

	cAliasGW1 := GetNextAlias()
	BeginSql Alias cAliasGW1
		SELECT GW1.R_E_C_N_O_ AS GW1RECNO
		FROM %table:GW1% GW1
		WHERE %Exp:cWhere%
		AND GW1.GW1_NRROM = %Exp:(cGWNTab)->GWN_NRROM%
		AND GW1.%NotDel%
		ORDER BY GW1.GW1_FILIAL,GW1.GW1_NRDC
	EndSql
	While !(cAliasGW1)->(Eof())
		GW1->(dbGoTo( (cAliasGW1)->GW1RECNO ))

		oSection2:Init()

		dbSelectArea("GU3")
		GU3->(dbSetOrder(1))
		GU3->(dbSeek(xFilial("GU3") + GW1->GW1_EMISDC))
		cEMISDC := GW1->GW1_EMISDC
		cNMEMIS := GU3->GU3_NMEMIT

		GU3->(dbSeek(xFilial("GU3") + GW1->GW1_CDREM))

		GU7->(dbSetOrder(1))
		GU7->(dbSeek(xFilial("GU7") + GU3->GU3_NRCID))

		cCDREM   := GW1->GW1_CDREM
		cNMREM   := GU3->GU3_NMEMIT
		cNRCDREM := GU7->GU7_NRCID
		cNMCDREM := GU7->GU7_NMCID
		cUFCDREM := GU7->GU7_CDUF

		GU3->(dbSeek(xFilial("GU3") + GW1->GW1_CDDEST))
		GU7->(dbSeek(xFilial("GU7") + GU3->GU3_NRCID))

		cCDDEST2 := GW1->GW1_CDDEST
		cNMREM2  := GU3->GU3_NMEMIT
		cNRCDDES := GU7->GU7_NRCID
		cNMCDDES := GU7->GU7_NMCID
		cUFCDDES := GU7->GU7_CDUF

		dbSelectArea("GW8")
		GW8->(dbSetOrder(1))
		GW8->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC))

		nGW1Trans := 0
		nGW1Vol   := 0
		nGW1Peso  := 0
		nGW1PesoC := 0

		While !GW8->( Eof() ) .And. (GW8->GW8_FILIAL + GW8->GW8_CDTPDC + GW8->GW8_EMISDC + GW8->GW8_SERDC + GW8->GW8_NRDC ) == GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC

			nGW1Trans := nGW1Trans + GW8->GW8_VALOR
			nGW1Vol   := nGW1Vol   + GW8->GW8_VOLUME
			nGW1Peso  := nGW1Peso  + GW8->GW8_PESOR
			nGW1PesoC := nGW1PesoC + GW8->GW8_PESOC

			GW8->( dbSkip() )
		EndDo

		oSection2:PrintLine()

		 //Secção 3
		oSection3:Init()

		GW8->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC))

		While !GW8->(EOF()) .And. (GW8->GW8_FILIAL + GW8->GW8_CDTPDC + GW8->GW8_EMISDC + GW8->GW8_SERDC + GW8->GW8_NRDC ) == GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC
			oSection3:PrintLine()
			GW8->( dbSkip() )
		EndDo

		oSection3:Finish()

		//Secção 4
		oSection4:Init()

		dbSelectArea("GWB")
	 	GWB->(dbSetOrder(1))
		GWB->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_NRDC))
		While !GWB->( Eof() ) .And. (GWB->GWB_FILIAL + GWB->GWB_NRDC ) == (GW1->GW1_FILIAL + GW1->GW1_NRDC)

			cDESUNI := Posicione("GUG",1,XFILIAL("GUG")+GWB->GWB_CDUNIT,"GUG_DSUNIT")
			oSection4:PrintLine()
			GWB->( dbSkip() )
		EndDo

		oSection4:Finish()

		//Secção 5
		oSection5:Init()
		GWU->(dbSetOrder(1))
		GWU->(dbSeek(GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC))
		While !GWU->(EOF()) .And. (GWU->GWU_FILIAL + GWU->GWU_CDTPDC + GWU->GWU_EMISDC + GWU->GWU_SERDC + GWU->GWU_NRDC ) == (GW1->GW1_FILIAL + GW1->GW1_CDTPDC + GW1->GW1_EMISDC + GW1->GW1_SERDC + GW1->GW1_NRDC)

			GU3->(dbSeek(xFilial("GU3") + GWU->GWU_CDTRP))
			GU7->(dbSeek(xFilial("GU7") + GU3->GU3_NRCID))

			oSection5:PrintLine()

			GWU->( dbSkip() )
		EndDo

		oSection5:Finish()

		oSection2:Finish()

		(cAliasGW1)->(dbSkip())
	EndDo	
	(cAliasGW1)->(dbCloseArea())

	If GFXCP12117("GWT_NRROM")	
		// Secção 6
		oSection6:Init()
			
		GWT->(dbSetOrder(1))
		GWT->(dbSeek((cGWNTab)->GWN_FILIAL + (cGWNTab)->GWN_NRROM))
		While !GWT->( Eof() ) .And. (cGWNTab)->GWN_FILIAL + (cGWNTab)->GWN_NRROM = GWT->GWT_FILIAL + GWT->GWT_NRROM
			
			cGWTTrp  := AllTrim(Posicione("GU3",1,xFilial("GU3")+GWT->GWT_CDTRP,"GU3_NMEMIT"))
			cGWTTpVc := AllTrim(Posicione("GV3",1,xFilial("GV3")+GWT->GWT_CDTPVC,"GV3_DSTPVC"))
			cGWTOpVp := AllTrim(Posicione("GU3",1,xFilial("GU3")+GWT->GWT_VPCDOP,"GU3_NMEMIT"))
			
			oSection6:PrintLine()
		
			GWT->(dbSkip())
		EndDo
		
		oSection6:Finish()

	EndIf
	oSection1:Finish()

	 (cGWNTab)->( dbSkip() )
EndDo

Return

Static Function CarregaDados()
	Local cQuery := ""

	cQuery += " SELECT GWN_FILIAL, GWN.GWN_NRROM,  GWN.GWN_CDTPOP, GWN.GWN_CDCLFR, GWN.GWN_CDTRP,  GWN.GWN_CDMTR,  GWN.GWN_CDMTR2, "
	cQuery += "        GWN.GWN_CDTPVC, GWN.GWN_PLACAD, GWN.GWN_PLACAT, GWN.GWN_PLACAM, GWN.GWN_SIT,    GWN.GWN_DTIMPL, GWN.GWN_HRIMPL, "
	cQuery += "        GWN.GWN_CALC,   GWN.GWN_PRIOR,  GWN.GWN_DTSAI,  GWN.GWN_HRSAI,  GWN.GWN_DISTAN, GWN.GWN_NRCIDD, GWN.GWN_CEPD,   "
	cQuery += "        GU3TRP.GU3_NMEMIT GU3_NMEMITTRP, GUB.GUB_DSCLFR GWN_DSCLFR"
	cQuery += " , GWN.GWN_LACRE "	
	cQuery += " FROM " + RetSQLName("GWN") + " GWN "
	cQuery += " LEFT JOIN " + RetSQLName("GUB") + " GUB ON (GWN.GWN_CDCLFR = GUB.GUB_CDCLFR AND GUB.D_E_L_E_T_ = ' ') "
	cQuery += " LEFT JOIN " + RetSQLName("GU3") + " GU3TRP ON (GWN.GWN_CDTRP = GU3TRP.GU3_CDEMIT AND GU3TRP.D_E_L_E_T_ = ' ') "
	cQuery += " WHERE  GWN.D_E_L_E_T_ = ' '"

	cQuery += IIF(MV_PAR05==4," AND GWN.GWN_SIT  >= '0' " ," AND GWN.GWN_SIT  =  '" + cValToChar(MV_PAR05)+ "'")
	if MV_PAR06 != 3
		cQuery += IIF(MV_PAR06==1," AND  GWN.GWN_CALC  = '1' " ," AND  GWN.GWN_CALC <> '1' " )
	EndIf

	cQuery += IIF(!Empty(MV_PAR01)," AND  GWN.GWN_FILIAL >= '" + MV_PAR01 + "'","")
	cQuery += IIF(!Empty(MV_PAR02)," AND  GWN.GWN_FILIAL <= '" + MV_PAR02 + "'","")
	cQuery += IIF(!Empty(MV_PAR03)," AND  GWN.GWN_NRROM  >= '" + MV_PAR03 + "'","")
	cQuery += IIF(!Empty(MV_PAR04)," AND  GWN.GWN_NRROM  <= '" + MV_PAR04 + "'","")
	cQuery += IIF(!Empty(MV_PAR07)," AND  GWN.GWN_DTIMPL >= '" + DTOS(MV_PAR07) + "'","")
	cQuery += IIF(!Empty(MV_PAR08)," AND  GWN.GWN_DTIMPL <= '" + DTOS(MV_PAR08) + "'","")
	cQuery += IIF(!Empty(MV_PAR09)," AND  GWN.GWN_CDTRP  >= '" + MV_PAR09 + "'","")
	cQuery += IIF(!Empty(MV_PAR10)," AND  GWN.GWN_CDTRP  <= '" + MV_PAR10 + "'","")
	cQuery += IIF(!Empty(MV_PAR11)," AND  GWN.GWN_CDTPOP >= '" + MV_PAR11 + "'","")
	cQuery += IIF(!Empty(MV_PAR12)," AND  GWN.GWN_CDTPOP <= '" + MV_PAR12 + "'","")
	cQuery += IIF(!Empty(MV_PAR13)," AND  GWN.GWN_DTSAI  >= '" + DTOS(MV_PAR13) + "'","")
	cQuery += IIF(!Empty(MV_PAR14)," AND  GWN.GWN_DTSAI  <= '" + DTOS(MV_PAR14) + "'","")
	cQuery += IIF(!Empty(MV_PAR15)," AND  GWN.GWN_CDCLFR >= '" + MV_PAR15 + "'","")
	cQuery += IIF(!Empty(MV_PAR16)," AND  GWN.GWN_CDCLFR <= '" + MV_PAR16 + "'","")
	cQuery += IIF(!Empty(MV_PAR17)," AND  GWN.GWN_CDTPVC >= '" + MV_PAR17 + "'","")
	cQuery += IIF(!Empty(MV_PAR18)," AND  GWN.GWN_CDTPVC <= '" + MV_PAR18 + "'","")
	cQuery += " ORDER BY GWN_FILIAL, GWN_NRROM "

	cGWNTab := GetNextAlias()
	dbUseArea( .T., "TOPCONN", TCGENQRY(,,ChangeQuery(cQuery)),cGWNTab, .F., .T.)
	dbSelectArea((cGWNTab))
	(cGWNTab)->( dbGoTop() )
Return
