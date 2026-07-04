/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "rwmake.ch"        // incluido por el asistente de conversión del AP5 IDE en 01/06/00
#include "finr15h.ch"

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funci¢n   ³ FINR15H  ³ Autor ³ Diego Fernando Rivero         ³ Fecha ³ 11/01/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip.  ³ Informe de Facturas en Abierto con opci¢n de mostrar                ³±±
±±³          ³ los cheques en cartera del Proveedor                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³             ACTUALIZACIONES SUFRIDAS DESDE EL DESARROLLO.                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ FECHA  ³     BOPS    ³  MOTIVO DE LA ALTERACION                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Bruno         ³10.05.00³xxxxxx       ³Correcao quando pedido so carteira.       ³±±
±±³Joao          ³31.05.00³xxxxxx       ³Alteracao do Programa para Contas a Pagar ³±±
±±³Paulo Augusto ³07.07.06³xxxxxx       ³Conversao Release 4                       ³±±
±±³Alf. Medrano  ³08/12/16³SERINN001-134³se quita la creacion de tablas tem        ³±±
±±³              ³        ³             ³-porales y se asigna FWTemporaryTable     ³±±
±±³              ³        ³             ³en fun ReportPrint                        ³±±
±±³Alf. Medrano  ³12/01/17³SERINN001-134³Merge Main vs 12.1.15                     ³±±
±±³Dora Vega     ³17/03/17³  MMI-267    ³Merge de replica del llamado TVVIC8.      ³±±
±±³              ³        ³             ³Cambios en funcion finr15h para mostrar   ³±±
±±³              ³        ³             ³los campos e2_emissao, e2_vencto.(ARG)    ³±±
±±³   Marco A.   ³16/04/18³ DMINA-2310  ³Se remueven sentencias CriaTrab y se apli-³±±
±±³              ³        ³             ³ca FWTemporaryTable(), para el manejo de  ³±±
±±³              ³        ³             ³las tablas temporales.                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function finr15h()


Local oReport	:= Nil

Private oTmpTable := Nil

SetPrvt("CTITULO")

SetPrvt("CARQTRAB,CARQTRAB1")

If !ExistBlock("FARGTIP")
   MsgAlert(OemToAnsi(STR0001),OemToAnsi(STR0002)) //"Bloque FARGTIP no encontrado","RDMAKE no Existe!"
   Return
EndIf

If TRepInUse()
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Interface de impressao ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	oReport	:= ReportDef()
	oReport:PrintDialog()
EndIf

If oTmpTable <> Nil  
	DbSelectArea("TRB")
	DbCloseArea()
	oTmpTable:Delete() 
	oTmpTable := Nil 
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportDef  ºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Definicion de Impresion para el Reporte.                     º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportDef()
Local oReport,oSection1,oSection2
Local cReport := "FINR15H"
Local cTitulo := OemToAnsi(STR0003)
Local cDescri := OemToAnsi(STR0003)

Pergunte( "FIN15H" , .F. )

oReport  := TReport():New( cReport, cTitulo, "FIN15H" , { |oReport| ReportPrint( oReport, "TRB" ) }, cDescri )

oSection1 := TRSection():New( oReport,STR0038 , {"TRB","SA2","SE2"} )


TRCell():New( oSection1, "E2_FORNECE" 	,"SE2",/*X3Titulo*/    	,/*Picture*/				,TAMSX3("E2_FORNECE" )[1] ,/*lPixel*/,{||TRB->TR_FORNECE})
TRCell():New( oSection1, "A2_NOME" 		,"SA2",/*X3Titulo*/  	,/*Picture*/				, /*Tamanho*/,/*lPixel*/,{||TRB->TR_NOME})	
TRCell():New( oSection1, "DESCTIPO"		,"   ",STR0034			,/*Picture*/				,10			,/*lPixel*/,{|| Iif(Alltrim(TRB->TR_TIPO)$"CH",STR0038,"")}) //"Cheque Carteira"
TRCell():New( oSection1, "E2_NUM" 		,"   ",/*X3Titulo*/  	,/*Picture*/				,20,/*lPixel*/,{|| TRB->TR_DOC})	
TRCell():New( oSection1, "E2_PARCELA" 	,"   ",/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{||TRB->TR_PARCELA })
TRCell():New( oSection1, "E2_TIPO"    	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{|| TRB->TR_TIPO})
TRCell():New( oSection1, "E2_NATUREZ"	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{||MascNat(TRB->TR_NATUREZ) })
TRCell():New( oSection1, "E2_EMISSAO" 	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{||TRB->TR_EMISSAO })
TRCell():New( oSection1, "E2_VENCTO" 	,"   " ,/*X3Titulo()*/	,/*Picture*/				,/*Tamanho*/,/*lPixel*/,{||  TRB->TR_VENCTO  })
TRCell():New( oSection1, "VLCRUZ" 		,"   " ,STR0035			,PesqPict("SE2","E2_VLCRUZ"),TAMSX3("E2_VLCRUZ")[1],/*lPixel*/,{||TRB->TR_VALOR })
TRCell():New( oSection1, "SALDO" 		,"   " ,STR0036	   		,PesqPict("SE2","E2_VLCRUZ"),TAMSX3("E2_SALDO")[1],/*lPixel*/,{||TRB->TR_SALDO  })
TRCell():New( oSection1, "ATRASO" 		,"   " ,STR0037		    ,"@E999",3,/*lPixel*/,{||IIf(dDataBase>TRB->TR_VENCREA, IIf(TRB->TR_SALDO>0,dDataBase-TRB->TR_VENCREA,0),0)  })
TRCell():New( oSection1, "CART" 		,"   ",/*X3Titulo()*/	,/*Picture*/				,1,/*lPixel*/,{||TRB->TR_CART })
TRCell():New( oSection1, "VENCIDO" 		,"   ",STR0012  		,PesqPict("SE2","E2_VLCRUZ")/*Picture*/,TAMSX3("E2_VLCRUZ")[1],/*lPixel*/,{||Iif(!Alltrim(TRB->TR_TIPO)$"CH" .AND. dDatabase>TRB->TR_VENCREA,TRB->TR_SALDO ,0) })
TRCell():New( oSection1, "ABERTO" 		,"   ",STR0013  		,PesqPict("SE2","E2_VLCRUZ")/*Picture*/,TAMSX3("E2_VLCRUZ")[1],/*lPixel*/,{||Iif(!Alltrim(TRB->TR_TIPO)$"CH",TRB->TR_SALDO ,0) })
TRCell():New( oSection1, "CARTEIRA" 	,"   ",STR0015  		,PesqPict("SE2","E2_VLCRUZ")/*Picture*/,TAMSX3("E2_VLCRUZ")[1],/*lPixel*/,{||Iif(Alltrim(TRB->TR_TIPO)$"CH",TRB->TR_SALDO ,0) })
TRCell():New( oSection1, "TOTFOR" 		,"   ",STR0016 			,PesqPict("SE2","E2_VLCRUZ")/*Picture*/,TAMSX3("E2_VLCRUZ")[1],/*lPixel*/,{||TRB->TR_SALDO  })

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrintºAutor  ³Paulo Augusto       º Data ³  27/06/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Query de impressao do relatorio                              º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ SIGAFIN                                                     º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ReportPrint( oReport )
Local oSection1	:= oReport:Section(1)
Local oBreak1	:= Nil
Local oBreak2	:= Nil
Local aCampos	:= {}

AADD(aCampos,{ "TR_FORNECE"  , "C",  TamSX3('A2_COD')[1], 0 })
AADD(aCampos,{ "TR_LOCAL"  , "C",  TamSX3('A2_LOJA')[1], 0 })
AADD(aCampos,{ "TR_NOME"   , "C", 20, 0 })
AADD(aCampos,{ "TR_DOC"    , "C", TamSX3('E2_NUM')[1], 0 })
AADD(aCampos,{ "TR_PREFIXO", "C", TamSX3('E2_PREFIXO')[1], 0 })
AADD(aCampos,{ "TR_TIPO"   , "C",  3, 0 })
AADD(aCampos,{ "TR_PARCELA", "C",  TamSX3('E2_PARCELA')[1], 0 })
AADD(aCampos,{ "TR_EMISSAO", "D",  8, 0 })
AADD(aCampos,{ "TR_VENCTO" , "D",  8, 0 })
AADD(aCampos,{ "TR_VENCREA", "D",  8, 0 })
AADD(aCampos,{ "TR_BANCO"  , "C",  3, 0 })
AADD(aCampos,{ "TR_SITUACA", "C",  1, 0 })
AADD(aCampos,{ "TR_VALOR"  , "N", 14, 2 })
AADD(aCampos,{ "TR_SALDO"  , "N", 14, 2 })
AADD(aCampos,{ "TR_NATUREZ", "C", 10, 0 })
AADD(aCampos,{ "TR_CART", "C", 1, 0 })

oTmpTable := FWTemporaryTable():New("TRB")
oTmpTable:SetFields( aCampos ) 
//crea indice
oTmpTable:AddIndex('T1', {"TR_FORNECE","TR_LOCAL","TR_EMISSAO","TR_CART","TR_TIPO"})
//Creacion de la tabla
oTmpTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Llena el archivo temporario con los datos pedidos           ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
Processa({|| FID010GR4(oSection1:GetAdvPlExp('SE2'),oSection1:GetAdvPlExp('SA2'))},OemToAnsi(STR0007),OemToAnsi(STR0008))

TrPosition():New(oSection1,'SA2',1,{|| xFilial('SA2')+TRB->(TR_FORNECE+TR_LOCAL)})
TrPosition():New(oSection1,'SE2',1,{|| xFilial('SE2')+TRB->(TR_PREFIXO+TR_DOC+TR_PARCELA+TR_TIPO)})

oBreak1 := TRBreak():New( oSection1,oSection1:Cell("E2_FORNECE"), STR0016 ,.T.)

TRFunction():New(oSection1:Cell("VENCIDO")	, , "SUM" , oBreak1, , , ,.f.  , )
TRFunction():New(oSection1:Cell("ABERTO")	, , "SUM" , oBreak1, , , , .f.  ,  )
TRFunction():New(oSection1:Cell("CARTEIRA")	, , "SUM" , oBreak1, , , ,.f. ,   )
TRFunction():New(oSection1:Cell("TOTFOR")	, , "SUM" , oBreak1, , , ,.f. ,   )

oSection1:Cell("CART"):Disable()
oSection1:Cell("TOTFOR"):Disable()
oSection1:Cell("VENCIDO"):Disable()
oSection1:Cell("ABERTO"):Disable()
oSection1:Cell("CARTEIRA"):Disable()
oSection1:Print()

Return Nil

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funci¢n   ³FID010GR4 ³ Autor ³ Paulo Augusto         ³ Data ³ 11/01/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descrip.  ³ Carga archivo temporario                                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ FIND010                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
Static Function FID010GR4(cFiltSE2,cFiltSA2)

Local lCartera	:= .F.
Local lAbierto	:= .F.
Local dDataTit	:= dDatabase
Local cTipos	:= ExecBlock("FARGTIP",.F.,.F.)
Local cNeg		:= GETMV('MV_CPNEG') + "/PA "
Local nSaldo	:= 0
Local nSigno	:= 1
Local lEmissa  := If (mv_par11 == 1,.T.,.F.)
Local lDtDigit  := If (mv_par11 == 2,.T.,.F.)

lCartera := IIf( mv_par07 == 2 .or. mv_par07 == 3, .t., .f. )
lAbierto := IIf( mv_par07 == 1 .or. mv_par07 == 3, .t., .f. )
dDataTit := MIN(dDataBase,mv_par06)

If lCartera
   cTipos := cTipos + "/CH "
End If

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Busca el primer producto                                    ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
DbSelectArea("SE2")
SE2->(DbSetOrder(9))
SE2->(DBGoTop())
If !Empty(mv_par01) .and. Empty(mv_par03)
   SE2->(DbSeek(xFilial("SE2") + mv_par01, .T.))
ElseIf !Empty(mv_par01).and. !Empty(mv_par03)
   SE2->(DbSeek(xFilial("SE2") + mv_par01+ mv_par03, .T.))
Else
   SE2->(DbSeek(xFilial("SE2")))
Endif

ProcRegua( LastRec() )

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Recorre el archivo de Stock                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄDiegoÄÄÄÄÄÄÙ
While !EOF() .AND. xFilial() == E2_FILIAL.And. E2_FORNECE + E2_LOJA <= mv_par02+mv_par04

   IncProc(OemToAnsi(STR0020) + E2_TIPO +"  "+ E2_NUM)  //"Procesando "

    If Val(E2_SITUACA) > 0 // Min(mv_par06,dDataBAse)
      DbSkip()
      Loop
   Endif
   
   If lEmissa    	
   		If E2_EMISSAO < mv_par05 .or. E2_EMISSAO > mv_par06
 			DbSkip()
    		Loop
    	EndIf	
   	Elseif	lDtDigit 
   		If E2_EMIS1 < mv_par05 .or. E2_EMIS1 > mv_par06 
   			DbSkip()
      		Loop
      	EndIF	
   EndIf

   If (mv_par07==1   .AND. E2_TIPO == "CH ").Or.;
      (mv_par07==2   .AND. E2_TIPO <> "CH ")
      DbSkip()
      Loop
   End If

   If !( E2_TIPO $ cTipos )
      DbSkip()
      Loop
   End If

   If (E2_NATUREZ < mv_par08 .or. E2_NATUREZ > mv_par09) .and.;
      (E2_TIPO != "CH ")
      DbSkip()
      Loop
   End If

   If !Empty(cFiltSE2) .And. !(&(cFiltSE2))
      DbSelectArea("SE2")
      DbSkip()
      Loop
	Endif

   nSaldo   := SaldoTit(SE2->E2_PREFIXO,SE2->E2_NUM,SE2->E2_PARCELA,SE2->E2_TIPO,SE2->E2_NATUREZ,"P",SE2->E2_FORNECE,1,,dDataBase,SE2->E2_LOJA,,Iif(MV_PAR10==2,Iif(!Empty(SE2->E2_TXMOEDA),SE2->E2_TXMOEDA,RecMoeda(SE2->E2_EMISSAO,SE2->E2_MOEDA)),0) )
   If nSaldo <= 0
      DbSkip()
      Loop
   Endif

   If E2_TIPO $ cNeg
      nSigno := -1
   Else
      nSigno := 1
   End

   SA2->(DbSetOrder(1))
   SA2->(MsSeek( xFilial() + SE2->E2_FORNECE + SE2->E2_LOJA ))
   If !Empty(cFiltSA2)
	   If !SA2->(&(cFiltSA2))
	      DbSelectArea("SE2")
	      DbSkip()
	      Loop
		Endif
	Endif

   If E2_EMISSAO < Min(mv_par05,dDataBase)

      IF TRB->(DbSeek(SE2->E2_FORNECE+SE2->E2_LOJA+dtos(Min(mv_par05,dDataBase)-1) ))
         Reclock("TRB",.F.)
         Replace TR_SALDO   With TR_SALDO + (nSaldo * nSigno)
         Replace TR_VALOR   With TR_VALOR + (SE2->E2_VLCRUZ * nSigno )
         MsUnlock()
      Else
         RecLock("TRB",.T.)
         Replace TR_FORNECE With SE2->E2_FORNECE
         Replace TR_LOCAL   With SE2->E2_LOJA
         Replace TR_NOME    With OemToAnsi(STR0021) // "Saldo acumulado al"
         Replace TR_NATUREZ With   "--------->"
         Replace TR_VALOR   With ( SE2->E2_VLCRUZ * nSigno )
         Replace TR_SALDO   With (nSaldo * nSigno)
  	     Replace TR_EMISSAO With Min(mv_par05,dDataBase)-1
         Replace TR_CART    With " "
         MsUnLock()
      Endif
      DbSelectArea("SE2")
      DbSkip()
      Loop
   ENDIF

   DbSelectArea("TRB")
   RecLock("TRB",.T.)
   Replace TR_FORNECE With SE2->E2_FORNECE
   Replace TR_LOCAL   With SE2->E2_LOJA
   Replace TR_NOME    With SubStr( SA2->A2_NOME, 1, 20 )
   Replace TR_DOC     With SE2->E2_NUM
   Replace TR_PREFIXO With SE2->E2_PREFIXO
   Replace TR_TIPO    With IIF(ALLTRIM(SE2->E2_TIPO)$"NF/FT","FT",ALLTRIM(SE2->E2_TIPO))
   Replace TR_PARCELA With SE2->E2_PARCELA
   Replace TR_EMISSAO With SE2->E2_EMISSAO
   Replace TR_VENCTO  With SE2->E2_VENCTO
   Replace TR_VENCREA With SE2->E2_VENCREA
   Replace TR_BANCO   With SE2->E2_BCOCHQ
   Replace TR_SITUACA With SE2->E2_SITUACA
   Replace TR_VALOR   With ( SE2->E2_VLCRUZ * nSigno )
   Replace TR_SALDO   With  nSaldo * nSigno
   Replace TR_NATUREZ With SE2->E2_NATUREZ
   Replace TR_CART    With IIF(ALLTRIM(SE2->E2_TIPO)=="CH","1","0")

   MsUnLock()

   DbSelectArea("SE2")
   DbSkip()

EndDo

DbSelectArea("TRB")
DbGoTop()

Return
