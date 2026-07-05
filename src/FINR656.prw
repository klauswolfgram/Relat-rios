/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr656.ch"
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ FINR656  ³ Autor ³Bruno Sobieski        ³ Data ³ 23.05.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de provisao p/cobrancas duvidosas                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ FINR655(void)                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FINR656()
Local oReport
#IFDEF TOP
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao                                                  ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()
#ELSE
	Aviso(STR0001,STR0002,{STR0003}) //"Nao disponivel"###"Este relatorio so esta disponivle para ambientes com banco de dados relacional"###"Ok"
#ENDIF
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³ReportDef ³ Autor ³Bruno Sobieski         ³ Data ³23.05.2008³±±
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
Local oReport,oSection1,oSection2
Local cReport := "FINR656"
Local cTitulo := OemToAnsi(STR0004)  //"Provisao para cobranca duvidosa"
Local cDescri := OemToAnsi(STR0005) //"Este relatorio imprime e as provisoes para cobranca duvidosas geradas."

Pergunte( "FINR656001" , .F. )
                   
oReport  := TReport():New( cReport, cTitulo, 'FINR656001' , { |oReport| ReportPrint( oReport ) }, cDescri )
oReport:SetLandScape()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Define a 1a. secao do relatorio Valores nas Moedas   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
oSection1 := TRSection():New( oReport,STR0006 , {"FIA","SE1","SA1"},{STR0007,STR0008})  //"Titulos"###"Cliente"###"Emissao Provisao+Cliente"
TRCell():New( oSection1, "FIA_CLIENT" ,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_LOJA" 	,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_PREFIX"	,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_NUM" 		,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_PARCEL"	,"FIA"	, ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_TIPO" 	,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_MOEDA"	,"FIA", ,/*Picture*/, ,/*lPixel*/,)	
TRCell():New( oSection1, "FIA_DTPROV" ,"FIA" )
TRCell():New( oSection1, "FIA_VALOR"	,"FIA" )	
TRCell():New( oSection1, "FIA_VLLOC"	,"FIA" )	
TRCell():New( oSection1, "FIA_SEQ"		,"FIA" )	

oSection1:SetHeaderPage(.T.)
 

Return oReport
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ ReportPrint Autor ³ Bruno Sobieski       ³ Data ³ 23.05.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Impressao do TREPORT                                       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ oReport : Objeto Report                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/


Static Function ReportPrint( oReport )
Local oSection1 := oReport:Section(1)
Local nOrder		:= oSection1:GetOrder()
Local cOrder 
Local 	oBreak1 
If nOrder	==	1
	cOrder	:=	"%ORDER BY FIA_CLIENT,FIA_LOJA,FIA_PREFIX,FIA_NUM,FIA_PARCEL,FIA_TIPO,FIA_SEQ%"
	oBreak1 := TRBreak():New( oSection1,oSection1:Cell("FIA_CLIENT"),STR0009 )   //"Total do cliente"
	TRFunction():New(oSection1:Cell("FIA_VLLOC"), , "SUM"  	, oBreak1,STR0010 , , , .F.,.T.  ) //"Total"
Else
	cOrder	:=	"%ORDER BY FIA_DTPROV,FIA_CLIENT,FIA_LOJA,FIA_PREFIX,FIA_NUM,FIA_PARCEL,FIA_TIPO,FIA_SEQ%"
	oBreak1 := TRBreak():New( oSection1,oSection1:Cell(STR0011), "Total do dia" )   //"FIA_DTPROV"
	TRFunction():New(oSection1:Cell("FIA_VLLOC"), , "SUM"  	, oBreak1,STR0012 , , ,.F. , .T.  ) //"Total "
Endif



MaKeSqlExpr("FINR656001")

	oSection1:BeginQuery()

	BeginSql alias "QRYFIA"
		SELECT E1_CLIENTE,E1_LOJA,E1_EMIS1,E1_VENCREA,E1_PREFIXO,E1_NUM,E1_PARCELA,E1_TIPO, 
					 FIA_CLIENT,FIA_LOJA,FIA_PREFIX,FIA_NUM,FIA_PARCEL,FIA_TIPO,
					FIA_DTPROV, FIA_VALOR, FIA_SEQ, FIA_VLLOC
  	FROM %table:SA1% SA1,%table:SE1% SE1,%table:FIA% FIA
		WHERE A1_FILIAL = %xfilial:SA1% AND
					E1_FILIAL = %xfilial:SE1% AND
					FIA_FILIAL = %xfilial:FIA% AND
					FIA_DTPROV BETWEEN %exp:Dtos(mv_par04)% AND %exp:Dtos(mv_par05)% AND
					E1_VENCREA BETWEEN %exp:Dtos(mv_par06)% AND %exp:Dtos(mv_par07)% AND
					A1_COD  	= 	FIA_CLIENT AND					
					A1_LOJA 	= 	FIA_LOJA   AND					
  				FIA_CLIENT=		E1_CLIENTE AND 
  				FIA_LOJA	=   E1_LOJA 	 AND 
  				FIA_PREFIX=   E1_PREFIXO AND 
  				FIA_NUM		=   E1_NUM		 AND 
  				FIA_PARCEL=   E1_PARCELA AND 
  				FIA_TIPO	=   E1_TIPO 	 AND 
					SA1.%notDel% AND
			  	SE1.%notDel% AND                                                              
			  	FIA.%notDel%
					%Exp:cOrder%
	EndSql

	/*
	Prepara relatorio para executar a query gerada pelo Embedded SQL passando como 
	parametro a pergunta ou vetor com perguntas do tipo Range que foram alterados 
	pela funcao MakeSqlExpr para serem adicionados a query
	*/
	oSection1:EndQuery({mv_par01,mv_par02,mv_par03})


	oSection1:Print()

Return