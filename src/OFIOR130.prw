/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 13    º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼
#INCLUDE "OFIOR130.ch"
#INCLUDE "PROTHEUS.CH"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³OFIOR130  º Autor ³ Ricardo Farinelli  º Data ³  19/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescricao ³ Relatorio de Veiculos Atendidos na Oficina.                º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function OFIOR130()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Declaracao de Variaveis                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

Local aOrd           := {}
Local cDesc1         := STR0001  //"Este programa tem como objetivo imprimir a relacao"
Local cDesc2         := STR0002 //"de veiculos atendidos na oficina conforme os parametros"
Local cDesc3         := STR0003 //"selecionados. "
Local cPict          := ""
Local imprime        := .T.
Local wnrel          := "OFIOR130"
Local cString        := "VO1"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		 := 0

Private titulo       := STR0004 //"Veiculos Atendidos na Oficina"
Private nLin         := 80
//Private CbTxt        := ""
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 220
Private cAliasVO1    := "SQLVO1"
Private tamanho      := "G"
Private lA1_IBGE := If(SA1->(FieldPos("A1_IBGE"))#0,.t.,.f.)

Private Cabec1       := STR0027
//Private Cabec1       := STR0005 //" [Cliente] [Nome--------------] [Endereco------------------------------] [Municipio---------------UF] [Telefone-----] [Placa-] [Revendedor--------------------------] [Municipio---------------UF] [Regiao] [Telefone-----]"
//Private Cabec2       := STR0006 //" ---------Chassi---------- Ch.Int -Frota- Mca -Fab/Mod- --------Modelo---------- --Descricao Modelo-- SegMod ---Cor---- Combust Tipo Difer Nro Difer. RelDif Tip.Cambio Nro Cambio -Tipo do Motor- -Nro do Motor-- --------]"
Private Cabec2       := STR0028
//								  1234567890123456789012345 123456 1234567 123 9999/9999 123456789012345678901234 12345678901234567890 123456 1234567890 1234567 1234567890 1234567890  12345 1234567890 1234567890 123456789012345 123456789012345 999 dias
//								                                                                                                                                                                                                                    99 horas
//								  0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789
//								           10        20        30        40        50        60        70        80        90        100       110       120       130      140        150       160       170       180       190       200       210
Private nTipo        := 18
Private aReturn      := {STR0007, 1,STR0008 , 1, 2, 1, "", 1}  //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OFR130"
//Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01

ValidPerg()
//         1         2         3         4         5         6         7         8         9         0         1         2         3         4         5         6         7         8         9         0         1         2
//1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890

pergunte(cPerg,.F.)

wnrel := SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
	Return
Endif

nTipo := If(aReturn[4]==1,15,18)

cIndice := CriaTrab(nil,.F.)

VV2->(DbSetOrder(1))
VV1->(DbSetOrder(1))


RptStatus({|lEnd| U_OFIR130IMP(@lEnd,wnrel,cString)},Titulo)

DbSelectArea("VO1")
RetIndex()

#IFNDEF TOP
	If File(cIndice+OrdBagExt())
		fErase(cIndice+OrdBagExt())
	Endif
#ENDIF

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³OFIR130IMPº Autor ³ Ricardo Farinelli  º Data ³  20/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Funcao auxiliar para a impressao do relatorio de veiculos  º±±
±±º          ³ atendidos na oficina.                                      º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Gestao de Concessionarias                                  º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function OFIR130IMP(lEnd,wnrel,cString)

Local nTotVei   := 0
Local lAchou    := .f.
Local nTotCCon  := 0
Local nTotSCon  := 0   
Local cAliasVO5 := "SQLVO5"
Local oSqlHelper := Dms_SqlHelper():New()

/*
ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
³MV_PAR01 = Marca - especificar uma marca, ou branco para todas                                        ³
³MV_PAR02 = Modelo - especificar um grupo de modelos, ou branco para todos                             ³
³MV_PAR03 = Modelo - especificar um modelo, ou branco para todos                                       ³
³MV_PAR04 = Proprietario - especificar um cliente, ou branco para todos                                ³
³MV_PAR05 = Loja - especificar uma loja do cliente, ou branco para todas                               ³
³MV_PAR06 = Data inicial - data inicial para levantamento dos atendimentos                             ³
³MV_PAR07 = Data final -   data final   para levantamento dos atendimentos                             ³
ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
*/

SetRegua(RecCount())

Titulo +=STR0010+Iif(!Empty(MV_PAR01),Alltrim(MV_PAR01),STR0011)  //" Marca: "###"Todas"
Titulo +=STR0012+Iif(!Empty(MV_PAR02),Alltrim(MV_PAR02),STR0011)  //### //" Familia: "###"Todas"
Titulo +=STR0013+Iif(!Empty(MV_PAR03),Alltrim(MV_PAR03),STR0014) //" Modelo: "###"Todos"
Titulo +=STR0015+Iif(!Empty(MV_PAR04),MV_PAR04+"/"+MV_PAR05,STR0014) //" Proprietario: "###"Todos"
Titulo +=STR0016+Dtoc(MV_PAR06)+STR0017+Dtoc(MV_PAR07) //" De: "###" a "

cQuery := "SELECT DISTINCT VO1.VO1_PROVEI,VO1.VO1_LOJPRO,VO1.VO1_CHAINT,VO1.VO1_NUMOSV,VO1.VO1_DATSAI,VO1.VO1_DATABE,VO1.VO1_HORSAI,VO1.VO1_HORABE,VO1.VO1_CODMAR FROM "+RetSqlName("VO1")+" VO1 "
If !Empty(MV_PAR02) .or. !Empty(MV_PAR03)
	cQuery += "LEFT JOIN "+RetSqlName("VV1")+" VV1 ON (VV1.VV1_FILIAL='"+xFilial("VV1")+"' AND VV1.VV1_CHAINT = VO1.VO1_CHAINT) AND VV1.D_E_L_E_T_ = ' ' "
	cQuery += "LEFT JOIN "+RetSqlName("VV2")+" VV2 ON (VV2.VV2_FILIAL='"+xFilial("VV2")+"' AND "+oSQLHelper:Concat( { "VV2.VV2_CODMAR","VV2.VV2_MODVEI" })+" = "+oSQLHelper:Concat( { "VV1.VV1_CODMAR","VV2.VV2_MODVEI" })+") AND VV2.D_E_L_E_T_ = ' ' "
Endif
If !Empty(MV_PAR09)
	cQuery += "LEFT JOIN "+RetSqlName("VEC")+" VEC ON (VEC.VEC_FILIAL='"+xFilial("VEC")+"' AND VEC.VEC_NUMOSV = VO1.VO1_NUMOSV) AND VEC.D_E_L_E_T_ = ' ' "
	cQuery += "LEFT JOIN "+RetSqlName("VSC")+" VSC ON (VSC.VSC_FILIAL='"+xFilial("VSC")+"' AND VSC.VSC_NUMOSV = VO1.VO1_NUMOSV) AND VSC.D_E_L_E_T_ = ' ' "
	cQuery += "LEFT JOIN "+RetSqlName("SF2")+" SF2 ON (SF2.F2_FILIAL='"+xFilial("SF2")+"' AND ( ( SF2.F2_DOC = VEC.VEC_NUMNFI  AND SF2.F2_SERIE = VEC.VEC_SERNFI ) OR ( SF2.F2_DOC = VSC.VSC_NUMNFI AND SF2.F2_SERIE = VSC.VSC_SERNFI ))) AND SF2.D_E_L_E_T_ = ' ' "
Endif
cQuery += "WHERE VO1.VO1_FILIAL='"+xFilial("VO1")+"' AND VO1.VO1_DATABE >= '"+dtos(MV_PAR06)+"' AND VO1.VO1_DATABE <= '"+dtos(MV_PAR07)+"'"
If !Empty(MV_PAR01)
	cQuery += " AND VO1.VO1_CODMAR = '"+MV_PAR01+"'"
Endif
If !Empty(MV_PAR02)
	cQuery += " AND VV2.VV2_GRUMOD='"+MV_PAR02+"'"
Endif
If !Empty(MV_PAR03)
	cQuery += " AND VV2.VV2_MODVEI='"+MV_PAR03+"'"
Endif
If !Empty(MV_PAR08)
	cQuery += " AND VO1.VO1_FUNABE='"+MV_PAR08+"'"
Endif
If !Empty(MV_PAR09)
	cQuery += " AND SF2.F2_VEND1='"+MV_PAR09+"'"
Endif
If !Empty(MV_PAR04)
	cQuery += " AND VO1.VO1_PROVEI = '"+MV_PAR04+"' AND VO1.VO1_LOJPRO = '"+MV_PAR05+"' "
Endif                                                                                    
cQuery += " AND VO1.D_E_L_E_T_=' ' ORDER BY VO1.VO1_NUMOSV"

dbUseArea(.T.,"TOPCONN",TcGenQry(,,cQuery),cAliasVO1,.T.,.T.)

Do While !( cAliasVO1 )->( Eof() )
	
	If nLin > 50
		nLin := Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo) + 1
		
		
		If lAbortPrint .or. lEnd
			@nLin,00 PSAY STR0018 //"*** CANCELADO PELO OPERADOR ***"
			Exit
		Endif
/*		
		SA1->(dbsetOrder(1))
		SA1->(dbSeek(xFilial("SA1")+( cAliasVO1 )->VO1_PROVEI+( cAliasVO1 )->VO1_LOJPRO))
		VV1->(DbSetOrder(1))
		VV1->(DbSeek(xFilial("VV1")+( cAliasVO1 )->VO1_CHAINT))
		VVK->(DbSetOrder(1))
		VVK->(Dbseek(xFilial("VVK")+VV1->(VV1_CODMAR+VV1_CODCON)))
		VV2->(DbSetOrder(1))
		VV2->(DbSeek(xFilial("VV2")+VV1->(VV1_CODMAR+VV1_MODVEI)))//+VV1_SEGMOD)))
		VVC->(DbSetOrder(1))
		VVC->(DbSeek(xFilial("VVC")+VV1->(VV1_CODMAR+VV1_CORVEI)))
		
		@ nLin,001 PSAY ( cAliasVO1 )->VO1_NUMOSV
		@ nLin,010 PSAY ( cAliasVO1 )->VO1_PROVEI+"/"+( cAliasVO1 )->VO1_LOJPRO
		@ nLin,020 PSAY subs(SA1->A1_NOME,1,20)  
		If SA1->(FieldPos("A1_NUMERO")) # 0
		   @ nLin,042 PSAY Left(SA1->A1_END,32)+", "+Left(SA1->A1_NUMERO,6)
		Else
		   @ nLin,042 PSAY Left(SA1->A1_END,32)+space(8)
		Endif
		If lA1_IBGE
			FG_Seek("VAM","SA1->A1_IBGE",1,.f.) // CIDADE
			@ nLin,082 PSAY VAM->VAM_DESCID
			@ nLin,106 PSAY VAM->VAM_ESTADO
		Else
			@ nLin,082 PSAY SA1->A1_MUN
			@ nLin,106 PSAY SA1->A1_EST
		EndIf
		//  @ nLin,082 PSAY SA1->A1_MUN
		@ nLin,106 PSAY SA1->A1_EST
		@ nLin,109 PSAY SA1->A1_TEL
		@ nLin,125 PSAY VV1->VV1_PLAVEI
		@ nLin,136 PSAY VV1->VV1_CODCON
		@ nLin,143 PSAY Left(VVK->VVK_RAZSOC,20)
		@ nLin,165 PSAY VVK->VVK_CIDADE
		@ nLin,190 PSAY VVK->VVK_ESTADO
		@ nLin,198 PSAY VVK->VVK_REGIAO
		@ nLin,205 PSAY VVK->VVK_TELEFO
		nLin++
*/
	Endif
	
	If lAbortPrint .or. lEnd
		@nLin,00 PSAY STR0018 //"*** CANCELADO PELO OPERADOR ***"
		Exit
	Endif
	
	SA1->(dbsetOrder(1))
	SA1->(dbSeek(xFilial("SA1")+( cAliasVO1 )->VO1_PROVEI+( cAliasVO1 )->VO1_LOJPRO))
	VV1->(DbSetOrder(1))
	VV1->(DbSeek(xFilial("VV1")+( cAliasVO1 )->VO1_CHAINT))
	VVK->(DbSetOrder(1))
	VVK->(Dbseek(xFilial("VVK")+VV1->(VV1_CODMAR+VV1_CODCON)))
	VV2->(DbSetOrder(1))
	VV2->(DbSeek(xFilial("VV2")+VV1->(VV1_CODMAR+VV1_MODVEI))) //+VV1_SEGMOD)))
	VVC->(DbSetOrder(1))
	VVC->(DbSeek(xFilial("VVC")+VV1->(VV1_CODMAR+VV1_CORVEI)))
	
	@ nLin,001 PSAY ( cAliasVO1 )->VO1_NUMOSV
	@ nLin,010 PSAY ( cAliasVO1 )->VO1_PROVEI+"/"+( cAliasVO1 )->VO1_LOJPRO
	@ nLin,020 PSAY subs(SA1->A1_NOME,1,20)
	If SA1->(FieldPos("A1_NUMERO")) # 0
		@ nLin,042 PSAY Left(SA1->A1_END,32)+", "+Left(SA1->A1_NUMERO,6)
	Else
		@ nLin,042 PSAY Left(SA1->A1_END,32)+space(8)
	Endif
	@ nLin,082 PSAY SA1->A1_MUN
	@ nLin,106 PSAY SA1->A1_EST
	@ nLin,110 PSAY SA1->A1_TEL
	@ nLin,125 PSAY VV1->VV1_PLAVEI
	@ nLin,136 PSAY VV1->VV1_CODCON
	@ nLin,143 PSAY left(VVK->VVK_RAZSOC,20)
	@ nLin,165 PSAY VVK->VVK_CIDADE
	@ nLin,190 PSAY VVK->VVK_ESTADO
	@ nLin,198 PSAY VVK->VVK_REGIAO
	@ nLin,205 PSAY VVK->VVK_TELEFO
	nLin++
	
	//  If nLin > 58
	If nLin > 50
		nLin := Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo) + 1
	Endif
	
	
	nTmpPerm := stod(( cAliasVO1 )->VO1_DATSAI) - stod(( cAliasVO1 )->VO1_DATABE)
	If nTmpPerm == 0
		nHoras := ((stod(( cAliasVO1 )->VO1_DATSAI)-stod(( cAliasVO1 )->VO1_DATABE))*24)
		nHoras += (val(left(Transform(( cAliasVO1 )->VO1_HORSAI,"@R 99:99"),2))+val(substr(Transform(( cAliasVO1 )->VO1_HORSAI,"@R 99:99"),4,2))/60)
		nHoras -= (val(left(Transform(( cAliasVO1 )->VO1_HORABE,"@R 99:99"),2))+val(substr(Transform(( cAliasVO1 )->VO1_HORABE,"@R 99:99"),4,2))/60)
		nMinut := round(60*(nHoras-int(nHoras)),0)
		nHoras := int(nHoras)
		cTmpPerm := StrZero(nHoras,2)+":"+strzero(nMinut,2) + " h"
	Else
		cTmpPerm := strzero(nTmpPerm,3) + STR0029
	Endif
	
	@ nLin,001 PSAY VV1->VV1_CHASSI
	@ nLin,027 PSAY VV1->VV1_CHAINT
	@ nLin,035 PSAY VV1->VV1_CODFRO
	@ nLin,042 PSAY ( cAliasVO1 )->VO1_CODMAR
	@ nLin,046 PSAY Transform(VV1->VV1_FABMOD,"@R 9999/9999")
	@ nLin,056 PSAY Substr(VV1->VV1_MODVEI,1,24)
	@ nLin,081 PSAY Substr(VV2->VV2_DESMOD,1,20)
	@ nLin,102 PSAY Left(VV1->VV1_SEGMOD,6)
	@ nLin,109 PSAY Substr(VVC->VVC_DESCRI,1,10)
	@ nLin,120 PSAY Substr(X3COMBO("VV1_COMVEI",VV1->VV1_COMVEI),1,7)
	@ nLin,128 PSAY Left(VV1->VV1_TIPDIF,10)
	@ nLin,139 PSAY Left(VV1->VV1_NUMDIF,10)
	@ nLin,151 PSAY Transform(VV1->VV1_RELDIF,"@E 99999")
	@ nLin,157 PSAY VV1->VV1_TIPCAM
	@ nLin,168 PSAY VV1->VV1_CAMBIO
	@ nLin,176 PSAY VV1->VV1_TIPMOT
	@ nLin,195 PSAY VV1->VV1_NUMMOT
	@ nLin,211 PSAY cTmpPerm
	nLin+=2
	
	// If nLin > 58
	// Cabec(Titulo,Cabec1,Cabec2,wnrel,Tamanho,nTipo)
	// nLin := 8
	// Endif
	IncRegua()
	lAchou := .f.
	cQuery := "SELECT VO5.VO5_CHAINT "
	cQuery += "FROM "
	cQuery += RetSqlName( "VO5" ) + " VO5 " 
	cQuery += "WHERE " 
	cQuery += "VO5.VO5_FILIAL='"+ xFilial("VO5")+ "' AND VO5.VO5_VEIACO = '1' AND VO5.VO5_CHAINT = '"+VV1->VV1_CHAINT+"' AND "
	cQuery += "( (VO5.VO5_DATENT <= '"+dtos(MV_PAR06)+"' AND VO5.VO5_DATSAI >= '"+dtos(MV_PAR07)+"') OR (VO5.VO5_DATENT >= '"+dtos(MV_PAR06)+"' AND VO5.VO5_DATENT <= '"+dtos(MV_PAR07)+"' AND VO5.VO5_DATSAI >= '"+dtos(MV_PAR07)+"')  OR  (VO5.VO5_DATSAI >='"+dtos(MV_PAR06)+"' AND VO5.VO5_DATSAI <= '"+dtos(MV_PAR07)+"') ) AND "
	cQuery += "VO5.D_E_L_E_T_=' '"                                             

	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVO5, .T., .T. )   

	if !(cAliasVO5)->(Eof())
	   lAchou := .t.
	Endif
    if lAchou 
       nTotCCon += 1
    Else
       nTotSCon += 1
    Endif      
	(cAliasVO5)->(dbCloseArea())
	nTotVei++
	
	dbSelectArea(cAliasVO1)
	( cAliasVO1 )->(dbskip())
	
Enddo
(cAliasVO1)->(dbCloseArea())
@ nLin+1,001 PSAY STR0039+Strzero(nTotCCon,6) //"Total de Passagens (Contrato/Acordo): "         
nLin++
@ nLin+1,001 PSAY STR0040+Strzero(nTotSCon,6) //"Total de Passagens (Sem Contr/Acordo): "
nLin++
@ nLin+1,001 PSAY STR0019+Strzero(nTotVei,6)  //"Total de Passagens no Periodo.: "
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Finaliza a execucao do relatorio...                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

SET DEVICE TO SCREEN

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Se impressao em disco, chama o gerenciador de impressao...          ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ

If aReturn[5]==1
	dbCommitAll()
	SET PRINTER TO
	OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡„o    ³VALIDPERG º Autor ³ Ricardo Farinelli  º Data ³  04/06/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDescri‡„o ³ Verifica a existencia das perguntas criando-as caso seja   º±±
±±º          ³ necessario (caso nao existam).                             º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Programa principal                                         º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
//cPerg := PADR(cPerg,6)
cPerg := PADR(cPerg,Len(SX1->X1_GRUPO))

aAdd(aRegs,{cPerg,"01",STR0030,"","","mv_ch1","C", 03,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","VE1",""})
aAdd(aRegs,{cPerg,"02",STR0031,"","","mv_ch2","C", 06,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","VRV",""})
aAdd(aRegs,{cPerg,"03",STR0032,"","","mv_ch3","C", 30,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","VR2",""})
Aadd(aRegs,{cPerg,"04",STR0033,"","","mv_ch4","C", 06,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","SA1",""})
Aadd(aRegs,{cPerg,"05",STR0034,"","","mv_ch5","C", 02,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"06",STR0035,"","","mv_ch6","D", 08,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"07",STR0036,"","","mv_ch7","D", 08,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08",STR0037,"","","mv_ch8","C", 06,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","VAI1",""})
Aadd(aRegs,{cPerg,"09",STR0038,"","","mv_ch9","C", 06,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","SA3",""})
For i:=1 to Len(aRegs)
	If !dbSeek(cPerg+aRegs[i,2])
		RecLock("SX1",.T.)
		For j:=1 to FCount()
			If j <= Len(aRegs[i])
				FieldPut(j,aRegs[i,j])
			Endif
		Next
		MsUnlock()
	Endif
Next

dbSelectArea(_sAlias)

Return
