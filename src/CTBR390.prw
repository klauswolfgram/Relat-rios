/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "CTBR390.CH"
#Include "PROTHEUS.CH"

Static lIsRedStor := FindFunction("IsRedStor") .and. IsRedStor() //Used to check if the Red Storn Concept used in russia is active in the system | Usada para verificar se o Conceito Red Storn utilizado na Russia esta ativo no sistema | Se usa para verificar si el concepto de Red Storn utilizado en Rusia esta activo en el sistema

// 17/08/2009 -- Filial com mais de 2 caracteres

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³ CTBR390	³ Autor ³ Cicero J. Silva   	³ Data ³ 24.07.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡„o ³ Relatorio do Cadastro de Orcamentos                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe	 ³                    					                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno	 ³ Nenhum       											  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGACTB                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ Nenhum													  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function CTBR390()

Local aArea := GetArea()
Local oReport

Private cPerg  := "CTR390"
PRIVATE oTRF1
PRIVATE oTRF2
PRIVATE cNormal := ""

//??????????????????????????????????????????????????????????????????????
//? Variaveis utilizadas para parametros       							?
//? mv_par01    Orcamento De           									?
//? mv_par02    Orcamento Ate          									?
//? mv_par03    Calendario De          									?
//? mv_par04    Calendario Ate         									?
//? mv_par05    Moeda De               									?
//? mv_par06    Moeda Ate              									?
//? mv_par07    Revisao De               								?
//? mv_par08    Revisao Ate              								?
//? mv_par09 	Status Listados = Aberto/Gerado Saldo/Revisado/Todos	?
//? mv_par10 	Filtra Por = Periodo/Data/Ambas/Nenhum               	?
//? mv_par11    Periodo De             									?
//? mv_par12    Periodo Ate            									?
//? mv_par13    Data Inicial           									?
//? mv_par14    Data Final             									?
//? mv_par15    Valores Zerados        									?
//???????????????????????????????????????????????????????????????????????

Pergunte("CTR390",.T.) // Precisa ativar as perguntas antes das definicoes.
	
oReport := ReportDef()
oReport:PrintDialog()
		
RestArea(aArea)

Return
/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ ReportDef º Autor ³ Cicero J. Silva    º Data ³  27/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ EXPL1 - Indica se esta sendo chamado da rotina de consulta º±±
±±º          ³         da visao gerencial                                 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()

Local oReport
Local oCabecOrc 
Local oLinhaOrc
Local oBreak1
Local lImpDesc      := IIF(mv_par17 == 1 .Or. mv_par18 == 1 .Or. mv_par19 == 1 .Or. mv_par20 == 1,.T.,.F.)
Local cAliasCV1 := GetNextAlias()
Local lCharSinal	:= .F.

oReport:= TReport():New("CTBR390",STR0003,cPerg, {|oReport| ReportPrint(oReport,cAliasCV1)},STR0001+" "+STR0002)//"Listagem do Cadastro de Orcamentos"##"Este programa ira emitir o cadastro de Orcamentos."##""
oReport:SetLandScape(.F.)    
oReport:SetTotalInLine(.F.)
oReport:EndPage(.T.)
oReport:ParamReadOnly() 

oCabecOrc := TRSection():New(oReport,STR0015,{"CV1"},/*aOrdem*/)//"Orcamento"

TRCell():New(oCabecOrc,"CV1_ORCMTO","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCabecOrc,"CV1_DESCRI","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCabecOrc,"CV1_CALEND","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCabecOrc,"CV1_MOEDA" ,"CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCabecOrc,"CV1_REVISA","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oCabecOrc,"CV1_SEQUEN","CV1",STR0020	  ,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)		//"Linha"

oCabecOrc:SetTotalInLine(.F.)
oCabecOrc:SetTotalText(STR0017) //"Total do orcamento"

oLinhaOrc := TRSection():New(oCabecOrc,STR0016,{"CV1"},/*aOrdem*/)    //"Detalhes"

TRCell():New(oLinhaOrc,"CV1_CT1INI","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CT1INI ),fAtulCond("CT1INI",(cAliasCV1)->CV1_CT1INI),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CT1FIM","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CT1FIM ),fAtulCond("CT1FIM",(cAliasCV1)->CV1_CT1FIM),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTTINI","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTTINI ),fAtulCond("CTTINI",(cAliasCV1)->CV1_CTTINI),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTTFIM","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTTFIM ),fAtulCond("CTTFIM",(cAliasCV1)->CV1_CTTFIM),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTDINI","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTDINI ),fAtulCond("CTDINI",(cAliasCV1)->CV1_CTDINI),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTDFIM","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTDFIM ),fAtulCond("CTDFIM",(cAliasCV1)->CV1_CTDFIM),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTHINI","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTHINI ),fAtulCond("CTHINI",(cAliasCV1)->CV1_CTHINI),"") }*/)
TRCell():New(oLinhaOrc,"CV1_CTHFIM","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| IIF( !Empty( (cAliasCV1)->CV1_CTHFIM ),fAtulCond("CTHFIM",(cAliasCV1)->CV1_CTHFIM),"") }*/)
TRCell():New(oLinhaOrc,"CV1_PERIOD","CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
TRCell():New(oLinhaOrc,"CV1_DTINI" ,"CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oLinhaOrc,"CV1_DTFIM" ,"CV1",/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/ ,/*{|| code-block de impressao }*/)
TRCell():New(oLinhaOrc,"CV1_VALOR" ,"CV1",STR0018,"",/*Tamanho*/,/*lPixel*/ ,{|| fAtulValor( (cAliasCV1)->CV1_CT1INI,(cAliasCV1)->CV1_CT1FIM,; 
																											(cAliasCV1)->CV1_CTTINI,(cAliasCV1)->CV1_CTTFIM,;
																											 (cAliasCV1)->CV1_CTDINI,(cAliasCV1)->CV1_CTDFIM,;
																											  (cAliasCV1)->CV1_CTHINI,(cAliasCV1)->CV1_CTHFIM,(cAliasCV1)->CV1_VALOR ) })
oLinhaOrc:SetTotalInLine(.F.)
oLinhaOrc:SetHeaderPage()

bTRSoma  := { || IIf(MV_PAR16==1,(cAliasCV1)->CV1_VALOR,ABS((cAliasCV1)->CV1_VALOR)) }
bTRPrin1  := { || ValorCTB(oTRF1:GetValue()*IIF(cNormal$"1D",-1,1),,,17,2,MV_PAR16==1,"","",,,,,,,.F.,,lCharSinal) }

bTBreak1 := { || (cAliasCV1)->CV1_ORCMTO+(cAliasCV1)->CV1_CALEND+(cAliasCV1)->CV1_MOEDA+(cAliasCV1)->CV1_REVISA+(cAliasCV1)->CV1_SEQUEN}
oBreak1 := TRBreak():New (oReport,bTBreak1,STR0019, /*[ lTotalInLine ]*/ )  //"Orcado"

oTRF1	:= TRFunction():New(oLinhaOrc:Cell("CV1_VALOR"),nil,"SUM"		,oBreak1,/*Tit*/,/*cPic*/,bTRSoma,.F.,.F.,.F.,oLinhaOrc)
oTRF1:disable()
TRFunction():New(oLinhaOrc:Cell("CV1_VALOR"),nil,"ONPRINT"	,oBreak1,/*Tit*/,""		 ,bTRPrin1,.F.,.F.,.F.,oLinhaOrc)

bTRPrin2  := { || ValorCTB(oTRF2:GetValue(),,,17,2,MV_PAR16==1,"","",,,,,,,.F.,,lCharSinal) }
bTBreak2 := { || (cAliasCV1)->CV1_ORCMTO+(cAliasCV1)->CV1_CALEND+(cAliasCV1)->CV1_MOEDA+(cAliasCV1)->CV1_REVISA }
oBreak2 := TRBreak():New (oReport,bTBreak2,STR0017, /*[ lTotalInLine ]*/ ) 

oTRF2 := TRFunction():New(oLinhaOrc:Cell("CV1_VALOR"),nil,"SUM",oBreak2,/*Titulo*/,/*cPicture*/,bTRSoma,.F.,.F.,.F.,oLinhaOrc)
oTRF2:disable()
TRFunction():New(oLinhaOrc:Cell("CV1_VALOR"),nil,"ONPRINT",oBreak2,/*Titulo*/,/*cPicture*/,bTRPrin2,.F.,.F.,.F.,oLinhaOrc)


Return oReport

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintº Autor ³ Cicero J. Silva    º Data ³  27/07/06  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Definicao do objeto do relatorio personalizavel e das      º±±
±±º          ³ secoes que serao utilizadas                                º±±
±±³          ³ Imprime o relatorio do cadastro de plano gerencial         ³±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºParametros³ReportPrint(oReport,cAliasCV1,lImpDesc)                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³                                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportPrint(oReport,cAliasCV1)

Local oCabecOrc  := oReport:Section(1)
Local oLinhaOrc  := oReport:Section(1):Section(1)
Local oBreak3
Local lCusto  	:= CtbMovSaldo("CTT")
Local lItem	  	:= CtbMovSaldo("CTD")
Local lCLVL	  	:= CtbMovSaldo("CTH")
Local lImpDescConta := IIF(mv_par17 == 1,.T.,.F.)
Local lImpDescCusto := IIF(mv_par18 == 1,.T.,.F.)
Local lImpDescItem  := IIF(mv_par19 == 1,.T.,.F.)
Local lImpDescClvlr := IIF(mv_par20 == 1,.T.,.F.)
Local lImpDesc      := IIF(mv_par17 == 1 .Or. mv_par18 == 1 .Or. mv_par19 == 1 .Or. mv_par20 == 1,.T.,.F.)
Local cWhere := ""
Local cCT1INI
Local cCT1FIM
Local cCTTINI
Local cCTTFIM
Local cCTDINI
Local cCTDFIM
Local cCTHINI
Local cCTHFIM
Local cMoeda
Local bQueb		:=	{|| (fRetDesc(lImpDescConta,lImpDescCusto,lImpDescItem,lImpDescClvlr,;
							    cCT1INI,cCT1FIM,cCTTINI,cCTTFIM,cCTDINI,cCTDFIM,cCTHINI,cCTHFIM,cMOEDA,oReport),;
								cCT1INI := (cAliasCV1)->CV1_CT1INI,;
								cCT1FIM := (cAliasCV1)->CV1_CT1FIM,;
								cCTTINI := (cAliasCV1)->CV1_CTTINI,;
								cCTTFIM := (cAliasCV1)->CV1_CTTFIM,;
								cCTDINI := (cAliasCV1)->CV1_CTDINI,;
								cCTDFIM := (cAliasCV1)->CV1_CTDFIM,;
								cCTHINI := (cAliasCV1)->CV1_CTHINI,;
								cCTHFIM := (cAliasCV1)->CV1_CTHFIM,;
								cMOEDA := (cAliasCV1)->CV1_MOEDA ) }
								



dbSelectArea("CV1")
dbSetOrder(1) 

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Filtragem do relatório                                                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Transforma parametros Range em expressao SQL                            ³	
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
MakeSqlExpr(oReport:uParam)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Query do relatório da secao 1                                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabecOrc:BeginQuery()	//Section(1)

cWhere :="%"

	If mv_par09 == 1		//Status Aberto
		cWhere 	+= " AND CV1_STATUS = '1' "
	ElseIf mv_par09 == 2	//Status Gerado Saldo
		cWhere	+= " AND CV1_STATUS = '2' "
	ElseIf mv_par09 == 3	//Status Revisado	
		cWhere	+= " AND CV1_STATUS = '3' "
	EndIf
		
	If mv_par10 == 1	//Se filtra por data 
		cWhere	+= " AND CV1_DTINI >= '" + DTOS(mv_par13) + "' "
		cWhere	+= " AND CV1_DTFIM <= '" + DTOS(mv_par14) + "' "					
	ElseIf mv_par10 == 2 //Se filtra por periodo
		cWhere	+= " AND CV1_PERIOD >= '" + mv_par11 + "' "
		cWhere	+= " AND CV1_PERIOD <= '" + mv_par12 + "' "
	ElseIf mv_par10 == 3 //Se filtra por periodo e por data
		cWhere	+= " AND CV1_PERIOD >= '" + mv_par11 + "' "
		cWhere	+= " AND CV1_PERIOD <= '" + mv_par12 + "' "
		cWhere	+= " AND CV1_DTINI >= '" + DTOS(mv_par13) + "' "
		cWhere	+= " AND CV1_DTFIM <= '" + DTOS(mv_par14) + "' "
	EndIf

	If mv_par15 == 2
		cWhere	+= " AND CV1_VALOR > 0"					
	EndIf		
	
cWhere +="%"	

BeginSql Alias cAliasCV1

SELECT CV1.*
	
FROM %table:CV1% CV1
	
WHERE CV1_FILIAL = %xFilial:CV1% AND 
	  CV1_ORCMTO >= %Exp:mv_par01% AND 
	  CV1_ORCMTO <= %Exp:mv_par02% AND 	 	  
	  CV1_CALEND >= %Exp:mv_par03% AND 
	  CV1_CALEND <= %Exp:mv_par04% AND 
	  CV1_MOEDA  >= %Exp:mv_par05% AND 
	  CV1_MOEDA  <= %Exp:mv_par06% AND 
	  CV1_REVISA >= %Exp:mv_par07% AND 
	  CV1_REVISA <= %Exp:mv_par08% AND 		  
	  CV1.%NotDel% 
	  %Exp:cWhere%
		  
	ORDER BY %Order:CV1% 
			
EndSql 
	
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Metodo EndQuery ( Classe TRSection )                                    ³
//³Prepara o relatório para executar o Embedded SQL.                       ³
//³ExpA1 : Array com os parametros do tipo Range                           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oCabecOrc:EndQuery(/*Array com os parametros do tipo Range*/)

oLinhaOrc:SetParentQuery()
oLinhaOrc:SetParentFilter( { |cParam| (cAliasCV1)->CV1_FILIAL+(cAliasCV1)->CV1_ORCMTO+(cAliasCV1)->CV1_CALEND+(cAliasCV1)->CV1_MOEDA+(cAliasCV1)->CV1_REVISA+(cAliasCV1)->CV1_SEQUEN == cParam },{ || (cAliasCV1)->CV1_FILIAL+(cAliasCV1)->CV1_ORCMTO+(cAliasCV1)->CV1_CALEND+(cAliasCV1)->CV1_MOEDA+(cAliasCV1)->CV1_REVISA+(cAliasCV1)->CV1_SEQUEN })// SERVE PARA IMPRIMIR O TITULO DA SECAO PAI

cCT1INI := (cAliasCV1)->CV1_CT1INI
cCT1FIM := (cAliasCV1)->CV1_CT1FIM
cCTTINI := (cAliasCV1)->CV1_CTTINI
cCTTFIM := (cAliasCV1)->CV1_CTTFIM
cCTDINI := (cAliasCV1)->CV1_CTDINI
cCTDFIM := (cAliasCV1)->CV1_CTDFIM
cCTHINI := (cAliasCV1)->CV1_CTHINI
cCTHFIM := (cAliasCV1)->CV1_CTHFIM
cMOEDA  := (cAliasCV1)->CV1_MOEDA

If lImpDesc
	oBreak3 := TRBreak():New ( oLinhaOrc , { || (cAliasCV1)->CV1_ORCMTO+(cAliasCV1)->CV1_CALEND+(cAliasCV1)->CV1_MOEDA+(cAliasCV1)->CV1_REVISA } , "Total do Orcamento " , /*[ lTotalInLine ]*/ )                         
	oBreak3:OnBreak( bQueb )
EndIf

oCabecOrc:Print()

Return                                                                          

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fRetDesc  ºAutor  ³Cicero J. Silva     º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna a descricao, da conta contabil, item, centro de     º±±
±±º          ³custo ou classe valor                                       º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fRetDesc(lImpDescConta,lImpDescCusto,lImpDescItem,lImpDescClvlr,;
						 cCT1INI,cCT1FIM,cCTTINI,cCTTFIM,cCTDINI,cCTDFIM,cCTHINI,cCTHFIM,cMoeda,oReport)

Local aArea := GetArea()
Local cDscCT1Ini	:= ""
Local cDscCT1Fim	:= ""
Local cDscCTTIni	:= ""
Local cDscCTTFim	:= ""
Local cDscCTDIni	:= ""
Local cDscCTDFim	:= ""
Local cDscCTHIni	:= ""
Local cDscCTHFim	:= ""

    oReport:ThinLine() 

    //Se imprime a descricao da conta, c.custo, item ou classe de valor			 		
	If mv_par17 == 1//lImpDescConta   
		dbSelectArea("CT1")      			                                  
		dbSetOrder(1)  
		If !Empty(cCT1INI)
			If MsSeek(xFilial("CT1")+cCT1INI,.F.)
				cDscCT1Ini	:= Alltrim(&("CT1->CT1_DESC" + cMoeda))
				If cCT1INI <> cCT1FIM
					If MsSeek(xFilial("CT1")+cCT1FIM,.F.)
						cDscCT1Fim	:= Alltrim(&("CT1->CT1_DESC" +  cMoeda))
					EndIf
				Else 
					cDscCT1Fim	:= ""
				EndIf													
			EndIf
		ElseIf !Empty(cCT1FIM)
			cDscCT1Ini	:= ""
			If MsSeek(xFilial("CT1")+cCT1FIM,.F.)
				cDscCT1Fim	:= Alltrim(&("CT1->CT1_DESC" +  cMoeda))
			EndIf				
		EndIf
		If cDscCT1Ini <> "" .Or. cDscCT1Fim <> ""
			If cDscCT1Ini <> cDscCT1Fim .And. cDscCT1Fim <> ""
				oReport:PrintText(STR0010 + ": " + cDscCT1Ini + STR0014 +cDscCT1Fim)//"Conta Contabil"	 "a"		
			Else
				oReport:PrintText(STR0010 + ": " + cDscCT1Ini)//"Conta Contabil"
			EndIf           
		EndIf
	EndIf

	If mv_par18 == 1//lImpDescCusto
		dbSelectArea("CTT")      			                                  				
		dbSetOrder(1)				
		If !Empty(cCTTINI)
			If MsSeek(xFilial("CTT")+cCTTINI,.F.)
				cDscCTTIni	:= Alltrim(&("CTT->CTT_DESC" + cMoeda))
				If cCTTINI <> cCTTFIM
					If MsSeek(xFilial("CTT")+cCTTFIM,.F.)
						cDscCTTFim	:= Alltrim(&("CTT->CTT_DESC" + cMoeda))
					EndIf
				Else 
					cDscCTTFim	:= ""
				EndIf													
			EndIf				
		ElseIf !Empty(cCTTFIM)
			cDscCTTIni	:= ""				
			If MsSeek(xFilial("CTT")+cCTTFIM,.F.)
				cDscCTTFim	:= Alltrim(&("CTT->CTT_DESC" + cMoeda))
			EndIf				
		EndIf    
		If cDscCTTIni <> "" .Or. cDscCTTFim <> ""				
			If cDscCTTIni <> cDscCTTFim  .And. cDscCTTFim <> ""
				oReport:PrintText(AllTrim(CtbSayApro("CTT")) + ": " +cDscCTTIni + STR0014 +cDscCTTFim)//	 "a"
			Else
				oReport:PrintText(AllTrim(CtbSayApro("CTT")) + ": " +  cDscCTTIni )
			EndIf           
		EndIf
	EndIf
					
	If mv_par19 == 1//lImpDescItem
		dbSelectArea("CTD")      			                                  				
		dbSetOrder(1)				
		If !Empty(cCTDINI)				
			If MsSeek(xFilial("CTD")+cCTDINI,.F.)
				cDscCTDIni	:= Alltrim(&("CTD->CTD_DESC" + cMoeda))
				If cCTDINI <> cCTDFIM
					If MsSeek(xFilial("CTD")+cCTDFIM,.F.)
						cDscCTDFim	:= Alltrim(&("CTD->CTD_DESC" + cMoeda))
					EndIf
				Else 
					cDscCTDFim	:= ""
				EndIf													
			EndIf				
		ElseIf !Empty(cCTDFIM)
			cDscCTDIni	:= ""
			If MsSeek(xFilial("CTD")+cCTDFIM,.F.)
				cDscCTDFim	:= Alltrim(&("CTD->CTD_DESC" + cMoeda))
			EndIf					
		EndIf
		If cDscCTDIni <> "" .Or. cDscCTDFim <> ""								
			If cDscCTDIni <> cDscCTDFim  .And. cDscCTDFim <> ""
				oReport:PrintText(AllTrim(CtbSayApro("CTD")) + ": " +  cDscCTDIni + STR0014 +cDscCTDFim)//	 "a"		
			Else
				oReport:PrintText(AllTrim(CtbSayApro("CTD")) + ": " +  cDscCTDIni )
			EndIf           
		EndIf
	EndIf
			
	If mv_par20 == 1//lImpDescClvlr
		dbSelectArea("CTH")      			                                  				
		dbSetOrder(1)				
		If !Empty(cCTHINI)
			If MsSeek(xFilial("CTH")+cCTHINI,.F.)
				cDscCTHIni	:= Alltrim(&("CTH->CTH_DESC" + cMoeda))
				If cCTHINI <> cCTHFIM
					If MsSeek(xFilial("CTH")+cCTHFIM,.F.)
						cDscCTHFim	:= Alltrim(&("CTH->CTH_DESC" + cMoeda))
					EndIf
				Else 
					cDscCTHFim	:= ""
				EndIf													
			EndIf                     
		ElseIf !Empty(cCTHFIM)      
			cDscCTHIni	:= ""				
			If MsSeek(xFilial("CTH")+cCTHFIM,.F.)
				cDscCTHFim	:= Alltrim(&("CTH->CTH_DESC" + cMoeda))
			EndIf					
		EndIf
		If cDscCTHIni <> "" .Or. cDscCTHFim <> ""												
			If cDscCTHIni <> cDscCTHFim  .And. cDscCTHFim <> ""
				oReport:PrintText(AllTrim(CtbSayApro("CTH")) + ": " +  cDscCTHIni + STR0014 +cDscCTHFim )	//	 "a"		
			Else
				oReport:PrintText(AllTrim(CtbSayApro("CTH")) + ": " +  cDscCTHIni )
			EndIf           
		EndIf			        
	EndIf

    oReport:ThinLine() 

RestArea(aArea)

Return 

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³fAtulValorºAutor  ³Cicero J. Silva     º Data ³  27/07/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Retorna o Valor atualizado com a rotina ValorCTB            º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ CTBR390                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

Static Function fAtulValor(CT1INI,CT1FIM,CTTINI,CTTFIM,CTDINI,CTDFIM,CTHINI,CTHFIM,nValor)

Local aArea := GetArea()
Local l2DigAno		:= ( Len( Dtoc(Date()) ) == 8 )	//	Esta utilizando ano com 2 digitos
Local nTamValor	:= If( l2DigAno,15,13 )				//	Se estiver utilizando ano com 4 digitos, limitar o 
//Local cNormal := ""
Local lCharSinal	:= .F.
	
	If !Empty(CT1INI) .Or. !Empty(CT1FIM)
		dbSelectArea("CT1")
		dbSetOrder(1)
		If MsSeek(xFilial("CT1")+CT1INI,.F.)
			cNormal := CT1->CT1_NORMAL
		ElseIf MsSeek(xFilial("CT1")+CT1FIM,.F.)
			cNormal := CT1->CT1_NORMAL			
		Else
			MsSeek(xFilial("CT1")+CT1INI,.T.)
			If CT1->CT1_CONTA >= CT1INI .and. CT1->CT1_CONTA <= CT1FIM
				cNormal := CT1->CT1_NORMAL			
			Endif				
		Endif				
	ElseIf !Empty(CTTINI) .OR. !Empty(CTTFIM)
		dbSelectArea("CTT")
		dbSetOrder(1)
		If MsSeek(xFilial("CTT")+CTTINI,.F.)
			cNormal := CTT->CTT_NORMAL
		ElseIf MsSeek(xFilial("CT1")+CTTFIM,.F.)
			cNormal := CTT->CTT_NORMAL			
		Else
			MsSeek(xFilial("CTT")+CTTINI,.T.)
			If CTT->CTT_CUSTO >= CTTINI .and. CTT->CTT_CUSTO <= CTTFIM
				cNormal := CTT->CTT_NORMAL			
			Endif				
		Endif				
	ElseIf !Empty(CTDINI) .OR. !Empty(CTDFIM)
		dbSelectArea("CTD")
		dbSetOrder(1)
		If MsSeek(xFilial("CTD")+CTDINI,.F.)
			cNormal := CTD->CTD_NORMAL
		ElseIf MsSeek(xFilial("CTD")+CTDFIM,.F.)
			cNormal := CTD->CTD_NORMAL			
		Else
			MsSeek(xFilial("CTD")+CTDINI,.T.)
			If CTD->CTD_ITEM >= CTDINI .and. CTD->CTD_ITEM <= CTDFIM
				cNormal := CTD->CTD_NORMAL			
			Endif				
		Endif				
	ElseIf !Empty(CTHINI) .OR. !Empty(CTHFIM)
		dbSelectArea("CTH")
		dbSetOrder(1)
		If MsSeek(xFilial("CTH")+CTHINI,.F.)
			cNormal := CTH->CTH_NORMAL
		ElseIf MsSeek(xFilial("CTH")+CTHFIM,.F.)
			cNormal := CTH->CTH_NORMAL			
		Else
			MsSeek(xFilial("CTH")+CTHINI,.T.)
			If CTH->CTH_CLVL >= CTHINI .and. CTH->CTH_CLVL <= CTHFIM
				cNormal := CTH->CTH_NORMAL			
			Endif				
		Endif				
	Endif

	If lIsRedStor
		cNormal := " "
	Endif
	nCV1Valor := nValor
	If cNormal$"1D"
		nCV1Valor := nValor * -1
	Endif

    nValor := ValorCTB(nCV1Valor,,,nTamValor,2,.T.,"",cNORMAL,,,,,,,.F.,,lCharSinal)

RestArea(aArea)

Return nValor