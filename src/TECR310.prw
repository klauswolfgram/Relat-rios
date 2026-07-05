/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TECR310.CH"
#INCLUDE "REPORT.CH"

#IFNDEF WINDOWS
	#DEFINE PSAY SAY
#ENDIF
#DEFINE CHRCOMP If(aReturn[4]==1,15,18)
Static cAutoPerg := "ATR310"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR310   ³ Autor ³ Cleber Martinez       ³ Data ³ 13.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Chamados Tecnicos.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
User Function TECR310()
Local oReport				//Objeto do relatorio personalizavel
Local aArea := GetArea()	//Guarda a area atual

If !TRepInUse()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Executa versao anterior do fonte³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	U_TECR310R3()
Else
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³                       PARAMETROS                                       ³
	//³                                                                        ³
	//³ MV_PAR01 : Nr.Chamado de  ?                                            ³
	//³ MV_PAR02 : Nr.Chamado ate ?                                            ³
	//³ MV_PAR03 : Emissao de     ?                                            ³
	//³ MV_PAR04 : Emissao ate    ?                                            ³
	//³ MV_PAR05 : Cliente de     ?                                            ³
	//³ MV_PAR06 : Cliente ate    ?                                            ³
	//³ MV_PAR07 : Produto de     ?                                            ³
	//³ MV_PAR08 : Produto ate    ?                                            ³
	//³ MV_PAR09 : Lista Quais    ? Aberto / Orcamento / OS / Todos / Outros   ³
	//³ MV_PAR10 : Classificacao de ?                                          ³
	//³ MV_PAR11 : Classificacao ate?                                          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Pergunte("ATR310",.F.)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport := Tcr310RptDef()
	oReport:PrintDialog()
	
EndIf

RestArea( aArea )
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr310RptDef ºAutor  ³Cleber Martinez     º Data ³  13/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para informar as celulas que serao utilizadas no rela-  º±±
±±º          ³latorio                                                        º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR310 R4                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr310RptDef()
Local oReport			// Objeto do relatorio
Local oSection1			// Objeto da secao 1
Local oSection2			// Objeto da secao 2
Local nMinutos:= 0		// Variav. da celula Minutos
Local aOrdem  := {STR0005,STR0006,STR0007} 	//"Chamado"###"Cliente"###"Emissao"
Local cAlias1		:= GetNextAlias()
Local cAlias2		:= GetNextAlias()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a criacao do objeto oReport  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//"Relacao de Chamados Tecnicos"  
//"   Este programa ira imprimir a relacao de chamados tecnicos conforme"
//"os parametros solicitados."
DEFINE REPORT oReport NAME "TECR310" TITLE STR0001 PARAMETER "ATR310" ACTION {|oReport| Tcr310PrtRpt(oReport,aOrdem,cAlias1,cAlias2)} DESCRIPTION STR0002 + STR0003 + STR0004
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Define a secao1 do relatorio  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	DEFINE SECTION oSection1 OF oReport TITLE STR0027 TABLES "AB1","SA1" ORDERS aOrdem	//"Cliente"
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define as celulas que irao aparecer na secao1  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ	
		DEFINE CELL NAME "AB1_CODCLI" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "AB1_LOJA" 	OF oSection1 ALIAS "AB1"
		DEFINE CELL NAME "A1_NOME" 		OF oSection1 ALIAS "SA1"
						
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ Define a secao2 do relatorio  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ		
		DEFINE SECTION oSection2 OF oSection1 TITLE STR0028 TABLE "AB2","AB1","AAG"	//"Chamados"
			oSection2:SetLineBreak()
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Define as celulas que irao aparecer na secao2  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ    
			DEFINE CELL NAME "AB2_NRCHAM" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AB2_ITEM" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AB1_EMISSA" 	OF oSection2 ALIAS "AB1" BLOCK {|| (cAlias1)->AB1_EMISSA }
			DEFINE CELL NAME "AB2_TIPO" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AB2_CLASSI" 	OF oSection2 ALIAS "AB2" 
			DEFINE CELL NAME "AB1_CODCLI" 	OF oSection2 ALIAS "AB1" BLOCK {|| (cAlias1)->AB1_CODCLI }
			DEFINE CELL NAME "AB1_LOJA" 	OF oSection2 ALIAS "AB1" BLOCK {|| (cAlias1)->AB1_LOJA	 }
			DEFINE CELL NAME "AB1_CONTAT" 	OF oSection2 ALIAS "AB1" BLOCK {|| (cAlias1)->AB1_CONTAT }
			DEFINE CELL NAME "nMinutos"		OF oSection2 ALIAS "AB2" TITLE STR0025 PICTURE TM(nMinutos,5,0) //"Tempo(Min)"
			DEFINE CELL NAME "AB2_CODPRO" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AB2_NUMSER" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AB2_CODPRB" 	OF oSection2 ALIAS "AB2"
			DEFINE CELL NAME "AAG_DESCRI" 	OF oSection2 ALIAS "AAG" 
			DEFINE CELL NAME "AB2_NUMOS" 	OF oSection2 ALIAS "AB2" 
			DEFINE CELL NAME "AB2_NUMORC" 	OF oSection2 ALIAS "AB2" 
			DEFINE CELL NAME "AB2_MEMO" 	OF oSection2 ALIAS "AB2" SIZE 140 TITLE STR0026 BLOCK {|| MSMM((cAlias2)->AB2_MEMO) } //"Comentário da Ocorr/Problema"
			
Return oReport


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFuncao    ³Tcr310PrtRptºAutor  ³Cleber Martinez     º Data ³  14/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Funcao para impressao do relatorio personalizavel             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºRetorno   ³Nenhum                                                      	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³oReport: Objeto TReport do relatorio personalizavel        	º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ TECR310 R4                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function Tcr310PrtRpt( oReport, aOrdem,cAlias1,cAlias2 )
Local oSection1 := oReport:Section(1)				// Define a secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Define que a secao 2 sera filha da secao 1
Local lImp 		:= .F.								// Indica se imprimiu algum registro
Local nOrdem 	:= 1								// Ordem definida pelo usuario
Local cOrderBy	:= ""								// Chave de ordenacao
Local cIndexKey := ""								// Indice do filtro (CodeBase)
Local aTotal    := { 0 , 0 , 0 , 0}  				// Array dos totalizadores
Local nMinutos  := 0                				// Variav. com o resultado dos minutos do atendimento
Local cQuebra 	:= ""								// Conteudo da quebra do relatorio (cliente ou emissao)
Local nLin 		:= 0								// Guarda a linha atual impressa

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Pega a ordem escolhida pelo usuario ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
nOrdem := oSection1:GetOrder() 
If nOrdem <= 0
	nOrdem := 1
EndIf

#IFNDEF TOP
	cAlias1	:= "AB1"
#ENDIF

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Configura as secoes a imprimir e os indices conforme a Ordem selecionada  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Do Case
	Case ( nOrdem == 1 )
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³ NR.CHAMADO  ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB1_FILIAL,AB1_NRCHAM %"
		cIndexKey:= "AB1_FILIAL+AB1_NRCHAM"
		oSection1:Hide()
	Case ( nOrdem == 2 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³   CLIENTE    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB1_FILIAL,AB1_CODCLI,AB1_LOJA,AB1_NRCHAM %"
		cIndexKey:= "AB1_FILIAL+AB1_CODCLI+AB1_LOJA+AB1_NRCHAM"
	Case ( nOrdem == 3 ) 
		//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
		//³   EMISSAO    ³
		//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		cOrderBy := "% AB1_FILIAL,AB1_EMISSA,AB1_NRCHAM %"
		cIndexKey:= "AB1_FILIAL+DTOS(AB1_EMISSA)+AB1_NRCHAM"
		oSection1:Hide()
EndCase
   
	DbSelectArea("AB1")
	DbSetOrder(1)

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Transforma parametros do tipo Range em expressao SQL para ser utilizada na query ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	MakeSqlExpr("ATR310")
    
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Inicializa a secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BEGIN REPORT QUERY oSection1

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Query da secao 1³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	BeginSql alias cAlias1
		SELECT	AB1_FILIAL,	AB1_NRCHAM,	AB1_CODCLI,	AB1_LOJA,	
				AB1_EMISSA,	AB1_CONTAT,	AB1_ATEND,	AB1_HORA,	
				AB1_HORAF
		
		FROM %table:AB1% AB1
		WHERE	AB1_FILIAL = %xfilial:AB1%		AND
				AB1_NRCHAM >= %exp:mv_par01%	AND  
				AB1_NRCHAM <= %exp:mv_par02%	AND
				AB1_EMISSA >= %exp:DtoS(mv_par03)%		AND
				AB1_EMISSA <= %exp:DtoS(mv_par04)%		AND
				AB1_CODCLI >= %exp:mv_par05%	AND
				AB1_CODCLI <= %exp:mv_par06%	AND
				AB1.%notDel%					

		ORDER BY %exp:cOrderBy%
				
	EndSql
	
	END REPORT QUERY oSection1 
      
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Adiciona a ordem escolhida ao titulo do relatorio          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetTitle(oReport:Title() + Space(10) + "[ " + AllTrim(Upper(aOrdem[nOrdem])) + " ]" )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Posiciona na tabela de clientes a usar na secao 1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRPosition():New(oSection1,"SA1",1,{|| xFilial("SA1")+(cAlias1)->AB1_CODCLI+(cAlias1)->AB1_LOJA })  

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Executa a impressao dos dados, de acordo com o filtro ou query³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oReport:SetMeter((cAlias1)->(LastRec()))
DbSelectArea(cAlias1)

While !oReport:Cancel() .And. !(cAlias1)->(Eof())

	oReport:IncMeter()
	If oReport:Cancel()
		Exit
	EndIf
    
 	lImp := .T.
	    
	Do Case
		Case ( nOrdem == 2 )
			If ( cQuebra <> (cAlias1)->AB1_CODCLI + (cAlias1)->AB1_LOJA )
				cQuebra := (cAlias1)->AB1_CODCLI + (cAlias1)->AB1_LOJA
				oSection1:Show()				
			Else
				oSection1:Hide()
			EndIf
		Case ( nOrdem == 3 )
			cQuebra := Dtoc((cAlias1)->AB1_EMISSA)
	EndCase
		
	BEGIN REPORT QUERY oSection2			
		BeginSql alias cAlias2		
			SELECT AB2_NRCHAM,AB2_ITEM,AB2_TIPO,AB2_CLASSI,AB2_CODPRO,AB2_NUMSER,AB2_CODPRB,AB2_NUMOS,AB2_NUMORC,AB2_MEMO,AB2_CODPRB
			FROM %table:AB2% AB2	INNER JOIN %table:AB1% AB1 ON AB2.AB2_FILIAL = AB1.AB1_FILIAL AND AB2.AB2_NRCHAM = AB1.AB1_NRCHAM	
			WHERE 
			AB2.AB2_FILIAL = %xfilial:AB2%
			AND AB2.AB2_NRCHAM=%exp:(cAlias1)->AB1_NRCHAM%
			AND AB2.%NotDel%				
			AND AB2.AB2_CODPRO >= %exp:mv_par07%
			AND AB2.AB2_CODPRO <= %exp:mv_par08%
			AND AB2.AB2_CLASSI >= %exp:mv_par10%
			AND AB2.AB2_CLASSI <= %exp:mv_par11%
			AND	(
				(AB2.AB2_TIPO = %exp:mv_par09%) OR
				(AB2.AB2_TIPO NOT IN ('1','2','3') AND %exp:mv_par09% = 5) OR
				( %exp:mv_par09% = 4 )
				)			
			ORDER BY AB2.AB2_NRCHAM,AB2.AB2_ITEM,AB2.AB2_TIPO	
		EndSql
	END REPORT QUERY oSection2
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Imprime a secao 1 ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !isBlind()
		oSection1:Init()
	 	oSection1:PrintLine()	
 	EndIf
 	nMinutos := SubtHoras((cAlias1)->AB1_EMISSA,(cAlias1)->AB1_HORA,(cAlias1)->AB1_EMISSA,(cAlias1)->AB1_HORAF)*60	
	
	While  !oReport:Cancel() .AND. (cAlias2)->( !Eof() )	
		aTotal[1] ++
		aTotal[2] ++
		aTotal[3] += nMinutos
		aTotal[4] += nMinutos
		TRPosition():New(oSection2,"AAG",1,{|| xFilial("AAG") + (cAlias2)->AB2_CODPRB }) 		
		oSection2:Init()
		oSection2:Cell("nMinutos"):SetValue(nMinutos)
		If !isBlind()
			oSection2:PrintLine()
		EndIf
		(cAlias2)->(DbSkip())	
	End
	
	DbSelectArea(cAlias1)
	(cAlias1)->(DbSkip())
	
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Verifica a quebra e a impressao dos Subtotais ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	Do Case
		Case ( nOrdem == 2 )
			If ( cQuebra <> (cAlias1)->AB1_CODCLI + (cAlias1)->AB1_LOJA)
			                      
				oReport:SkipLine()
				nLin := oReport:Row()
				oReport:PrintText( STR0016 + cQuebra, nLin  ) //"TOTAL DO CLIENTE: "
				oReport:PrintText( STR0017 + Str(aTotal[1],6,0), nLin, oSection2:Cell("AB2_CLASSI"):ColPos() ) //"NR.CHAMADOS:"
				oReport:PrintText( Str(aTotal[3],6,0), nLin, oSection2:Cell("nMinutos"):ColPos() ) 
				oReport:PrintText( STR0018 + Str(aTotal[3]/aTotal[1],8,2), nLin, oSection2:Cell("AB2_CODPRB"):ColPos() )	//"MEDIA:"
                oReport:SkipLine()

				aTotal[1] := aTotal[3] := 0
			EndIf
		Case ( nOrdem == 3 )
			If ( cQuebra <> Dtoc((cAlias1)->AB1_EMISSA) )
				
				oReport:SkipLine()   
				nLin := oReport:Row()
				oReport:PrintText( STR0019 + cQuebra, nLin ) //"TOTAL DO DIA: "
				oReport:PrintText( STR0020 + Str(aTotal[1],6,0),nLin, oSection2:Cell("AB2_CLASSI"):ColPos() ) //"NR.CHAMADOS:"
				oReport:PrintText( Str(aTotal[3],6,0), nLin, oSection2:Cell("nMinutos"):ColPos() ) 
				oReport:PrintText( STR0021 + Str(aTotal[3]/aTotal[1],8,2), nLin, oSection2:Cell("AB2_CODPRB"):ColPos() ) //"MEDIA:"
                oReport:SkipLine()

				aTotal[1] := aTotal[3] := 0
			EndIf
	EndCase
    oSection2:Finish()
 	oSection1:Finish()
End 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Imprime o totalizador final do relatorio ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
If ( lImp )
	oReport:FatLine()                                                              
	oReport:PrintText( STR0022,,oSection2:Cell("AB2_NRCHAM"):ColPos() ) //"TOTAL GERAL:"
	//Guarda a linha atual
	nLin := oReport:Row()
	oReport:PrintText( STR0023, nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() )			//"NR.CHAMADOS:"
	If !isBlind()
		oReport:PrintText( Str(aTotal[2],6,0), nLin, oSection2:Cell("AB2_TIPO"):ColPos() )
	EndIf	
	oReport:SkipLine()
	nLin := oReport:Row()
	oReport:PrintText( Upper(STR0025), nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() ) 	//"Tempo(Min)"
	If !isBlind()
		oReport:PrintText( Str(aTotal[4],6,0), nLin, oSection2:Cell("AB2_TIPO"):ColPos() )
	EndIf
	oReport:SkipLine()
	nLin := oReport:Row()	
	oReport:PrintText( STR0024, nLin, oSection2:Cell("AB2_NRCHAM"):ColPos() )			//"MEDIA:"
	If !isBlind()
		oReport:PrintText( Str(aTotal[4]/aTotal[2],8,2), nLin, oSection2:Cell("AB2_TIPO"):ColPos() )
	EndIf
EndIf

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³TECR310R3 ³ Autor ³ Eduardo Riera         ³ Data ³ 07.10.98 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Relacao de Chamados Tecnicos.                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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
User Function TECR310R3()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local Titulo  := STR0001 //"Relacao de Chamados Tecnicos"  // Titulo do Relatorio
Local cDesc1  := STR0002 //"   Este programa ira imprimir a relacao de chamados tecnicos conforme"  // Descricao 1
Local cDesc2  := STR0003 //"os parametros solicitados."  // Descricao 2
Local cDesc3  := STR0004 //""  // Descricao 3
Local cString := "AB1"  // Alias utilizado na Filtragem
Local lDic    := .F. // Habilita/Desabilita Dicionario
Local lComp   := .F. // Habilita/Desabilita o Formato Comprimido/Expandido
Local lFiltro := .T. // Habilita/Desabilita o Filtro
Local wnrel   := "TECR310"  // Nome do Arquivo utilizado no Spool
Local nomeprog:= "TECR310"  // nome do programa

Private Tamanho := "G" // P/M/G
Private Limite  := 220 // 80/132/220
Private aOrdem  := {STR0005,STR0006,STR0007} //"Chamado"###"Cliente"###"Emissao"
Private cPerg   := "ATR310"  // Pergunta do Relatorio
Private aReturn := { STR0008, 1,STR0009, 1, 2, 1, "",1 } //"Zebrado"###"Administracao"
						//[1] Reservado para Formulario
						//[2] Reservado para N§ de Vias
						//[3] Destinatario
						//[4] Formato => 1-Comprimido 2-Normal
						//[5] Midia   => 1-Disco 2-Impressora
						//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
						//[7] Expressao do Filtro
						//[8] Ordem a ser selecionada
						//[9]..[10]..[n] Campos a Processar (se houver)
Private lEnd    := .F.// Controle de cancelamento do relatorio
Private m_pag   := 1  // Contador de Paginas
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Verifica as Perguntas Seleciondas                                       ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³                       PARAMETROS                                       ³
//³                                                                        ³
//³ MV_PAR01 : Nr.Chamado de  ?                                            ³
//³ MV_PAR02 : Nr.Chamado ate ?                                            ³
//³ MV_PAR03 : Emissao de     ?                                            ³
//³ MV_PAR04 : Emissao ate    ?                                            ³
//³ MV_PAR05 : Cliente de     ?                                            ³
//³ MV_PAR06 : Cliente ate    ?                                            ³
//³ MV_PAR07 : Produto de     ?                                            ³
//³ MV_PAR08 : Produto ate    ?                                            ³
//³ MV_PAR09 : Lista Quais    ? Aberto / Orcamento / OS / Todos / Outros   ³
//³ MV_PAR10 : Classificacao de ?                                          ³
//³ MV_PAR11 : Classificacao ate?                                          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Pergunte(cPerg,.F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,lDic,aOrdem,lComp,Tamanho,lFiltro)
If ( nLastKey==27 )
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif
SetDefault(aReturn,cString)
If ( nLastKey==27 )
	DbSelectArea(cString)
	DbSetOrder(1)
	Set Filter to
	Return
Endif
#IFDEF WINDOWS
	RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo)},Titulo)
#ELSE
	ImpDet(.F.,wnrel,cString,nomeprog,Titulo)
#ENDIF

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³ Eduardo Riera         ³ Data ³02.07.1998³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
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

Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo)

Local li        := 100 // Contador de Linhas
Local lImp      := .F. // Indica se algo foi impresso
Local cbCont    := 0   // Numero de Registros Processados
Local cbText    := ""  // Mensagem do Rodape
Local cQuebra   := ""  // Quebra
Local cQuery    := ""
Local cArqInd   := CriaTrab(,.F.)
Local cMemo     := ""
Local aTotal    := { 0 , 0 , 0 , 0}
Local nMinutos  := 0                 
Local nMemCount := 0
Local cLinha    := ""
Local nLoop     := 0  

//
//                                    1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                          01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Local cCabec1 := STR0010 //"NUMERO      DATA       SITUACAO   CLASSIFICACAO  CLIENTE   CONTATO              TEMPO PRODUTO         NR.SERIE             OCORRENCIA/PROBLEMA                   ORC./OS  COMENTARIO DA OCORRENCIA/PROBLEMA"
Local cCabec2 := STR0011 //"CHAMADO     EMISSAO    DO CHAMADO DO CHAMADO                                    (MIN) EQUIPAMENTO"
//                          XXXXXXXX-XX XX/XX/XXXX XXXXXXXXXX XXX-XXXXXXXXXX XXXXXX-XX XXXXXXXXXXXXXXXXXXXX XXXXX XXXXXXXXXXXXXXX XXXXXXXXXXXXXXXXXXXX XXXXXX-123456789012345678901234567890 XXXXXXXX 123456789012345678901234567890123456789012345678901

DbSelectArea("AB1")
SetRegua(LastRec())
cQuery := "AB1_FILIAL=='"+xFilial("AB1")+"'.And."
cQuery += "AB1_NRCHAM>='"+MV_PAR01+"'.And."
cQuery += "AB1_NRCHAM<='"+MV_PAR02+"'.And."
cQuery += "DTOS(AB1_EMISSA)>='"+DTOS(MV_PAR03)+"'.And."
cQuery += "DTOS(AB1_EMISSA)<='"+DTOS(MV_PAR04)+"'.And."
cQuery += "AB1_CODCLI>='"+MV_PAR05+"'.And."
cQuery += "AB1_CODCLI<='"+MV_PAR06+"'"

Do Case
	Case ( aReturn[8] == 1 )
		cChave := "AB1_FILIAL+AB1_NRCHAM"
		Titulo += STR0012 //" [ NR.CHAMADO ] "
	Case ( aReturn[8] == 2 )
		cChave := "AB1_FILIAL+AB1_CODCLI+AB1_LOJA+AB1_NRCHAM"
		Titulo += STR0013 //" [ CLIENTE ] "
	Case ( aReturn[8] == 3 )
		cChave := "AB1_FILIAL+DTOS(AB1_EMISSA)+AB1_NRCHAM"
		Titulo += STR0014 //" [ EMISSAO ] "
EndCase
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Esta IndRegua fornece bom desempenho para o TOP e o ADS,³
//³com grande volume de dados.                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
IndRegua("AB1",cArqInd,cChave,,cQuery)
dbGotop()
While ( !Eof() ) //IndRegua
	lImp := .T.
	#IFNDEF WINDOWS
		If LastKey() = 286
			lEnd := .T.
		EndIf
	#ENDIF
	If lEnd
		@ Prow()+1,001 PSAY STR0015 //"CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If ( li > 60 )
		li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
		li++
	EndIf
	Do Case
		Case ( aReturn[8] == 2 )
			If ( cQuebra <> AB1->AB1_CODCLI)
				cQuebra := AB1->AB1_CODCLI
				DbSelectArea("SA1")
				DbSetOrder(1)
				MsSeek(xFilial("SA1")+AB1->AB1_CODCLI+AB1->AB1_LOJA)
				Li++
				@ Li,000 PSAY RetTitle("AB1_CODCLI")+": "+SA1->A1_NOME
				Li++
				Li++
			EndIf
		Case ( aReturn[8] == 3 )
			cQuebra := Dtoc(AB1->AB1_EMISSA)
	EndCase
	DbSelectArea("AB2")
	DbSetOrder(1)
	MsSeek(xFilial("AB2")+AB1->AB1_NRCHAM)
	While ( !Eof() .And. xFilial("AB2") == AB2->AB2_FILIAL .And.;
								AB1->AB1_NRCHAM== AB2->AB2_NRCHAM )
		If (  AB2->AB2_CODPRO >= MV_PAR07 .And.;
				AB2->AB2_CODPRO <= MV_PAR08 .And.;
				AB2->AB2_CLASSI >= MV_PAR10 .And.;
				AB2->AB2_CLASSI <= MV_PAR11 .And.;
				(  (AB2->AB2_TIPO=="2" .And. MV_PAR09 == 2) .Or.;
					(AB2->AB2_TIPO=="3" .And. MV_PAR09 == 3) .Or.;
					(AB2->AB2_TIPO=="1" .And. MV_PAR09 == 1) .Or.;
					(!AB2->AB2_TIPO$"123" .And. MV_PAR09==5) .Or.;
					( MV_PAR09 == 4 )) )
			    
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Efetua a quebra de pagina caso estore o limite de ³
			//³60 linhas/pagina                                  ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			If ( li > 60 )
				li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
				li++
			EndIf
			DbSelectArea("AAG")
			DbSetOrder(1)
			MsSeek(xFilial("AAG")+AB2->AB2_CODPRB)
			cMemo 	:= AllTrim(MSMM(AB2->AB2_MEMO))
			nMinutos := SubtHoras(AB1->AB1_EMISSA,AB1->AB1_HORA,AB1->AB1_EMISSA,AB1->AB1_HORAF)*60
			@ Li,000 PSAY AB2->AB2_NRCHAM+"-"+AB2->AB2_ITEM
			@ Li,012 PSAY AB1->AB1_EMISSA
			@ Li,023 PSAY x3Combo("AB2_TIPO",AB2->AB2_TIPO)
			@ Li,034 PSAY AB2->AB2_CLASSI+"-"+SubStr(Tabela("A3",AB2->AB2_CLASSI),1,10)
			@ Li,049 PSAY AB1->AB1_CODCLI+"-"+AB1->AB1_LOJA
			@ Li,059 PSAY SubStr(AB1->AB1_CONTAT,1,20)
			@ Li,080 PSAY nMinutos PICTURE TM(nMinutos,5,0)
			@ Li,086 PSAY AB2->AB2_CODPRO
			@ Li,102 PSAY AB2->AB2_NUMSER
			@ Li,123 PSAY AB2->AB2_CODPRB+"-"+SubStr(AAG->AAG_DESCRI,1,30)
			@ Li,161 PSAY If(Empty(AB2->AB2_NUMOS),AB2->AB2_NUMORC,AB2->AB2_NUMOS)

			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³ Exibe o campo memo     ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

			nMemCount := MlCount( cMemo, 50 ) 
		
			If !Empty( nMemCount ) 
				For nLoop := 1 To nMemCount                
					cLinha := MemoLine( cMemo, 50, nLoop ) 			
					If ( li > 60 )	
						li := cabec(Titulo,cCabec1,cCabec2,nomeprog,Tamanho,CHRCOMP)
						li++
					EndIf
					@ Li,170 PSAY cLinha
					li++
				Next nLoop 
			EndIf 	
		
			//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
			//³Sub-Totais do Relatorio ³
			//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			aTotal[1] ++
			aTotal[2] ++
			aTotal[3] += nMinutos
			aTotal[4] += nMinutos
			Li++
		EndIf
		DbSelectArea("AB2")
		DbSkip()
	End
	DbSelectArea("AB1")
	DbSkip()
	cbCont++
	IncRegua()
	Do Case
		Case ( aReturn[8] == 2 )
			If ( cQuebra <> AB1->AB1_CODCLI)
				Li++
				@ Li,000 PSAY STR0016+cQuebra 	//"TOTAL DO CLIENTE: "
				@ Li,035 PSAY STR0017				//"NR.CHAMADOS:"
				@ Li,050 PSAY aTotal[1] PICTURE TM(aTotal[1],6,0)
				@ Li,079 PSAY aTotal[3] PICTURE TM(aTotal[3],6,0)
				@ Li,120 PSAY STR0018 			//"MEDIA:"
				@ Li,130 PSAY aTotal[3]/aTotal[1] PICTURE TM(aTotal[3]/aTotal[1],6)
				aTotal[1] := aTotal[3] := 0
				Li++
			EndIf
		Case ( aReturn[8] == 3 )
			If ( cQuebra <> Dtoc(AB1->AB1_EMISSA) )
				Li++
				@ Li,000 PSAY STR0019+cQuebra 	//"TOTAL DO DIA: "
				@ Li,035 PSAY STR0020				//"NR.CHAMADOS:"
				@ Li,050 PSAY aTotal[1] PICTURE TM(aTotal[1],6,0)
				@ Li,079 PSAY aTotal[3] PICTURE TM(aTotal[3],6,0)
				@ Li,120 PSAY STR0021 	//"MEDIA:"
				@ Li,130 PSAY aTotal[3]/aTotal[1] PICTURE TM(aTotal[3]/aTotal[1],6)
				aTotal[1] := aTotal[3] := 0
				Li++
			EndIf
		EndCase
End
If ( lImp )
	Li++
	@ Li,000 PSAY STR0022 	//"TOTAL GERAL:"
	@ Li,035 PSAY STR0023		//"NR.CHAMADOS:"
	@ Li,050 PSAY aTotal[2] PICTURE TM(aTotal[2],6,0)
	@ Li,079 PSAY aTotal[4] PICTURE TM(aTotal[4],6,0)
	@ Li,120 PSAY STR0024 	//"MEDIA:"
	@ Li,130 PSAY aTotal[4]/aTotal[2] PICTURE TM(aTotal[4]/aTotal[2],6)
	Roda(cbCont,cbText,Tamanho)
EndIf
Set Device To Screen
Set Printer To
DbSelectArea("AB1")
RetIndex("AB1")
dbClearFilter()
Ferase(cArqInd+OrdBagExt())
DbSelectArea(cString)
dbClearFilter()
If ( aReturn[5] = 1 )
	dbCommitAll()
	OurSpool(wnrel)
EndIf
MS_FLUSH()
Return(.T.)

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} ReportDef
Monta as definiçoes do relatorio.
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function ReportDef()

Return Tcr310RptDef()

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} PrintReport
Chama a função ReportPrint
Chamada utilizada na automação de código.

@author Mateus Boiani
@since 31/10/2018
@return objeto Report
/*/
//-------------------------------------------------------------------------------------
Static Function PrintReport ( oReport )

Return Tcr310PrtRpt( oReport , {STR0005,STR0006,STR0007} , GetNextAlias() , GetNextAlias())

//-------------------------------------------------------------------------------------
/*/{Protheus.doc} GetPergTRp
Retorna o nome do Pergunte utilizado no relatório
Função utilizada na automação
@author Mateus Boiani
@since 31/10/2018
@return cAutoPerg, string, nome do pergunte
/*/
//-------------------------------------------------------------------------------------
Static Function GetPergTRp()

Return cAutoPerg