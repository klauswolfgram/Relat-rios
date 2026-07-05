/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 11     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "Protheus.ch"
#Include "Folder.ch"
#Include "Fileio.ch"
#Include "VEIVR210.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ VEIVR210 º Autor ³ Manoel             º Data ³  22/06/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Lista Despesas de Veiculos                     			  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Concessionarias                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VEIVR210()

Private cAlias     := "VVD"
Private cDesc1     := STR0001  //Despesas do Veiculo
Private cDesc2     := ""
Private cDesc3     := ""
Private nLin       := 0
Private cTamanho   := "P"          // P/M/G
Private Limite     := 80           // 80/132/220
Private cTitulo    := STR0001 //Despesas do Veiculo
Private cNomeProg  := "VEIVR210"
Private cNomeRel   := "VEIVR210"
Private nLastKey   := 0
Private nCaracter  := 18
Private lAbortPrint:= .f.
Private cString    := "VVD"
Private Li         := 80
Private m_Pag      := 1
Private wnRel      := "VEIVR210"
Private nPos       := 0
Private ni         := 0
Private aReturn    := { OemToAnsi(STR0002), 1,OemToAnsi(STR0003), 1, 1, 1, "",2 }		//1-ZEBRADO,2-,3-ADMINISTRACAO,4-1:COMPACTA,2:NAO,5-MIDIA 1:DISCO,6-CRYSTAL,7-,8-ORDEM

//cPerg := Padr("PVR210",len(SX1->X1_GRUPO))
cPerg := "PVEIR210"

ValidPerg(cPerg)

Pergunte(cPerg,.f.)

Processa( {|| FS_Imprime() } )

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPRIMEº Autor ³ Manoel             º Data ³  17/06/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Impressao dos Dados de Estoque de Veiculos 		          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Concessionarias                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_Imprime()

Local _i_         := 0
Local nTotRec     := 0
Local nTotDeS     := 0
Local lVVD_FILENT := VVD->(FieldPos("VVD_FILENT")) <> 0
Local cQuery      := ""
Local cQAlSQL     := "ALIASSQL"	


// Armazena dados da impressao
aVetor := {}
//  1o. Elemento - Codigoda Despesa
//  2o. Elemento - Descricao da Despesa
//  3o. Elemento - Data da Despesa
//  4o. Elemento - Valor da Despesa

wnrel:= "VEIVR210"
wnrel:=SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,,.T.,cTamanho)

if Empty(MV_PAR02) .AND. Empty(MV_PAR03)
	MsgStop(STR0005)
	Return
Endif	
dbSelectArea("VV1")     
if !Empty(MV_PAR02)
	nOrd := 2 
	cPesq := MV_PAR02
Else
	nOrd := 9
	cPesq := MV_PAR03
Endif	
DbSetOrder(nOrd)
If  !dbseek(xFilial("VV1")+Upper(cPesq)) 
	MsgStop(STR0005)
	Return
Endif
If nLastKey == 27
	Set Filter to
	Return
Endif

Set Printer to &wnrel
Set Printer On
Set Device  to Printer

SetDefault(aReturn,cString)

If nLastKey == 27
	Set Filter To
	Return
Endif

li         := 80
m_pag      := 1
nTipo      := 18
nCaracter  := 18


dbSelectArea("VV2")
DbSetOrder(1)
dbseek(xFilial("VV2")+VV1->VV1_CODMAR+VV1->VV1_MODVEI)
dbSelectArea("VVC")
DbSetOrder(1)
dbseek(xFilial("VVC")+VV1->VV1_CODMAR+VV1->VV1_CORVEI)
dbSelectArea("VAE")
DbSetOrder(1)
dbseek(xFilial("VAE")+VV1->VV1_STATUS)

cCombus := Padr(X3CBOXDESC("VV1_COMVEI",VV1->VV1_COMVEI),11," ")
cAnoMod := subs(VV1->VV1_FABMOD,3,2)+"/"+subs(VV1->VV1_FABMOD,7,2)
nTotDes := 0

cQuery := "SELECT VVD.* FROM "+RetSqlName("VVD")+" VVD "
If !lVVD_FILENT
	cQuery += " WHERE VVD.VVD_FILIAL = '" + VV1->VV1_FILENT + "'" // antes do VVD_FILENT
Else
	cQuery += " WHERE ( ( VVD.VVD_FILIAL = '" + xFilial("VVD") + "' AND VVD.VVD_FILENT = '" + VV1->VV1_FILENT + "' ) " // novos registros
	cQuery += "       OR (VVD.VVD_FILIAL = '" + VV1->VV1_FILENT + "' AND VVD.VVD_FILENT = ' ' ) ) " // registro antigos
Endif
cQuery+= " AND VVD.VVD_CHAINT='"+VV1->VV1_CHAINT+"'  AND VVD.VVD_TRACPA='"+VV1->VV1_TRACPA+"' AND VVD.D_E_L_E_T_=' ' "
dbUseArea( .T., "TOPCONN", TcGenQry( ,, cQuery ), cQAlSQL , .F., .T. )
While !( cQAlSQL )->( Eof() )//existe o resgitro
	Iif(( cQAlSQL )->VVD_TIPOPE=='1',nTotRec += ( cQAlSQL )->VVD_VALOR,nTotDes += ( cQAlSQL )->VVD_VALOR)
	
	aadd(aVetor,{( cQAlSQL )->VVD_CODIGO+" "+substr(( cQAlSQL )->VVD_DESCRI,1,30)+" ",; // 01
					DTOC(Stod(( cQAlSQL )->VVD_DATADR))+"     ",;  // 02
					transform(( cQAlSQL )->VVD_VALOR,"@E 999,999.99")+" ",; // 03
					Iif(( cQAlSQL )->VVD_TIPOPE=='1',"(+)","(-)")}) // 04
	( cQAlSQL )->( DbSkip() )
Enddo
( cQAlSQL )->( DbcloseArea() )


cCabec1 := STR0006 //"Tp Operação          Descrição                       Data          Valor"
cCabec2 := "-----------          --------------------          ---------     ----------"
//			xxxxxxxxxxx          xxxxxxxxxxxxxxxxxxxx          99/99/99   99,999,999.99
//			123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//				     10        20        30        40        50        60        70        80        90        100       110       120       130

cabec(cTitulo,STR0021,"",cNomeprog,cTamanho,nTipo)  //"Dados do Veículo"

@ li++,00 psay STR0007  + Space(29) + STR0008  //Placa ### Chassi
@ li++,00 psay left(Transform(VV1->VV1_PLAVEI,VV1->(X3PICTURE("VV1_PLAVEI")))+space(40),40) + " " + VV1->VV1_CHASSI
li++
@ li++,00 psay STR0009  + Space(29) + STR0010  //Cor ### Modelo
@ li++,00 psay left(VVC->VVC_DESCRI,14) + Space(27) + left(VV1->VV1_MODVEI,6)+" "+left(VV2->VV2_DESMOD,20)
li++
@ li++,00 psay STR0011  + Space(29) + STR0012  //Ano/modelo ### Combustivel
@ li++,00 psay cAnoMod         + Space(36) + cComBus
li++
@ li  ,00 psay VV1->VV1_STATUS + " - " + VAE->VAE_DESCRI
Li := Li + 2
@ li  ,00 psay repl("-",80)
li++
@ li,00  PSAY cCabec1
li:=li+1
@ li,00  PSAY cCabec2
li:=li+2
      
aSort(aVetor,,,{|x,y| x[2] < y[2]})

For _i_ := 1 to Len(aVetor)
	
	If li > 56
		
		cabec(cTitulo,cCabec1,cCabec2,cNomeprog,cTamanho,nTipo)
		li:=li+2
		@li,00  PSAY cCabec1
		li:=li+1
		@li,00  PSAY cCabec2
		li:=li+2
		
	Endif
	
	@ li++,00 PSAY aVetor[_i_,01]+aVetor[_i_,02]+aVetor[_i_,03]+aVetor[_i_,04]
	
Next

Li := Li + 2
@ li  ,00 psay STR0013 + Transform(nTotRec-nTotDes,"@E 99,999,999.99") //"Total das Receitas-Despesas ................"


ms_flush()

Set Printer to
set Device  to Screen

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

Return .t.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ValidPerg º Autor ³ Manoel             º Data ³  17/06/2005 º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Valida perguntes.								          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Concessionarias                                            º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ValidPerg(cPerg)
local _sAlias := Alias()
local aRegs := {}
local i,j

cPerg := Padr(cPerg,len(SX1->X1_GRUPO))
dbSelectArea("SX1")
dbSetOrder(1)
If dbSeek(cPerg+"01")
	if Alltrim(SX1->X1_PERGUNT) == STR0022 
		RecLock("SX1",.F.,.T.)
		dbdelete()
		MsUnlock()
	Endif
Endif

// Grupo/Ordem/Pergunta/Variavel/Tipo/Tamanho/Decimal/Presel/GSC/Valid/Var01/Def01/Cnt01/Var02/Def02/Cnt02/Var03/Def03/Cnt03/Var04/Def04/Cnt04/Var05/Def05/Cnt05
aAdd(aRegs,{cPerg,"01",STR0023,"","","mv_ch1","C",25,0,0,"G","U_VR210GETKEY()","Mv_Par01","","","","","","","","","","","","","","","","","","","","","","","","","V14","","","","",""})
aAdd(aRegs,{cPerg,"02",STR0024,"","","mv_ch2","C",25,0,0,"G","","Mv_Par02","","","","","","","","","","","","","","","","","","","","","","","","","VV1","","","","",""})
aAdd(aRegs,{cPerg,"03",STR0022,"","","mv_ch3","C",10,0,0,"G","","Mv_Par03","","","","","","","","","","","","","","","","","","","","","","","","","","","","",VV1->(X3PICTURE("VV1_PLAVEI")),""})

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

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡Æo    ³ FS_GetKey³ Autor ³  Emilton              ³ Data ³ 19/07/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡Æo ³ Apresenta Dados de Veiculos para Orcamento                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ Generico                                                   ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function VR210GETKEY()

Local lReturn := .f.
Private cPesqVV1 := MV_PAR01

If Empty(MV_PAR01)
	Return(.t.)
EndIf

lReturn := FG_POSVEI("cPesqVV1",)

if !lReturn
	return(lReturn)
endif

DBSelectArea("VV1")
MV_PAR01 := space(25)
MV_PAR02 := VV1->VV1_CHASSI
MV_PAR03 := VV1->VV1_PLAVEI

Return(.T.)
