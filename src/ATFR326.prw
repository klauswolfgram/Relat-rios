/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "atfr326.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "RwMake.ch"
#INCLUDE "DBINFO.CH"
/*PACOTE FNC 00000030092010*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATFR326  บ Autor ณ Felipe C. Seolin   บ Data ณ  23/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Demonstrativo de Bens em Terceiros			              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR326				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR326()
Local clPerg		:= "AFR326"
Local olReport		:= Nil 
Local lTReport	:= TRepInUse()
Private apSelFil	:= {}
Private apSelMoed	:= {}
Private lpTodasFil	:= .F.


If !lTReport
	Help("  ",1,"AFR326R4",,STR0002,1,0)  //"Fun็ใo disponํvel apenas para TReport"
	Return
ENdIf

If Pergunte(clPerg,.T.)
	While !ATF326Vld()
		If !Pergunte(clPerg,.T.)
			Return()
		EndIf
	EndDo
	olReport := ATF026Def(clPerg)
	olReport:PrintDialog()
EndIf


Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF026Defบ Autor ณ Felipe C. Seolin   บ Data ณ  23/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Estrutura de Demonstrativo de Bens em Terceiros			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR326				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF026Def(clPerg)
Local olReport		:= Nil
Local olSecBem		:= Nil
Local olSecValor	:= Nil
Local olDadosBem	:= Nil
Local olTxtEnt		:= Nil
Local olTotEnt		:= Nil
Local olTxtFil		:= Nil
Local olTotFil		:= Nil
Local olTxtGer		:= Nil
Local olTotGeral	:= Nil
Local clNomeProg	:= "ATFR326"  
Local clTitle		:= STR0003  //"Demonstrativo de Bens em Terceiros"
Local clDesc		:= STR0003  //"Demonstrativo de Bens em Terceiros"
Local alOrd			:= {OemToAnsi(STR0004),OemToAnsi(STR0005),OemToAnsi(STR0006)}  //"Codigo"###"Grupo"###"Data Aquisicao"

olReport := TReport():New(clNomeProg,clTitle,clPerg,{|olReport| ATF026Prt(olReport)},clDesc)

olSecBem := TRSection():New(olReport,STR0007,,alOrd)  //"Dados da Entidade"
TRCell():New(olSecBem,"N3_FILIAL"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_CBASE"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_ITEM"		,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_TIPO"		,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_TIPODESC"	,""		,STR0008,						,30	)  //"Descri็ใo Tipo"
TRCell():New(olSecBem,"N1_PATRIM"	,"SN1"	,		,								,15	)
TRCell():New(olSecBem,"N1_DESCRIC"	,"SN1"	,		,								,35	)
TRCell():New(olSecBem,"N1_AQUISIC"	,"SN1"	,		,								,	)
TRCell():New(olSecBem,"N1_BAIXA"	,"SN1"	,		,								,	)
TRCell():New(olSecBem,"N1_QUANTD"	,"SN1"	,		,PesqPict("SN1","N1_QUANTD",11)	,11	)
TRCell():New(olSecBem,"N1_CHAPA"	,"SN1"	,		,								,	)
TRCell():New(olSecBem,"N3_CCONTAB"	,"SN3"	,		,								,25	)
TRCell():New(olSecBem,"N3_CUSTBEM"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_SUBCCON"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_CLVLCON"	,"SN3"	,		,								,	)
olSecBem:SetHeaderPage(.T.)

olSecValor := TRSection():New(olSecBem,STR0009)  //"Valores"
TRCell():New(olSecValor,"SIMBMOEDA"		,""		,STR0010,""									,5	)  //"Moeda"
TRCell():New(olSecValor,"N3_VORIG1"		,""		,STR0011,							,	)  //"Valor Original"
TRCell():New(olSecValor,"N3_AMPLIA1"	,"SN3"	,STR0012,							,	)  //"Valor Amplia็ใo"
TRCell():New(olSecValor,"VLATUALIZADO"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olSecValor,"N3_VRDACM1"	,""		,STR0014,									,19	)  //"Deprec. Acumulada"
TRCell():New(olSecValor,"VLRESIDUAL"	,""		,STR0015,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Residual"
TRCell():New(olSecValor,"N3_VRCDA1"		,"SN3"	,		,									,17	)
TRCell():New(olSecValor,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olSecValor:SetHeaderPage(.T.)
olSecValor:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olSecValor:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olDadosBem := TRSection():New(olSecBem,STR0016)  //"Dados"
TRCell():New(olDadosBem,"NP_SEQ"	,"SNP")  //"Sequ๊ncia da Vig๊ncia"
TRCell():New(olDadosBem,"NP_VIGINI"	,"SNP")  //"Data Inicial da Vig๊ncia"
TRCell():New(olDadosBem,"NP_VIGFIM"	,"SNP")  //"Data Final da Vig๊ncia"
TRCell():New(olDadosBem,"NP_FORNEC"	,"SNP")  //"Codigo do Fornecedor"
TRCell():New(olDadosBem,"NP_LOJA"	,"SNP")  //"Codigo do Fornecedor"
TRCell():New(olDadosBem,"A1_NREDUZ"	,"SA1")  //"Nome do Detentor do Bem"
TRCell():New(olDadosBem,"NP_CONTATO","SNP")  //"Nome do Contato"
TRCell():New(olDadosBem,"NP_STATUS"	,"SNP")  //"Status da Vig๊ncia do Bem"
olDadosBem:SetHeaderPage(.T.)

olTxtEnt := TRSection():New(olReport,STR0017)  //"Texto Total por Entidade Contแbil"
TRCell():New(olTxtEnt,"TEXTO"		,"",STR0018,"",70)  //"Total Geral"
TRCell():New(olTxtEnt,STR0019	,"",STR0019,"",20)  //"QUANTIDADE"###"Quantidade"
olTxtEnt:SetHeaderSection(.F.)
olTxtEnt:SetLeftMargin(7)

olTotEnt := TRSection():New(olReport,STR0020)  //"Valores do Total por Entidade Contแbil"
TRCell():New(olTotEnt,"SIMBMOEDA"	,""		,"Moeda",""									,5	) 
TRCell():New(olTotEnt,"N3_VORIG1"	,""		,STR0011,							,	)  //"Valor Original"
TRCell():New(olTotEnt,"N3_AMPLIA1"	,"SN3"	,STR0012,							,	)  //"Valor Amplia็ใo"
TRCell():New(olTotEnt,"VLATUALIZADO",""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotEnt,"N3_VRDACM1"	,""		,STR0014,									,19	)  //"Deprec. Acumulada"
TRCell():New(olTotEnt,"VLRESIDUAL"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotEnt,"N3_VRCDA1"	,"SN3"	,		,									,17	)
TRCell():New(olTotEnt,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olTotEnt:SetHeaderSection(.F.)
olTotEnt:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olTotEnt:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olTxtFil := TRSection():New(olReport,STR0021)  //"Texto Total por Filial"
TRCell():New(olTxtFil,"TEXTO"		,"",STR0018,"",70)  //"Total Geral"
TRCell():New(olTxtFil,STR0019	,"",STR0019,"",20)  //"QUANTIDADE"###"Quantidade"
olTxtFil:SetHeaderSection(.F.)
olTxtFil:SetLeftMargin(7)

olTotFil := TRSection():New(olReport,STR0022)  //"Valores do Total por Filial"
TRCell():New(olTotFil,"SIMBMOEDA"	,""		,STR0010,""									,5	)  //"Moeda"
TRCell():New(olTotFil,"N3_VORIG1"	,""		,STR0011,							,	)  //"Valor Original"
TRCell():New(olTotFil,"N3_AMPLIA1"	,"SN3"	,STR0012,							,	)  //"Valor Amplia็ใo"
TRCell():New(olTotFil,"VLATUALIZADO",""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotFil,"N3_VRDACM1"	,""		,STR0014,									,19	)  //"Deprec. Acumulada"
TRCell():New(olTotFil,"VLRESIDUAL"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotFil,"N3_VRCDA1"	,"SN3"	,		,									,17	)
TRCell():New(olTotFil,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olTotFil:SetHeaderSection(.F.)
olTotFil:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olTotFil:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olTxtGer := TRSection():New(olReport,STR0023)  //"Texto Total Geral"
TRCell():New(olTxtGer,"TEXTO"		,"",STR0018,"",70)  //"Total Geral"
TRCell():New(olTxtGer,STR0019	,"",STR0019,"",20)  //"QUANTIDADE"###"Quantidade"
olTxtGer:SetHeaderSection(.F.)
olTxtGer:SetLeftMargin(7)

olTotGeral := TRSection():New(olReport,STR0024)  //"Valores do Total Geral"
TRCell():New(olTotGeral,"SIMBMOEDA"		,""		,STR0010,""									,5	)  //"Moeda"
TRCell():New(olTotGeral,"N3_VORIG1"		,""		,"Valor Original",							,	) 
TRCell():New(olTotGeral,"N3_AMPLIA1"	,"SN3"	,STR0012,							,	)  //"Valor Amplia็ใo"
TRCell():New(olTotGeral,"VLATUALIZADO"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotGeral,"N3_VRDACM1"	,""		,STR0014,									,19	)  //"Deprec. Acumulada"
TRCell():New(olTotGeral,"VLRESIDUAL"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	)  //"Valor Atualizado"
TRCell():New(olTotGeral,"N3_VRCDA1"		,"SN3"	,		,									,17	)
TRCell():New(olTotGeral,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olTotGeral:SetHeaderSection(.F.)
olTotGeral:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olTotGeral:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olReport:SetLandScape()
olReport:DisableOrientation()
olReport:ParamReadOnly() 

Return olReport
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF026Prtบ Autor ณ Felipe C. Seolin   บ Data ณ  24/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressใo de Demonstrativo de Bens em Terceiros            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR326				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF026Prt(olReport)
Local olSecBem		:= olReport:Section(1)
Local olSecValor	:= olReport:Section(1):Section(1)
Local olDadosBem	:= olReport:Section(1):Section(2)
Local olTxtEnt		:= olReport:Section(2)
Local olTotEnt		:= olReport:Section(3)
Local olTxtFil		:= olReport:Section(4)
Local olTotFil		:= olReport:Section(5)
Local olTxtGer		:= olReport:Section(6)
Local olTotGeral	:= olReport:Section(7)
Local olMeter		:= Nil
Local olText		:= Nil
Local olDlg			:= Nil
Local clQuery		:= ""
Local clCod			:= ""
Local clMoeda		:= ""
Local nlI			:= 0
Local llEnd
Local clBemIni		:= MV_PAR01
Local clBemFim		:= MV_PAR02
Local clItemIni  	:= MV_PAR03
Local clItemFim  	:= MV_PAR04
Local clGrupoIni	:= MV_PAR05
Local clGrupoFim	:= MV_PAR06
Local dlAquIni		:= MV_PAR09
Local dlAquFim   	:= MV_PAR10
Local nlStatus		:= MV_PAR13
Local nlPagIni 		:= MV_PAR15
Local nlPagFim		:= MV_PAR16
Local nlPagRes		:= MV_PAR17
Local clChave		:= ""
Local clWhrSql		:= ""
Local nlTipoEnt		:= olSecBem:GetOrder()
Local clAliasTRB 	:= GetNextAlias()
Local alTotEnt		:= {}
Local alTotFil		:= {}
Local alTotGeral	:= {}
Local dDataSLD		:= IIF(Empty(MV_PAR19),dDataBase,MV_PAR19)
Local cBaixa		:= cValToChar(MV_PAR11)
Local cArqAux		:= ""

apSelMoed := Iif(Empty(apSelMoed),{"01"},apSelMoed)
apSelFil  := Iif(Empty(apSelFil ),{cFilAnt},apSelFil )

olSecValor:Cell("SIMBMOEDA"):SetTitle("")
olTotGeral:Cell("SIMBMOEDA"):SetTitle("")

If nlTipoEnt == 1
	clChave := "FILIAL + CBASE + ITEM"
ElseIf nlTipoEnt == 2
	clChave := "FILIAL + GRUPO + CBASE + ITEM"
ElseIf nlTipoEnt == 3
	clChave := "FILIAL + AQUISIC + CBASE + ITEM"
EndIf

olReport:SetPageNumber(nlPagIni)
olReport:OnPageBreak({||If((nlPagIni + 1) > nlPagFim,(nlPagIni := nlPagRes,olReport:SetPageNumber(nlPagIni - 1)),nlPagIni += 1)})

If !Empty(MV_PAR08)
	clWhrSql += " AND		N1_FORNEC >= '" + MV_PAR07 + "' "
	clWhrSql += " AND		N1_FORNEC <= '" + MV_PAR08 + "' "
EndIf
clWhrSql += " AND N1_TPCTRAT = '3' "

If MV_PAR12 == 2
	olSecValor:Cell("SIMBMOEDA"):Disable()
	olSecValor:Cell("N3_VORIG1"):Disable()
	olSecValor:Cell("N3_AMPLIA1"):Disable()
	olSecValor:Cell("VLATUALIZADO"):Disable()
	olSecValor:Cell("N3_VRDACM1"):Disable()
	olSecValor:Cell("VLRESIDUAL"):Disable()
	olSecValor:Cell("N3_VRCDA1"):Disable()
	olSecValor:Cell("N3_VRCACM1"):Disable()
EndIf

MsgMeter({|olMeter,olText,olDlg,llEnd | ;
ATFGERSLDM(olMeter,olText,olDlg,llEnd,clAliasTRB,dlAquIni,dlAquFim,dDataSLD,clBemIni,clBemFim,clItemIni,clItemFim,/*cContaIni*/,/*cContaFim*/,;
/*cCCIni*/,/*cCCFim*/,/*cItCtbIni*/,/*cItCtbFim*/,/*cClvlIni*/,/*cClVlFim*/,clGrupoIni,clGrupoFim,apSelMoed,apSelFil,lpTodasFil,clChave,.T.,, clWhrSql,cBaixa,  )},;
OemToAnsi(OemToAnsi(STR0025)),OemToAnsi(STR0026))  //"Criando Arquivo Temporแrio..."###"Posicao Valorizada dos Bens na Data"

(clAliasTRB)->(DBGoTop())
While (clAliasTRB)->(!EOF()) .and. !olReport:Cancel()
	clFilial := (clAliasTRB)->FILIAL
	clCond1 := clAliasTRB + "->(FILIAL) == clFilial"
	While (clAliasTRB)->(!EOF()) .and. &clCond1 .and. !olReport:Cancel()
		If nlTipoEnt == 1
			clEntidade := (clAliasTRB)->(FILIAL + CBASE)
			clCond2 := clAliasTRB + "->(FILIAL + CBASE) == clEntidade"
		ElseIf nlTipoEnt == 2
			clEntidade := (clAliasTRB)->(FILIAL + GRUPO)
			clCond2 := clAliasTRB + "->(FILIAL + GRUPO) == clEntidade"
		ElseIf nlTipoEnt == 3
			clEntidade := (clAliasTRB)->(FILIAL + dtos(AQUISIC))
			clCond2 := clAliasTRB + "->(FILIAL + dtos(AQUISIC)) == clEntidade"
		EndIf
		While (clAliasTRB)->(!EOF()) .and. &clCond2 .and. !olReport:Cancel()
			alSNP := {}
			alSNP := ATF026SNP((clAliasTRB)->FILIAL,(clAliasTRB)->CBASE,(clAliasTRB)->ITEM,nlStatus)
			If Empty(alSNP)
				(clAliasTRB)->(DBSkip())
				Loop
			EndIf
			olSecBem:Init()
			olSecBem:Cell("N3_FILIAL"):SetBlock({||(clAliasTRB)->FILIAL})
			olSecBem:Cell("N3_CBASE"):SetBlock({||(clAliasTRB)->CBASE})
			olSecBem:Cell("N3_ITEM"):SetBlock({||(clAliasTRB)->ITEM})
			olSecBem:Cell("N3_TIPO"):SetBlock({||(clAliasTRB)->TIPO})
			SX5->(MsSeek(xFilial("SX5") + "G1"+ (clAliasTRB)->TIPO))
			olSecBem:Cell("N3_TIPODESC"):SetBlock({||X5Descri()})
			olSecBem:Cell("N1_PATRIM"):SetBlock({||X3Combo("N1_PATRIM",(clAliasTRB)->CLASSIF)})
			olSecBem:Cell("N1_DESCRIC"):SetBlock({||SubStr((clAliasTRB)->DESC_SINT,1,35)})
			olSecBem:Cell("N1_AQUISIC"):SetBlock({||(clAliasTRB)->AQUISIC})
			olSecBem:Cell("N1_BAIXA"):SetBlock({||(clAliasTRB)->DTBAIXA})
			olSecBem:Cell("N1_QUANTD"):SetBlock({||(clAliasTRB)->QUANTD})
			olSecBem:Cell("N1_CHAPA"):SetBlock({||(clAliasTRB)->CHAPA})
			olSecBem:Cell("N3_CCONTAB"):SetBlock({||(clAliasTRB)->CONTA})
			olSecBem:Cell("N3_CUSTBEM"):SetBlock({||(clAliasTRB)->CCUSTO})
			olSecBem:Cell("N3_SUBCCON"):SetBlock({||(clAliasTRB)->SUBCTA})
			olSecBem:Cell("N3_CLVLCON"):SetBlock({||(clAliasTRB)->CLVL})
			olSecBem:PrintLine()
			olSecBem:Finish()
			
			clLoopMoed := (clAliasTRB)->(FILIAL + CBASE + ITEM)
			clCond3 := clAliasTRB + "->(FILIAL + CBASE + ITEM) == clLoopMoed"
			
			olSecValor:Init()
			While (clAliasTRB)->(!EOF()) .and. &clCond3 .and. !olReport:Cancel()
				olSecValor:Cell("SIMBMOEDA"):SetBlock({||SuperGetMV("MV_SIMB" + SubStr((clAliasTRB)->MOEDA,2,1))})
				olSecValor:Cell("N3_VORIG1"):SetBlock({||(clAliasTRB)->ORIGINAL})
				olSecValor:Cell("N3_AMPLIA1"):SetBlock({||(clAliasTRB)->AMPLIACAO})
				olSecValor:Cell("VLATUALIZADO"):SetBlock({||(clAliasTRB)->ATUALIZ})
				olSecValor:Cell("N3_VRDACM1"):SetBlock({||(clAliasTRB)->DEPRECACM})
				olSecValor:Cell("VLRESIDUAL"):SetBlock({||(clAliasTRB)->RESIDUAL})
				olSecValor:Cell("N3_VRCDA1"):SetBlock({||(clAliasTRB)->CORRECACM})
				olSecValor:Cell("N3_VRCACM1"):SetBlock({||(clAliasTRB)->CORDEPACM})
				olSecValor:PrintLine()
				//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ฟ
				//ณSoma os totais da quebraณ
				//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤ$ู
				nlPos := aScan(alTotEnt,{|x| AllTrim(x[1]) == Alltrim((clAliasTRB)->MOEDA)})
				If nlPos == 0
					aAdd(alTotEnt,{"",0,0,0,0,0,0,0})
					nlPos := Len(alTotEnt)
					alTotEnt[nlPos][1] := (clAliasTRB)->MOEDA
				EndIf
				alTotEnt[nlPos][2] += (clAliasTRB)->ORIGINAL
				alTotEnt[nlPos][3] += (clAliasTRB)->AMPLIACAO
				alTotEnt[nlPos][4] += (clAliasTRB)->ATUALIZ
				alTotEnt[nlPos][5] += (clAliasTRB)->DEPRECACM
				alTotEnt[nlPos][6] += (clAliasTRB)->RESIDUAL
				alTotEnt[nlPos][7] += (clAliasTRB)->CORRECACM
				alTotEnt[nlPos][8] += (clAliasTRB)->CORDEPACM
				
				nlPos := aScan(alTotFil,{|x| AllTrim(x[1]) == Alltrim((clAliasTRB)->MOEDA)})
				If nlPos == 0
					aAdd(alTotFil,{"",0,0,0,0,0,0,0})
					nlPos := Len(alTotFil)
					alTotFil[nlPos][1] := (clAliasTRB)->MOEDA
				EndIf
				alTotFil[nlPos][2] += (clAliasTRB)->ORIGINAL
				alTotFil[nlPos][3] += (clAliasTRB)->AMPLIACAO
				alTotFil[nlPos][4] += (clAliasTRB)->ATUALIZ
				alTotFil[nlPos][5] += (clAliasTRB)->DEPRECACM
				alTotFil[nlPos][6] += (clAliasTRB)->RESIDUAL
				alTotFil[nlPos][7] += (clAliasTRB)->CORRECACM
				alTotFil[nlPos][8] += (clAliasTRB)->CORDEPACM
				
				nlPos := aScan(alTotGeral,{|x| AllTrim(x[1]) == Alltrim((clAliasTRB)->MOEDA)})
				If nlPos == 0
					aAdd(alTotGeral,{"",0,0,0,0,0,0,0})
					nlPos := Len(alTotGeral)
					alTotGeral[nlPos][1] := (clAliasTRB)->MOEDA
				EndIf
				alTotGeral[nlPos][2] += (clAliasTRB)->ORIGINAL
				alTotGeral[nlPos][3] += (clAliasTRB)->AMPLIACAO
				alTotGeral[nlPos][4] += (clAliasTRB)->ATUALIZ
				alTotGeral[nlPos][5] += (clAliasTRB)->DEPRECACM
				alTotGeral[nlPos][6] += (clAliasTRB)->RESIDUAL
				alTotGeral[nlPos][7] += (clAliasTRB)->CORRECACM
				alTotGeral[nlPos][8] += (clAliasTRB)->CORDEPACM
				(clAliasTRB)->(DBSkip())
			EndDo
			olSecValor:Finish()
			If Len(alSNP) > 0
				olDadosBem:Init()
				For nlI := 1 to Len(alSNP)
					olDadosBem:Cell("NP_SEQ"):SetBlock({||alSNP[nlI][1]})
					olDadosBem:Cell("NP_VIGINI"):SetBlock({||alSNP[nlI][2]})
					olDadosBem:Cell("NP_VIGFIM"):SetBlock({||alSNP[nlI][3]})
					olDadosBem:Cell("NP_FORNEC"):SetBlock({||alSNP[nlI][4]})
					olDadosBem:Cell("NP_LOJA"):SetBlock({||alSNP[nlI][8]})
					olDadosBem:Cell("A1_NREDUZ"):SetBlock({||alSNP[nlI][5]})
					olDadosBem:Cell("NP_CONTATO"):SetBlock({||alSNP[nlI][6]})
					olDadosBem:Cell("NP_STATUS"):SetBlock({||X3Combo("NP_STATUS",alSNP[nlI][7])})
					olDadosBem:PrintLine()
				Next nlI
			EndIf
			olDadosBem:Finish()
		EndDo
		olTxtEnt:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0027)})  //"* * *   T O T A L   P O R   E N T I D A D E   * * *"
		olTxtEnt:Cell(STR0019):SetBlock({||OemToAnsi(STR0019)/* + Str(nTotal,7,0)*/})  //"QUANTIDADE"###"QUANTIDADE"
		olTxtEnt:Init()
		olTxtEnt:PrintLine()
		olTotEnt:Init()
		For nlI := 1 to Len(alTotEnt)
			clMoeda := alTotEnt[nlI][1]
			clSuf := CValtoChar(Val(clMoeda))
			olTotEnt:Cell("SIMBMOEDA"):SetBlock({||SuperGetMV("MV_SIMB" + clSuf)})
			olTotEnt:Cell("N3_VORIG1"):SetBlock({||alTotEnt[nlI][2]})
			olTotEnt:Cell("N3_AMPLIA1"):SetBlock({||alTotEnt[nlI][3]})
			olTotEnt:Cell("VLATUALIZADO"):SetBlock({||alTotEnt[nlI][4]})
			olTotEnt:Cell("N3_VRDACM1"):SetBlock({||alTotEnt[nlI][5]})
			olTotEnt:Cell("VLRESIDUAL"):SetBlock({||alTotEnt[nlI][6]})
			olTotEnt:Cell("N3_VRCDA1"):SetBlock({||alTotEnt[nlI][7]})
			olTotEnt:Cell("N3_VRCACM1"):SetBlock({||alTotEnt[nlI][8]})
			olTotEnt:PrintLine()
		Next nlI
		olTotEnt:Finish()
		olTxtEnt:Finish()
		alTotEnt := {}
	EndDo
	olTxtFil:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0028)})  //"* * *   T O T A L   P O R   F I L I A L   * * *"
	olTxtFil:Cell(STR0019):SetBlock({||OemToAnsi(STR0019)/* + Str(nTotal,7,0)*/})  //"QUANTIDADE"###"QUANTIDADE"
	olTxtFil:Init()
	olTxtFil:PrintLine()
	olTotFil:Init()
	For nlI := 1 to Len(alTotFil)
		clMoeda := alTotFil[nlI][1]
		clSuf := CValtoChar(Val(clMoeda))
		olTotFil:Cell("SIMBMOEDA"):SetBlock({||SuperGetMV("MV_SIMB" + clSuf)})
		olTotFil:Cell("N3_VORIG1"):SetBlock({||alTotFil[nlI][2]})
		olTotFil:Cell("N3_AMPLIA1"):SetBlock({||alTotFil[nlI][3]})
		olTotFil:Cell("VLATUALIZADO"):SetBlock({||alTotFil[nlI][4]})
		olTotFil:Cell("N3_VRDACM1"):SetBlock({||alTotFil[nlI][5]})
		olTotFil:Cell("VLRESIDUAL"):SetBlock({||alTotFil[nlI][6]})
		olTotFil:Cell("N3_VRCDA1"):SetBlock({||alTotFil[nlI][7]})
		olTotFil:Cell("N3_VRCACM1"):SetBlock({||alTotFil[nlI][8]})
		olTotFil:PrintLine()
	Next nlI
	olTotFil:Finish()
	olTxtFil:Finish()
	alTotFil := {}
EndDo

If Len(alTotGeral) > 0
	olTxtGer:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0029)})  //"* * *   T O T A L   G E R A L   * * *"
	olTxtGer:Cell(STR0019):SetBlock({||OemToAnsi(STR0019)/* + Str(nTotal,7,0)*/})  //"QUANTIDADE"###"QUANTIDADE"
	olTxtGer:Init()
	olTxtGer:PrintLine()
	olTotGeral:Init()
	For nlI := 1 to Len(alTotGeral)
		clMoeda := alTotGeral[nlI][1]
		clSuf := CValtoChar(Val(clMoeda))
		olTotGeral:Cell("SIMBMOEDA"):SetBlock({||SuperGetMV("MV_SIMB" + clSuf)})
		olTotGeral:Cell("N3_VORIG1"):SetBlock({||alTotGeral[nlI][2]})
		olTotGeral:Cell("N3_AMPLIA1"):SetBlock({||alTotGeral[nlI][3]})
		olTotGeral:Cell("VLATUALIZADO"):SetBlock({||alTotGeral[nlI][4]})
		olTotGeral:Cell("N3_VRDACM1"):SetBlock({||alTotGeral[nlI][5]})
		olTotGeral:Cell("VLRESIDUAL"):SetBlock({||alTotGeral[nlI][6]})
		olTotGeral:Cell("N3_VRCDA1"):SetBlock({||alTotGeral[nlI][7]})
		olTotGeral:Cell("N3_VRCACM1"):SetBlock({||alTotGeral[nlI][8]})
		olTotGeral:PrintLine()
	Next nlI
	alTotGeral := {}
	olTotGeral:Finish()
	olTxtGer:Finish()
EndIf

If Select(clAliasTRB) > 0
	dbSelectArea(clAliasTRB)
	cArqAux := (clAliasTRB)->(dbInfo(DBI_FULLPATH))
	cArqAux := AllTrim(Substr(cArqAux,RAT("\",cArqAux)+1))
	DbCloseArea()
	MsErase(cArqAux)
EndIf

Return()
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF026SNPบ Autor ณ Felipe C. Seolin   บ Data ณ  25/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Busca dados da vig๊ncia de Bens em Terceiros	              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR326				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF026SNP(clFilial,clCodBase,clItem,nlStatus)
Local alDados	:= {}
Local clQuery	:= ""
Local clAlsTRB	:= "TRBDAD"
Local nlPos		:= 0

clQuery	:= "SELECT	NP_SEQ  "
clQuery	+= "		,NP_VIGINI  "
clQuery	+= "		,NP_VIGFIM  "
clQuery	+= "		,NP_FORNEC  "
clQuery	+= "		,A1_NREDUZ  "
clQuery	+= "		,NP_CONTATO  "
clQuery	+= "		,NP_STATUS  "
clQuery	+= "		,NP_LOJA  "
clQuery	+= "FROM " + RetSqlName("SNP") + " SNP "

clQuery	+= "INNER JOIN " + RetSqlName("SA1") + " SA1 "
clQuery	+= "ON	A1_FILIAL = '" + xFilial("SA1",clFilial) + "' "
clQuery	+= "AND	SA1.D_E_L_E_T_ <> '*' "
clQuery	+= "AND	A1_COD = NP_FORNEC "
clQuery	+= "AND	A1_LOJA = NP_LOJA  "

clQuery	+= "WHERE	NP_FILIAL = '" + clFilial + "' "
clQuery	+= "AND		SNP.D_E_L_E_T_ <> '*' "
clQuery	+= "AND		NP_CBASE = '" + clCodBase + "' "
clQuery	+= "AND		NP_ITEM = '" + clItem + "' "
If nlStatus == 1
	clQuery	+= "AND		NP_STATUS = '1' "
EndIf

clQuery := ChangeQuery(clQuery)
DBUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery),clAlsTRB,.T.,.F.)

While (clAlsTRB)->(!EOF())
	aAdd(alDados,{"",STOD(""),STOD(""),"","","","",""})
	nlPos := Len(alDados)
	alDados[nlPos][1] := (clAlsTRB)->NP_SEQ
	alDados[nlPos][2] := STOD((clAlsTRB)->NP_VIGINI)
	alDados[nlPos][3] := STOD((clAlsTRB)->NP_VIGFIM)
	alDados[nlPos][4] := (clAlsTRB)->NP_FORNEC
	alDados[nlPos][5] := (clAlsTRB)->A1_NREDUZ
	alDados[nlPos][6] := (clAlsTRB)->NP_CONTATO
	alDados[nlPos][7] := (clAlsTRB)->NP_STATUS
	alDados[nlPos][8] := (clAlsTRB)->NP_LOJA
	(clAlsTRB)->(DBSkip())
EndDo

(clAlsTRB)->(DBCloseArea())
Return alDados

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF326Vldบ Autor ณ Felipe C. Seolin   บ Data ณ  29/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida perguntas de parโmetro				              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR326				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF326Vld()

If MV_PAR02 < MV_PAR01
	Help(" ",1,"ATFR326COD",,STR0128,1,0)  //"Digite C๓digo do Bem vแlido"
	Return .F.
EndIf

If MV_PAR04 < MV_PAR03
	Help(" ",1,"ATFR326ITE",,STR0129,1,0)  //"Digite Item do Bem vแlido"
	Return .F.
EndIf

If MV_PAR06 < MV_PAR05
	Help(" ",1,"ATFR326GRU",,STR0130,1,0)  //"Digite Grupo do Bem vแlido"
	Return .F.
EndIf

If MV_PAR08 < MV_PAR07
	Help(" ",1,"ATFR326FOR",,STR0131,1,0)  //"Digite Fornecedor vแlido"
	Return .F.
EndIf

If MV_PAR10 < MV_PAR09
	Help(" ",1,"ATFR326DAT",,STR0132,1,0)  //"Digite Data de Aquisi็ใo do Bem vแlida"
	Return .F.
EndIf

If MV_PAR14 == 1
	apSelFil := AdmGetFil(@lpTodasFil)
	If Len(apSelFil) <= 0
		Help(" ",1,"ATFR326FIL",,STR0133,1,0) //"Deve ser selecionado no mํnimo 1 Filial"
		Return .F.
	EndIf
EndIf

If MV_PAR16 < MV_PAR15
	Help(" ",1,"ATFR326FOL",,STR0134,1,0)  //"Digite N๚mero da Folha vแlida"
	Return .F.
EndIf

If MV_PAR18 == 1
	apSelMoed := AdmGetMoed()
	If Len(apSelMoed) <= 0
		Help(" ",1,"ATFR326MOE",,STR0135,1,0) //"Deve ser selecionado no mํnimo 1 Moeda"
		Return .F.
	EndIf
	If Len(apSelMoed) > 5
		Help(" ",1,"ATFR326MOE",,STR0136,1,0)  //"Deve ser selecionado no mแximo 5 Moedas"
		Return .F.
	EndIf
EndIf
Return .T.
