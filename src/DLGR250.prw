/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "DLGR250.ch"
#Include 'FIVEWIN.CH'
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Programa  ³          ³ Autor ³     Paullo Vieira     ³ Data ³ 10/07/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³Indicadores de Produtividade - Desempenho por Atividade     ³±±
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
User Function DLGR250()
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Define Variaveis                                                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Local wnrel   := 'DLGR250'  // Nome do Arquivo utilizado no Spool
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
Private Titulo  := STR0005 //'Indicadores de Produtividade - Desempenho por Atividade'
Private nomeprog:= 'DLGR250'  // nome do programa
Private lEnd    := .F.// Controle de cancelamento do relatorio

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Variaveis utilizadas como parametros p/filtrar as ordens de servico   ³
//ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´
//³ mv_par01	// Armazem       De  ?                                    ³
//³ mv_par02	//               Ate ?                                    ³
//³ mv_par03	// Rec.Humano    De  ?                                    ³
//³ mv_par04	//               Ate ?                                    ³
//³ mv_par05	// Servico       De  ?                                    ³
//³ mv_par06	//               Ate ?                                    ³
//³ mv_par07	// Tarefa        De  ?                                    ³
//³ mv_par08	//               Ate ?                                    ³
//³ mv_par09	// Atividade     De  ?                                    ³
//³ mv_par10	//               Ate ?                                    ³
//³ mv_par11	// Analitico/Sintetic? 1-Analitico                        ³
//³                                   2-Sintetico                         ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Pergunte('DLR250', .F.)
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³Envia para a SetPrinter                                                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
wnrel:=SetPrint(cString,wnrel,'DLR250',@titulo,cDesc1,cDesc2,cDesc3,.F.,,,Tamanho)

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
Static Function ImpDet(lEnd,wnrel,cString,nomeprog,Titulo,Tamanho)
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
If	mv_par11 == 1
	Cabec1	:= STR0006 //"           Produto         Quantidade         Data Inicial   Hora Inicial   Data Final   Hora Final   Total de Horas"
Else
	Cabec1	:= STR0007 //"                           Quantidade                                                                 Total de Horas"
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
cQuery  += 'DB_RECHUM <= "'+mv_par04+'".And.'
cQuery  += 'DB_SERVIC >= "'+mv_par05+'".And.'
cQuery  += 'DB_SERVIC <= "'+mv_par06+'".And.'
cQuery  += 'DB_TAREFA >= "'+mv_par07+'".And.'
cQuery  += 'DB_TAREFA <= "'+mv_par08+'".And.'
cQuery  += 'DB_ATIVID >= "'+mv_par09+'".And.'
cQuery  += 'DB_ATIVID <= "'+mv_par10+'"'


IndRegua('SDB',cIndTmp,'DB_FILIAL + DB_LOCAL + DB_SERVIC + DB_TAREFA + DB_ATIVID',,cQuery,OemToAnsi(STR0008)) //'Selecionando Registros ...'
nIndex := RetIndex('SDB')
dbSetIndex(cIndTmp+OrdBagExt())
dbSetOrder(nIndex+1)
SetRegua(LastRec())
DbGoTop()

While SDB->(!Eof())
	lImp := .T.
	If lEnd
		@ Prow()+1,001 PSAY STR0009 //'CANCELADO PELO OPERADOR'
		Exit
	EndIf
	IncRegua()
	
	If	SDB->DB_ATUEST != 'N' .Or. Empty(SDB->DB_LOCAL) .Or.;
		Empty(SDB->DB_DATA) .Or. Empty(SDB->DB_HRINI) .Or. Empty(SDB->DB_DATAFIM) .Or. Empty(SDB->DB_HRFIM)
		SDB->(DbSkip())
		Loop
	EndIf
	
	If li > 55
		Cabec(titulo,cabec1,cabec2,nomeprog,tamanho)
		cQuebra := ''
	EndIf
	
	If	cQuebra != SDB->DB_LOCAL + SDB->DB_SERVIC + SDB->DB_TAREFA + SDB->DB_ATIVID
		cQuebra := SDB->DB_LOCAL + SDB->DB_SERVIC + SDB->DB_TAREFA + SDB->DB_ATIVID
		li++
		@ Li,00 PSay STR0010+ SDB->DB_LOCAL  //'Armazem  : '
		li++
		@ Li,00 PSay STR0011+ SDB->DB_SERVIC +' - '+ AllTrim(Tabela('L4',SDB->DB_SERVIC,.F.)) + '     ' + STR0012+ SDB->DB_TAREFA +' - '+ AllTrim(Tabela('L2',SDB->DB_TAREFA,.F.)) + '     ' + STR0013+ SDB->DB_ATIVID +' - '+ AllTrim(Tabela('L3',SDB->DB_ATIVID,.F.)) //'Servico  : '###'Tarefa   : '###'Atividade: '
		li++
	EndIf
	
	If	mv_par11 == 1				//-- Analitico
		@ Li++
		@ Li,11 PSay SDB->DB_PRODUTO				Picture PesqPict("SDB","DB_PRODUTO")
		@ Li,28 PSay SDB->DB_QUANT				Picture PesqPictQt("DB_QUANT")
		@ Li,48 PSay SDB->DB_DATA
		@ Li,65 PSay SDB->DB_HRINI				Picture PesqPict("SDB","DB_HRINI")
		@ Li,77 PSay SDB->DB_DATAFIM
		@ Li,91 PSay SDB->DB_HRFIM				Picture PesqPict("SDB","DB_HRFIM")
		@ Li,106 PSay IntToHora(SubtHoras(SDB->DB_DATA,SDB->DB_HRINI,SDB->DB_DATAFIM,SDB->DB_HRFIM),3)
	EndIf
	
	nTotHora += SubtHoras(SDB->DB_DATA,SDB->DB_HRINI,SDB->DB_DATAFIM,SDB->DB_HRFIM)
	nTotQuant += DB_QUANT
	DbSelectArea(cString)
	dbSkip()
	
	If cQuebra != SDB->DB_LOCAL + SDB->DB_SERVIC + SDB->DB_TAREFA + SDB->DB_ATIVID
		If	mv_par11 == 1				//-- Analitico
			Li+=2
			@ Li,00 PSay STR0014 //'Total Geral: '
		EndIf
		@ Li,28 PSay nTotQuant Picture PesqPictQt('DB_QUANT')
		@ Li,106 PSay IntToHora(nTotHora,3)
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
Endif

MS_FLUSH()

If	File(cIndTmp+OrdBagExt())
	dbSelectArea('SDB')
	Set Filter to
	Ferase(cIndTmp+OrdBagExt())
EndIf
RetIndex('SDB')
Return(.T.)
