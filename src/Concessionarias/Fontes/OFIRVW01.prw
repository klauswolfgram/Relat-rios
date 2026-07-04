/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 12     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "RPTDEF.CH"
#INCLUDE "FWPRINTSETUP.CH"
#INCLUDE "PROTHEUS.CH"
#INCLUDE "OFIRVW01.CH"
#include "fileio.ch"

/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    |  OFIRVW01  | Autor | Luis Delorme          | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
##|Descrição |  Geração do relatório ADO (Análise Diária da Oficina)        |##
##|          |  para Caminhões e Ônibus VW/MAN                              |##
##|          |  Versão 04/2013                                              |##
##+----------+--------------------------------------------------------------+##
##|Uso       |  VOLSWAGEN CAMINHOES E ONIBUS - OFICINA                      |##
##+----------+--------------------------------------------------------------+##
###############################################################################
===============================================================================
*/
User Function OFIRVW01()

Local cDesc1  := STR0001
Local cDesc2  := STR0002
Local cDesc3  := STR0003
Local aSay := {}
Local aButton := {}
//
Private cTitulo := STR0004
Private cPerg 	:= "ORVW01"
Private cNomRel := "OFIRVW01"
Private nOpc
Private aErros := {}
//
CriaSX1()
//
aAdd( aSay, cDesc1 )
aAdd( aSay, cDesc2 )
aAdd( aSay, cDesc3 )
//
aAdd( aButton, { 5, .T., {|| Pergunte(cPerg,.T. )    }} )
aAdd( aButton, { 1, .T., {|| nOpc := 1, FechaBatch() }} )
aAdd( aButton, { 2, .T., {|| FechaBatch()            }} )
//

FormBatch( cTitulo, aSay, aButton )
//
If nOpc <> 1
	Return
Endif
//
Pergunte(cPerg,.f.)
//
oProcTTP := MsNewProcess():New({ |lEnd| RunProc() }," ","",.f.)
oProcTTP:Activate()
//
return
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    | RunProc    | Autor | André Delorme         | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
###############################################################################
===============================================================================
*/
Static Function RunProc(lEnd)
Local nCntFor, nCntFor2
Local oPrinter

Private cAliasVV1 := "SQLVV1"
Private cAliasVV2 := "SQLVV2"
Private oVerdana9 := TFont():New( "Verdana" , 6 , 5 , , .t. , , , , .T. , .F. )
Private cStrTit := STR0005+DTOC(MV_PAR01) + STR0080 + DTOC(MV_PAR02)

//lLIBVOO := (VOO->(FieldPos("VOO_LIBVOO")) <> 0 .And. Substr(GetMv("MV_LOJAVEI",,"NNN"),2,1) == "S" ) // Não é para considerar Liberação Parcial

lVaiCaminhoes = (MV_PAR14 == 2 .OR. MV_PAR14 == 3)
lVaiOnibus = (MV_PAR14 == 1 .OR. MV_PAR14 == 3)


CSTARTPATH := GETPVPROFSTRING(GETENVSERVER(),"StartPath","ERROR",GETADV97())
CSTARTPATH += IF(RIGHT(CSTARTPATH,1) <> "\","\","")
CSTARTPATH = __RELDIR

nPag = 1

aCabec := {;
{01,0,00,01,5,"C","@!",STR0013},{02,0,01,07,2,"C","@!",STR0014},{03,2,01,02,3,"C","@!",STR0015},{04,2,03,05,1,"C","@!",STR0016},{05,3,03,01,2,"C","@!",STR0017},;
{06,3,04,01,2,"C","@!",STR0018},{07,3,05,01,2,"C","@!",STR0019},{08,3,06,01,2,"C","@!",STR0020},{09,3,07,01,2,"C","@!",STR0021},{10,0,08,08,1,"C","@!",STR0022},;
{11,1,09,07,1,"C","@!",STR0023},{12,1,08,01,4,"C","@!",STR0024},{13,2,09,01,3,"C","@!",STR0025},{14,2,10,03,1,"C","@!",STR0026},{15,3,10,01,2,"C","@!",STR0027},;
{16,3,11,01,2,"C","@!",STR0028},{17,3,12,01,2,"C","@!",STR0029},{18,2,13,01,3,"C","@!",STR0030},{19,2,14,02,1,"C","@!",STR0026},{20,3,14,01,2,"C","@!",STR0031},;
{21,3,15,01,2,"C","@!",STR0032},{22,0,16,02,2,"C","@!",STR0033},{23,2,16,01,3,"C","@!",STR0034},{24,2,17,01,3,"C","@!",STR0035},{25,0,18,10,2,"C","@!",STR0036},;
{26,2,18,02,3,"C","@!",STR0037},{27,2,20,02,3,"C","@!",STR0038},{28,2,22,02,3,"C","@!",STR0039},{29,2,24,02,3,"C","@!",STR0020},{30,2,26,02,3,"C","@!",STR0021},;
{31,0,28,14,2,"C","@!",STR0042},{32,2,28,02,3,"C","@!",STR0027},{33,2,30,02,3,"C","@!",STR0028},{34,2,32,02,3,"C","@!",STR0029},{35,2,34,02,3,"C","@!",STR0031},;
{36,2,36,02,3,"C","@!",STR0032},{37,2,38,02,3,"C","@!",STR0020},{38,2,40,02,3,"C","@!",STR0021},{39,2,42,02,3,"C","@!",STR0043},{40,0,42,06,2,"C","@!",STR0044},;
{41,2,44,02,3,"C","@!",STR0045},{42,2,46,02,3,"C","@!",STR0046},{43,0,48,02,5,"C","@!",STR0047},{42,0,50,02,5,"C","@!",STR0064},{43,5,00,01,1,"C","@!",    "1"},;
{43,5,01,02,1,"C","@!",    "2"},{43,5,03,01,1,"C","@!",    "3"},{43,5,04,01,1,"C","@!",    "4"},{43,5,05,01,1,"C","@!",    "5"},{43,5,06,01,1,"C","@!",     ""},;
{43,5,07,01,1,"C","@!",    "" },{43,5,08,01,1,"C","@!",    "6"},{43,5,09,01,1,"C","@!",    "7"},{43,5,10,01,1,"C","@!",    "8"},{43,5,11,01,1,"C","@!",    "9"},;
{43,5,12,01,1,"C","@!",   "10"},{43,5,13,01,1,"C","@!",   "11"},{43,5,14,01,1,"C","@!",   "12"},{43,5,15,01,1,"C","@!",   "13"},{43,5,16,01,1,"C","@!",   "14"},;
{43,5,17,01,1,"C","@!",   "15"},{43,5,18,02,1,"C","@!",   "16"},{43,5,20,02,1,"C","@!",   "17"},{43,5,22,02,1,"C","@!",   "18"},{43,5,24,02,1,"C","@!",   "19"},;
{43,5,26,02,1,"C","@!",   "20"},{43,5,28,02,1,"C","@!",   "21"},{43,5,30,02,1,"C","@!",   "22"},{43,5,32,02,1,"C","@!",   "23"},{43,5,34,02,1,"C","@!",   "24"},;
{43,5,36,02,1,"C","@!",   "25"},{43,5,38,02,1,"C","@!",   "26"},{43,5,40,02,1,"C","@!",   "27"},{43,5,42,02,1,"C","@!",   "28"},{43,5,44,02,1,"C","@!",   "29"},;
{43,5,46,02,1,"C","@!",   "30"},{43,5,48,02,1,"C","@!",   "31"}}
aAcumula := {;
{1  ,0, 0,1, 6,"N","@!",""},{2  ,0, 1,2, 1,"C","@!",STR0008},{3  ,1, 1,2, 1,"C","@!",STR0009},{4  ,2, 1,2, 1,"C","@!",STR0010},{5  ,3, 1,2, 1,"C","@!",STR0011},;
{6  ,4, 1,2, 1,"C","@!",STR0012},{7  ,0, 3,1, 3,"N","@!",""},{8  ,3, 3,1, 1,"N","@!",""},{9  ,4, 3,1, 1,"N","@!",""},{10 ,0, 4,1, 3,"N","@!",""},{11 ,3, 4,1, 1,"N","@!",""},{12 ,4, 4,1, 1,"N","@!",""},;
{13 ,0, 5,1, 3,"N","@!",""},{14 ,3, 5,1, 1,"N","@!",""},{15 ,4, 5,1, 1,"N","@!",""},{16 ,0, 6,1, 1,"N","@!",""},{17 ,1, 6,1, 1,"N","@!",""},{18 ,2, 6,1, 1,"N","@!",""},{19 ,3, 6,1, 1,"N","@!",""},;
{20 ,4, 6,1, 1,"N","@!",""},{21 ,0, 7,1, 1,"N","@!",""},{22 ,1, 7,1, 1,"N","@!",""},{23 ,2, 7,1, 1,"N","@!",""},{24 ,3, 7,1, 1,"N","@!",""},{25 ,4, 7,1, 1,"N","@!",""},{26 ,0, 8,1, 6,"N","@!",""},;
{27 ,0, 9,1, 1,"N","@!",""},{28 ,1, 9,1, 1,"N","@!",""},{29 ,2, 9,1, 1,"N","@!",""},{30 ,3, 9,1, 1,"N","@!",""},{31 ,4, 9,1, 1,"N","@!",""},{32 ,0, 10,1, 1,"N","@!",""},{33 ,1, 10,1, 1,"N","@!",""},;
{34 ,2, 10,1, 1,"N","@!",""},{35 ,3, 10,1, 1,"N","@!",""},{36 ,4, 10,1, 1,"N","@!",""},{37 ,0, 11,1, 1,"N","@!",""},{38 ,1, 11,1, 1,"N","@!",""},{39 ,2, 11,1, 1,"N","@!",""},{40 ,3, 11,1, 1,"N","@!",""},;
{41 ,4, 11,1, 1,"N","@!",""},{42 ,0, 12,1, 1,"N","@!",""},{43 ,0, 13,1, 1,"N","@!",""},{44 ,1, 13,1, 1,"N","@!",""},{45 ,2, 13,1, 1,"N","@!",""},{46 ,3, 13,1, 1,"N","@!",""},{47 ,4, 13,1, 1,"N","@!",""},;
{48 ,0, 14,1, 1,"N","@!",""},{49 ,1, 14,1, 1,"N","@!",""},{50 ,2, 14,1, 1,"N","@!",""},{51 ,3, 14,1, 1,"N","@!",""},{52 ,4, 14,1, 1,"N","@!",""},{53 ,0, 15,1, 1,"N","@!",""},{54 ,1, 15,1, 1,"N","@!",""},;
{55 ,2, 15,1, 1,"N","@!",""},{56 ,3, 15,1, 1,"N","@!",""},{57 ,4, 15,1, 1,"N","@!",""},{58 ,0, 16,1, 6,"N","@!",""},{59 ,0, 17,1, 6,"N","@!",""},{60 ,0, 18,2, 6,"N","@E 9999999.99","",90},{61 ,0, 20,2, 1,"N","@E 9999999.99",""},;
{62 ,1, 20,2, 1,"N","@E 9999999.99",""},{63 ,2, 20,2, 1,"N","@E 9999999.99",""},{64 ,3, 20,2, 1,"N","@E 9999999.99",""},{65 ,4, 20,2, 1,"N","@E 9999999.99",""},{66 ,0, 22,2, 6,"N","@E 9999999.99","",90},{67 ,0, 24,2, 1,"N","@E 9999999.99",""},{68 ,1, 24,2, 1,"N","@E 9999999.99",""},;
{69 ,2, 24,2, 1,"N","@E 9999999.99",""},{70 ,3, 24,2, 1,"N","@E 9999999.99",""},{71 ,4, 24,2, 1,"N","@E 9999999.99",""},{72 ,0, 26,2, 1,"N","@E 9999999.99",""},{73 ,1, 26,2, 1,"N","@E 9999999.99",""},{74 ,2, 26,2, 1,"N","@E 9999999.99",""},{75 ,3, 26,2, 1,"N","@E 9999999.99",""},;
{76 ,4, 26,2, 1,"N","@E 9999999.99",""},{77 ,0, 28,2, 1,"N","@E 9999999.99",""},{78 ,1, 28,2, 1,"N","@E 9999999.99",""},{79 ,2, 28,2, 1,"N","@E 9999999.99",""},{80 ,3, 28,2, 1,"N","@E 9999999.99",""},{81 ,4, 28,2, 1,"N","@E 9999999.99",""},{82 ,0, 30,2, 1,"N","@E 9999999.99",""},;
{83 ,1, 30,2, 1,"N","@E 9999999.99",""},{84 ,2, 30,2, 1,"N","@E 9999999.99",""},{85 ,3, 30,2, 1,"N","@E 9999999.99",""},{86 ,4, 30,2, 1,"N","@E 9999999.99",""},{87 ,0, 32,2, 1,"N","@E 9999999.99",""},{88 ,1, 32,2, 1,"N","@E 9999999.99",""},{89 ,2, 32,2, 1,"N","@E 9999999.99",""},;
{90 ,3, 32,2, 1,"N","@E 9999999.99",""},{91 ,4, 32,2, 1,"N","@E 9999999.99",""},{92 ,0, 34,2, 1,"N","@E 9999999.99",""},{93 ,1, 34,2, 1,"N","@E 9999999.99",""},{94 ,2, 34,2, 1,"N","@E 9999999.99",""},{95 ,3, 34,2, 1,"N","@E 9999999.99",""},{96 ,4, 34,2, 1,"N","@E 9999999.99",""},;
{97 ,0, 36,2, 1,"N","@E 9999999.99",""},{98 ,1, 36,2, 1,"N","@E 9999999.99",""},{99 ,2, 36,2, 1,"N","@E 9999999.99",""},{100,3, 36,2, 1,"N","@E 9999999.99",""},{101,4, 36,2, 1,"N","@E 9999999.99",""},{102,0, 38,2, 1,"N","@E 9999999.99",""},{103,1, 38,2, 1,"N","@E 9999999.99",""},;
{104,2, 38,2, 1,"N","@E 9999999.99",""},{105,3, 38,2, 1,"N","@E 9999999.99",""},{106,4, 38,2, 1,"N","@E 9999999.99",""},{107,0, 40,2, 1,"N","@E 9999999.99",""},{108,1, 40,2, 1,"N","@E 9999999.99",""},{109,2, 40,2, 1,"N","@E 9999999.99",""},{110,3, 40,2, 1,"N","@E 9999999.99",""},;
{111,4, 40,2, 1,"N","@E 9999999.99",""},{112,0, 42,2, 1,"N","@E 9999999.99",""},{113,0, 44,2, 6,"N","@E 9999999.99","",90},{114,0, 46,2, 6,"N","@E 9999999.99","",90},{115,0, 48,2, 6,"N","@E 9999999.99","",90},{115,0, 50,2, 6,"N","@E 9999999.99","",90},;
{21	,5, 1,2, 1,"C","@!",STR0084},{22	,5, 3,1, 1,"N","@!",""}, {22	,5, 4,1, 1,"N","@!",""},{22	,5, 5,1, 1,"N","@!",""},{22	,5, 6,1, 1,"N","@!",""},{22	,5, 7,1, 1,"N","@!",""},;
{22	,5, 9,1, 1,"N","@!",""},{22	,5, 10,1, 1,"N","@!",""},{22	,5, 11,1, 1,"N","@!",""},{22	,5,13 ,1, 1,"N","@!",""},{22	,5, 14,1, 1,"N","@!",""},{22	,5, 15,1, 1,"N","@!",""},;
{22	,5,20 ,2, 1,"N","@E 9999999.99",""},{22	,5, 24,2, 1,"N","@E 9999999.99",""},{22	,5, 26,2, 1,"N","@E 9999999.99",""},;
{22	,5, 28,2, 1,"N","@E 9999999.99",""},{22	,5, 30,2, 1,"N","@E 9999999.99",""},{22,5, 32,2, 1,"N","@E 9999999.99",""},{22	,5, 34,2, 1,"N","@E 9999999.99",""},{22	,5,36 ,2, 1,"N","@E 9999999.99",""},{22	,5, 38,2, 1,"N","@E 9999999.99",""},{22	,5, 40,2, 1,"N","@E 9999999.99",""},;
{112,1, 42,2, 1,"N","@E 9999999.99",""},{112,2, 42,2, 1,"N","@E 9999999.99",""},{112,3, 42,2, 1,"N","@E 9999999.99",""},{112,4, 42,2, 1,"N","@E 9999999.99",""},{112,5, 42,2, 1,"N","@E 9999999.99",""},;
{42 ,1, 12,1, 1,"N","@!",""},{42 ,2, 12,1, 1,"N","@!",""},{42 ,3, 12,1, 1,"N","@!",""},{42 ,4, 12,1, 1,"N","@!",""},{42 ,5, 12,1, 1,"N","@!",""}}

aDetalhe := {;
{1,0, 0,1, 1,"N","@!",""},{5,0, 1,2, 1,"N","@!",""},{13,0, 3,1, 1,"C","@!",""},{17,0, 4,1, 1,"C","@!",""},{21,0, 5,1, 1,"C","@!",""},{25,0, 6,1, 1,"C","@!",""},{29,0, 7,1, 1,"C","@!",""},;
{33,0, 8,1, 1,"C","@!",""},{37,0, 9,1, 1,"C","@!",""},{41	,0, 10,1, 1,"C","@!",""},{45	,0, 11,1, 1,"C","@!",""},{49	,0, 12,1, 1,"C","@!",""},{53	,0, 13,1, 1,"C","@!",""},;
{57,0, 14,1, 1,"C","@!",""},{61,0, 15,1, 1,"C","@!",""},{65	,0, 16,1, 1,"C","@!",""},{69,0, 17,1, 1,"C","@!",""},{73	,0, 18,2, 1,"N","@E 9999999.99",""},{77,0, 20,2, 1,"N","@E 9999999.99",""},;
{81	,0, 22,2, 1,"N","@E 9999999.99",""},{85,0, 24,2, 1,"N","@E 9999999.99",""},{89,0, 26,2, 1,"N","@E 9999999.99",""},{93	,0, 28,2, 1,"N","@E 9999999.99",""},{97,0, 30,2, 1,"N","@E 9999999.99",""},{101,0, 32,2, 1,"N","@E 9999999.99",""},;
{105,0, 34,2, 1,"N","@E 9999999.99",""},{109,0, 36,2, 1,"N","@E 9999999.99",""},{113,0, 38,2, 1,"N","@E 9999999.99",""},{117,0, 40,2, 1,"N","@E 9999999.99",""},{121,0, 42,2, 1,"N","@E 9999999.99",""},{125,0, 44,2, 1,"N","@E 9999999.99",""},;
{129,0, 46,2, 1,"N","@E 9999999.99",""},{133,0, 48,2, 1,"N","@E 9999999.99",""},{133,0, 50,2, 1,"N","@E 9999999.99",""}}

aAgingList := {;
{1,0,0,2,1,"N","@!",STR0085},{2,1,0,1,1,"N","@!",STR0086},{3,2,0,1,1,"N","@!",STR0087},{4,3,0,1,1,"N","@!",STR0088},;
{5,4,0,1,1,"N","@!",STR0089},{6,5,0,1,1,"N","@!",STR0090},{7,1,1,1,1,"N","@E 9999999",0},;
{8,2,1,1,1,"N","@E 9999999",0},{9,3,1,1,1,"N","@E 9999999",0},{10,4,1,1,1,"N","@E 9999999",0},{11,5,1,1,1,"N","@E 9999999",0 } }

cQryAl001 := GetNextAlias()

cQuery := " SELECT DISTINCT VEC_NUMOSV NUMOSV, VEC_TIPTEM TIPTEM FROM " + RetSqlName("VEC")
cQuery += " WHERE VEC_FILIAL = '"+xFilial("VEC")+"' AND D_E_L_E_T_ = ' ' AND VEC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'"
cQuery += " UNION"
cQuery += " SELECT DISTINCT VSC_NUMOSV NUMOSV, VSC_TIPTEM TIPTEM FROM " + RetSqlName("VSC")
cQuery += " WHERE VSC_FILIAL = '"+xFilial("VSC")+"' AND D_E_L_E_T_ = ' ' AND VSC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'"
//
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQryAl001, .F., .T. )
//
aOSTTP := {}
aOSTTS := {}
while !((cQryAl001)->(eof()))

	if Empty((cQryAl001)->(NUMOSV))
		(cQryAl001)->(DbSkip())
		loop
	endif

	If Select(cAliasVV1) > 0
		( cAliasVV1 )->( DbCloseArea() )
	EndIf

	cQuery := "SELECT VV1.VV1_CODMAR, VV1.VV1_MODVEI "
	cQuery += "FROM "+RetSqlName( "VV1" ) + " VV1 INNER JOIN " + RetSqlName( "VO1" ) + " VO1 ON "
	cQuery += "( VO1_FILIAL='"+xFIlial("VO1")+"' AND VV1.VV1_CHAINT = VO1.VO1_CHAINT AND VO1.VO1_NUMOSV='"+(cQryAl001)->(NUMOSV)+"' AND VO1.D_E_L_E_T_=' ' ) "
	cQuery += "WHERE "
	cQuery += "VV1.VV1_FILIAL='"+ xFilial("VV1")+ "' AND "
	cQuery += "VV1.D_E_L_E_T_=' ' "
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV1, .T., .T. )

	If Select(cAliasVV2) > 0
		( cAliasVV2 )->( DbCloseArea() )
	EndIf

	cQuery := "SELECT VV2.VV2_TIPVEI TIPVEI "
	cQuery += "FROM "+RetSqlName( "VV2" ) + " VV2 "
	cQuery += "WHERE "
	cQuery += "VV2.VV2_FILIAL='"+ xFilial("VV2") + "' AND VV2.VV2_CODMAR = '"+(cAliasVV1)->VV1_CODMAR+"' AND VV2.VV2_MODVEI = '"+(cAliasVV1)->VV1_MODVEI+"' AND "
	cQuery += "VV2.D_E_L_E_T_=' ' "
	cQuery += "Order By VV2_CODMAR,VV2_MODVEI"
	dbUseArea( .T., "TOPCONN", TcGenQry(,,cQuery), cAliasVV2, .T., .T. )

	lCaminhao := .f.
	lOnibus := .f.

	if (cAliasVV2)->(TIPVEI) $ MV_PAR15
		lOnibus := .t.
	elseif (cAliasVV2)->(TIPVEI) $ MV_PAR16
		lCaminhao := .t.
	endif

	if ((lVaiCaminhoes .and. lCaminhao) .or. (lVaiOnibus .and. lOnibus)) .and. Alltrim((cAliasVV1)->VV1_CODMAR) $ Alltrim(MV_PAR17)
		aOSTTPC := FMX_CALPEC((cQryAl001)->(NUMOSV), (cQryAl001)->(TIPTEM),,,.f.,.f.,.t.,.f.,.t.,.t.,.f.,,"VO3_DATFEC BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'" )
		aOSTTSC := FMX_CALSER((cQryAl001)->(NUMOSV), (cQryAl001)->(TIPTEM),,,.f.,.f.,.f.,.t.,.t.,.f.,,"VSC_DATVEN BETWEEN '"+dtos(MV_PAR01)+"' AND '"+dtos(MV_PAR02)+"'")
		if len(aOSTTPC) > 0
			for nCntFor := 1 to Len(aOSTTPC)
				aAdd(aOSTTP,aOSTTPC[nCntFor])
			next
		endif
		if len(aOSTTSC) > 0
			for nCntFor := 1 to Len(aOSTTSC)
				aAdd(aOSTTS,aOSTTSC[nCntFor])
			next
		endif
	endif
	(cAliasVV2)->(DBCloseArea())
	(cAliasVV1)->(DBCloseArea())
	(cQryAl001)->(dbSkip())
enddo
//
DBSelectArea("VO1")
DBSetOrder(1)
DBSelectArea("VOI")
DBSetOrder(1)
dbSelectArea("VOO")
dbSetOrder(1)
dbSelectArea("VV1")
dbSetOrder(2)

aChassis := {} // Chassis para contagem de passagens
aInfoDetalhe := {}
//
cSRapido 		:= MV_PAR03
cSRevisao 		:= MV_PAR04
cSMecanica 		:= MV_PAR05
cSFunilaria 	:= MV_PAR06
cSPintura   	:= MV_PAR07
cSLavagem 		:= MV_PAR08
cSLubrifica 	:= MV_PAR09
cGPecas     	:= MV_PAR10
cGAcessorios	:= MV_PAR11
cGOutrasMerc	:= MV_PAR12
cGLubComb		:= MV_PAR18
//
if (nHandle := FCREATE("OFRVW01.TXT", FC_NORMAL)) != -1
	for nCntFor = 1 to Len(aOSTTP)
		cStringDBG :=""
		for nCntFor2 = 1 to Len(aOSTTP[nCntFor])
			cStringDBG += Transform(aOSTTP[nCntFor,nCntFor2],"@!") + " | "
		next
		FWRITE(nHandle, cStringDBG + CHR(13) + CHR(10))
	next
	FCLOSE(nHandle)
endif
//
for nCntFor := 1 to Len(aOSTTP)
	// lCntPassagem := .f.
	//
	if !VO1->(DBSeek(xFilial("VO1")+aOSTTP[nCntFor,4]))
		MsgInfo(STR0049+Alltrim(aOSTTP[nCntFor,4])+ STR0050)
		loop
	endif
	// Tipo de Tempo
	if !VOI->(DBSeek(xFilial("VOI")+aOSTTP[nCntFor,3]))
		MsgInfo(STR0040 + aOSTTP[nCntFor,3] + STR0041)
		loop
	endif
	//
//	if !VOO->(dbSeek(xFilial("VOO")+aOSTTP[nCntFor,4]+aOSTTP[nCntFor,3]+IIf(lLIBVOO , VFE->VFE_LIBVOO , "")))
	if !VOO->(dbSeek(xFilial("VOO")+aOSTTP[nCntFor,4]+aOSTTP[nCntFor,3]))  // Não é para considerar Liberação Parcial
		MsgInfo(STR0079 + aOSTTP[nCntFor,3])
		loop
	endif
	//
	nAging = Year(MV_PAR02) - val(left(VV1->VV1_FABMOD,4))
	nPos := aScan(aInfoDetalhe,{|x| x[2]+x[35] == aOSTTP[nCntFor,4]+aOSTTP[nCntFor,3]})
	//
	if nPos == 0
		aAdd(aInfoDetalhe,{0,aOSTTP[nCntFor,4],"","","","","","","","","","","","","","","",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,aOSTTP[nCntFor,3],aOSTTP[nCntFor,19],IIF(VOO->VOO_GARESP == "1","E",VOI->VOI_SITTPO),"ZZ", nAging})
		nPos := Len(aInfoDetalhe)
	endif

	// GRUPOS DE PEÇAS
	if VOI->VOI_DESLOC =="1"
		aInfoDetalhe[nPos,22] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif VOO->VOO_DEPTO $ MV_PAR19
		aInfoDetalhe[nPos,34] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif VOO->VOO_GARESP == "1"
		aInfoDetalhe[nPos,21] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif aOSTTP[nCntFor,1] $ Alltrim(cGPecas)
		aInfoDetalhe[nPos,18] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif aOSTTP[nCntFor,1] $ Alltrim(cGAcessorios)
		aInfoDetalhe[nPos,19] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif aOSTTP[nCntFor,1] $ Alltrim(cGOutrasMerc)
		aInfoDetalhe[nPos,20] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28]  - aOSTTP[nCntFor,7]
	elseif aOSTTP[nCntFor,1] $ Alltrim(cGLubComb)
		aInfoDetalhe[nPos,32] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28] -  aOSTTP[nCntFor,7]
	else
		aInfoDetalhe[nPos,32] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28] -  aOSTTP[nCntFor,7] // <- Acumula o resto em outras vendas (?)
		cMsgErr := STR0081 + aOSTTP[nCntFor,1]
	   nPosErr := aScan(aErros,{|x| x == cMsgErr })
	   if nPosErr == 0
	   	aAdd(aErros,cMsgErr)
	   	MsgInfo(cMsgErr)
	   endif
	endif
	aInfoDetalhe[nPos,33] += aOSTTP[nCntFor,10] - aOSTTP[nCntFor,28] - aOSTTP[nCntFor,7]
next
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////////////////////////
for nCntFor := 1 to Len(aOSTTS)
	lCntPassagem := .f.
	if !VO1->(DBSeek(xFilial("VO1")+aOSTTS[nCntFor,3]))
		MsgInfo(STR0049+Alltrim(aOSTTS[nCntFor,3])+ STR0050)
		loop
	endif
	// Tipo de Tempo
	// DBSetOrder(1)
	if !VOI->(DBSeek(xFilial("VOI")+aOSTTS[nCntFor,4]))
		MsgInfo(STR0040 + aOSTTS[nCntFor,4] + STR0041)
		loop
	endif
	// Veículo
	if !VV1->(DBSeek(xFilial("VV1")+VO1->VO1_CHASSI))
		MsgInfo(STR0091 + Alltrim(VO1->VO1_NUMOSV) + " : " + Alltrim(VO1->VO1_CHASSI))
		loop
	endif
	//
//	if !VOO->(dbSeek(xFilial("VOO")+aOSTTS[nCntFor,3]+aOSTTS[nCntFor,4]+IIf(lLIBVOO , VFE->VFE_LIBVOO , "")))
	if !VOO->(dbSeek(xFilial("VOO")+aOSTTS[nCntFor,3]+aOSTTS[nCntFor,4])) // Não é para considerar Liberação Parcial
		MsgInfo(STR0079+ aOSTTS[nCntFor,3])
		loop
	endif
	
	if aOSTTS[nCntFor,6] = "0" // Não considera MAO DE OBRA GRATUITA (VOK_INCMOB)
		loop
	endif

	nAging = Year(MV_PAR02) - val(left(VV1->VV1_FABMOD,4))
	//
	if aScan(aChassis,{|x| x[1] == VO1->VO1_CHASSI .and. x[2] == aOSTTS[nCntFor,24] }) > 0
		lCntPassagem := .f.
	else
		aAdd(aChassis,{ VO1->VO1_CHASSI,aOSTTS[nCntFor,24] })
		lCntPassagem := .t.
	endif
	//
	cSecOfi := ""
	if aOSTTS[nCntFor,18] $ Alltrim(cSRapido) .or. aOSTTS[nCntFor,18] $ Alltrim(cSMecanica)  .or. aOSTTS[nCntFor,18] $ Alltrim(cSRevisao)
		cSecOfi := "SG"
	elseif aOSTTS[nCntFor,18] $ Alltrim(cSFunilaria) .or. aOSTTS[nCntFor,18] $ Alltrim(cSPintura)
		cSecOfi := "SC"
	elseif aOSTTS[nCntFor,18] $ Alltrim(cSLavagem) .or. aOSTTS[nCntFor,18] $ Alltrim(cSLubrifica)
		cSecOfi := "LL"
	endif
	nPos := aScan(aInfoDetalhe,{|x| x[2]+x[35]+x[38] == aOSTTS[nCntFor,3]+aOSTTS[nCntFor,4]+cSecOfi})
	if nPos == 0
		aAdd(aInfoDetalhe,{iif(lCntPassagem,1,0),aOSTTS[nCntFor,3],"","","","","","","","","","","","","","","",0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,aOSTTS[nCntFor,4],aOSTTS[nCntFor,24],IIF(VOO->VOO_GARESP == "1","E",VOI->VOI_SITTPO),"ZW",nAging})
		nPos := Len(aInfoDetalhe)
	endif
	// VOI_SITTPO:  1=Publico;2=Garantia;3=Interno;4=Revisao;5=VolksTotal
	if VOI->VOI_DESLOC == "1"
		aInfoDetalhe[nPos,7] := "X"
	elseif VOO->VOO_GARESP == "1"
		aInfoDetalhe[nPos,6] := "X"
	elseif VOI->VOI_SITTPO == "1"
		aInfoDetalhe[nPos,3] := "X"
	elseif VOI->VOI_SITTPO == "2"
		aInfoDetalhe[nPos,4] := "X"
	elseif VOI->VOI_SITTPO == "3"
		aInfoDetalhe[nPos,5] := "X"
	endif
	//
	aInfoDetalhe[nPos,8] := IIF(lCntPassagem,"X",aInfoDetalhe[nPos,8])
	// SEÇÃO
	if VOI->VOI_DESLOC != "1"
		nIndValSer := 0
		if VOO->VOO_GARESP == "1"
			aInfoDetalhe[nPos,28] += aOSTTS[nCntFor,9] - aOSTTS[nCntFor,39]
		endif
		if aOSTTS[nCntFor,18] $ Alltrim(cSRapido) // ---------------
			aInfoDetalhe[nPos,9] := "X"
			aInfoDetalhe[nPos,10] := "X"
			nIndValSer := iif(aOSTTS[nCntFor,6] != "2",23,30)
			aInfoDetalhe[nPos,38] := "SG"
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSMecanica) // ---------------
			aInfoDetalhe[nPos,9] := "X"
			if (aInfoDetalhe[nPos,11] == "")
				aInfoDetalhe[nPos,12] := "X"
			endif
			nIndValSer := iif(aOSTTS[nCntFor,6] != "2",25,30)
			aInfoDetalhe[nPos,38] := "SG"
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSRevisao) // ---------------
			aInfoDetalhe[nPos,9] := "X"
			aInfoDetalhe[nPos,11] := "X"
			aInfoDetalhe[nPos,12] := ""
			nIndValSer := iif(aOSTTS[nCntFor,6] != "2",24,30)
			aInfoDetalhe[nPos,38] := "SG"
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSFunilaria) // ---------------
			aInfoDetalhe[nPos,13] := "X"
			aInfoDetalhe[nPos,14] := "X"
			nIndValSer := iif(aOSTTS[nCntFor,6] != "2",26,30)
			aInfoDetalhe[nPos,38] := "SG"
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSPintura) // ---------------
			aInfoDetalhe[nPos,13] := "X"
			aInfoDetalhe[nPos,15] := "X"
			aInfoDetalhe[nPos,38] := "SG"
			nIndValSer := iif(aOSTTS[nCntFor,6] != "2",27,30)
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSLavagem) // ---------------
			aInfoDetalhe[nPos,16] := "X"
			nIndValSer := 31
			aInfoDetalhe[nPos,38] := "LL"
		elseif aOSTTS[nCntFor,18] $ Alltrim(cSLubrifica) // ---------------
			aInfoDetalhe[nPos,17] := "X"
			nIndValSer := 32
			aInfoDetalhe[nPos,38] := "LL"
		else
		   cMsgErr := STR0078+aOSTTS[nCntFor,18]
		   nPosErr := aScan(aErros,{|x| x == cMsgErr })
		   if nPosErr == 0
		   	aAdd(aErros,cMsgErr)
		   	MsgInfo(cMsgErr)
		   endif
		endif
		if aOSTTS[nCntFor,6] == "2"
			aInfoDetalhe[nPos,30] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
			if VOO->VOO_GARESP == "1"
				aInfoDetalhe[nPos,28] -= (aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39])
			endif
			aInfoDetalhe[nPos,33] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
		else
			if nIndValSer != 0
				if VOO->VOO_GARESP != "1"
					aInfoDetalhe[nPos,nIndValSer] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
				endif
				aInfoDetalhe[nPos,33] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
			endif
		endif
	else
		if aOSTTS[nCntFor,6] == "2"
			aInfoDetalhe[nPos,30] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
		else
			aInfoDetalhe[nPos,29] += aOSTTS[nCntFor,9] - aOSTTS[nCntFor,39]
		endif
		aInfoDetalhe[nPos,33] += aOSTTS[nCntFor,9]  - aOSTTS[nCntFor,39]
	endif
next
(cQryAl001)->(dbCloseArea())

aSort(aInfoDetalhe,,,{|x,y| x[2]+x[37]+x[38] < y[2]+y[37]+y[38] })
//
if (nHandle := FCREATE("OFRVW01B.TXT", FC_NORMAL)) != -1
	for nCntFor = 1 to Len(aInfoDetalhe)
		cStringDBG :=""
		for nCntFor2 = 1 to Len(aInfoDetalhe[nCntFor])
			cStringDBG += Transform(aInfoDetalhe[nCntFor,nCntFor2],"@!") + " | "
		next
		FWRITE(nHandle, cStringDBG + CHR(13) + CHR(10))
	next
	FCLOSE(nHandle)
endif
//


cOSAtu := "00000000XXXXYY"
aInfoDTmp:= {}

for nCntFor := 1 to Len(aInfoDetalhe)
	if aInfoDetalhe[nCntFor,38] == "ZZ" .or. aInfoDetalhe[nCntFor,38] == "ZW"
		nPosDF := aScan(aInfoDTmp,{|x| x[2]+x[37]+dtos(x[36]) == aInfoDetalhe[nCntFor,2]+aInfoDetalhe[nCntFor,37]+dtos(aInfoDetalhe[nCntFor,36]) })
	else
		nPosDF := aScan(aInfoDTmp,{|x| x[2]+x[37]+x[38]+dtos(x[36]) == aInfoDetalhe[nCntFor,2]+aInfoDetalhe[nCntFor,37]+aInfoDetalhe[nCntFor,38]+dtos(aInfoDetalhe[nCntFor,36]) })
	endif
	if nPosDF == 0
		aAdd(aInfoDTmp,	aInfoDetalhe[nCntFor])
		nPosDF := Len(aInfoDTmp)
	else
		aInfoDTmp[nPosDF,1] = IIF(aInfoDetalhe[nCntFor,1]==1,1,aInfoDTmp[nPosDF,1])
		for nCntFor2 := 3 to 17
			aInfoDTmp[nPosDF,nCntFor2] = IIF( aInfoDetalhe[nCntFor,nCntFor2]=="X","X",aInfoDTmp[nPosDF,nCntFor2])
		next
		for nCntFor2 := 18 to 34
			aInfoDTmp[nPosDF,nCntFor2] += aInfoDetalhe[nCntFor,nCntFor2]
		next
		VOI->(DBSeek(xFilial("VOI")+aInfoDetalhe[nCntFor,3]))
		if VOI->VOI_DESLOC == "1"
			aInfoDTmp[nPosDF,35] = aInfoDetalhe[nCntFor,35]
		endif
	endif
next

aInfoDetalhe := aClone(aInfoDTmp)

for nCntFor := 1 to Len(aInfoDetalhe)
	if aInfoDetalhe[nCntFor,22] > 0 .or. aInfoDetalhe[nCntFor,29] > 0
		aInfoDetalhe[nCntFor,22] += aInfoDetalhe[nCntFor,34]+aInfoDetalhe[nCntFor,21]+aInfoDetalhe[nCntFor,18]+aInfoDetalhe[nCntFor,19]+ aInfoDetalhe[nCntFor,20]+aInfoDetalhe[nCntFor,32]
		aInfoDetalhe[nCntFor,34] := aInfoDetalhe[nCntFor,21] := aInfoDetalhe[nCntFor,18] := aInfoDetalhe[nCntFor,19] := aInfoDetalhe[nCntFor,20] := aInfoDetalhe[nCntFor,32] := 0
		for nCntFor2 := 3 to 17
			aInfoDetalhe[nCntFor,nCntFor2] = ""
		next
		aInfoDetalhe[nCntFor,7] = "X"
	endif
	if aInfoDetalhe[nCntFor,13]=="X"
		aInfoDetalhe[nCntFor,9] := aInfoDetalhe[nCntFor,10] := aInfoDetalhe[nCntFor,11] := aInfoDetalhe[nCntFor,12] := ""
	endif
next

aSort(aInfoDetalhe,,,{|x,y| dtos(x[36]) + x[2] < dtos(y[36]) + y[2]})
if Len(aInfoDetalhe) == 0
	MsgStop(STR0082,STR0083)
	return
endif

nPassagens := 0
for nCntFor := 1 to Len(aInfoDetalhe)
	nPassagens +=aInfoDetalhe[nCntFor,1]
	aInfoDetalhe[nCntFor,1] := nPassagens
next

oPrinter := FWMSPrinter():New("OFIRVW01", IMP_PDF, .f.,CSTARTPATH , .t.)
oPrinter:SetLandscape()
oPrinter:SetPaperSize(DMPAPER_A4)
oPrinter:SetMargin(0,0,0,0)
oPrinter:cPathPDF := CSTARTPATH

oPrinter:StartPage()

aTitulo := {{1,0,0,2,1,"C","@!", DTOC(aInfoDetalhe[1,36])},{2,0,2,46,1,"C","@!", cStrTit},{3,0,48,2	,1,"C","@!", Alltrim(STR(nPag))}}

nMax := FGX_MntTab(oPrinter, aTitulo, 12, 2)
nMax += 2
nMax := FGX_MntTab(oPrinter, aCabec, nMax, 2)
nMax += 2
//nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2)
//nMax += 2

dAnterior = ctod("00/00/00")
aAcumDia := array(148)
aAcumTotal := array(148)
for nCntFor := 1 to Len(aAcumTotal)
	aAcumDia[nCntFor] = 0
	aAcumTotal[nCntFor] = 0
next
nAcumAnt = 0
for nCntFor = 1 to Len(aInfoDetalhe)
	if aInfoDetalhe[nCntFor,36] != dAnterior
		if nCntFor != 1
			aAcumDia[1] = aInfoDetalhe[nCntFor - 1,1] - nAcumAnt
			nAcumAnt += aAcumDia[1]
			nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2, aAcumDia)
			nMax += 2
			// zera diario
			for nCntFor2 := 1 to Len(aAcumDia)
				aAcumTotal[nCntFor2] += aAcumDia[nCntFor2]
				aAcumDia[nCntFor2] = 0
			next
			//
			if mv_par21 == 2
				nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2,aAcumTotal )
				nMax += 2
				oPrinter:EndPage()
				oPrinter:StartPage()
				nPag++
				nMax = 12
			endif
			//
			aTitulo := {{1,0,0,2,1,"C","@!", DTOC(aInfoDetalhe[nCntFor,36])},{2,0,2,46,1,"C","@!", cStrTit},{3,0,48,2	,1,"C","@!", Alltrim(STR(nPag))}}
			nMax := FGX_MntTab(oPrinter, aTitulo, nMax, 2)
			nMax += 2
			if mv_par21 == 2
				nMax := FGX_MntTab(oPrinter, aCabec, nMax, 2)
				nMax += 2
				nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2,aAcumTotal )
				nMax += 2
			endif
		endif
		dAnterior = aInfoDetalhe[nCntFor,36]
	endif
	if nMax > 470
		oPrinter:EndPage()
		oPrinter:StartPage()
		nPag++
		aTitulo := {{1,0,0,2,1,"C","@!", DTOC(aInfoDetalhe[nCntFor,36])},{2,0,2,46,1,"C","@!", cStrTit},{3,0,48,2	,1,"C","@!", Alltrim(STR(nPag))}}
		nMax := FGX_MntTab(oPrinter, aTitulo, 12, 2)
		nMax += 2
		nMax := FGX_MntTab(oPrinter, aCabec, nMax, 2)
		nMax += 2
	endif
	if mv_par21 == 2
		nMax := FGX_MntTab(oPrinter, aDetalhe, nMax, 2,aInfoDetalhe[nCntFor])
	endif
	// ===================
	// A C U M U L A D O S
	// ===================
	aAcumDia[7] += IIF(aInfoDetalhe[nCntFor,3]="X",1,0)
	aAcumDia[10] += IIF(aInfoDetalhe[nCntFor,4]="X",1,0)
	aAcumDia[13] += IIF(aInfoDetalhe[nCntFor,5]="X" .and. !(aInfoDetalhe[nCntFor,35] $ MV_PAR20) ,1,0)
	aAcumDia[120] += IIF(aInfoDetalhe[nCntFor,5]="X" .and. aInfoDetalhe[nCntFor,35] $ MV_PAR20 ,1,0)
	aAcumDia[19] += IIF(aInfoDetalhe[nCntFor,6]="X",1,0)
	if aInfoDetalhe[nCntFor,8]=="X"
		nAging := aInfoDetalhe[nCntFor,39] // aging para deslocamento
		if nAging <= 1
			aAgingList[7,8]++		
		elseif nAging <= 3
			aAgingList[8,8]++		
		elseif nAging <= 5
			aAgingList[9,8]++		
		elseif nAging <= 10
			aAgingList[10,8]++		
		else				
			aAgingList[11,8]++
		endif
	endif
	if aInfoDetalhe[nCntFor,7]="X"
		VOI->(DBSeek(xFilial("VOI")+aInfoDetalhe[nCntFor,35]))
		if VOI->VOI_SITTPO == "1"
			aAcumDia[21] += 1
		elseif VOI->VOI_SITTPO == "2"
			aAcumDia[22] += 1
		elseif VOI->VOI_SITTPO == "3"
			aAcumDia[23] += 1
		else
			aAcumDia[25] += 1
		endif
	endif
	aAcumDia[26] += IIF(aInfoDetalhe[nCntFor,8]="X",1,0)

	nInc := -1
	if aInfoDetalhe[nCntFor,3] == "X"  //SITTPO = 1
		nInc := 0
	elseif aInfoDetalhe[nCntFor,4] == "X" //SITTPO = 2
		nInc := 1
	elseif aInfoDetalhe[nCntFor,5] == "X" //SITTPO = 3
		if aInfoDetalhe[nCntFor,35] $ MV_PAR20
			aAcumDia[123] += IIF(aInfoDetalhe[nCntFor,9]="X",1,0)
			aAcumDia[124] += IIF(aInfoDetalhe[nCntFor,10]="X",1,0)
			aAcumDia[125] += IIF(aInfoDetalhe[nCntFor,11]="X",1,0)
			aAcumDia[126] += IIF(aInfoDetalhe[nCntFor,13]="X",1,0)
			aAcumDia[127] += IIF(aInfoDetalhe[nCntFor,14]="X",1,0)
			aAcumDia[128] += IIF(aInfoDetalhe[nCntFor,15]="X",1,0)
   
			aAcumDia[60] += aInfoDetalhe[nCntFor,18]
			aAcumDia[66] += aInfoDetalhe[nCntFor,20]
 
			aAcumDia[129] += aInfoDetalhe[nCntFor,19]
			aAcumDia[130] += aInfoDetalhe[nCntFor,21]
			aAcumDia[131] += aInfoDetalhe[nCntFor,22]
			aAcumDia[132] += aInfoDetalhe[nCntFor,23]
			aAcumDia[133] += aInfoDetalhe[nCntFor,24]
			aAcumDia[134] += aInfoDetalhe[nCntFor,25]
			aAcumDia[135] += aInfoDetalhe[nCntFor,26]
			aAcumDia[136] += aInfoDetalhe[nCntFor,27]
			aAcumDia[137] += aInfoDetalhe[nCntFor,28]
			aAcumDia[138] += aInfoDetalhe[nCntFor,29]
			aAcumDia[143] += aInfoDetalhe[nCntFor,30]
            
			nIncAging := 0
			nIncAging += IIF(aInfoDetalhe[nCntFor,10]="X",1,0)
			nIncAging += IIF(aInfoDetalhe[nCntFor,11]="X",1,0)
			nIncAging += IIF(aInfoDetalhe[nCntFor,12]="X",1,0)
			nIncAging += IIF(aInfoDetalhe[nCntFor,13]="X",1,0)

/*			if aInfoDetalhe[nCntFor,6]=="X"
				nAging := aInfoDetalhe[nCntFor,39]
				if nAging < 1
					aAgingList[7,8] += nIncAging		
				elseif nAging < 3
					aAgingList[8,8] += nIncAging		
				elseif nAging < 5
					aAgingList[9,8] += nIncAging
				elseif nAging < 10
					aAgingList[10,8] += nIncAging
				else				
					aAgingList[11,8] += nIncAging
				endif
			endif
*/

			nInc := -2
		else
			nInc := 2
		endif

	elseif aInfoDetalhe[nCntFor,37] == "E"
		nInc := 3
	else
		// TODO: O que fazer com revisão(4)?
	endif
	//
	if nInc != -2
		if nInc == -1
			// VOI_SITTPO:  1=Publico;2=Garantia;3=Interno;4=Revisao
			if aInfoDetalhe[nCntFor,37] == "2"
				nInc := 1
			elseif  aInfoDetalhe[nCntFor,37] == "3"
				nInc := 2
			elseif  aInfoDetalhe[nCntFor,37] == "1"
				nInc := 0
			endif
		endif
		//
		if nInc >= 0 // TODO: Prever todos os tipo de tempo para não ter (-1)
			aAcumDia[27 + nInc] += IIF(aInfoDetalhe[nCntFor,9]="X",1,0)
			aAcumDia[32 + nInc] += IIF(aInfoDetalhe[nCntFor,10]="X",1,0)
			aAcumDia[37 + nInc] += IIF(aInfoDetalhe[nCntFor,11]="X",1,0)
			
			nIncAging := 0
			nIncAging += IIF(aInfoDetalhe[nCntFor,10]="X",1,0)
			nIncAging += IIF(aInfoDetalhe[nCntFor,11]="X",1,0)
			nIncAging += IIF(aInfoDetalhe[nCntFor,12]="X",1,0)
/*		
			if aInfoDetalhe[nCntFor,6]=="X"
				nAging := aInfoDetalhe[nCntFor,39]
				if nAging < 1
					aAgingList[7,8] += nIncAging		
				elseif nAging < 3
					aAgingList[8,8] += nIncAging		
				elseif nAging < 5
					aAgingList[9,8] += nIncAging		
				elseif nAging < 10
					aAgingList[10,8] += nIncAging		
				else				
					aAgingList[11,8] += nIncAging		
				endif
			endif
*/
		endif
		
		if nInc >= 0 // TODO: Prever todos os tipo de tempo para não ter (-1)
			if nInc == 0
				aAcumDia[42] += IIF(aInfoDetalhe[nCntFor,12]="X",1,0)
			else
				aAcumDia[143 + nInc] += IIF(aInfoDetalhe[nCntFor,12]="X",1,0)
			endif
			aAcumDia[43 + nInc] += IIF(aInfoDetalhe[nCntFor,13]="X",1,0)
			aAcumDia[48 + nInc] += IIF(aInfoDetalhe[nCntFor,14]="X",1,0)
			aAcumDia[53 + nInc] += IIF(aInfoDetalhe[nCntFor,15]="X",1,0)
			
			nIncAging := 0
			nIncAging += IIF(aInfoDetalhe[nCntFor,13]="X",1,0)
			nAging := aInfoDetalhe[nCntFor,39]
  /*
  			if aInfoDetalhe[nCntFor,6]=="X"
				if nAging < 1
					aAgingList[7,8] += nIncAging		
				elseif nAging < 3
					aAgingList[8,8] += nIncAging		
				elseif nAging < 5
					aAgingList[9,8] += nIncAging
				elseif nAging < 10
					aAgingList[10,8] += nIncAging
				else				
					aAgingList[11,8] += nIncAging
				endif
			endif
	*/
		endif

		aAcumDia[58] += IIF(aInfoDetalhe[nCntFor,16]="X",1,0)
		aAcumDia[59] += IIF(aInfoDetalhe[nCntFor,17]="X",1,0)
		aAcumDia[60] += aInfoDetalhe[nCntFor,18]
		aAcumDia[66] += aInfoDetalhe[nCntFor,20]
		if nInc >= 0 // TODO: Prever todos os tipo de tempo para não ter (-1)
			aAcumDia[61 + nInc] += aInfoDetalhe[nCntFor,19]
			aAcumDia[67 + nInc] += aInfoDetalhe[nCntFor,21]
			aAcumDia[72 + nInc] += aInfoDetalhe[nCntFor,22]
			aAcumDia[77 + nInc] += aInfoDetalhe[nCntFor,23]
			aAcumDia[82 + nInc] += aInfoDetalhe[nCntFor,24]
			aAcumDia[87 + nInc] += aInfoDetalhe[nCntFor,25]
			aAcumDia[92 + nInc] += aInfoDetalhe[nCntFor,26]
			aAcumDia[97 + nInc] += aInfoDetalhe[nCntFor,27]
			aAcumDia[102 + nInc] += aInfoDetalhe[nCntFor,28]
			aAcumDia[107 + nInc] += aInfoDetalhe[nCntFor,29]
			if nInc = 0
				aAcumDia[112] += aInfoDetalhe[nCntFor,30]
			else
				aAcumDia[138 + nInc] += aInfoDetalhe[nCntFor,30]
			endif
		endif
		//
		aAcumDia[113] += aInfoDetalhe[nCntFor,31]
		aAcumDia[114] += aInfoDetalhe[nCntFor,32]
		aAcumDia[115] += aInfoDetalhe[nCntFor,33]
		aAcumDia[116] += aInfoDetalhe[nCntFor,34]
		//
	endif
next  

aAcumDia[1] = aInfoDetalhe[Len(aInfoDetalhe),1] - nAcumAnt
nMax += 2
nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2, aAcumDia)
nMax += 2
for nCntFor2 := 1 to Len(aAcumDia)
	aAcumTotal[nCntFor2] += aAcumDia[nCntFor2]
	aAcumDia[nCntFor2] = 0
next
//
nMax := FGX_MntTab(oPrinter, aAcumula, nMax, 2,aAcumTotal )
oPrinter:EndPage()  

oPrinter:StartPage()
nMax := FGX_MntTab(oPrinter, aAgingList,12,2, ,192)
oPrinter:EndPage()
oPrinter:Setup()
if oPrinter:nModalResult == PD_OK
	oPrinter:Preview()
EndIf
Return
/*
===============================================================================
###############################################################################
##+----------+------------+-------+-----------------------+------+----------+##
##|Função    | CriaSX1    | Autor | André Delorme         | Data | 17/04/13 |##
##+----------+------------+-------+-----------------------+------+----------+##
###############################################################################
===============================================================================
*/
Static Function CriaSX1()
Local aSX1    := {}
Local aEstrut := {}
Local i       := 0
Local j       := 0
Local lSX1	  := .F.
//
if cPerg == ""
	return
endif
//
aEstrut:= { "X1_GRUPO"  ,"X1_ORDEM","X1_PERGUNT","X1_PERSPA","X1_PERENG" ,"X1_VARIAVL","X1_TIPO" ,"X1_TAMANHO","X1_DECIMAL","X1_PRESEL"	,;
"X1_GSC"    ,"X1_VALID","X1_VAR01"  ,"X1_DEF01" ,"X1_DEFSPA1","X1_DEFENG1","X1_CNT01","X1_VAR02"  ,"X1_DEF02"  ,"X1_DEFSPA2"	,;
"X1_DEFENG2","X1_CNT02","X1_VAR03"  ,"X1_DEF03" ,"X1_DEFSPA3","X1_DEFENG3","X1_CNT03","X1_VAR04"  ,"X1_DEF04"  ,"X1_DEFSPA4"	,;
"X1_DEFENG4","X1_CNT04","X1_VAR05"  ,"X1_DEF05" ,"X1_DEFSPA5","X1_DEFENG5","X1_CNT05","X1_F3"     ,"X1_GRPSXG" ,"X1_PYME"}
//################################################################
//# aAdd a Pergunta                                              #
//################################################################
aAdd(aSX1,{cPerg,"01",STR0051,STR0051,STR0051,"MV_CH1","D",8 ,0,0,"G","","mv_par01","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"02",STR0052,STR0052,STR0052,"MV_CH2","D",8 ,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"03",STR0053,STR0053,STR0053,"MV_CH3","C",40,0,0,"G","","mv_par03","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"04",STR0054,STR0054,STR0054,"MV_CH4","C",40,0,0,"G","","mv_par04","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"05",STR0055,STR0055,STR0055,"MV_CH5","C",40,0,0,"G","","mv_par05","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"06",STR0056,STR0056,STR0056,"MV_CH6","C",40,0,0,"G","","mv_par06","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"07",STR0057,STR0057,STR0057,"MV_CH7","C",40,0,0,"G","","mv_par07","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"08",STR0058,STR0058,STR0058,"MV_CH8","C",40,0,0,"G","","mv_par08","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"09",STR0059,STR0059,STR0059,"MV_CH9","C",40,0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"10",STR0060,STR0060,STR0060,"MV_CHA","C",40,0,0,"G","","mv_par10","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"11",STR0061,STR0061,STR0061,"MV_CHB","C",40,0,0,"G","","mv_par11","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"12",STR0062,STR0062,STR0062,"MV_CHC","C",40,0,0,"G","","mv_par12","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"13",STR0063,STR0063,STR0063,"MV_CHD","C",40,0,0,"G","","mv_par13","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"14",STR0065,STR0065,STR0065,"MV_CHE","N",1,0,0,"C","","mv_par14",STR0073,"","","","",STR0074,"","","","",STR0075,"","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"15",STR0066,STR0066,STR0066,"MV_CHF","C",40,0,0,"G","","mv_par15","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"16",STR0067,STR0067,STR0067,"MV_CHG","C",40,0,0,"G","","mv_par16","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"17",STR0068,STR0068,STR0068,"MV_CHH","C",40,0,0,"G","","mv_par17","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"18",STR0069,STR0069,STR0069,"MV_CHI","C",40,0,0,"G","","mv_par18","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"19",STR0070,STR0070,STR0070,"MV_CHJ","C",40,0,0,"G","","mv_par19","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"20",STR0071,STR0071,STR0071,"MV_CHK","C",40,0,0,"G","","mv_par20","","","","","","","","","","","","","","","","","","","","","","","","","",""	,"S"})
aAdd(aSX1,{cPerg,"21",STR0072,STR0072,STR0072,"MV_CHL","N",1,0,0,"C","","mv_par21",STR0076,"","","","",STR0077,"","","","","","","","","","","","","","","","","","","",""	,"S"})
//
ProcRegua(Len(aSX1))
//
dbSelectArea("SX1")
dbSetOrder(1)
For i:= 1 To Len(aSX1)
	If !Empty(aSX1[i][1])
		lAchou := dbSeek(Left(Alltrim(aSX1[i,1])+SPACE(100),Len(SX1->X1_GRUPO))+aSX1[i,2])
		lSX1 := .T.
		RecLock("SX1",!lAchou)
		For j:=1 To Len(aSX1[i])
			If !Empty(FieldName(FieldPos(aEstrut[j])))
				if !lAchou .or. (Left(aEstrut[j],6) != "X1_CNT" .and. aEstrut[j] !="X1_PRESEL")
					FieldPut(FieldPos(aEstrut[j]),aSX1[i,j])
				endif
			EndIf
		Next j
		dbCommit()
		MsUnLock()
	EndIf
Next i
//
return
