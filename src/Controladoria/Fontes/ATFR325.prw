/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "ATFR325.ch"
#INCLUDE "Protheus.ch"
#INCLUDE "TopConn.ch"
#INCLUDE "RwMake.ch"
#INCLUDE "DBINFO.CH"

/*PACOTE FNC 00000030092010*/
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATFR325  บ Autor ณ Felipe C. Seolin   บ Data ณ  23/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Demonstrativo de Bens de Terceiros			              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR325				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function ATFR325()
Local clPerg		:= "AFR325"
Local olReport		:= Nil 
Local lTReport	:= TRepInUse()
Private apSelFil	:= {}
Private apSelMoed	:= {}
Private lpTodasFil	:= .F.

If !lTReport
	Help("  ",1,"AFR325R4",,STR0036,1,0) //"Fun็ใo disponํvel apenas para TReport"
	Return
ENdIf

If Pergunte(clPerg,.T.)
	While !ATF325Vld()
		If !Pergunte(clPerg,.T.)
			Return()
		EndIf
	EndDo
	olReport := ATF035Def(clPerg)
	olReport:PrintDialog()
EndIf


Return Nil
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF035Defบ Autor ณ Felipe C. Seolin   บ Data ณ  23/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Estrutura de Demonstrativo de Bens de Terceiros			  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR325				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF035Def(clPerg)
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
Local clNomeProg	:= STR0001 //"Demonstrativo de Bens de Terceiros"
Local clTitle		:= STR0001 //"Demonstrativo de Bens de Terceiros"
Local clDesc		:= STR0001 //"Demonstrativo de Bens de Terceiros"
Local alOrd			:= {OemToAnsi(STR0002),OemToAnsi(STR0003),OemToAnsi(STR0004)} //"Codigo"###"Grupo"###"Data Aquisicao"

olReport := TReport():New(clNomeProg,clTitle,clPerg,{|olReport| ATF035Prt(olReport)},clDesc)

olSecBem := TRSection():New(olReport,STR0005,,alOrd) //"Dados da Entidade"
TRCell():New(olSecBem,"N3_FILIAL"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_CBASE"	,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_ITEM"		,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_TIPO"		,"SN3"	,		,								,	)
TRCell():New(olSecBem,"N3_TIPODESC"	,""		,STR0006,								,30	) //"Descri็ใo Tipo"
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

olSecValor := TRSection():New(olSecBem,STR0007) //"Valores"
TRCell():New(olSecValor,"SIMBMOEDA"		,""		,STR0008,""									,5	) //"Moeda"
TRCell():New(olSecValor,"N3_VORIG1"		,""		,STR0009,									,	) //"Valor Original"
TRCell():New(olSecValor,"N3_AMPLIA1"	,"SN3"	,STR0010,									,	) //"Valor Amplia็ใo"
TRCell():New(olSecValor,"VLATUALIZADO"	,""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olSecValor,"N3_VRDACM1"	,""		,STR0012,									,19	) //"Deprec. Acumulada"
TRCell():New(olSecValor,"VLRESIDUAL"	,""		,STR0013,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Residual"
TRCell():New(olSecValor,"N3_VRCDA1"		,"SN3"	,		,									,17	)
TRCell():New(olSecValor,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olSecValor:SetHeaderPage(.T.)
olSecValor:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olSecValor:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olDadosBem := TRSection():New(olSecBem,STR0014) //"Dados"
TRCell():New(olDadosBem,"NO_SEQ"	,"SNO")  //"Sequ๊ncia da Vig๊ncia"
TRCell():New(olDadosBem,"NO_VIGINI"	,"SNO")  //"Data Inicial da Vig๊ncia"
TRCell():New(olDadosBem,"NO_VIGFIM"	,"SNO")  //"Data Final da Vig๊ncia"
TRCell():New(olDadosBem,"NO_FORNEC"	,"SNO")  //"Codigo do Fornecedor"
TRCell():New(olDadosBem,"NO_LOJA"	,"SNO")  //"Codigo do Fornecedor"
TRCell():New(olDadosBem,"A2_NREDUZ"	,"SA2")  //"Nome do Detentor do Bem"
TRCell():New(olDadosBem,"NO_CONTATO","SNO")  //"Nome do Contato"
TRCell():New(olDadosBem,"NO_STATUS"	,"SNO")  //"Status da Vig๊ncia do Bem"
olDadosBem:SetHeaderPage(.T.)

olTxtEnt := TRSection():New(olReport,STR0015) //"Texto Total por Entidade Contแbil"
TRCell():New(olTxtEnt,"TEXTO"		,"",STR0016,"",70) //"Total Geral"
TRCell():New(olTxtEnt,"QUANTIDADE"	,"",STR0017,"",20) //"Quantidade"
olTxtEnt:SetHeaderSection(.F.)
olTxtEnt:SetLeftMargin(7)

olTotEnt := TRSection():New(olReport,STR0018) //"Valores do Total por Entidade Contแbil"
TRCell():New(olTotEnt,"SIMBMOEDA"	,""		,STR0008,""									,5	) //"Moeda"
TRCell():New(olTotEnt,"N3_VORIG1"	,""		,STR0009,									,	) //"Valor Original"
TRCell():New(olTotEnt,"N3_AMPLIA1"	,"SN3"	,STR0010,									,	) //"Valor Amplia็ใo"
TRCell():New(olTotEnt,"VLATUALIZADO",""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olTotEnt,"N3_VRDACM1"	,""		,STR0012,									,19	) //"Deprec. Acumulada"
TRCell():New(olTotEnt,"VLRESIDUAL"	,""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olTotEnt,"N3_VRCDA1"	,"SN3"	,		,									,17	)
TRCell():New(olTotEnt,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olTotEnt:SetHeaderSection(.F.)
olTotEnt:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olTotEnt:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olTxtFil := TRSection():New(olReport,STR0019) //"Texto Total por Filial"
TRCell():New(olTxtFil,"TEXTO"		,"",STR0016,"",70) //"Total Geral"
TRCell():New(olTxtFil,"QUANTIDADE"	,"",STR0017,"",20) //"Quantidade"
olTxtFil:SetHeaderSection(.F.)
olTxtFil:SetLeftMargin(7)

olTotFil := TRSection():New(olReport,STR0020) //"Valores do Total por Filial"
TRCell():New(olTotFil,"SIMBMOEDA"	,""		,STR0008,""									,5	) //"Moeda"
TRCell():New(olTotFil,"N3_VORIG1"	,""		,STR0009,									,	) //"Valor Original"
TRCell():New(olTotFil,"N3_AMPLIA1"	,"SN3"	,STR0010,									,	) //"Valor Amplia็ใo"
TRCell():New(olTotFil,"VLATUALIZADO",""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olTotFil,"N3_VRDACM1"	,""		,STR0012,									,19	) //"Deprec. Acumulada"
TRCell():New(olTotFil,"VLRESIDUAL"	,""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olTotFil,"N3_VRCDA1"	,"SN3"	,		,									,17	)
TRCell():New(olTotFil,"N3_VRCACM1"	,"SN3"	,		,									,19	)
olTotFil:SetHeaderSection(.F.)
olTotFil:Cell("VLATUALIZADO"):SetHeaderAlign("RIGHT")
olTotFil:Cell("VLRESIDUAL"):SetHeaderAlign("RIGHT")

olTxtGer := TRSection():New(olReport,STR0021) //"Texto Total Geral"
TRCell():New(olTxtGer,"TEXTO"		,"",STR0016,"",70) //"Total Geral"
TRCell():New(olTxtGer,"QUANTIDADE"	,"",STR0017,"",20) //"Quantidade"
olTxtGer:SetHeaderSection(.F.)
olTxtGer:SetLeftMargin(7)

olTotGeral := TRSection():New(olReport,STR0022) //"Valores do Total Geral"
TRCell():New(olTotGeral,"SIMBMOEDA"		,""		,STR0008,""									,5	) //"Moeda"
TRCell():New(olTotGeral,"N3_VORIG1"		,""		,STR0009,									,	) //"Valor Original"
TRCell():New(olTotGeral,"N3_AMPLIA1"	,"SN3"	,STR0010,									,	) //"Valor Amplia็ใo"
TRCell():New(olTotGeral,"VLATUALIZADO"	,""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
TRCell():New(olTotGeral,"N3_VRDACM1"	,""		,STR0012,									,19	) //"Deprec. Acumulada"
TRCell():New(olTotGeral,"VLRESIDUAL"	,""		,STR0011,PesqPict("SN3","N3_VORIG1",19,1)	,19	) //"Valor Atualizado"
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
ฑฑบPrograma  ณ ATF035Prtบ Autor ณ Felipe C. Seolin   บ Data ณ  24/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Impressใo de Demonstrativo de Bens de Terceiros            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR325				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF035Prt(olReport)
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
clWhrSql += " AND N1_TPCTRAT = '2' "

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
OemToAnsi(OemToAnsi(STR0023)),OemToAnsi(STR0024)) //"Criando Arquivo Temporแrio..."###"Posicao Valorizada dos Bens na Data"

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
			alSNO := {}
			alSNO := ATF035SNO((clAliasTRB)->FILIAL,(clAliasTRB)->CBASE,(clAliasTRB)->ITEM,nlStatus)
			If Empty(alSNO)
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
			If Len(alSNO) > 0
				olDadosBem:Init()
				For nlI := 1 to Len(alSNO)
					olDadosBem:Cell("NO_SEQ"):SetBlock({||alSNO[nlI][1]})
					olDadosBem:Cell("NO_VIGINI"):SetBlock({||alSNO[nlI][2]})
					olDadosBem:Cell("NO_VIGFIM"):SetBlock({||alSNO[nlI][3]})
					olDadosBem:Cell("NO_FORNEC"):SetBlock({||alSNO[nlI][4]})
					olDadosBem:Cell("NO_LOJA"):SetBlock({||alSNO[nlI][8]})
					olDadosBem:Cell("A2_NREDUZ"):SetBlock({||alSNO[nlI][5]})
					olDadosBem:Cell("NO_CONTATO"):SetBlock({||alSNO[nlI][6]})
					olDadosBem:Cell("NO_STATUS"):SetBlock({||X3Combo("NO_STATUS",alSNO[nlI][7])})
					olDadosBem:PrintLine()
				Next nlI
			EndIf
			olDadosBem:Finish()
		EndDo
		olTxtEnt:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0025)}) //"* * *   T O T A L   P O R   E N T I D A D E   * * *"
		olTxtEnt:Cell("QUANTIDADE"):SetBlock({||OemToAnsi(STR0017)/* + Str(nTotal,7,0)*/}) //"QUANTIDADE"
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
	olTxtFil:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0026)}) //"* * *   T O T A L   P O R   F I L I A L   * * *"
	olTxtFil:Cell("QUANTIDADE"):SetBlock({||OemToAnsi(STR0017)/* + Str(nTotal,7,0)*/}) //"QUANTIDADE"
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
	olTxtGer:Cell("TEXTO"):SetBlock({||OemToAnsi(STR0027)}) //"* * *   T O T A L   G E R A L   * * *"
	olTxtGer:Cell("QUANTIDADE"):SetBlock({||OemToAnsi(STR0017)/* + Str(nTotal,7,0)*/}) //"QUANTIDADE"
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
ฑฑบPrograma  ณ ATF035SNOบ Autor ณ Felipe C. Seolin   บ Data ณ  25/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Busca dados da vig๊ncia de Bens de Terceiros	              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR325				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF035SNO(clFilial,clCodBase,clItem,nlStatus)
Local alDados	:= {}
Local clQuery	:= ""
Local clAlsTRB	:= "TRBDAD"
Local nlPos		:= 0

clQuery	:= "SELECT	NO_SEQ  "
clQuery	+= "		,NO_VIGINI  "
clQuery	+= "		,NO_VIGFIM  "
clQuery	+= "		,NO_FORNEC  "
clQuery	+= "		,A2_NREDUZ  "
clQuery	+= "		,NO_CONTATO  "
clQuery	+= "		,NO_STATUS  "
clQuery	+= "		,NO_LOJA  "
clQuery	+= "FROM " + RetSqlName("SNO") + " SNO "

clQuery	+= "INNER JOIN " + RetSqlName("SA2") + " SA2 "
clQuery	+= "ON	A2_FILIAL = '" + xFilial("SA2",clFilial) + "' "
clQuery	+= "AND	SA2.D_E_L_E_T_ <> '*' "
clQuery	+= "AND	A2_COD = NO_FORNEC "
clQuery	+= "AND	A2_LOJA = NO_LOJA  "

clQuery	+= "WHERE	NO_FILIAL = '" + clFilial + "' "
clQuery	+= "AND		SNO.D_E_L_E_T_ <> '*' "
clQuery	+= "AND		NO_CBASE = '" + clCodBase + "' "
clQuery	+= "AND		NO_ITEM = '" + clItem + "' "
If nlStatus == 1
	clQuery	+= "AND		NO_STATUS = '1' "
EndIf

clQuery := ChangeQuery(clQuery)
DBUseArea(.T.,"TOPCONN",TcGenQry(,,clQuery),clAlsTRB,.T.,.F.)

While (clAlsTRB)->(!EOF())
	aAdd(alDados,{"",STOD(""),STOD(""),"","","","",""})
	nlPos := Len(alDados)
	alDados[nlPos][1] := (clAlsTRB)->NO_SEQ
	alDados[nlPos][2] := STOD((clAlsTRB)->NO_VIGINI)
	alDados[nlPos][3] := STOD((clAlsTRB)->NO_VIGFIM)
	alDados[nlPos][4] := (clAlsTRB)->NO_FORNEC
	alDados[nlPos][5] := (clAlsTRB)->A2_NREDUZ
	alDados[nlPos][6] := (clAlsTRB)->NO_CONTATO
	alDados[nlPos][7] := (clAlsTRB)->NO_STATUS
	alDados[nlPos][8] := (clAlsTRB)->NO_LOJA
	(clAlsTRB)->(DBSkip())
EndDo

(clAlsTRB)->(DBCloseArea())
Return alDados
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณ ATF325Vldบ Autor ณ Felipe C. Seolin   บ Data ณ  29/11/10   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Valida perguntas de parโmetro				              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ ATFR325				                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function ATF325Vld()

If MV_PAR02 < MV_PAR01
	Help(" ",1,"ATFR325COD",,STR0028,1,0) //"Digite C๓digo do Bem vแlido"
	Return .F.
EndIf

If MV_PAR04 < MV_PAR03
	Help(" ",1,"ATFR325ITE",,STR0029,1,0) //"Digite Item do Bem vแlido"
	Return .F.
EndIf

If MV_PAR06 < MV_PAR05
	Help(" ",1,"ATFR325GRU",,STR0030,1,0) //"Digite Grupo do Bem vแlido"
	Return .F.
EndIf

If MV_PAR08 < MV_PAR07
	Help(" ",1,"ATFR325FOR",,STR0031,1,0) //"Digite Fornecedor vแlido"
	Return .F.
EndIf

If MV_PAR10 < MV_PAR09
	Help(" ",1,"ATFR325DAT",,STR0032,1,0) //"Digite Data de Aquisi็ใo do Bem vแlida"
	Return .F.
EndIf

If MV_PAR14 == 1
	apSelFil := AdmGetFil(@lpTodasFil)
	If Len(apSelFil) <= 0
		Help(" ",1,"ATFR325FIL",,STR0037,1,0)//"Deve ser selecionado no mํnimo 1 Filial"
		Return .F.
	EndIf
EndIf

If MV_PAR16 < MV_PAR15
	Help(" ",1,"ATFR325FOL",,STR0033,1,0) //"Digite N๚mero da Folha vแlida"
	Return .F.
EndIf

If MV_PAR18 == 1
	apSelMoed := AdmGetMoed()
	If Len(apSelMoed) <= 0
		Help(" ",1,"ATFR325MOE",,STR0038,1,0)//"Deve ser selecionado no mํnimo 1 Moeda"
		Return .F.
	EndIf
	If Len(apSelMoed) > 5
		Help(" ",1,"ATFR325MOE",,STR0034,1,0) //"Deve ser selecionado no mแximo 5 Moedas"
		Return .F.
	EndIf
EndIf
Return .T.
