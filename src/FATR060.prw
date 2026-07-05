/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Protheus.CH"
#INCLUDE "REPORT.CH"
#INCLUDE "FATR060.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FATR060     º Autor ³Vendas CRM          º Data ³  07/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³Relatorio de Oportunidades x Proc. Venda                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function FATR060(aParam,lSigaCRM)

Local oReport
Local aFields     := {"A1_NOME","A3_NOME","US_NOME"}
Default lSigaCRM := .F.
Private lFiltroCRM := lSigaCRM

FATPDLoad(Nil, Nil, aFields)

oReport := ReportDef(aParam)
oReport:PrintDialog()

FATPDUnload()
Return

Static Function ReportDef(aParam)

	Local cPerg  := "FATR060"
	Local cAlias := ""
	Local oAC2                //Objeto para armazenar a secao pai
	
   	Local nVend       := TamSX3("AD1_VEND")[1] + TamSX3("A3_NOME")[1]  //Variavel para ajustar tamanho do campo Vendedor
	Local nLoj        := TamSX3("A1_LOJA")[1]							//Variavel para ajustar tamanho do campo Loja
	Local nDescri     := TamSX3("A1_NOME")[1]							//Variavel para ajustar tamanho do campo Descriçao do cliente/prospect
	
	
	cAlias := GetNextAlias()
	
   
	Pergunte(cPerg, .F.)
	
	
	//Relatório
	DEFINE REPORT oReport NAME "FATR060" TITLE STR0001 PARAMETER cPerg ACTION {|oReport| PrintReport(oReport, cPerg, cAlias)} //"Relatorio de Oportunidade x Proc. Venda"
	oReport:SetLandscape() //Escolher o padrão de Impressao como Paisagem 
	 
	 //sessao 1
	 DEFINE SECTION oAC2 OF oReport TITLE STR0002 TABLES "AC2" BREAK HEADER //"Processo de Vendas"
      
      //Celulas secao 1
      DEFINE CELL NAME "Processo"	    OF oAC2 TITLE STR0003 		SIZE 40 BLOCK {|| AC1 ->AC1_PROVEN + " - " + AC1->AC1_DESCRI } //"Processo"
      DEFINE CELL NAME "AC2_STAGE"	    OF oAC2 ALIAS "AC2"         
      DEFINE CELL NAME "AC2_DESCRI"	    OF oAC2 ALIAS "AC2"         
     
     
	//Sessao 2
	  DEFINE SECTION oSession OF oAC2 TITLE STR0004 TABLE "AD1" BREAK HEADER LINE BREAK
	
		//Celulas secao 2
   		DEFINE CELL NAME "AD1_NROPOR"		OF oSession TITLE STR0005 	    BLOCK {|| (cAlias) ->AD1_NROPOR }
		DEFINE CELL NAME "AD1_REVISA"		OF oSession TITLE STR0006	    BLOCK {|| (cAlias) ->AD1_REVISA }
   		DEFINE CELL NAME "AD1_DESCRI"		OF oSession ALIAS "AD1"         
		DEFINE CELL NAME "AD1_DATA"	        OF oSession ALIAS "AD1" 		
		DEFINE CELL NAME "Vendedor"		    OF oSession TITLE STR0007 		SIZE nVend   BLOCK {|| (cAlias) ->AD1_VEND + " - " + FATPDObfuscate(POSICIONE("SA3",1,XFILIAL("SA3") + (cAlias)->AD1_VEND,"A3_NOME"),"A3_NOME")}
		DEFINE CELL NAME "Entidade"		    OF oSession TITLE STR0008 		SIZE 9       BLOCK {|| IIF (!EMPTY((cAlias)->AD1_CODCLI),STR0029,STR0030)}  //"Cliente"#"Prospect"
    	DEFINE CELL NAME "Codigo"		    OF oSession TITLE STR0009 		SIZE 8       BLOCK {|| IIF (!EMPTY((cAlias)->AD1_CODCLI),((cAlias)->AD1_CODCLI),((cAlias)->AD1_PROSPE))}
    	DEFINE CELL NAME "Loja"		        OF oSession TITLE STR0010 		SIZE nLoj    BLOCK {|| IIF (!EMPTY((cAlias)->AD1_CODCLI),((cAlias)->AD1_LOJCLI),((cAlias)->AD1_LOJPRO))}
    	DEFINE CELL NAME "Descricao"		OF oSession TITLE STR0011 		SIZE nDescri BLOCK {|| IIF (!EMPTY((cAlias)->AD1_CODCLI),FATPDObfuscate(POSICIONE("SA1",1,XFILIAL("SA1") + (cAlias)->AD1_CODCLI + (cAlias)->AD1_LOJCLI,"A1_NOME"),"A1_NOME"),FATPDObfuscate(POSICIONE("SUS",1,XFILIAL("SUS") + (cAlias)->AD1_PROSPE + (cAlias)->AD1_LOJPRO,"US_NOME"),"US_NOME"))}
		DEFINE CELL NAME "AD1_CODPRO"	    OF oSession ALIAS "AD1"																	 
		DEFINE CELL NAME "AD1_DESPRO"	    OF oSession ALIAS "AD1" 					 BLOCK {|| POSICIONE("SB1",1,XFILIAL("SB1") + (cAlias)->AD1_CODPRO,"B1_DESC")}
		DEFINE CELL NAME "AD1_VERBA"	    OF oSession ALIAS "AD1"
	
	//Totalizador
	DEFINE FUNCTION FROM oSession:Cell("AD1_NROPOR") OF oSession FUNCTION COUNT TITLE STR0012 //"Oportunidades"		
	DEFINE FUNCTION FROM oSession:Cell("AD1_VERBA") OF oSession FUNCTION SUM TITLE STR0013 //"Verba"
		
	
Return(oReport)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³PrintReportºAutor  ³Vendas CRM         º Data ³  07/01/10   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Selecao dos itens a serem impressos                         º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³FATRXX                                                      º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function PrintReport(oReport, cPerg, cAlias)

Local oSection1 := oReport:Section(1)				// Objeto secao 1 do relatorio
Local oSection2 := oSection1:Section(1)				// Objeto secao 2 do relatorio 
Local cFiltro   := ""      							// String contendo o filtro de busca a ser utilizado com DBF
Local cSQL      := ""                               // String contendo a expressão utilizada na query  
Local bMenos
Local bMais
Local cFilCRM   := ""
Local cOperador := "%" + IIf(Trim(Upper(TcGetDb())) $ "ORACLE,POSTGRES,DB2,INFORMIX","||","+") + "%"

If Type("lFiltroCRM") == "U"
	lFiltroCRM := .F.
EndIf

MakeSqlExp(cPerg)


If !Empty(MV_PAR01)//Data De:
   	cSQL += "AND AD1_DATA >= '" + DToS(MV_PAR01) + "' "
EndIf

If !Empty(MV_PAR02)//Data Até:
	cSQL += "AND AD1_DATA <= '" + DToS(MV_PAR02) + "' "
EndIf

If !Empty(MV_PAR04) //Vendedores
   	cSQL += "AND " + MV_PAR04 + " "
EndIf

If MV_PAR05 == 1
	cSQL  += ""
Else
	If MV_PAR05 <> 5      
		cSQL += "AND AD1_STATUS='" + Str( MV_PAR05 - 1, 1 ) + "'" 
	Else
   		cSQL += "AND AD1_STATUS='9'"
	EndIf                                         
EndIf 

If MV_PAR06 == 1 
	cSQL += ""
Else
	If MV_PAR06 <> 5        
		cSQL   += "AND AD1_STATUS<>'" + Str( MV_PAR06 - 1, 1 ) + "'" 
	Else 		
		cSQL   += "AND AD1_STATUS<>'9'"
	EndIf
EndIf


If !Empty(MV_PAR07) //Moeda padrao
   	cSQL += "AND AD1_MOEDA = " + Str(MV_PAR07) + " "
EndIf

If lFiltroCRM
	cFilCRM := CRMXFilEnt( "AD1", .T. ) 
	If !Empty(cFilCRM)
		cSQL += " AND ( "+ cFilCRM + "  OR AD2_VEND = '"+ CRMXRetVend() +"' ) "
	EndIf
EndIf
 
cSQL := "%"+cSQL+"%" 

BEGIN REPORT QUERY oSection1
	
	If !Empty(cFilCRM)
	
		BeginSql Alias cAlias
			SELECT DISTINCT AD1_STAGE,AD1_PROVEN,AD1_NROPOR,AD1_REVISA,AD1_DESCRI,AD1_DATA,AD1_VEND,AD1_CODCLI,AD1_LOJCLI,
			       AD1_VERBA,AD1_CODPRO,AD1_LOJPRO,AD1_PROSPE,AC2_DESCRI,AC2_STAGE
			FROM %Table:AD1% AD1, %Table:AC2% AC2, %Table:AD2% AD2,%Table:AO4% AO4
			WHERE AD1_FILIAL = %XFILIAL:AD1% 
			  AND (AD1.AD1_FILIAL %Exp:cOperador% AD1.AD1_NROPOR) = AO4.AO4_CHVREG
			  AND AC2_FILIAL = %XFILIAL:AC2%
			  AND AD2_FILIAL = %XFILIAL:AD2% 
			  AND AC2_STAGE  = AD1_STAGE
			  AND AC2_PROVEN = AD1_PROVEN
		      AND AC2_PROVEN = %Exp:MV_PAR03% 
		      AND AD2_NROPOR = AD1_NROPOR
			  AND AD2_HISTOR = '2' 
			  AND AD2_REVISA = AD1_REVISA 
			  AND AD1.%NotDel% %Exp:cSQL% 
			ORDER BY AC2_STAGE 
		EndSql
		
	Else
		
		BeginSql Alias cAlias
			SELECT AD1_STAGE,AD1_PROVEN,AD1_NROPOR,AD1_REVISA,AD1_DESCRI,AD1_DATA,AD1_VEND,AD1_CODCLI,AD1_LOJCLI,
			       AD1_VERBA,AD1_CODPRO,AD1_LOJPRO,AD1_PROSPE,AC2_DESCRI,AC2_STAGE
			FROM %Table:AD1% AD1, %Table:AC2% AC2
			WHERE AD1_FILIAL = %XFILIAL:AD1% AND AC2_FILIAL= %XFILIAL:AC2% 
			AND AC2_STAGE = AD1_STAGE 
			AND AC2_PROVEN = AD1_PROVEN
			AND AC2_PROVEN = %Exp:MV_PAR03% 
			AND AD1.%NotDel% %Exp:cSQL% 
			ORDER BY AC2_STAGE
		EndSql	
	
	EndIf

END REPORT QUERY oSection1 

TRPosition():New(oSection1,"AC1",1,{|| xFilial("AC1")+(cAlias)->AD1_PROVEN})

oSection2:SetParentQuery()
oSection2:SetParentFilter({|cStage| (cAlias)->AC2_STAGE == cStage},{|| (cAlias)->AD1_STAGE })
oSection1:Print()
 	
Return Nil  




//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDLoad
    @description
    Inicializa variaveis com lista de campos que devem ser ofuscados de acordo com usuario.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cUser, Caractere, Nome do usuário utilizado para validar se possui acesso ao 
        dados protegido.
    @param aAlias, Array, Array com todos os Alias que serão verificados.
    @param aFields, Array, Array com todos os Campos que serão verificados, utilizado 
        apenas se parametro aAlias estiver vazio.
    @param cSource, Caractere, Nome do recurso para gerenciar os dados protegidos.
    
    @return cSource, Caractere, Retorna nome do recurso que foi adicionado na pilha.
    @example FATPDLoad("ADMIN", {"SA1","SU5"}, {"A1_CGC"})
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDLoad(cUser, aAlias, aFields, cSource)
	Local cPDSource := ""

	If FATPDActive()
		cPDSource := FTPDLoad(cUser, aAlias, aFields, cSource)
	EndIf

Return cPDSource


//-----------------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUnload
    @description
    Finaliza o gerenciamento dos campos com proteção de dados.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @author Squad CRM & Faturamento
    @since  05/12/2019
    @version P12.1.27
    @param cSource, Caractere, Remove da pilha apenas o recurso que foi carregado.
    @return return, Nulo
    @example FATPDUnload("XXXA010") 
/*/
//-----------------------------------------------------------------------------------
Static Function FATPDUnload(cSource)    

    If FATPDActive()
		FTPDUnload(cSource)    
    EndIf

Return Nil

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDObfuscate
    @description
    Realiza ofuscamento de uma variavel ou de um campo protegido.
	Remover essa função quando não houver releases menor que 12.1.27

    @type  Function
    @sample FATPDObfuscate("999999999","U5_CEL")
    @author Squad CRM & Faturamento
    @since 04/12/2019
    @version P12
    @param xValue, (caracter,numerico,data), Valor que sera ofuscado.
    @param cField, caracter , Campo que sera verificado.
    @param cSource, Caractere, Nome do recurso que buscar dados protegidos.
    @param lLoad, Logico, Efetua a carga automatica do campo informado

    @return xValue, retorna o valor ofuscado.
/*/
//-----------------------------------------------------------------------------
Static Function FATPDObfuscate(xValue, cField, cSource, lLoad)
    
    If FATPDActive()
		xValue := FTPDObfuscate(xValue, cField, cSource, lLoad)
    EndIf

Return xValue   




//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    Função que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
