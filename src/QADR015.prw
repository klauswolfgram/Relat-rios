/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "QADR015.ch"
#INCLUDE "Protheus.CH"
#INCLUDE "report.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³QADR015   ºAutor  ³Telso Carneiro      º Data ³  16/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Log de Transferencia                             º±±
±±º          ³ (Versao Relatorio Personalizavel)                          º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Generico                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QADR015()
Local oReport
Private cPerg   := "QUN015    "

If TRepInUse()
	Pergunte(cPerg,.F.)
	oReport := ReportDef()
	oReport:PrintDialog()
Else
	Return U_QADR015R3()	// Executa versão anterior do fonte
Endif                

Return


Static Function ReportDef()
Local cTitulo   := OemToAnsi(STR0001) // "Lista de Transferência das Pendencias de Auditorias"
Local cDesc1    := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡ao de transferencias"
Local cDesc2    := OemToAnsi(STR0003) // "de acordo com os parƒmetros definidos pelo usu rio."
Local cString   := "QUN"
Local wnrel     := "QADR015" 
Local oReport
Local oSection1
Local nLargAp	:= TAMSX3("QAA_FILIAL")[1]+TAMSX3("QAA_MAT")[1]+TAMSX3("QAA_APELID")[1]+4                             
Local aLarBox   := {}
Local nLarBox	:= 0          

QNCCBOX("QUN_TPPEND",@aLarBox)
nLarBox:=Eval({|| y:=0, aEval(aLarBox,{|x| IF(Len(Alltrim(x)) > y ,y:=Len(Alltrim(x)),"") }), y })

oReport	:= TReport():New(wnrel,cTitulo,cPerg,{|oReport| ReportPrin(oReport) },cDesc1+cDesc2)
oSection1:= TRSection():New(oReport,TITSX3("QUN_NUMAUD")[1],{"QUN"})
oReport:SetLandscape(.T.)                                          
/*TRCell():New(<oParent>, <cName>, [ <cAlias> ], [ <cTitle> ],[ <cPicture> ], [ <nSize> ], [ <.lPixel.> ], [ <bBlock> ],;
          [ <"cAlign"> ], [ <.lLineBreak.> ], [ <"cHeaderAlign"> ], [ <.lCellBreak.> ],[ <nColSpace> ], [<.lAutoSize.>], [ <nClrBack> ], [ <nClrFore> ])*/
TRCell():New(oSection1,"QUN_NUMAUD","QUN")
TRCell():New(oSection1,"QUN_DTTRAN","QUN")
TRCell():New(oSection1,"QUN_SEQTRF","QUN")

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Usuario Responsavel            				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oSection1,"QUN_MATRES","QUN",,,nLargAp,,{|| QUN_FILRES+" - "+QUN_MATRES+" "+Alltrim(QA_NUSR(QUN_FILRES,QUN_MATRES))},,.T.)
TRCell():New(oSection1,"QUN_MOTIVO","QUN",,,,,,,.T.)
TRCell():New(oSection1,"QUN_TPPEND","QUN",,,18,,,,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Usuario Origem                 				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oSection1,"QUN_MATDE","QUN",,,nLargAp,,{|| QUN_FILDE+" - "+QUN_MATDE+" "+Alltrim(QA_NUSR(QUN_FILDE,QUN_MATDE))},,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Usuario Destino                				   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
TRCell():New(oSection1,"QUN_MATPAR","QUN",,,nLargAp,,{|| QUN_FILPAR+" - "+QUN_MATPAR+" "+Alltrim(QA_NUSR(QUN_FILPAR,QUN_MATPAR))},,.T.)

Return oReport

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³ReportPrinºAutor  ³Telso Carneiro      º Data ³  16/05/06   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Relatorio Personalizavel                                    º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³U_QADR015()                                                   º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
                  
Static Function ReportPrin(oReport) 
Local cAliasQUN	:= "QUN"
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
oReport:Section(1):BeginQuery()	

cAliasQUN := GetNextAlias()

BeginSql Alias cAliasQUN
SELECT * FROM %table:QUN% QUN

WHERE QUN_FILIAL = %xFilial:QUN% AND 
	QUN_NUMAUD BETWEEN %Exp:mv_par01% AND %Exp:mv_par02% AND
	QUN_DTTRAN BETWEEN %Exp:DTOS(mv_par03)% AND %Exp:DTOS(mv_par04)% AND
	QUN_DESTIN BETWEEN %Exp:mv_par05% AND %Exp:mv_par06% AND
	QUN_SEQTRF BETWEEN %Exp:mv_par07% AND %Exp:mv_par08% AND
	QUN_FILDE  BETWEEN %Exp:mv_par09% AND %Exp:mv_par11% AND
	QUN_MATDE  BETWEEN %Exp:mv_par10% AND %Exp:mv_par12% AND
	QUN_FILPAR BETWEEN %Exp:mv_par13% AND %Exp:mv_par15% AND
	QUN_MATPAR BETWEEN %Exp:mv_par14% AND %Exp:mv_par16% AND 
	QUN.%notDel%                  

ORDER BY QUN_FILIAL,QUN_NUMAUD,QUN_DTTRAN,QUN_SEQTRF,QUN_TPPEND
		
EndSql  
oReport:Section(1):EndQuery()

oReport:Section(1):Print()
(cAliasQUN)->(DbCloseArea())

Return NIL

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºFun‡ao    ³ QADR015R3º Autor ³ Telso Carneiro     º Data ³ 14/09/2004  º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³ Relatorio Log de Transferencia                             º±±
±±º          ³                                                            º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ QADA015R3()                                                º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/

User Function QADR015R3()

Local cTitulo   := OemToAnsi(STR0001) // "Lista de Transferência das Pendencias de Auditorias"
Local cDesc1    := OemToAnsi(STR0002) // "Este programa ir  imprimir uma rela‡ao de transferencias"
Local cDesc2    := OemToAnsi(STR0003) // "de acordo com os parƒmetros definidos pelo usu rio."
Local cString   := "QUN"
Local wnrel     := "QADR015"
Local Tamanho   := "M"

Private aReturn  := {STR0004, 1, STR0005, 1, 2, 1, '', 1}  //"Zebrado"###"Administracao"
Private nLastKey:= 0
Private INCLUI  := .F.	// Colocada para utilizar as funcoes

If ! ChkFile("QUN")
	Return             
Endif            

Pergunte("QUN015    ",.F.)

wnrel := AllTrim(SetPrint(cString,wnrel,"QUN015    ",ctitulo,cDesc1,cDesc2,"",.F.,,,Tamanho))

If nLastKey = 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey = 27
	Return
Endif

RptStatus({|lEnd| QADR015Imp(@lEnd,ctitulo,wnRel,tamanho)},ctitulo)

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³QADR015Imp³ Autor ³ Telso Carneiro		³ Data ³14/09/2004³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Envia para funcao que faz a impressao do relatorio.        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QADR015Imp(ExpL1,ExpC1,ExpC2,ExpC3)                        ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QADR015                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QADR015Imp(lEnd,ctitulo,wnRel,tamanho)

Local cCabec1  := ""
Local cCabec2  := ""
Local cbtxt    := SPACE(10)
Local nTipo		:= GetMV("MV_COMP")
Local cbcont   := 0
Local cIndex1  := CriaTrab(Nil,.F.) // Cria Indice Condicional nos arquivos utilizados
Local cFiltro  := ""
Local cKey     := ""

DbSelectarea("QUN")
DbSetOrder(1)

cFiltro:= 'QUN->QUN_FILIAL =="'  +xFilial("QUN")+'" .And. '
cFiltro+= 'QUN->QUN_NUMAUD >= "' +mv_par01+'" .And. QUN->QUN_NUMAUD <= "' +mv_par02+'" .And. '
cFiltro+= 'DTOS(QUN->QUN_DTTRAN) >= "'+DTOS(mv_par03)+'" .And. DTOS(QUN->QUN_DTTRAN) <= "'+DTOS(mv_par04)+'" .And. '
cFiltro+= 'QUN->QUN_DESTIN >= "' +mv_par05+'" .And. QUN->QUN_DESTIN <= "' +mv_par06+'" .And. '
cFiltro+= 'QUN->QUN_SEQTRF >= "' +mv_par07+'" .And. QUN->QUN_SEQTRF <= "' +mv_par08+'" .And. '                      
cFiltro+= 'QUN->QUN_FILDE  >= "' +mv_par09+'" .And. QUN->QUN_MATDE  >= "' +mv_par10+'" .And. '
cFiltro+= 'QUN->QUN_FILDE  <= "' +mv_par11+'" .And. QUN->QUN_MATDE  <= "' +mv_par12+'" .And. '		  
cFiltro+= 'QUN->QUN_FILPAR >= "' +mv_par13+'" .And. QUN->QUN_MATPAR >= "' +mv_par14+'" .And. '
cFiltro+= 'QUN->QUN_FILPAR <= "' +mv_par15+'" .And. QUN->QUN_MATPAR <= "' +mv_par16+'"'

cKey:= 'QUN->QUN_FILIAL+QUN->QUN_NUMAUD+DTOS(QUN->QUN_DTTRAN)+QUN->QUN_SEQTRF'

IndRegua("QUN",cIndex1,cKey,,cFiltro,OemToAnsi(STR0006)) // "Selecionando Registros.."

Li     := 80
m_Pag  := 1

QUN->(DbSeek(xFilial("QUN")))
SetRegua(RecCount()) // Total de Elementos da Regua

cCabec1  := OemToAnsi(Alltrim(RetTitle("QUN_DTTRAN")+"-"+Alltrim(RetTitle("QUN_SEQTRF"))+STR0007+dtoc(mv_par03)+"-"+mv_par07+STR0008+dtoc(mv_par04)+"-"+mv_par08)) //": De "###" até "

While QUN->(!Eof())
	If lEnd
		Li++
		@ PROW()+1,001 PSAY OemToAnsi(STR0009) // "CANCELADO PELO OPERADOR"
		Exit
	EndIf
	If Li > 60
		Cabec(cTitulo,cCabec1,cCabec2,wnrel,Tamanho,nTipo)
	EndIf
	
	@ Li,000 PSay __PrtFatLine()
	Li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Auditoria Data de Transferencia - Sequencia   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,000 PSay Alltrim(RetTitle("QUN_NUMAUD"))+": "+Alltrim(QUN->QUN_NUMAUD)+"   "+Alltrim(RetTitle("QUN_DTTRAN"))+"-"+Alltrim(RetTitle("QUN_SEQTRF"))+": "+DToC(QUN->QUN_DTTRAN)+' - '+QUN->QUN_SEQTRF
	Li++

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Tipo de Transferencia  Responsavel pela Transferencia   Motivo da Transferencia	³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,000 PSay Alltrim(RetTitle("QUN_TPPEND"))+": "+Alltrim(QADCBox("QUN_TPPEND", QUN->QUN_TPPEND))
	@ Li,035 PSay Alltrim(RetTitle("QUN_MATRES"))+": "+QUN->QUN_FILRES+" - "+QUN->QUN_MATRES+" "+Alltrim(QA_NUSR(QUN->QUN_FILRES,QUN->QUN_MATRES))+" "+Alltrim(RetTitle("QUN_MOTIVO"))+": "+Alltrim(QUN->QUN_MOTIVO)
	Li++
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Usuario Origem                 				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,000 PSay Alltrim(RetTitle("QUN_MATDE"))+": "+QUN->QUN_FILDE +" - "+QUN->QUN_MATDE+" "+Alltrim(QA_NUSR(QUN->QUN_FILDE,QUN->QUN_MATDE))
	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³Usuario Destino                				   ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	@ Li,062 PSay Alltrim(RetTitle("QUN_MATPAR"))+": "+QUN->QUN_FILPAR +" - "+QUN->QUN_MATPAR+" "+Alltrim(QA_NUSR(QUN->QUN_FILPAR,QUN->QUN_MATPAR))
	Li++
	
	@ Li,000 PSay __PrtThinLine()
	Li++
	
	QUN->(DbSkip())
	
EndDo

If Li != 80
	Roda(cbcont,cbtxt,tamanho)
EndIf

RetIndex("QUN")
Set Filter to

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Apaga indice de trabalho                                     ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
cIndex1 += OrdBagExt()
Delete File &(cIndex1)

Set Device To Screen

If aReturn[5] = 1
	Set Printer TO
	DbCommitAll()
	Ourspool(wnrel)
Endif
MS_FLUSH()

Return (.T.)


