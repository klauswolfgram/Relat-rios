/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Matr970.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³Matr970   ³ Autor ³ Andressa Fagundes     ³ Data ³02/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao Trimestral das Operacoes Interestaduais            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function Matr970()

Local oReport    
Local lVerpesssen := Iif(FindFunction("Verpesssen"),Verpesssen(),.T.)    
Local cRelease as character

Local cEndWeb		:= "https://tdn.totvs.com/display/PROT/Tabela+SFT+-+Livro+Fiscal+por+Item+de+NF"

cRelease 	:=  GetRPORelease()     

If !IsBlind() 
	If FindFunction("DlgRelVer")
		DlgRelVer("MATR970","Relatorio Lancamentos fiscais",cEndWeb )
	EndIf
EndIf
       

Private cPerg := 'MTR970'
If lVerpesssen
	If TRepInUse()
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Interface de impressao                                                  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oReport	:= ReportDef()
		oReport:PrintDialog()
	Else
		U_Matr970R3()
	EndIf     
EndIf

Return    

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Andressa Fagundes      ³ Data ³02/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportDef devera ser criada para todos os ³±±
±±³          ³relatorios que poderao ser agendados pelo usuario.          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³ExpO1: Objeto do relatório                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
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
Local oNfSaid
 
cPerg := 'MTR970' 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Componente de impressao³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport := TReport():New("MATR970",STR0003,"MTR970", {|oReport| ReportPrint(oReport)},STR0001+" "+STR0002)
oReport:SetTotalInLine(.F.)
oReport:SetLandscape() 
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // da Data                              ³
//³ mv_par02             // ate a Data                           ³
//³ mv_par03             // Numero Pagina inicial                ³
//³ mv_par04             // Qtd Paginas/Feixe                    ³
//³ mv_par05             // Seleciona Filial?                    ³
//³ mv_par06             // Aglutina por CNPJ+IE?                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F., NIL , NIL, NIL, NIL, NIL, NIL, NIL, .F. )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Secao 1 - Movimentos de Saida 	                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oNfSaid:= TRSection():New(oReport,STR0029,{"SF2","SA1"},{"UF e emissão"},/*Campos do SX3*/,/*Campos do SIX*/) //"Documentos de Saída"
oNfSaid:SetTotalInLine(.F.)
TRCell():New(oNfSaid,"F2_FILIAL"	,"SF2"	,STR0026,/*Picture*/,0,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_EST"	    ,"SF2"	,STR0011,/*Picture*/,0,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_DOC"		,"SF2"	,STR0013,/*Picture*/,TamSX3("F2_DOC")[1],/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,SerieNfId("SF2",3,"F2_SERIE"),"SF2",STR0014,/*Picture*/,SerieNfId("SF2",6,"F2_SERIE"),/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_EMISSAO"	,"SF2"	,STR0015,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_CLIENTE"	,"SF2"	,STR0016,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_END"		,"SA1"	,STR0017,/*Picture*/,20,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_CEP"		,"SA1"	,STR0018,"@R 99999-999",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_INSCR"		,"SA1"	,STR0019,"@!",15,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"A1_CGC"		,"SA1"	,STR0020,"@R! NN.NNN.NNN/NNNN-99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_VALMERC"	,"SF2"	,STR0021,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_VALIPI"	,"SF2"	,STR0022,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"F2_VALICM"	,"SF2"	,STR0023,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oNfSaid,"VL_TOTAL"		,"SF2"	,STR0024,"@E 999,999,999.99",/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

oNfSaid:Cell("F2_FILIAL"):Disable()
oNfSaid:Cell("F2_EST"):Disable()

Return(oReport)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportPrint³ Autor ³Andressa Fagundes     ³ Data ³02/06/2006³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³A funcao estatica ReportPrint devera ser criada para todos  ³±±
±±³          ³os relatorios que poderao ser agendados pelo usuario.       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function ReportPrint(oReport)

Local oNfSaid := oReport:Section(1)
Local oBreakEs
Local oBreakFil

Local cCliFor   :=	""
Local cEndereco	:=	""
Local cCEP		:=	""
Local cInscEst	:=	""
Local cCGC		:=	""
Local cUF		:=	""
Local cAliasSF2	:= "SF2" 

// Variaveis utilizadas no processamento por Filiais
Local nForFilial := 0
Local lProc	     := .T.
Local aFilsCalc  := {} 
Local lFiliais   := Iif( MV_PAR05==1 , .T. , .F. ) 
Local lFilAgl    := Iif( MV_PAR06==1 , .T. , .F. )
Local cSelect    := ""

#IFNDEF TOP
	Local cCondicao :=	""
#ENDIF

//Totalizadores
oBreakEs := TRBreak():New(oNfSaid,oNfSaid:Cell("F2_EST"),STR0025,.F.) // "Total do Estado "
TRFunction():New(oNfSaid:Cell("F2_VALMERC"),Nil,"SUM",oBreakEs,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("F2_VALIPI"),Nil,"SUM",oBreakEs,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("F2_VALICM"),Nil,"SUM",oBreakEs,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("VL_TOTAL"),Nil,"SUM",oBreakEs,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)

oBreakFil := TRBreak():New(oNfSaid,oNfSaid:Cell("F2_FILIAL"),STR0030,.F.) // "Total da Filial"
TRFunction():New(oNfSaid:Cell("F2_VALMERC"),Nil,"SUM",oBreakFil,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("F2_VALIPI"),Nil,"SUM",oBreakFil,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("F2_VALICM"),Nil,"SUM",oBreakFil,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)
TRFunction():New(oNfSaid:Cell("VL_TOTAL"),Nil,"SUM",oBreakFil,"","@E 999,999,999.99",/*uFormula*/,.F.,.F.,.F.)

If lFiliais 
	If MV_PAR05==2               
		aFilsCalc  := MatFilCalc(lFiliais)
	else
		lFilAgl:=(lFiliais .and. mv_par05 == 1) 
		aFilsCalc := MatFilCalc(lFiliais,,,lFilAgl,,Iif(MV_PAR06 == 1,2,0)) //Parametro Exp6 Valida apenas CNPJ+IE iguais
	Endif
EndIf

			
If !Empty(aFilsCalc)

	For nForFilial := 1 To Len(aFilsCalc)
	
		If aFilsCalc[ nForFilial, 1 ]

			oReport:EndPage() //Reinicia Paginas
			
			cFilAnt := aFilsCalc[nForFilial][2]  
			SM0->( DbSeek( cEmpAnt + CFILANT ) )

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Inicio filtro do relatorio                 ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
			#IFDEF TOP
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Transforma parametros Range em expressao SQL   ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				MakeSqlExpr(oReport:uParam)
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Query do relatório da secao 1                 ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oNfSaid:BeginQuery()	        
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Somente cria o alias da query na primeira filial.³
				//³As demais utilizarao o mesmo alias.              ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If lProc
					cAliasSF2 := GetNextAlias()
					lProc := .F.
				Endif
				
				cSelect:= "%"
				cSelect+= "F2_FILIAL,F2_EST,F2_EMISSAO,F2_DOC,F2_SERIE,"
				cSelect+= Iif(SerieNfId("SF2",3,"F2_SERIE")<>"F2_SERIE","F2_SDOC,","") + "F2_CLIENTE, F2_LOJA," 
				cSelect+= "F2_TIPO, F2_VALMERC, F2_VALIPI, F2_VALICM, F2_FRETE, F2_SEGURO, A1_COD, A1_LOJA"
				cSelect+= "%"
							
				BeginSql Alias cAliasSF2
				
				SELECT DISTINCT %Exp:cSelect%
				
				FROM %table:SF2% SF2, %table:SD2% SD2, %table:SA1% SA1
				
				WHERE F2_FILIAL = %xFilial:SF2%
			  	AND F2_EMISSAO >= %Exp:Dtos(mv_par01)%
			  	AND F2_EMISSAO <= %Exp:Dtos(mv_par02)%
			  	AND F2_EST <> %Exp:GetMv("MV_ESTADO")%
			  	AND F2_FILIAL = D2_FILIAL
			  	AND F2_DOC = D2_DOC
			  	AND F2_SERIE = D2_SERIE
		      	AND F2_CLIENTE = D2_CLIENTE
		      	AND F2_CLIENTE = A1_COD
			  	AND F2_LOJA = D2_LOJA
 		      	AND F2_LOJA = A1_LOJA
			  	AND NOT(D2_CF LIKE '7%')
			  	AND SF2.%NotDel%
			  	AND SD2.%NotDel%
				  
				ORDER BY F2_FILIAL, F2_EST , F2_EMISSAO, F2_DOC, F2_SERIE
				  
				EndSql 
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³Metodo EndQuery ( Classe TRSection )                                    ³
				//³                                                                        ³
				//³Prepara o relatório para executar o Embedded SQL.                       ³
				//³                                                                        ³
				//³ExpA1 : Array com os parametros do tipo Range                           ³
				//³                                                                        ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				oNfSaid:EndQuery(/*Array com os parametros do tipo Range*/)
				oNfSaid:SetParentQuery()
				oNfSaid:SetParentFilter( { || (cAliasSF2)->F2_EST},{ || (cAliasSF2)->F2_EST })
				
			#ELSE
				MakeAdvplExpr(oReport:uParam)
		
				cChave	  := "F2_FILIAL+F2_EST+DTOS(F2_EMISSAO)+F2_DOC+F2_SERIE"
				cCondicao := "F2_FILIAL == '"+xFilial("SF2")+"' .AND. "
				cCondicao += "Dtos(F2_EMISSAO)>= '"+Dtos(mv_par01)+"' .And. Dtos(F2_EMISSAO)<= '"+DTos(mv_par02)+"' .And. "
				cCondicao += "F2_EST !='"+GetMV("MV_ESTADO")+ "'"
		
				oNfSaid:SetFilter(cCondicao,cChave)
				oNfSaid:SetRelation({|| (cAliasSF2)->F2_EST })
				oNfSaid:SetParentFilter({|| (cAliasSF2)->F2_EST })
		
			#ENDIF
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Secao 1 - Movimentos de Saida 	                            ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			oNfSaid:Cell("F2_CLIENTE"):SetBlock({|| cCliFor})
			oNfSaid:Cell("A1_END"):SetBlock({||cEndereco})
			oNfSaid:Cell("A1_CEP"):SetBlock({||cCep})
			oNfSaid:Cell("A1_INSCR"):SetBlock({||cInscEst})
			oNfSaid:Cell("A1_CGC"):SetBlock({||	cCGC})
			oNfSaid:Cell("VL_TOTAL"):SetBlock({||(cAliasSF2)->F2_VALMERC+(cAliasSF2)->F2_FRETE+(cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_VALIPI})
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Inicio da impressao do fluxo do relatório                               ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		  
			(cAliasSF2)->(dbGoTop())
			dbSelectArea(cAliasSF2)
			oReport:SetMeter((cAliasSF2)->(LastRec()))
		
			While !oReport:Cancel() .And. !(cAliasSF2)->(Eof())
				
				cUF := (cAliasSF2)->F2_EST
				
				If oReport:Cancel()
					Exit
				EndIf
			
				#IFNDEF TOP
					If R970ImpExp((cAliasSF2)->F2_DOC,(cAliasSF2)->F2_SERIE,(cAliasSF2)->F2_CLIENTE,(cAliasSF2)->F2_LOJA)
						(cAliasSD2)->(dbSkip())
						Loop
					EndIf
				#ENDIF 
		                            
				oNfSaid:Init()
		    
		    	While !oReport:Cancel() .And. !(cAliasSF2)->(Eof()) .And. (cAliasSF2)->F2_EST == cUF
			
					If (cAliasSF2)->F2_TIPO$'DB'
		  				dbSelectArea("SA2")
						SA2->(dbSetOrder(1))
						SA2->(dbSeek(xFilial("SA2")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))
						cCliFor	:=Substr(SA2->A2_NOME,1,30)
						cEndereco	:=SA2->A2_END
						cCEP		:=SA2->A2_CEP
						cInscEst	:=SA2->A2_INSCR
						cCGC		:=SA2->A2_CGC
					Else
						dbSelectArea("SA1")
						SA1->(dbSetOrder(1))
						SA1->(dbSeek(xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))
						cCliFor	:=Substr(SA1->A1_NOME,1,30)
						cEndereco	:=SA1->A1_END
						cCEP		:=SA1->A1_CEP
						cInscEst	:=SA1->A1_INSCR
						cCGC		:=SA1->A1_CGC
					Endif
		
					oNfSaid:PrintLine()
					
					dbSelectArea("SX5")
					cChave:=xFilial()+"12"+cUF
					dbSeek(cChave)
					
					oBreakEs:SetTotalText(STR0025 + (cAliasSF2)->F2_EST + " - " + X5Descri())
					
					oReport:IncMeter()
					(cAliasSF2)->(DbSkip())
				Enddo                                         
				oReport:IncMeter()
			Enddo

			oNfSaid:Finish()
		                      
		Endif
	Next nForFilial
	(cAliasSF2)->(DbCloseArea())

Else // Processamento apenas da filial corrente
	
	oReport:EndPage() //Reinicia Paginas
		
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicio filtro do relatorio                 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				
	#IFDEF TOP
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Transforma parametros Range em expressao SQL   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		MakeSqlExpr(oReport:uParam)
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Query do relatório da secao 1                 ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oNfSaid:BeginQuery()	        
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Somente cria o alias da query na primeira filial.³
		//³As demais utilizarao o mesmo alias.              ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If lProc
			cAliasSF2 := GetNextAlias()
			lProc := .F.
		Endif
		
		cSelect:= "%"
		cSelect+= "F2_FILIAL,F2_EST,F2_EMISSAO,F2_DOC,F2_SERIE,"
		cSelect+= Iif(SerieNfId("SF2",3,"F2_SERIE")<>"F2_SERIE","F2_SDOC,","") + "F2_CLIENTE, F2_LOJA," 
		cSelect+= "F2_TIPO, F2_VALMERC, F2_VALIPI, F2_VALICM, F2_FRETE, F2_SEGURO, A1_COD, A1_LOJA"
		cSelect+= "%"		
		
		BeginSql Alias cAliasSF2
				
		SELECT DISTINCT %Exp:cSelect%
		
		FROM %table:SF2% SF2, %table:SD2% SD2, %table:SA1% SA1
		
		WHERE F2_FILIAL = %xFilial:SF2%
		AND F2_EMISSAO >= %Exp:Dtos(mv_par01)%
	  	AND F2_EMISSAO <= %Exp:Dtos(mv_par02)%
	  	AND F2_EST <> %Exp:GetMv("MV_ESTADO")%
	  	AND F2_FILIAL = D2_FILIAL
	  	AND F2_DOC = D2_DOC
	  	AND F2_SERIE = D2_SERIE
	   	AND F2_CLIENTE = D2_CLIENTE
	   	AND F2_CLIENTE = A1_COD
	  	AND F2_LOJA = D2_LOJA
	 	AND F2_LOJA = A1_LOJA
	  	AND NOT(D2_CF LIKE '7%')
	  	AND SF2.%NotDel%
	  	AND SD2.%NotDel%
		  
		ORDER BY F2_FILIAL, F2_EST , F2_EMISSAO, F2_DOC, F2_SERIE
		  
		EndSql 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Metodo EndQuery ( Classe TRSection )                                    ³
		//³                                                                        ³
		//³Prepara o relatório para executar o Embedded SQL.                       ³
		//³                                                                        ³
		//³ExpA1 : Array com os parametros do tipo Range                           ³
		//³                                                                        ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oNfSaid:EndQuery(/*Array com os parametros do tipo Range*/)
		oNfSaid:SetParentQuery()
		oNfSaid:SetParentFilter( { || (cAliasSF2)->F2_EST},{ || (cAliasSF2)->F2_EST })
				
	#ELSE
		MakeAdvplExpr(oReport:uParam)

		cChave	  := "F2_FILIAL+F2_EST+DTOS(F2_EMISSAO)+F2_DOC+F2_SERIE"
		cCondicao := "F2_FILIAL == '"+xFilial("SF2")+"' .AND. "
		cCondicao += "Dtos(F2_EMISSAO)>= '"+Dtos(mv_par01)+"' .And. Dtos(F2_EMISSAO)<= '"+DTos(mv_par02)+"' .And. "
		cCondicao += "F2_EST !='"+GetMV("MV_ESTADO")+ "'"

		oNfSaid:SetFilter(cCondicao,cChave)
		oNfSaid:SetRelation({|| (cAliasSF2)->F2_EST })
		oNfSaid:SetParentFilter({|| (cAliasSF2)->F2_EST })

	#ENDIF
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Secao 1 - Movimentos de Saida 	                            ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		oNfSaid:Cell("F2_CLIENTE"):SetBlock({|| cCliFor})
		oNfSaid:Cell("A1_END"):SetBlock({||cEndereco})
		oNfSaid:Cell("A1_CEP"):SetBlock({||cCep})
		oNfSaid:Cell("A1_INSCR"):SetBlock({||cInscEst})
		oNfSaid:Cell("A1_CGC"):SetBlock({||	cCGC})
		oNfSaid:Cell("VL_TOTAL"):SetBlock({||(cAliasSF2)->F2_VALMERC+(cAliasSF2)->F2_FRETE+(cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_VALIPI})
		
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³Inicio da impressao do fluxo do relatório                               ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	  
		(cAliasSF2)->(dbGoTop())
		dbSelectArea(cAliasSF2)
		oReport:SetMeter((cAliasSF2)->(LastRec()))
	
		While !oReport:Cancel() .And. !(cAliasSF2)->(Eof())
			
			cUF := (cAliasSF2)->F2_EST
			
			If oReport:Cancel()
				Exit
			EndIf
		
			#IFNDEF TOP
				If R970ImpExp((cAliasSF2)->F2_DOC,(cAliasSF2)->F2_SERIE,(cAliasSF2)->F2_CLIENTE,(cAliasSF2)->F2_LOJA)
					(cAliasSD2)->(dbSkip())
					Loop
				EndIf
			#ENDIF 
	                            
			oNfSaid:Init()
	    
	    	While !oReport:Cancel() .And. !(cAliasSF2)->(Eof()) .And. (cAliasSF2)->F2_EST == cUF
		
				If (cAliasSF2)->F2_TIPO$'DB'
	  				dbSelectArea("SA2")
					SA2->(dbSetOrder(1))
					SA2->(dbSeek(xFilial("SA2")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))
					cCliFor		:=Substr(SA2->A2_NOME,1,30)
					cEndereco	:=SA2->A2_END
					cCEP		:=SA2->A2_CEP
					cInscEst	:=SA2->A2_INSCR
					cCGC		:=SA2->A2_CGC
				Else
					dbSelectArea("SA1")
					SA1->(dbSetOrder(1))
					SA1->(dbSeek(xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA))
					cCliFor		:=Substr(SA1->A1_NOME,1,30)
					cEndereco	:=SA1->A1_END
					cCEP		:=SA1->A1_CEP
					cInscEst	:=SA1->A1_INSCR
					cCGC		:=SA1->A1_CGC
				Endif
	
			    oNfSaid:PrintLine()
				
				dbSelectArea("SX5")
				cChave:=xFilial()+"12"+cUF
				dbSeek(cChave)
				
				oBreakEs:SetTotalText(STR0025 + (cAliasSF2)->F2_EST + " - " + X5Descri())
				
				oReport:IncMeter()
				(cAliasSF2)->(DbSkip())
			Enddo                                         
			oReport:IncMeter()
		Enddo
		oNfSaid:Finish()
	    (cAliasSF2)->(DbCloseArea())
EndIf

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³MATR970R3 ³ Autor ³ Gilson do Nascimento  ³ Data ³ 27.02.93 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao Trimestral das Operacoes Interestaduais             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_MATR970R3(void)                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Marcos Simidu³06/11/98³XXXXXX³ Ano 2000.                              ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function MatR970R3
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
  
LOCAL wnrel		
LOCAL tamanho:="G"
LOCAL cDesc1:=STR0001 //"Emiss„o da rela‡„o trimestral das vendas interestaduais"
LOCAL cDesc2:=STR0002 //"totalizada por estado."
LOCAL cDesc3:=""
LOCAL lEnd:=.F.

PRIVATE Titulo:=OemToAnsi(STR0003) //"Rel.Trimestral das Operacoes Interestaduais"
PRIVATE aReturn:={ STR0004, 1,STR0005, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
PRIVATE nomeprog:="MATR970",nLastKey:=0
PRIVATE cString:="SF2"
cPerg := 'MTR970'
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Envia controle para a funcao SETPRINT                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte(cPerg,.F.)
wnrel:="MATR970"   // nome default do relatorio em disco
wnrel:=SetPrint(cString,wnrel,cPerg,Titulo,cDesc1,cDesc2,cDesc3,.F.,"",,Tamanho)
If nLastKey==27
	Return
Endif

SetDefault(aReturn,cString)
If nLastKey==27
	Return
Endif 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Executa relatorio                                            ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

RptStatus({|lEnd| R970Imp(@lEnd,wnRel,cString,Tamanho)},titulo) 

If aReturn[5]==1
	Set Printer To
	OurSpool(wnrel)
Endif 

MS_FLUSH()

Return
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ R970Imp  ³ Autor ³ Juan Jose Pereira     ³ Data ³ 18.12.96 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Imprime Relatorio                                          ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
STATIC FUNCTION R970Imp(lEnd,wnRel,cString,Tamanho)         
Local cUF         := ""
Local cCliFor     := ""
Local cEndereco   := ""
Local cCEP        := ""
Local cInscEst    := ""
Local cCGC        := ""
LOCAL CbCont      := 0
Local cBTxt       := Space(10)
Local cabec1      := ""
Local cabec2      := ""
Local cAliasSF2   := "SF2" 
Local cFilterUser :=aReturn[7]
Local nLin        := 80
Local lQuery      := .F. 
Local lImprimiu	  := .T.

#IFDEF TOP
	Local aStruSF2	:=	{}
	Local cQuery	:=	""
	Local nX		:=	0
//	Local nTot_reg	:=	0
#ELSE
	Local cNomeArq	:=	""
	Local cCondSF2	:=	""
	Local cKey_SF2	:=	""
#ENDIF

// Variaveis utilizadas no processamento por Filiais
Local aFilsCalc  := {}
Local cFilBack   := cFilAnt
Local nForFilial := 0
Local lFiliais   := Iif( MV_PAR05==1 , .T. , .F. ) 
Local lFilAgl    := Iif( MV_PAR06==1 , .T. , .F. )
Local nGer1      := 0
Local nGer2      := 0
Local nGer3      := 0
Local nGer4      := 0

PRIVATE aLinha:={}
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica as perguntas selecionadas                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas para parametros                         ³
//³ mv_par01             // da Data                              ³
//³ mv_par02             // ate a Data                           ³
//³ mv_par03             // Numero Pagina inicial                ³
//³ mv_par04             // Qtd Paginas/Feixe                    ³
//³ mv_par05             // Seleciona Filial?                    ³
//³ mv_par06             // Aglutina por CNPJ+IE?                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
PRIVATE m_pag:=IIf(mv_par03<=0,1,mv_par03)
PRIVATE nQtFeixe:=IIF(mv_par04<=0,500,mv_par04) 
If lFiliais 
	If MV_PAR05==2 
		aFilsCalc  := MatFilCalc(lFiliais)
	else
		lFilAgl:=(lFiliais .and. mv_par05 == 1) 
		aFilsCalc := MatFilCalc(lFiliais,,,lFilAgl,,2) //Parametro Exp6 Valida apenas CNPJ+IE iguais
	Endif
EndIf
	//aFilsCalc  := MatFilCalc(mv_par05 == 1)

if Empty(aFilsCalc)
	aadd(aFilsCalc,{.T.,cFilAnt,""})
Endif

For nForFilial := 1 to Len(aFilsCalc)

	If aFilsCalc[nForFilial][1]

		cFilAnt := aFilsCalc[nForFilial][2]  
		nLin := 80 // Faz a Quebra de Pagina por Filial
        DBSELECTAREA("SM0")
		DBSETORDER(1)
		DBSEEK(cEmpAnt + CFILANT)	            
  
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Formato de impressao                         ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		Cabec1:=STR0006 //"NOTA   SR.  EMISSAO    DESTINATARIO                                                                                                                              VALOR            VALOR              VALOR             TOTAL"
		Cabec2:=STR0007 //"FISCAL                 RAZAO SOCIAL                           ENDERECO                                 CEP    INSCR. ESTADUAL        C.N.P.J.               MERCADORIA              IPI                ICM"
		//       999999 999  DD/MM/AAAA xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx 99999-999 XXX.XXX.XXX.XXX NN.NNN.NNN/NNNN-99 999,999,999,999.99 9,999,999,999,99 999,999,999,999,99 999,999,999,999,99
		//	               1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
		// 	     01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Gera arquivo Index de Trabalho para o  SF2   ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cAliasSF2	:=	"SF2" 
		dbSelectArea(cAliasSF2)
		
		#IFDEF TOP
		    If TcSrvType()<>"AS/400"
				lQuery 		:= .T.
				cAliasSF2	:= "SF2_MTR970"
				aStruSF2	:=	SF2->(dbStruct())
				cQuery	:=	"SELECT DISTINCT SF2.F2_FILIAL, SF2.F2_EMISSAO, SF2.F2_EST, SF2.F2_DOC, SF2.F2_SERIE,"
				cQuery	+=  Iif(SerieNfId("SF2",3,"F2_SERIE")<>"F2_SERIE","SF2.F2_SDOC,","") + "SF2.F2_CLIENTE, "
				cQuery	+=	"SF2.F2_LOJA, SF2.F2_TIPO, SF2.F2_VALMERC, SF2.F2_VALIPI, SF2.F2_VALICM, SF2.F2_FRETE, SF2.F2_SEGURO "
				cQuery	+=	"FROM " + RetSqlName("SF2") + " SF2, " + RetSqlName("SD2") + " SD2 "
				cQuery	+=	"WHERE SF2.F2_FILIAL = '" + xFilial("SF2") + "' AND "
				cQuery	+=	"SF2.F2_EMISSAO >= '" + Dtos(mv_par01) + "' AND "
				cQuery	+=	"SF2.F2_EMISSAO <= '" + Dtos(mv_par02) + "' AND "
				cQuery	+=	"SF2.F2_EST <> '" + GetMV("mv_estado")	+"' AND " 
				cQuery	+=	"SF2.F2_FILIAL = SD2.D2_FILIAL AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE AND "
				cQuery	+=  "SF2.F2_CLIENTE = SD2.D2_CLIENTE AND SF2.F2_LOJA = SD2.D2_LOJA AND NOT(SD2.D2_CF LIKE '7%') AND "
				cQuery	+=	"SF2.D_E_L_E_T_ = ' ' "
				cQuery	+=	"ORDER BY F2_FILIAL, F2_EST, F2_EMISSAO, F2_DOC, F2_SERIE" 
				cQuery	:=	ChangeQuery(cQuery)                       
				
				dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasSF2)
				For nX := 1 To len(aStruSF2)
					If aStruSF2[nX][2] <> "C" .And. FieldPos(aStruSF2[nX][1])<>0
						TcSetField(cAliasSF2,aStruSF2[nX][1],aStruSF2[nX][2],aStruSF2[nX][3],aStruSF2[nX][4])
					EndIf
				Next nX
				
				dbSelectArea(cAliasSF2)	
				//SetRegua(nTot_reg)
			Else  
		#ENDIF
				cNomeArq	:=	CriaTrab(NIL,.F.)
				cCondSF2	:=	"F2_FILIAL=='" + xFilial() + "' .And. "
				cCondSF2	+=	"dTos(F2_EMISSAO) >= '" + dTos(mv_par01) + "' .And. dTos(F2_EMISSAO) <= '" + dTos(mv_par02) + "' .And. "
				cCondSF2	+=	"F2_EST !='" + GetMV("mv_estado")	+ "'"	
				cKey_SF2	:=	"F2_FILIAL+F2_EST+DTOS(F2_EMISSAO)+F2_DOC+F2_SERIE"
				IndRegua(cAliasSF2,cNomeArq,cKey_SF2,,cCondSF2,STR0008) //"Selecionando Registros..."
				dbSelectArea(cAliasSF2)
				SetRegua(RecCount())
				dbGoTop()      
		#IFDEF TOP
			Endif    
		#ENDIF
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Faz o processamento antes da impressao do Relatorio ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		nTAC1:=0
		nTAC2:=0
		nTAC3:=0
		nTAC4:=0
		
		While !eof()
		  //IncRegua()
			If Interrupcao(@lEnd)
				Exit
			Endif
		#IFNDEF TOP
			If /*(cAliasSF2)->F2_EST == GetMV("mv_estado") .OR. */;
				R970ImpExp((cAliasSF2)->F2_DOC,(cAliasSF2)->F2_SERIE,(cAliasSF2)->F2_CLIENTE,(cAliasSF2)->F2_LOJA)
				dbSkip()
				Loop
			EndIf
		#ENDIF 
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³                 Faz a impressao do Relatorio                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			nAC1 := 0
			nAC2 := 0
			nAC3 := 0
			nAC4 := 0
			lImprimiu	:=	.F.
			
			cUF := (cAliasSF2)->F2_EST
		dbSelectArea(cAliasSF2)			
		While !(cAliasSF2)->(eof()) .And. cUF == (cAliasSF2)->F2_EST
				
				//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
				//³ Considera filtro do usuario                     ³
				//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If !Empty(cFilterUser) .And. !((cAliasSF2)->&(cFilterUser))
					dbSkip()
					Loop
				EndIf
				lImprimiu	:=	.T.

				If Interrupcao(@lEnd)
					Exit
				Endif
		
		#IFNDEF TOP		
				If /*(cAliasSF2)->F2_EST == GetMV("mv_estado") .OR.*/;
					R970ImpExp((cAliasSF2)->F2_DOC,(cAliasSF2)->F2_SERIE,(cAliasSF2)->F2_CLIENTE,(cAliasSF2)->F2_LOJA)
					dbSkip()
					Loop
				EndIf
		#ENDIF		
				IF nLin > 60
					cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
					If m_pag%(nQtFeixe+1)==0
						m_pag:=1
					Endif
					nLin:=Prow()
				EndIF
				
				If (cAliasSF2)->F2_TIPO$'DB'
					dbSelectArea("SA2")
					dbSetOrder(1)
					dbSeek(xFilial("SA2")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA)
					cCliFor:=Substr(A2_NOME,1,30)
					cEndereco:=A2_END
					cCEP:=A2_CEP
					cInscEst:=A2_INSCR
					cCGC:=A2_CGC
				Else
					dbSelectArea("SA1")
					dbSetOrder(1)
					dbSeek(xFilial("SA1")+(cAliasSF2)->F2_CLIENTE+(cAliasSF2)->F2_LOJA)
					cCliFor:=Substr(A1_NOME,1,30)
					cEndereco:=A1_END
					cCEP:=A1_CEP
					cInscEst:=A1_INSCR
					cCGC:=A1_CGC
				Endif
				
				dbSelectArea(cAliasSF2)
				
				nLin++
				@ nLin,000	PSAY (cAliasSF2)->F2_DOC
				@ nLin,010	PSAY (cAliasSF2)->&(SerieNfId("SF2",3,"F2_SERIE"))
				@ nLin,015	PSAY (cAliasSF2)->F2_EMISSAO
				@ nLin,026	PSAY cCliFor
				@ nLin,059	PSAY Substr(cEndereco ,1,36)
				@ nLin,095	PSAY cCEP 	PICTURE "@R 99999-999"
				@ nLin,105	PSAY Alltrim(cInscEst) PICTURE "@!"
				@ nLin,124	PSAY cCGC 	PICTURE "@R! NN.NNN.NNN/NNNN-99"
				@ nLin,143	PSAY (cAliasSF2)->F2_VALMERC 	PICTURE "@E 999,999,999,999.99"
				@ nLin,163	PSAY (cAliasSF2)->F2_VALIPI	PICTURE "@E 9,999,999,999.99"
				@ nLin,181	PSAY (cAliasSF2)->F2_VALICM	PICTURE "@E 999,999,999,999.99"
				@ nLin,200	PSAY ((cAliasSF2)->F2_VALMERC+(cAliasSF2)->F2_FRETE+(cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_VALIPI) PICTURE "@E 999,999,999,999.99"
				
				nAC1+=(cAliasSF2)->F2_VALMERC
				nAC2+=(cAliasSF2)->F2_VALIPI
				nAC3+=(cAliasSF2)->F2_VALICM
				nAC4+=((cAliasSF2)->F2_VALMERC+(cAliasSF2)->F2_FRETE+(cAliasSF2)->F2_SEGURO+(cAliasSF2)->F2_VALIPI)
				(cAliasSF2)->(dbSkip())
			
			EndDo
			
			If lEnd
				Loop
			EndIf
			
			If lImprimiu
				nLin++
				@ nLin,000 PSAY Repli("-",220)
				dbSelectArea("SX5")
				cChave:=xFilial()+"12"+cUF
				dbSeek(cChave)
				
				nLin++
				@ nLin,000 PSAY STR0010+cUF+' - '+X5Descri() //'TOTAL Estado -> '
				dbSelectArea(cAliasSF2)
				@ nLin,143 PSAY nAC1 PICTURE "@E 999,999,999,999.99"
				@ nLin,163 PSAY nAC2 PICTURE "@E 9,999,999,999.99"
				@ nLin,181 PSAY nAC3 PICTURE "@E 999,999,999,999.99"
				@ nLin,200 PSAY nAC4 PICTURE "@E 999,999,999,999.99"
				nTAC1 += nAC1
				nTAC2 += nAC2
				nTAC3 += nAC3
				nTAC4 += nAC4
				
				nLin +=2
			EndIf
		EndDo
		
		If (nTAC1+nTAC2+nTAC3+nTAC4)>0.and.!lEnd 
			IF nLin > 63
				cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
				If m_pag%(nQtFeixe+1)==0
					m_pag:=1
				Endif
				nLin:=Prow()
			EndIF
			nLin++
			@ nLin,000 PSAY repl("=",220)
			nLin++
			@ nLin,001 PSAY STR0009 + STR0026 + SM0->M0_FILIAL //"TOTAL GERAL ---> "+"FILIAL "
			@ nLin,143 PSAY nTAC1 PICTURE "@E 999,999,999,999.99"
			@ nLin,163 PSAY nTAC2 PICTURE "@E 9,999,999,999.99"
			@ nLin,181 PSAY nTAC3 PICTURE "@E 999,999,999,999.99"
			@ nLin,200 PSAY nTAC4 PICTURE "@E 999,999,999,999.99"
			nGer1 += nTac1
			nGer2 += nTac2
			nGer3 += nTac3
			nGer4 += nTac4
			
			nLin++
			@ nLin,000 PSAY repl("=",220)
			If nLin < 60
				roda(cbcont,cbtxt,tamanho)
			Endif
		Endif 
		
		If lQuery
			dbSelectArea(cAliasSF2)
			dbCloseArea()
		Else
			dbSelectArea(cAliasSF2)
			RetIndex(cAliasSF2)
			dbClearFilter()
			Ferase(cNomeArq+OrdBagExt())
			dbSetOrder(1)
		Endif

	Endif

Next nForFilial

			nLin++
			@ nLin,000 PSAY repl("=",220)
			If nLin > 60
				nlin := cabec(titulo,cabec1,cabec2,nomeprog,tamanho,15)
			Endif
			nLin++
			@ nLin,000 PSAY repl("=",220)
			nLin++
			@ nLin,001 PSAY "TOTAL GERAL"
			@ nLin,143 PSAY nGer1 PICTURE "@E 999,999,999,999.99"
			@ nLin,163 PSAY nGer2 PICTURE "@E 9,999,999,999.99"
			@ nLin,181 PSAY nGer3 PICTURE "@E 999,999,999,999.99"
			@ nLin,200 PSAY nGer4 PICTURE "@E 999,999,999,999.99"
			nLin++
			@ nLin,000 PSAY repl("=",220)

cFilAnt:=cFilBack
DBSELECTAREA("SM0")
DBSETORDER(1)
DBSEEK(cEmpAnt + CFILANT)	            

Return
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³ Fun‡…o   ³ R970ImpExp() ³ Autor ³ Juan Jose Pereira ³ Data ³ 16.11.95 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Descri‡…o³ Filtra Notas Fiscais de Exportacao (cfo=7XX)               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Sintaxe  ³ R970ImpExp(cNf,cSerie,cCliFor,cLoja)                       ³±±
±±³          ³ Onde: cNf = Numero da Nota                                 ³±±
±±³          ³       cSerie = Serie                                       ³±±
±±³          ³       cCliFor = Codigo do Cliente/Fornecedor               ³±±
±±³          ³       cLoja = Loja                                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ MATR970                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
#IFNDEF TOP
Static Function R970ImpExp(cNf,cSerie,cCliFor,cLoja)

Local lPulaNota:=.f. , cSeek:=""

cSeek:=xFilial()+cNf+cSerie+cCliFor+cLoja
dbSelectArea("SD2")
dbSetOrder(3)
dbSeek(cSeek,.t.)
If cSeek==D2_FILIAL+D2_DOC+D2_SERIE+D2_CLIENTE+D2_LOJA .and.;
	Substr(SD2->D2_CF,1,1)=="7" // Exportacao
	lPulaNota:=.t.
Endif

Return (lPulaNota)
#ENDIF
