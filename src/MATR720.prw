/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR720.CH" 
#Include "PROTHEUS.Ch"

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ MATR720  ³ Autor ³ Marco Bianchi         ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Minuta de Despacho				                          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ SIGAFAT                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function MATR720()

Local oReport := Nil 

Pergunte("MTR720",.F.)

//-- Interface de impressao
oReport := ReportDef()  
oReport:PrintDialog() 

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³ Marco Bianchi         ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportDef()

Local oReport
Local lValadi	:= cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local cAliasQry	:= GetNextAlias()

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
oReport := TReport():New("MATR720",STR0024,"MTR720", {|oReport| ReportPrint(oReport,cAliasQry)},STR0022 + " " + STR0023)	// "RECIBO PARA DESPACHO"###"Este relatorio ira emitir a relacao de Recibos"###"de Despacho para as transportadoras."
oReport:SetPortrait()
oReport:SetTotalInLine(.F.)       

Pergunte(oReport:uParam,.F.)
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
oRecDesp := TRSection():New(oReport,STR0021,{"SF2"},/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)	// "RECIBO PARA DESPACHO"
oReport:Section(1):SetLineStyle()
oReport:Section(1):SetCols(1)

TRCell():New(oRecDesp,"F2_DOC","SF2",RetTitle("F2_DOC"),PesqPict("SF2","F2_DOC"),TamSx3("F2_DOC")[1],/*lPixel*/,{|| (cAliasQry)->F2_DOC  }	)
TRCell():New(oRecDesp,"F2_VALBRUT","SF2",RetTitle("F2_VALBRUT"),PesqPict("SF2","F2_VALBRUT"),TamSx3("F2_VALBRUT")[1],/*lPixel*/,{|| (cAliasQry)->F2_VALMERC+(cAliasQry)->F2_VALIPI+(cAliasQry)->F2_FRETE+(cAliasQry)->F2_SEGURO+(cAliasQry)->F2_ICMSRET  }	)
If lValadi
	TRCell():New(oRecDesp,"F2_VALADI","SF2",RetTitle("F2_VALADI"),PesqPict("SF2","F2_VALADI"),TamSx3("F2_VALADI")[1],/*lPixel*/,{|| (cAliasQry)->F2_VALADI  }	)
EndIf

TRCell():New(oRecDesp,"A1_NOME","SA1",RetTitle("A1_NOME"),PesqPict("SA1","A1_NOME"),TamSx3("A1_NOME")[1],/*lPixel*/,{|| SA1->A1_NOME  }	)
TRCell():New(oRecDesp,"A1_END","SA1",RetTitle("A1_END"),PesqPict("SA1","A1_END"),TamSx3("A1_END")[1],/*lPixel*/,{|| SA1->A1_END  }	)
TRCell():New(oRecDesp,"A1_ENDENT","SA1",RetTitle("A1_ENDENT"),PesqPict("SA1","A1_ENDENT"),TamSx3("A1_ENDENT")[1],/*lPixel*/,{|| SA1->A1_ENDENT  }	)
TRCell():New(oRecDesp,"A1_BAIRRO","SA1",RetTitle("A1_BAIRRO"),PesqPict("SA1","A1_BAIRRO"),TamSx3("A1_BAIRRO")[1],/*lPixel*/,{|| SA1->A1_BAIRRO  }	)
TRCell():New(oRecDesp,"A1_MUN","SA1",RetTitle("A1_MUN"),PesqPict("SA1","A1_MUN"),TamSx3("A1_MUN")[1],/*lPixel*/,{|| SA1->A1_MUN  }	)
TRCell():New(oRecDesp,"A1_EST","SA1",RetTitle("A1_EST"),PesqPict("SA1","A1_EST"),TamSx3("A1_EST")[1],/*lPixel*/,{|| SA1->A1_EST  }	)

TRCell():New(oRecDesp,"A2_NOME","SA2",RetTitle("A2_NOME"),PesqPict("SA2","A2_NOME"),TamSx3("A2_NOME")[1],/*lPixel*/,{|| SA2->A2_NOME  }	)
TRCell():New(oRecDesp,"A2_END","SA2",RetTitle("A2_END"),PesqPict("SA2","A2_END"),TamSx3("A2_END")[1],/*lPixel*/,{|| SA2->A2_END  }	)
TRCell():New(oRecDesp,"A2_BAIRRO","SA2",RetTitle("A2_BAIRRO"),PesqPict("SA2","A2_BAIRRO"),TamSx3("A2_BAIRRO")[1],/*lPixel*/,{|| SA2->A2_BAIRRO  }	)
TRCell():New(oRecDesp,"A2_MUN","SA2",RetTitle("A2_MUN"),PesqPict("SA2","A2_MUN"),TamSx3("A2_MUN")[1],/*lPixel*/,{|| SA2->A2_MUN  }	)
TRCell():New(oRecDesp,"A2_EST","SA2",RetTitle("A2_EST"),PesqPict("SA2","A2_EST"),TamSx3("A2_EST")[1],/*lPixel*/,{|| SA2->A2_EST  }	)

TRCell():New(oRecDesp,"A4_NOME","SA4",RetTitle("A4_NOME"),PesqPict("SA4","A4_NOME"),TamSx3("A4_NOME")[1],/*lPixel*/,{|| SA4->A4_NOME  }	)
TRCell():New(oRecDesp,"A4_END","SA4",RetTitle("A4_END"),PesqPict("SA4","A4_END"),TamSx3("A4_END")[1],/*lPixel*/,{|| SA4->A4_END  }	)
TRCell():New(oRecDesp,"F2_PBRUTO","SF2",RetTitle("F2_PBRUTO"),PesqPict("SF2","F2_PBRUTO"),TamSx3("F2_PBRUTO")[1],/*lPixel*/,{|| (cAliasQry)->F2_PBRUTO  }	)
TRCell():New(oRecDesp,"F2_PLIQUI","SF2",RetTitle("F2_PLIQUI"),PesqPict("SF2","F2_PLIQUI"),TamSx3("F2_PLIQUI")[1],/*lPixel*/,{|| (cAliasQry)->F2_PLIQUI  }	)
TRCell():New(oRecDesp,"F2_ESPECI1","SF2",RetTitle("F2_ESPECI1"),PesqPict("SF2","F2_ESPECI1"),TamSx3("F2_ESPECI1")[1],/*lPixel*/,{|| (cAliasQry)->F2_ESPECI1  }	)
TRCell():New(oRecDesp,"F2_VOLUME1","SF2",RetTitle("F2_VOLUME1"),PesqPict("SF2","F2_VOLUME1"),TamSx3("F2_VOLUME1")[1],/*lPixel*/,{|| (cAliasQry)->F2_VOLUME1  }	)
TRCell():New(oRecDesp,"F2_ESPECI2","SF2",RetTitle("F2_ESPECI2"),PesqPict("SF2","F2_ESPECI2"),TamSx3("F2_ESPECI2")[1],/*lPixel*/,{|| (cAliasQry)->F2_ESPECI2  }	)
TRCell():New(oRecDesp,"F2_VOLUME2","SF2",RetTitle("F2_VOLUME2"),PesqPict("SF2","F2_VOLUME2"),TamSx3("F2_VOLUME2")[1],/*lPixel*/,{|| (cAliasQry)->F2_VOLUME2  }	)
TRCell():New(oRecDesp,"F2_ESPECI3","SF2",RetTitle("F2_ESPECI3"),PesqPict("SF2","F2_ESPECI3"),TamSx3("F2_ESPECI3")[1],/*lPixel*/,{|| (cAliasQry)->F2_ESPECI3  }	)
TRCell():New(oRecDesp,"F2_VOLUME3","SF2",RetTitle("F2_VOLUME3"),PesqPict("SF2","F2_VOLUME3"),TamSx3("F2_VOLUME3")[1],/*lPixel*/,{|| (cAliasQry)->F2_VOLUME3  }	)
TRCell():New(oRecDesp,"F2_ESPECI4","SF2",RetTitle("F2_ESPECI4"),PesqPict("SF2","F2_ESPECI4"),TamSx3("F2_ESPECI4")[1],/*lPixel*/,{|| (cAliasQry)->F2_ESPECI4  }	)
TRCell():New(oRecDesp,"F2_VOLUME4","SF2",RetTitle("F2_VOLUME4"),PesqPict("SF2","F2_VOLUME4"),TamSx3("F2_VOLUME4")[1],/*lPixel*/,{|| (cAliasQry)->F2_VOLUME4  }	)

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrin³ Autor ³ Marco Bianchi         ³ Data ³ 12/07/06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ExpO1: Objeto Report do Relatório                           ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport,cAliasQry)

Local nI 		:= 0
Local cEspecie:= ""
Local cVolume := ""
Local lValadi := cPaisLoc == "MEX" .AND. SD2->(FieldPos("D2_VALADI")) > 0 //  Adiantamentos Mexico
Local cExpAdi	:= Iif(lValadi,"% ,F2_VALADI %","%%")
Local cidWhere:="%"+SerieNfId("SF2",3,"F2_SERIE")+"='"+ mv_par01+"'%"	

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea("SF2")		// Cabecalho da Nota Fiscal de Saida
dbSetOrder(1)			// Doc,Serie,Cliente,Loja

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
lQuery := .T.
oReport:Section(1):BeginQuery()	
BeginSql Alias cAliasQry
SELECT F2_FILIAL,F2_DOC,F2_CLIENTE,F2_LOJA,F2_VALBRUT,F2_PBRUTO,F2_PLIQUI,F2_VALMERC,F2_VALIPI,F2_FRETE,;
	F2_SEGURO,F2_ICMSRET,F2_ESPECI1,F2_ESPECI2,F2_ESPECI3,F2_ESPECI4,F2_VOLUME1,F2_VOLUME2,F2_VOLUME3,F2_VOLUME4,;
	F2_TIPO,F2_TRANSP,F2_SERIE %Exp:cExpAdi%
FROM %Table:SF2% SF2
WHERE F2_FILIAL = %xFilial:SF2% AND 
	%Exp:cidWhere%	AND
	F2_DOC >= %Exp:mv_par02% AND F2_DOC <= %Exp:mv_par03% AND
	SF2.%NotDel%
ORDER BY F2_DOC,F2_SERIE,F2_CLIENTE,F2_LOJA
EndSql 
oReport:Section(1):EndQuery(/*Array com os parametros do tipo Range*/)
	


//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo TrPosition()                                                     ³
//³                                                                        ³
//³Posiciona em um registro de uma outra tabela. O posicionamento será     ³
//³realizado antes da impressao de cada linha do relatório.                ³
//³                                                                        ³
//³                                                                        ³
//³ExpO1 : Objeto Report da Secao                                          ³
//³ExpC2 : Alias da Tabela                                                 ³
//³ExpX3 : Ordem ou NickName de pesquisa                                   ³
//³ExpX4 : String ou Bloco de código para pesquisa. A string será macroexe-³
//³        cutada.                                                         ³
//³                                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oReport:Section(1),"SA1",1,{|| xFilial("SA1")+(cAliasQry)->F2_CLIENTE+(cAliasQry)->F2_LOJA})
TRPosition():New(oReport:Section(1),"SA2",1,{|| xFilial("SA2")+(cAliasQry)->F2_CLIENTE+(cAliasQry)->F2_LOJA})
TRPosition():New(oReport:Section(1),"SA4",1,{|| xFilial("SA4")+(cAliasQry)->F2_TRANSP})

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Impressao do Relatório                               				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
dbSelectArea(cAliasQry)
dbGoTop()
oReport:SetMeter((cAliasQry)->(LastRec()))
oReport:Section(1):Init()	
Do While !oReport:Cancel() .And. !Eof() .and. F2_FILIAL == xFilial("SF2")

	If !((cAliasQry)->F2_TIPO $ "DB")
		oReport:Section(1):Cell("A1_NOME"):Enable()
		oReport:Section(1):Cell("A1_END"):Enable()
		oReport:Section(1):Cell("A1_ENDENT"):Enable()
		oReport:Section(1):Cell("A1_BAIRRO"):Enable()
		oReport:Section(1):Cell("A1_MUN"):Enable()
		oReport:Section(1):Cell("A1_EST"):Enable()
		oReport:Section(1):Cell("A2_NOME"):Disable()
		oReport:Section(1):Cell("A2_END"):Disable()
		oReport:Section(1):Cell("A2_BAIRRO"):Disable()
		oReport:Section(1):Cell("A2_MUN"):Disable()
		oReport:Section(1):Cell("A2_EST"):Disable()
	Else
		oReport:Section(1):Cell("A1_NOME"):Disable()
		oReport:Section(1):Cell("A1_END"):Disable()
		oReport:Section(1):Cell("A1_ENDENT"):Disable()
		oReport:Section(1):Cell("A1_BAIRRO"):Disable()
		oReport:Section(1):Cell("A1_MUN"):Disable()
		oReport:Section(1):Cell("A1_EST"):Disable()
		oReport:Section(1):Cell("A2_NOME"):Enable()
		oReport:Section(1):Cell("A2_END"):Enable()
		oReport:Section(1):Cell("A2_BAIRRO"):Enable()
		oReport:Section(1):Cell("A2_MUN"):Enable()
		oReport:Section(1):Cell("A2_EST"):Enable()
	EndIf

	For nI := 1 to 4
		cEspecie := "F2_ESPECI" + AllTrim(Str(nI))
		cVolume  := "F2_VOLUME" + AllTrim(Str(nI))
		If !Empty(&cEspecie)
			oReport:Section(1):Cell(cEspecie):Enable()	
			oReport:Section(1):Cell(cVolume):Enable()	
		Else	
			oReport:Section(1):Cell(cEspecie):Disable()	
			oReport:Section(1):Cell(cVolume):Disable()	
		EndIf
	Next

	oReport:Section(1):PrintLine()

	oReport:PrintText(STR0036,2500,500)		   												// "Data: ___/___/___"
	oReport:Line(2500,1800,2500,2300)  														// Linha para Assinatura
	oReport:PrintText(STR0037,2530,1900)													// "CARIMBO E ASSINATURA"
	oReport:EndPage()
	
	dbSelectArea(cAliasQry)
	dbSKip()
	oReport:IncMeter()
EndDo
oReport:Section(1):Finish()


Return