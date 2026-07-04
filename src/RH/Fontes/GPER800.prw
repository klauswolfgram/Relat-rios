/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER800.CH"
#INCLUDE "REPORT.CH"    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma   ³GPER800   ºAutor   ³Erika Kanamori      º Data ³  08/18/08    º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.      ³Imprime o Relatorio Livro de Saldos da Argentina.             º±±
±±º           ³                                                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso        ³ AP                                                           º±±
±±ÌÍÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºMarcos Kato³01/04/09|73232009  ³Ajuste no relatorio R3 e R4 referente     º±±
±±º           ³        |          ³impressao da informacoes do dados         º±±
±±º           ³        |          ³funcionarios(Ex:Cuilt) e separacao dos    º±±
±±º           ³        |          ³valores de remuneracao de acordo comos    º±±
±±º			  ³		   ³          ³itens relacionados da Lei 20744.          º±±
±±ºAlceu P.   ³27/04/09³06142/2009³Feitos ajustes na traducao.E aumentado o  º±±
±±º			  ³		   ³	      ³Tamanho dos campos e ajuste no lay-out.   º±±
±±ºAlceu P.   ³05/02/10³0014442010³Alterada a verificacao do campo RV_INSS   º±±
±±º			  ³		   ³          ³para o campo RV_REMUNE.	                 º±±
±±ºL.Trombini ³26/11/10³26148/2010³Ajustado o programa para verificar a data º±±
±±º			  ³		   ³		  ³de demissao para imprimir somenta na data º±±
±±º			  ³		   ³		  ³da Emissao, Acertado tambem para respeitarº±±
±±º			  ³		   ³		  ³a data de admissao com a emissao.         º±±
±±ºL.Trombini ³03/12/10³26148/2010³Ajustada verificacao da data RA_DEMISSA   º±±
±±ºAndreia    ³08/12/10³26148/2010³ajuste p/ não imprimir o livro lei quando º±± 
±±º			  ³		   ³		  ³o funcionario estiver demitido e a emissãoº±± 
±±º			  ³		   ³		  ³for em meses posteriores a rescisão.      º±± 
±±ºGlaucia M. ³25/05/12³10802/2012³Perguntas alterado para GPR800, o campo	 º±± 
±±º			  ³		   ³    TEX837³RV_REMUNE foi alterado por RV_CLASIF, con-º±± 
±±º			  ³		   ³		  ³especificacao Hub Mexico.			     º±±
±±ºL.Samaniego³31/03/15³TRHQPE    ³Se agrega informacion en el encabezado.   º±±
±±º  Marco A. ³16/04/18³DMINA-2310³Se remueven sentencias CriaTrab y se apli-º±± 
±±º			  ³		   ³          ³ca FWTemporaryTable(), para el manejo de  º±±
±±º			  ³		   ³          ³las tablas temporales.                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/

User Function GPER800()
	Local aArea	:= Getarea()
	Local oReport 
	Local oReportEV 
	Private lTabela:= .F.
	Private cMesAno	:= ""     
	Private cArqDBF := ""
	Private cDatPgt := ""
   
	//-- Interface de impressao
	Pergunte("GPR800",.F.)      
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Variaveis utilizadas para parametros                         ³
	//³ mv_par01        //  Processo                                 ³
	//³ mv_par02        //  Procedimento                             ³
	//³ mv_par03        //  Periodo                                  ³
	//³ mv_par04        //  De Numero de Pagamento                   ³
	//³ mv_par05        //  Ate Numero de Pagamento                  ³
	//³ mv_par06        //  Filial                                   ³
	//³ mv_par07        //  Matricula                                ³
	//³ mv_par08        //  Tipo de impressao                        ³
	//³ mv_par09        //  Numero inicial da folha a imprimir       ³
	//³ mv_par10        //  quantidade de folhas a imprimir          ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
 	oReport:= ReportDef()  
 	                                             
	oReport:PrintDialog() 
	
	If SRA->(FieldPos("RA_CODPRO"))> 0 .and. SRA->(FieldPos("RA_LOJPRO"))> 0 .and. SRV->(FieldPos("RV_REMEVE "))> 0
		oReportEV:= ReportDefE() 
		
		oReportEV:PrintDialog()
	EndIf                          
	
	Restarea(aArea)
Return  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ReportDef ³ Autor ³ Erika Kanamori        ³ Data ³ 07.18.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Definicao do relatorio                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function ReportDef()
                                  
	Local aArea	:= Getarea()
	//-- Objeto Relatorio
	Local oReport  
	
	//-- Objeto Section
	Local oSection1
	Local oSection2
	Local oSection3
	
	//-- Objeto Function
	Local oLiquido    
	
	Local	cDesc		:=	STR0002 +" "+ STR0003 + STR0004 // "Emision del Libro de Sueldos" # "Ser  impresso de acordo com os parametros solicitados pelo" # "usuario." 

	//-- Inicio definicao do Relatorio
	DEFINE REPORT oReport NAME "GPER800" TITLE OemToAnsi(STR0001) PARAMETER "GPR800" ACTION {|oReport| PrintReport(oReport)} DESCRIPTION cDesc TOTAL IN COLUMN
                                     
	//-- Section de Funcionario
	DEFINE SECTION oSection1 OF oReport TABLES "SRA","SRC" TITLE STR0013 TOTAL IN COLUMN
	oSection1:SetHeaderBreak(.T.)
	oSection1:SetHeaderSection(.T.)
   	oSection1:SetLineStyle(.T.) 
   	oSection1:nlinesbefore:=5     
   	oSection1:SetCols(2)
	DEFINE CELL NAME "RA_MAT" 		OF oSection1 ALIAS "SRA"
	DEFINE CELL NAME "RA_NOME" 		OF oSection1 ALIAS "SRA" SIZE 30 
	DEFINE CELL NAME "RA_ADMISSA"	OF oSection1 ALIAS "SRA" Title OemToAnsi(STR0030)
	DEFINE CELL NAME "RA_DEMISSA"	OF oSection1 ALIAS "SRA" Title OemToAnsi(STR0031)
	DEFINE CELL NAME "RA_NASC"		OF oSection1 ALIAS "SRA" 
	DEFINE CELL NAME "RA_CIC"		OF oSection1 ALIAS "SRA" PICTURE "999999999999" SIZE 12
	DEFINE CELL NAME "RA_NACIONA" 	OF oSection1 ALIAS "SRA" BLOCK {|| If(Empty(RA_NACIONA),"",Tabela("34",RA_NACIONA))} 	SIZE 12
	DEFINE CELL NAME "RA_SEXO"		OF oSection1 ALIAS "SRA" BLOCK {|| IIF((cQrySRA)->RA_SEXO == "M",STR0022,STR0023) }		SIZE 4
	DEFINE CELL NAME "RA_ESTCIVI" 	OF oSection1 ALIAS "SRA" BLOCK {|| If(Empty(RA_ESTCIVI),"",Tabela("33",RA_ESTCIVI))}	SIZE 14
	DEFINE CELL NAME "RA_CODFUNC"	OF oSection1 ALIAS "SRA" BLOCK {|| fDesc("SRJ",(cQrySRA)->RA_CODFUNC,"RJ_DESC") }       SIZE 30
	DEFINE CELL NAME "RA_CARGO"		OF oSection1 ALIAS "SRA" BLOCK {|| fDesc("SQ3",(cQrySRA)->RA_CARGO,"Q3_DESCSUM") }		SIZE 30
	DEFINE CELL NAME "RA_ENDEREC"	OF oSection1 ALIAS "SRA" SIZE 20
	DEFINE CELL NAME "RA_BAIRRO"	OF oSection1 ALIAS "SRA" 
	DEFINE CELL NAME "RA_CEP"		OF oSection1 ALIAS "SRA" BLOCK {|| IIF(empty((cQrySRA)->RA_CEP),"","(" + ALLTRIM((cQrySRA)->RA_CEP) + ")") }
	DEFINE CELL NAME "RA_ESTADO"  	OF oSection1 ALIAS "SRA" BLOCK {|| If(Empty(RA_ESTADO), "", Tabela("12",RA_ESTADO))} 	SIZE 15
	DEFINE CELL NAME "NRO.RECIBO"	OF oSection1             BLOCK {|| fDesc("SRC",(cQrySRA)->RA_MAT+(cQrySRA)->RA_PROCES+MV_PAR02+MV_PAR03,"SRC->RC_SEQIMP",,(cQrySRA)->RA_FILIAL,6) } 	SIZE 30 //+

	oSection1:Cell("RA_NOME"):SetCellBreak(.T.)
	//-- Section de Dependentes
	DEFINE SECTION oSection2 OF oSection1 TABLES "SRB" TITLE STR0014 TOTAL IN COLUMN

	DEFINE CELL NAME "RB_NOME"		OF oSection2 ALIAS "SRB"
	DEFINE CELL NAME "RB_GRAUPAR"	OF oSection2 ALIAS "SRB" BLOCK {|| IF(RB_GRAUPAR == "C",STR0024,IF(RB_GRAUPAR == "F",STR0025,STR0026))}
	DEFINE CELL NAME "DATA"			OF oSection2 ALIAS "SRB" BLOCK {|| IF(RB_GRAUPAR == "C",STR0027 + dtoc(RB_DTCASAM),STR0028 + dtoc(RB_DTNASC))} TITLE STR0019 SIZE 20
	
	Restarea(aArea)
Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³PrintReport³ Autor ³ Erika Kanamori          ³ Data ³ 18.08.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Relacao de Verbas dos Funcionarios.                           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function PrintReport(oReport)     
            
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Locais                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local aArea			:= Getarea()
//-- Objeto
Local oSection1 	:= oReport:Section(1) 		// Funcionario
Local oSection2 	:= oSection1:Section(1)		// Dependente
Local oSection3 	:= oSection1:Section(2)		// Lancamentos
Local oSection4 	:= oSection1:Section(2)		// Lancamentos

//-- String
Local cFiltro		:= ""
Local cFiltro2		:= ""
Local cAcessaSRB  	:= &("{ || " + ChkRH("GPER800","SRB","2") + "}")
Local cAcessaSRC  	:= &("{ || " + ChkRH("GPER800","SRC","2") + "}")
Local cAcessaSRD  	:= &("{ || " + ChkRH("GPER800","SRD","2") + "}")

Local nReg			:= 0
Local nX			:= 0

Local X				:= 1    
Local aEmpresas		:={} 
Local nEmpDe 		            
Private cFilialDe   := mv_par06
Private cFilialAte  := mv_par07

Private cProcFunc 	:= "(" 
Private cSvProcesso 	:= mv_par01
Private nTamProc		:=	GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )  
Private nTam 			:= Len(Alltrim(cSvProcesso))  

Public nIni			:= 0   

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis Privadas                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private cAcessaSRA  	:= &("{ || " + ChkRH("GPER800","SRA","2") + "}")
Private cProcAnt:= ""


DbSelectArea('RCH')
dbSetOrder( RetOrder("RCH","RCH_FILIAL+RCH_PROCES+RCH_ROTEIR+RCH_PER+RCH_NUMPAG") )  

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³ Desmembrar Processo e Roteiro de Calculo                     ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ*/
cSvProcesso 	:= mv_par01
For X := 1 to nTam Step nTamProc
	cProcFunc += "'" + Substr(cSvProcesso, X, nTamProc) + "',"
Next X
cProcFunc 		:= Substr( cProcFunc, 1, Len(cProcFunc)-1) + ")"

aEmpresas	:= FwAllFilial(,,,.F.)	// seleção de todas filiais de todas empresas
nEmpDe		:= iif(aScan(aEmpresas,cFilialDe)==0,1,aScan(aEmpresas,cFilialDe))  
cFilialDe	:= aEmpresas[nEmpDe]

oReport:HideHeader()
oReport:HideFooter()
			                                                             
//-- Section de Lancamentos
DEFINE SECTION oSection3 OF oSection1 TABLES "SRC", "SRV" TITLE STR0015 TOTAL IN COLUMN
oSection3:SetHeaderBreak(.T.)
DEFINE CELL NAME "RC_PD"		OF oSection3 ALIAS "SRC"          	BLOCK {|| (cQryLanc)->RD_PD}
DEFINE CELL NAME "RV_DESC"		OF oSection3 ALIAS "SRV"            BLOCK {|| (cQryLanc)->RV_DESC}
DEFINE CELL NAME "RC_HORAS"		OF oSection3 ALIAS "SRC" 			   										PICTURE "999.99"   BLOCK {|| (cQryLanc)->RD_HORAS} SIZE 08
DEFINE CELL NAME "PROVENTOC"	OF oSection3 ALIAS "SRC" 							TITLE STR0016+" CON" 	PICTURE "@EZ 9,999,999.99" BLOCK {|| IF(((cQryLanc)->RV_TIPOCOD == "1" .And. (cQryLanc)->RV_CLASIF!="N"),(cQryLanc)->RD_VALOR,0)} SIZE 16
DEFINE CELL NAME "PROVENTOS"	OF oSection3 ALIAS "SRC" 							TITLE STR0016+" SIN" 	PICTURE "@EZ 9,999,999.99" BLOCK {|| IF(((cQryLanc)->RV_TIPOCOD == "1" .And. (cQryLanc)->RV_CLASIF=="N"),(cQryLanc)->RD_VALOR,0)} SIZE 16
DEFINE CELL NAME "DESCONTOS"	OF oSection3 ALIAS "SRC" 							TITLE STR0017 			PICTURE "@EZ 9,999,999.99" BLOCK {|| IF((cQryLanc)->RV_TIPOCOD == "2"							,(cQryLanc)->RD_VALOR,0)} SIZE 16

cQrySRA := GetNextAlias()
//Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
MakeSqlExpr("GPR800")

cOrdem := "%RA_FILIAL,RA_MAT%"

cDtIni := MV_PAR03+"01"    
cUltdt := dtos(lastdate(stod(cDtIni)+1))
cDtFim := dtos(lastdate(stod(cDtIni)))   
cFiltro := "% RA_FILIAL BETWEEN '" + cFilialDe + "' AND '" + cFilialAte + "' AND "
cFiltro += " RA_PROCES IN " + cProcFunc + "  AND "
cFiltro += " RA_MAT BETWEEN 	'" + MV_PAR08 + "' AND '" + MV_PAR09 + "' AND " 
cFiltro += " RA_ADMISSA < '"+ cUltDt + "' AND "
cFiltro += " (RA_DEMISSA = ('"+ Space(8) + " ') OR " 
cFiltro += " (RA_DEMISSA BETWEEN '"+ cDtIni + "' AND '"+ cDtFim + "') OR RA_DEMISSA >'"+ cDtFim+"' )  %" 

BEGIN REPORT QUERY oSection1
	BeginSql alias cQrySRA 
		%noparser% //nao passa pelo topconnect
		SELECT RA_FILIAL,RA_MAT,RA_NOME,RA_ADMISSA,RA_DEMISSA,RA_NASC,RA_CIC,RA_NACIONA,RA_SEXO,RA_ESTCIVI,RA_CODFUNC,RA_CARGO,RA_ENDEREC,
		RA_BAIRRO,RA_CEP,RA_ESTADO,RA_MUNICIP,RA_CODFUNC,RA_CATFUNC,RA_CARGO,RA_PROCES,RA_SITFOLH
		FROM %table:SRA% SRA                                        
		Where %exp:cFiltro%
					AND SRA.%notDel%
	EndSql

END REPORT QUERY oSection1 //PARAM mv_par06, mv_par07  

oSection1:SetLineCondition({|| fCondSRA(oSection1) })

//-- Relaciona a Section Filha (Dependente) com a Section Pai (Funcionario)
oSection2:SetRelation({|| (cQrySRA)->RA_FILIAL + (cQrySRA)->RA_MAT },"SRB",1,.T.)

//-- Condicao de relacionamento da secao filha em relacao a sua secao pai
//-- Filial e matricula da tabela de funcionarios (SRA) com a tabela de dependente (SRB)
oSection2:SetParentFilter({|cParam| SRB->RB_FILIAL + SRB->RB_MAT == cParam},{|| (cQrySRA)->RA_FILIAL + (cQrySRA)->RA_MAT })

oSection2:SetLineCondition({|| Eval(cAcessaSRB) })                                                 

cQryLanc := GetNextAlias()

cFiltro := "% RC_PROCES IN "+ cProcFunc 
cFiltro2:= "% RD_PROCES IN "+ cProcFunc 
	
cFiltro += " AND ( RC_FILIAL BETWEEN '" + cFilialDe + "' AND '" + cFilialAte + "' )" 
cFiltro2+= " AND ( RD_FILIAL BETWEEN '" + cFilialDe + "' AND '" + cFilialAte + "' )" 

cFiltro += " AND ( RC_MAT BETWEEN '" + mv_par08 + "' AND '" + mv_par09 + "' )" 
cFiltro2+= " AND ( RD_MAT BETWEEN '" + mv_par08 + "' AND '" + mv_par09 + "' )" 
		
//-- Roteiro
If !Empty(mv_par02)	
	cFiltro += " AND RC_ROTEIR = '" + mv_par02 + "'"
	cFiltro2+= " AND RD_ROTEIR = '" + mv_par02 + "'"
EndIf

//-- Periodo  
If !Empty(mv_par03)	
	cFiltro += " AND RC_PERIODO = '" + mv_par03 + "'"
	cFiltro2+= " AND RD_PERIODO = '" + mv_par03 + "'"
EndIf
					
//-- Numero de Pagamento
cFiltro += " AND RC_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "' %"
cFiltro2 += " AND RD_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "' %"

BEGIN REPORT QUERY oSection3
	BeginSql alias cQryLanc
		%noparser% //nao passa pelo topconnect
		SELECT RC_FILIAL RD_FILIAL, 
				RC_MAT RD_MAT,
				RC_PD RD_PD,
				RC_HORAS RD_HORAS,
				RC_VALOR RD_VALOR, 
				RC_DATA RD_DATPGT,
				RV_TIPOCOD, 
				RV_CLASIF,				   
				RV_DESC,           
				RC_ROTEIR RD_ROTEIR
		FROM %Table:SRC% SRC Left Join %Table:SRV% SRV On RC_PD = RV_COD
		WHERE %exp:cFiltro%
					AND SRC.%notDel%
					AND SRV.%notDel% 
					AND SRV.RV_TIPOCOD IN ('1','2')
		UNION 
		SELECT RD_FILIAL, 
				RD_MAT, 
				RD_PD,
				RD_HORAS,
				RD_VALOR, 
				RD_DATPGT,				   				   				   
				RV_TIPOCOD, 
				RV_CLASIF,
				RV_DESC,
				RD_ROTEIR
		FROM %Table:SRD% SRD Left Join %Table:SRV% SRV On RD_PD = RV_COD
		WHERE %exp:cFiltro2%
					AND SRD.%notDel%
					AND SRV.%notDel% 
					AND SRV.RV_TIPOCOD IN ('1','2')
	EndSql	
END REPORT QUERY oSection3     

(cQryLanc)->(DbGoTop())
cDatPgt:=DToc((cQryLanc)->RD_DATPGT)
Do While (cQryLanc)->(!Eof())
	If (cQryLanc)->RD_ROTEIR == MV_PAR02
		cDatPgt:=Dtoc((cQryLanc)->RD_DATPGT)
	Endif
	(cQryLanc)->(DbSkip())
End     

//-- Condicao de relacionamento da secao filha em relacao a sua secao pai
//-- Filial e matricula da tabela de funcionarios (SRA) com a tabela de lancamentos (SRC)
oSection3:SetParentFilter({|cParam| (cQryLanc)->RD_FILIAL + (cQryLanc)->RD_MAT == cParam},{|| (cQrySRA)->RA_FILIAL + (cQrySRA)->RA_MAT })
	
oSection3:SetLineCondition({|| Eval(cAcessaSRC)  })       

//-- Define o total da regua da tela de processamento do relatorio
oReport:SetMeter((cQrySRA)->( RecCount() ))  

nIni := MV_PAR11

If MV_PAR10 == 1
	oSection1:Hide() 		// Funcionario
	oSection2:Hide()		// Dependente
	oSection3:Hide()		// Lancamentos

	nFim := (nIni+ MV_PAR12)-1
	For nx := nIni to nfim
	   nIni := nX
	   oReport:StartPage()
	   fCabec( oReport )
	   oReport:EndPage()
	Next	   
Else
	//-- Total do Funcionario e Total da Empresa
	DEFINE FUNCTION NAME "TOTAL1"	FROM oSection3:Cell("PROVENTOC")	FUNCTION SUM 	TITLE STR0016+" CON" 	OF oSection1
	DEFINE FUNCTION NAME "TOTAL2"	FROM oSection3:Cell("PROVENTOS")	FUNCTION SUM 	TITLE STR0016+" SIN" 	OF oSection1		
	DEFINE FUNCTION NAME "TOTAL3"	FROM oSection3:Cell("DESCONTOS")	FUNCTION SUM 	TITLE STR0017			OF oSection1
	DEFINE FUNCTION oLiquido 		FROM oSection3:Cell("DESCONTOS") 	FUNCTION ONPRINT 	TITLE STR0021 OF oSection1 FORMULA {|| oSection1:GetFunction("TOTAL1"):GetLastValue() + oSection1:GetFunction("TOTAL2"):GetLastValue() - oSection1:GetFunction("TOTAL3"):GetLastValue() }
	oLiquido:ShowHeader()
EndIf

//-- Impressao na quebra de pagina - Impressao das informacoes da Empresa e Filial
If MV_PAR10 == 3 
	oReport:OnPageBreak({|| fCabec(oReport) })
ElseIf MV_PAR10 == 2 
	oReport:OnPageBreak({|| fPulaLinha(oReport) })
EndIf	

//-- Impressao do Relatorio
oSection1:Print()

Restarea(aArea)
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCondSRA   ³ Autor ³ Erika Kanamori          ³ Data ³ 09.16.08 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Verifica se a linha deve ser impressa                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCondSRA()                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCondSRA(oSection) 

	Local aArea	:= Getarea()
	Local lRetorno	:= .T.  
	Local cQryLanc 	:= "QSRC" 
	Local cFiltro	:= ""
	Local cFiltro2	:= ""
	Local cMatric	:= (CQRYSRA)->RA_MAT      

    If !((cQrySRA)->RA_FILIAL $ fValidFil()) .Or. !Eval(cAcessaSRA)
  	   lRetorno := .F.
  	EndIf
    
	cAnoMes:=MV_PAR04	 
	
	If (cQrySRA)->RA_SITFOLH $'D' .And. MesAno((cQrySRA)->RA_DEMISSA) < cMesAno
  	   lRetorno := .F.
	Endif

    If MesAno((cQrySRA)->RA_DEMISSA) > MV_PAR03
    	oSection:Cell("RA_DEMISSA"):SetValue(CtoD("  /  /  "))
    EndIf
	  
	If ( SELECT(cQryLanc) > 0 )
		(cQryLanc)->(dbCloseArea())
	EndIf
                      
	cFiltro := "% RC_PROCES IN "+ cProcFunc 
	cFiltro2:= "% RD_PROCES IN "+ cProcFunc 
	  
	cFiltro += " AND RC_MAT = '" + cMatric + "'"
	cFiltro2+= " AND RD_MAT = '" + cMatric + "'"
	//-- Roteiro
	If !Empty(mv_par02)	
		cFiltro += " AND RC_ROTEIR = '" + mv_par02 + "'"
		cFiltro2+= " AND RD_ROTEIR = '" + mv_par02 + "'"
	EndIf
	
	//-- Periodo  
	If !Empty(mv_par03)	
		cFiltro += " AND RC_PERIODO = '" + mv_par03 + "'"
		cFiltro2+= " AND RD_PERIODO = '" + mv_par03 + "'"
	EndIf
	                  
	//-- Numero de Pagamento
	cFiltro += " AND RC_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "' %"
	cFiltro2 += " AND RD_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "' %"

	BeginSql alias cQryLanc
	%noparser% //nao passa pelo topconnect
	SELECT RC_FILIAL RD_FILIAL, 
		   RC_MAT RD_MAT, 
		   RC_PD RD_PD,
		   RC_HORAS RD_HORAS,
		   RC_VALOR RD_VALOR, 
		   RC_DATA RD_DATPGT,
		   RV_TIPOCOD, 
		   RV_CLASIF,				   
		   RV_DESC,           
		   RC_ROTEIR RD_ROTEIR
	FROM %Table:SRC% SRC Left Join %Table:SRV% SRV On RC_PD = RV_COD
	WHERE %exp:cFiltro%
			   AND SRC.%notDel%
			   AND SRV.%notDel% 
			   AND SRV.RV_TIPOCOD IN ('1','2')
	UNION 
	SELECT RD_FILIAL, 
		   RD_MAT, 
		   RD_PD,
		   RD_HORAS,
		   RD_VALOR, 
           RD_DATPGT,				   				   				   
		   RV_TIPOCOD, 
		   RV_CLASIF,
		   RV_DESC,
		   RD_ROTEIR
	FROM %Table:SRD% SRD Left Join %Table:SRV% SRV On RD_PD = RV_COD
	WHERE %exp:cFiltro2%
			   AND SRD.%notDel%
			   AND SRV.%notDel% 
			   AND SRV.RV_TIPOCOD IN ('1','2')
	EndSql	
	
	(cQryLanc)->( dbGotop())
	If (cQryLanc)->(Eof())
		lRetorno := .F.
	EndIf
	
	Restarea(aArea)
Return lRetorno
	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³fCabec     ³ Autor ³ R.H. - Tatiane Matias   ³ Data ³ 08.08.06 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Cabecalho do relatorio                                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ fCabec()                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                      ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function fCabec(oReport)

	Local aArea	:= Getarea()
	Local cAtivEmp  := If (!Empty(UPPER(LEFT(Alltrim(SM0->M0_DSCCNA),30))),UPPER(LEFT(Alltrim(SM0->M0_DSCCNA),30)), Space(30)) 
	Local cNomeEmp  := If (!Empty(UPPER(LEFT(Alltrim(SM0->M0_NOMECOM),30))),UPPER(LEFT(Alltrim(SM0->M0_NOMECOM),30)), Space(30)) 
	Local cNomeEnd  := If (!Empty(UPPER(LEFT(Alltrim(SM0->M0_ENDCOB),40))),UPPER(LEFT(Alltrim(SM0->M0_ENDCOB),40)), Space(40)) 
	Local cNomeCid  := If (!Empty(UPPER(LEFT(Alltrim(SM0->M0_CIDCOB),20))),UPPER(LEFT(Alltrim(SM0->M0_CIDCOB),20)), Space(20)) 
	Local cNomeCUIT := If (!Empty(UPPER(LEFT(Alltrim(SM0->M0_CGC),15))),UPPER(LEFT(Alltrim(SM0->M0_CGC),15)), Space(15)) 
	
	cAtivEmp:= UPPER(LEFT(cAtivEmp,30))


	oReport:PrintText(STR0051) //"HABILITACION DEL REGISTRO DE HOJAS MOVILES EN REEMPLAZO DEL LIBRO ESPECIAL ART. 52§ LEY 20744 (T.O.)"
	oReport:PrintText(cNomeEmp + Space(5) + cNomeEnd + Space(5) + cNomeCid + Space(5)+ STR0052 + cNomeCUIT) //"C.U.I.T.: "
	oReport:PrintText(cAtivEmp+ Space(10) + STR0018 + ": " + Substr(mv_par03,5,2) + Substr(mv_par03,1, 4) + Space(10) + STR0053+cDatPgt + space(10)+STR0054+strzero(nIni,4)) //"Fecha Pago: " - "Hoja: "
	oReport:ThinLine()
	oReport:SkipLine()

	If MV_PAR10 == 3
		nIni++			
    EndIf
    Restarea(aArea)
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³GPER800   ºAutor  ³Microsiga           º Data ³  07/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Salto de Líneas en el Informe                               º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function fPulaLinha(oReport)
Local aArea	:= Getarea()

		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
		oReport:SkipLine()
Restarea(aArea)		
Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDefEºAutor  ³Microsiga           º Data ³  07/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definición de Reporte E                                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDefE()

Local aArea      := GetArea() 

Local oReport
Local oSection1
Local oSection2
Local oSection3
Local cDes := ""

Private cTitulo	:= OEMTOANSI(STR0032)

Pergunte("GPER800",.F.)

cTitulo := Trim(cTitulo)
cDesc := OemToAnsi(STR0048) + OemToAnsi(STR0049) + OemToAnsi(STR0050)

oReport := TReport():New("GPER800",OemToAnsi(cTitulo),,{|oReport| PrintRepE(oReport)},cDesc)

oReport:SetPortrait() 
oReport:Setlandscape(.T.)	
oReport:SetTotalInLine(.F.)

oSection1 := TRSection():New(oReport,OemToAnsi(STR0034),,,/*Campos do SX3*/,/*Campos do SIX*/)
oSection1:SetHeaderPage(.T.)	
oSection1:SetLineStyle(.t.)   	
oSection1:SetCharSeparator(" ")    
oSection1:SetHeaderBreak(.T.) 
oSection1:nColSpace:=5   
oSection1:SetPageBreak(.T.)

TRCell():New(oSection1,"A2_CGC",PesqPict("SRA","A2_CGC")	, STR0035, ,TamSx3("A2_CGC")[1] + 4)
TRCell():New(oSection1,"A2_NOME", , STR0036, ,TamSx3("A2_NOME")[1])
oSection1:Cell("A2_NOME"):SetCellBreak(.T.)
TRCell():New(oSection1,"A2_END",	, STR0037, , TamSx3("A2_END")[1])
TRCell():New(oSection1,"A2_NR_END",	, STR0038, , TamSx3("A2_END")[1])
TRCell():New(oSection1,"A2_BAIRRO", , STR0039, ,TamSx3("A2_BAIRRO")[1])
TRCell():New(oSection1,"A2_ESTADO", , STR0040, ,TamSx3("A2_ESTADO")[1])
TRCell():New(oSection1,"A2_MUN",	, STR0041, ,TamSx3("A2_MUN")[1])
TRCell():New(oSection1,"A2_CEP",	, STR0042, , TamSx3("A2_CEP")[1] + 2)

oSection2 := TRSection():New(oReport,oemtoansi(STR0033),,,/*Campos do SX3*/,/*Campos do SIX*/)

oSection2:SetTotalInLine(.F.)  
oSection2:SetHeaderSection(.T.)
oSection2:SetHeaderPage(.T.)	
oSection2:SetLineStyle(.F.)   

TRCell():New(oSection2, "RA_CIC", ,	STR0043, PesqPict("SRA","RA_CIC"),TamSx3("RA_CIC")[1] + 4)
TRCell():New(oSection2, "RA_NOME", ,	STR0044, ,TamSx3("RA_NOME")[1])
TRCell():New(oSection2, "RJ_DESC", ,	STR0045, ,TamSx3("RJ_DESC")[1])
TRCell():New(oSection2, "Q3_DESCSUM",	, STR0046, ,TamSx3("Q3_DESCSUM")[1])
TRCell():New(oSection2, "RA_ADMISSA",	, STR0030, ,TamSx3("RA_ADMISSA")[1])
TRCell():New(oSection2, "RA_DEMISSA",	, STR0031, ,TamSx3("RA_DEMISSA")[1])
TRCell():New(oSection2, "RA_SALARIO",	, STR0047,PesqPict("SRA","RA_SALARIO"),TamSx3("RA_SALARIO")[1] + 2)

Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDefEºAutor  ³Microsiga           º Data ³  07/23/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impresio de Informacion para Reporte E                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ AP                                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintRepE(oReport)

	Local oSection1  := oReport:Section(1)
	Local oSection2  := oReport:Section(2)
	Local cAliasEv		:= "QRYEV" 
	Local aEmpresas		:={} 
	Local nEmpDe 		            
	Local cFiltro		:= ""
	Local cFiltroC		:= ""
	Local cFiltroD	:= ""
	Local X				:= 1
	Local cCodPro := ""
	Local cLojPro	:= ""
	Local cMatEmp	:= ""
	Local cFilEmp := ""
	Local cOrdem := ""
	Local aEmp := {}
	
	Local cFilialDe   := mv_par06
	Local cFilialAte  := mv_par07
	Local cProcFunc 	:= "(" 
	Local cSvProcesso := mv_par01
	Local nTam := 0
	Local nTamProc :=	0
	Local nFacBruta := 0
	
	nTam := Len(Alltrim(cSvProcesso))
	nTamProc :=	GetSx3Cache( "RCJ_CODIGO" , "X3_TAMANHO" )
	
	For X := 1 to nTam Step nTamProc
		cProcFunc += "'" + Substr(cSvProcesso, X, nTamProc) + "',"
	Next X
	cProcFunc 		:= Substr( cProcFunc, 1, Len(cProcFunc)-1) + ")"
	
	aEmpresas	:= FwAllFilial(,,,.F.)	//
	nEmpDe		:= iif(aScan(aEmpresas,cFilialDe)==0,1,aScan(aEmpresas,cFilialDe))  
	cFilialDe	:= aEmpresas[nEmpDe]

	cOrdem := "%A2_COD, A2_LOJA, RA_FILIAL,RA_MAT%"
	
	cDtIni := MV_PAR03+"01"    
	cUltdt := dtos(lastdate(stod(cDtIni)+1))
	cDtFim := dtos(lastdate(stod(cDtIni)))  
	cFiltro := "% RA_FILIAL BETWEEN '" + cFilialDe + "' AND '" + cFilialAte + "' AND "
	cFiltro += " RA_PROCES IN " + cProcFunc + "  AND "
	cFiltro += " RA_MAT BETWEEN 	'" + MV_PAR08 + "' AND '" + MV_PAR09 + "' AND " 
	cFiltro += " RA_ADMISSA < '"+ cUltDt + "' AND "
	cFiltro += " (RA_DEMISSA = ('"+ Space(8) + " ') OR " 
	cFiltro += " (RA_DEMISSA BETWEEN '"+ cDtIni + "' AND '"+ cDtFim + "') OR RA_DEMISSA >'"+ cDtFim+"' ) "
	cFiltro += " AND RA_SITREV = 42"
	cFiltro += " AND A2_COD = RA_CODPRO"
	cFiltro += " AND A2_LOJA = RA_LOJPRO"
	cFiltro += " AND RA_CODFUNC = RJ_FUNCAO"
	cFiltro += " AND RJ_CARGO = Q3_CARGO "
	
	cFiltroC := cFiltro
	cFiltroC += " AND RC_PROCES = RA_PROCES"
    cFiltroC += " AND RC_FILIAL = RA_FILIAL"
	cFiltroC += " AND RC_MAT = RA_MAT"
	cFiltroC += " AND RC_ROTEIR = '" + mv_par02 + "'"
	cFiltroC += " AND RC_PERIODO = '" + mv_par03 + "'"
	cFiltroC += " AND RC_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "'"
	cFiltroC += " AND SRV.RV_TIPOCOD IN ('1','2')"
	cFiltroC += " AND SRV.RV_REMEVE = 'S'%"
	
	cFiltroD := cFiltro
	cFiltroD += " AND RD_PROCES = RA_PROCES"
    cFiltroD += " AND RD_FILIAL = RA_FILIAL"
	cFiltroD += " AND RD_MAT = RA_MAT"
	cFiltroD += " AND RD_ROTEIR = '" + mv_par02 + "'"
	cFiltroD += " AND RD_PERIODO = '" + mv_par03 + "'"
	cFiltroD += " AND RD_SEMANA BETWEEN '" + mv_par04 + "' AND '"  + mv_par05 + "'"
	cFiltroD += " AND SRV.RV_TIPOCOD IN ('1','2')"
	cFiltroD += " AND SRV.RV_REMEVE = 'S'%"
	
	BeginSql alias cAliasEv 
		SELECT A2_COD, A2_LOJA,A2_CGC, A2_NOME, A2_END, A2_NR_END, A2_BAIRRO, A2_ESTADO, A2_MUN, A2_CEP,
			RA_FILIAL,RA_MAT,RA_NOME,RA_ADMISSA,RA_DEMISSA,RA_CIC, RA_PROCES, RA_NOME, RA_ADMISSA, RA_DEMISSA, 
			RA_CODFUNC, RA_SALARIO,RJ_FUNCAO, RJ_DESC, RJ_CARGO, Q3_CARGO, Q3_DESCSUM,  RC_VALOR RD_VALOR, RC_PD RD_PD
		FROM  %table:SRA% SRA, %table:SRJ% SRJ, %table:SQ3% SQ3, %table:SA2% SA2, %table:SRC% SRC
		Left Join %Table:SRV% SRV On RC_PD = RV_COD
		Where %exp:cFiltroC%
				AND SRA.%notDel%
				AND SA2.%notDel%
				AND SRJ.%notDel%
				AND SQ3.%notDel%
				AND SRC.%notDel%
				AND SRV.%notDel%
		UNION
		SELECT A2_COD, A2_LOJA,A2_CGC, A2_NOME, A2_END, A2_NR_END, A2_BAIRRO, A2_ESTADO, A2_MUN, A2_CEP,
				RA_FILIAL,RA_MAT,RA_NOME,RA_ADMISSA,RA_DEMISSA,RA_CIC, RA_PROCES, RA_NOME, RA_ADMISSA, RA_DEMISSA, 
				RA_CODFUNC, RA_SALARIO,RJ_FUNCAO, RJ_DESC, RJ_CARGO, Q3_CARGO, Q3_DESCSUM, RD_VALOR, RD_PD
		FROM  %table:SRA% SRA, %table:SRJ% SRJ, %table:SQ3% SQ3, %table:SA2% SA2, %table:SRD% SRD
		Left Join %Table:SRV% SRV On RD_PD = RV_COD
		Where %exp:cFiltroD%
				AND SRA.%notDel%
				AND SA2.%notDel%
				AND SRJ.%notDel%
				AND SQ3.%notDel%
				AND SRD.%notDel%
				AND SRV.%notDel%
		ORDER BY %exp:cOrdem%
	EndSql

	dbSelectArea( cAliasEv )
	
	(cAliasEv)->(DbGoTop())
	
	While (cAliasEv)->(!Eof())
		
		If (cAliasEv)->A2_COD  + (cAliasEv)->A2_LOJA <> cCodPro + cLojPro  
			cCodPro := (cAliasEv)->A2_COD 
			cLojPro := (cAliasEv)->A2_LOJA
			
			If Len(aEmp) > 0
				oSection2:Init()
				oSection2:Cell("RA_CIC"):SetValue(aEmp[1][1])
				oSection2:Cell("RA_NOME"):SetValue(aEmp[1][2])
				oSection2:Cell("RJ_DESC"):SetValue(aEmp[1][3])
				oSection2:Cell("Q3_DESCSUM"):SetValue(aEmp[1][4])
				oSection2:Cell("RA_ADMISSA"):SetValue(aEmp[1][5])
				oSection2:Cell("RA_DEMISSA"):SetValue(aEmp[1][6])
				oSection2:Cell("RA_SALARIO"):SetValue(nFacBruta)
				oSection2:Printline()
				oSection2:Finish()
				nFacBruta := 0
				aEmp := {}
			EndIF
			
			oSection1:Init() 
			oSection1:Cell("A2_CGC"):SetValue(AllTrim((cAliasEv)->A2_CGC)) //
			oSection1:Cell("A2_NOME"):SetValue(AllTrim((cAliasEv)->A2_NOME)) //
			oSection1:Cell("A2_END"):SetValue(AllTrim((cAliasEv)->A2_END))//
			oSection1:Cell("A2_NR_END"):SetValue(A2_NR_END)
			oSection1:Cell("A2_BAIRRO"):SetValue(AllTrim((cAliasEv)->A2_BAIRRO))//
			oSection1:Cell("A2_ESTADO"):SetValue(AllTrim((cAliasEv)->A2_ESTADO))//
			oSection1:Cell("A2_MUN"):SetValue(AllTrim((cAliasEv)->A2_MUN))//
			oSection1:Cell("A2_CEP"):SetValue(AllTrim((cAliasEv)->A2_CEP))//
			oSection1:printline()
			oReport:Fatline()
			oSection1:Finish()
			
		EndIF
		
		If (cAliasEv)->A2_COD  + (cAliasEv)->A2_LOJA == cCodPro + cLojPro  .and. (cAliasEv)->RA_FILIAL + (cAliasEv)->RA_MAT <> cFilEmp + cMatEmp 
			cFilEmp := (cAliasEv)->RA_FILIAL
			cMatEmp := (cAliasEv)->RA_MAT
			
			If Len(aEmp) > 0
				oSection2:Init()
				oSection2:Cell("RA_CIC"):SetValue(aEmp[1][1])
				oSection2:Cell("RA_NOME"):SetValue(aEmp[1][2])
				oSection2:Cell("RJ_DESC"):SetValue(aEmp[1][3])
				oSection2:Cell("Q3_DESCSUM"):SetValue(aEmp[1][4])
				oSection2:Cell("RA_ADMISSA"):SetValue(aEmp[1][5])
				oSection2:Cell("RA_DEMISSA"):SetValue(aEmp[1][6])
				oSection2:Cell("RA_SALARIO"):SetValue(nFacBruta)
				oSection2:Printline()
				oSection2:Finish()
				nFacBruta := 0
				aEmp := {}
			Else
				AADD(aEmp,{AllTrim((cAliasEv)->RA_CIC),AllTrim((cAliasEv)->RA_NOME),AllTrim((cAliasEv)->RJ_DESC),AllTrim((cAliasEv)->Q3_DESCSUM),STOD((cAliasEv)->RA_ADMISSA),STOD((cAliasEv)->RA_DEMISSA)})
			EndIf
			
		EndIf
		
		If (cAliasEv)->A2_COD  + (cAliasEv)->A2_LOJA == cCodPro + cLojPro  .and. (cAliasEv)->RA_FILIAL + (cAliasEv)->RA_MAT == cFilEmp + cMatEmp 
			nFacBruta += (cAliasEv)->RD_VALOR
		EndIf 
		
		(cAliasEv)->(DbSkip())
	EndDo
	
	If Len(aEmp) > 0
		oSection2:Init()
		oSection2:Cell("RA_CIC"):SetValue(aEmp[1][1])
		oSection2:Cell("RA_NOME"):SetValue(aEmp[1][2])
		oSection2:Cell("RJ_DESC"):SetValue(aEmp[1][3])
		oSection2:Cell("Q3_DESCSUM"):SetValue(aEmp[1][4])
		oSection2:Cell("RA_ADMISSA"):SetValue(aEmp[1][5])
		oSection2:Cell("RA_DEMISSA"):SetValue(aEmp[1][6])
		oSection2:Cell("RA_SALARIO"):SetValue(nFacBruta)
		oSection2:Printline()
		oSection2:Finish()
		nFacBruta := 0
		aEmp := {}
	EndIF
	(cAliasEv)->(dbCloseArea())
	
Return ( Nil )
