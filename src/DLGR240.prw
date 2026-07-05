/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "DLGR240.ch"
#Include 'FIVEWIN.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³          ³ Autor ³     Paullo Vieira     ³ Data ³ 29/05/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Indicadores de Produtividade - Homem / hora                 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function DLGR240()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   := 'DLGR240'  // Nome do Arquivo utilizado no Spool
Local cDesc1  := STR0001 //'Relatorio de todos os Movimentos de Distribuicao cadastrados no armazem com as informacoes'
Local cDesc2  := STR0002 //'utilizadas no armazem'
Local cDesc3  := ''  // Descricao 3
Local Tamanho := 'M' // P/M/G

Private cString := 'SDB' // Alias utilizado na Filtragem
Private aReturn := { STR0003, 1,STR0004, 1, 2, 1, '',1 }  //'Zebrado'###'Administracao'
//[1] Reservado para Formulario
//[2] Reservado para N§ de Vias
//[3] Destinatario
//[4] Formato => 1-Comprimido 2-Normal
//[5] Midia   => 1-Disco 2-Impressora
//[6] Porta ou Arquivo 1-LPT1... 4-COM1...
//[7] Expressao do Filtro
//[8] Ordem a ser selecionada
//[9]..[10]..[n] Campos a Processar (se houver)
Private nLastKey:= 0  // Controla o cancelamento da SetPrint e SetDefault
Private Titulo  := STR0005 //'Indicadores de Produtividade - Homem / Hora'
Private nomeprog:= 'DLGR240'  // nome do programa
Private lEnd    := .F.// Controle de cancelamento do relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas como parametros p/filtrar as ordens de servico   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01	// Armazem       De  ?                                    ³
//³ mv_par02	//               Ate ?                                    ³
//³ mv_par03	// Rec.Humano    De  ?                                    ³
//³ mv_par04	//               Ate ?                                    ³
//³ mv_par05	// Analitico/Sintetic? 1-Analitico                        ³
//³                                   2-Sintetico                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte('DLR240', .F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,'DLR240',@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
EndIf

SetDefault(aReturn,cString)

If ( nLastKey==27 )
	dbSelectArea(cString)
	dbSetOrder(1)
	Set Filter to
	Return
EndIf

RptStatus({|lEnd| ImpDet(@lEnd,wnRel,cString,nomeprog,Titulo,Tamanho)},Titulo)

Return(.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Program   ³ ImpDet   ³ Autor ³                       ³ Data ³          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³Controle de Fluxo do Relatorio.                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Retorno   ³Nenhum                                                      ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³Nenhum                                                      ³±±
±±³          ³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³   DATA   ³ Programador   ³Manutencao efetuada                         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³          ³               ³                                            ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo,Tamanho)
Local lImp		:= .F. // Indica se algo foi impresso
Local cQuebra	:= ''
Local nTotHora	:= 0
Local nTotQuant:= 0
Local nIndex	:= 0
Local cIndTmp	:= ''
Local cQuery	:= ''

Private cbCont	:= 00
Private Cbtext	:= Space( 10 )
Private Cabec1 := ''
Private li		:= 80
Private m_pag	:= 01

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Inicializa os codigos de caracter Comprimido/Normal da impressora ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Private nTipo	:= IIF(aReturn[4]==1,GetMV('MV_COMP'),GetMV('MV_NORM'))
Private nOrdem	:= aReturn[8]

If	mv_par05 == 1
	Cabec1	:= STR0006 //'Produto         Quantidade       Data Inicial   Hora Inicial   Data Final   Hora Final   Total de Horas'
Else
	Cabec1	:= STR0007 //'                Quantidade                                                               Total de Horas'
EndIf
//                  0         1         2         3         4         5         6         7         8         9        10        11        12        13        14        15        16        17        18        19        20        21        22
//                  01234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
Private Cabec2	:= ''
Private Cabec3	:= ''


SRJ->(DbSetOrder(1))

dbSelectArea(cString)

cIndTmp := CriaTrab(NIL,.F.)
cQuery  := 'DB_FILIAL == "'+xFilial('SDB')+'".And.'
cQuery  += 'DB_LOCAL  >= "'+mv_par01+'".And.'
cQuery  += 'DB_LOCAL  <= "'+mv_par02+'".And.'
cQuery  += 'DB_RECHUM >= "'+mv_par03+'".And.'
cQuery  += 'DB_RECHUM <= "'+mv_par04+'"'

IndRegua('SDB',cIndTmp,'DB_FILIAL + DB_LOCAL + DB_RECHUM',,cQuery,OemToAnsi(STR0008)) //'Selecionando Registros ...'
nIndex := RetIndex('SDB')
dbSetIndex(cIndTmp+OrdBagExt())
dbSetOrder(nIndex+1)
SetRegua(LastRec())
dbGoTop()


While SDB->(!Eof())
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY STR0009 //'CANCELADO PELO OPERADOR'
		Exit
	EndIf
	IncRegua()
	
	If	SDB->DB_ATUEST != 'N' .Or. Empty(SDB->DB_LOCAL) .Or. Empty(SDB->DB_RECHUM) .Or.;
		Empty(SDB->DB_DATA) .Or. Empty(SDB->DB_HRINI) .Or. Empty(SDB->DB_DATAFIM) .Or. Empty(SDB->DB_HRFIM)
		SDB->(DbSkip())
		Loop
	EndIf
	
	
	If li > 55
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho)
		cQuebra := ''
	EndIf
	
	If	cQuebra != SDB->DB_LOCAL + SDB->DB_RECHUM
		cQuebra := SDB->DB_LOCAL + SDB->DB_RECHUM
		SRJ->(DbSeek(xFilial('SRJ') + SDB->DB_RECHUM))
		@ Li,00 PSay STR0010+ SDB->DB_LOCAL  //'Centro de Distribuicao : '
		@ Li,57 PSay STR0011+ SDB->DB_RECHUM + ' - ' + SRJ->RJ_DESC //'Recurso Humano : '
		li++
	EndIf
	
	If	mv_par05 == 1				//-- Analitico
		Li++
		@ Li,00 PSay SDB->DB_PRODUTO				Picture PesqPict('SDB','DB_PRODUTO')
		@ Li,16 PSay SDB->DB_QUANT				Picture PesqPictQt('DB_QUANT')
		@ Li,35 PSay SDB->DB_DATA
		@ Li,52 PSay SDB->DB_HRINI				Picture PesqPict('SDB','DB_HRINI')
		@ Li,64 PSay SDB->DB_DATAFIM
		@ Li,79 PSay SDB->DB_HRFIM				Picture PesqPict('SDB','DB_HRFIM')
		@ Li,93 PSay IntToHora(SubtHoras(SDB->DB_DATA,SDB->DB_HRINI,SDB->DB_DATAFIM,SDB->DB_HRFIM),3)
	EndIf
	
	nTotHora += SubtHoras(SDB->DB_DATA,SDB->DB_HRINI,SDB->DB_DATAFIM,SDB->DB_HRFIM)
	nTotQuant += DB_QUANT
	DbSelectArea(cString)
	dbSkip()
	
	If cQuebra != SDB->DB_LOCAL + SDB->DB_RECHUM
		If	mv_par05 == 1				//-- Analitico
			Li+=2
			@ Li,00 PSay STR0012 //'Total Geral: '
		EndIf
		@ Li,16 PSay nTotQuant Picture PesqPictQt('DB_QUANT')
		@ Li,93 PSay IntToHora(nTotHora,3)
		nTotHora := 0
		nTotQuant:= 0
		li+=2
	EndIf
EndDo

If ( lImp )
	Roda(cbCont,cbText,Tamanho)
EndIf

If ( aReturn[5] = 1 )
	Set Printer To
	dbCommitAll()
	OurSpool(wnrel)
EndIf

MS_FLUSH()

If	File(cIndTmp+OrdBagExt())
	dbSelectArea('SDB')
	Set Filter to
	Ferase(cIndTmp+OrdBagExt())
EndIf
RetIndex('SDB')
Return(.T.)
