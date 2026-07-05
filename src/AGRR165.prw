/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include 'protheus.ch'

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³ AGRR165  ³ Autor ³ Ricardo Tomasi        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Relacao para Transferencia de Produtos                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ SIGAAGR                                                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³           ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ PROGRAMADOR  ³ DATA   ³ BOPS ³  MOTIVO DA ALTERACAO                   ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³              ³        ³      ³                                        ³±± 
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

User Function AGRR165()

Local cDesc1         := "Este programa tem como objetivo imprimir relatorio "
Local cDesc2         := "de acordo com os parametros informados pelo usuario."
Local cDesc3         := "Indices de Precipitacao Pluviometrica."
Local titulo         := "Indices de Precipitacao Pluviometrica"
Local nLin           := 220
Local Cabec1         := ""
Local Cabec2         := ""

Private aOrd        := {}
Private lEnd        := .F.
Private lAbortPrint := .F.
Private limite      := 132
Private tamanho     := "M"
Private nomeprog    := 'AGRR165'
Private nTipo       := 18
Private aReturn     := { "Zebrado", 1, "Administracao", 1, 2, 1, "", 1}
Private nLastKey    := 0
Private cbtxt       := Space(10)
Private cbcont      := 00
Private CONTFL      := 01
Private m_pag       := 01
Private cPerg       := "AGR165"
Private wnrel       := "AGRR165"
Private cString 	:= "NNP"

DbSelectArea("NNP")
DbSetOrder(1)

Pergunte(cPerg,.f.)

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.f.,aOrd,.f.,Tamanho,,.t.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| RunReport(Cabec1,Cabec2,Titulo,nLin) },Titulo)

Return()

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funçào    ³RunReport ³ Autor ³ Danyel Bernuci        ³ Data ³ 15/12/05 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descriçào ³ Funcao auxiliar chamada pela RPTSTATUS. A funcao RPTSTATUS ³±±
±±³			 ³ monta a janela com a regua de processamento.				  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ AGRR420                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/

Static Function RunReport(Cabec1,Cabec2,Titulo,nLin)
Local aArea     := GetArea()
Local nX        := 0
Local nY        := 0
Local aAnoMes   := Array(0,0)
Local cFilNNP   := ''
Local cFilNQP   := ''
Local cFiltUser := aReturn[7]
Local dDataINI  := CTOD('01/01/'+Str(Year(mv_par04)))
Local dDataFIM  := CTOD('31/12/'+Str(Year(mv_par05)))
Local nAnoINI   := Year(dDataINI)
Local nAnoFIM   := Year(dDataFIM)
Local aUteis    := Array(0)
Local lPluvio   := .t.

For nX := nAnoINI to nAnoFIM
	aAdd(aAnoMes, Array(12))
	aAdd(aUteis, nX)
Next nX

//          0         0         0         0         0         0         0         0         0         1         1         1         1
//          1         2         3         4         5         6         7         8         9         0         1         2         3
//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
//|Pluviometro | Talhao |        |  Ano | Jan | Fev | Mar | Abr | Mai | Jun | Jul | Ago | Set | Out | Nov | Dez |   Media | Acumulado|
//|######      | ###    |        | #### | ####| ####| ####| ####| ####| ####| ####| ####| ####| ####| ####| ####| ###.### | #.###.###|

Cabec1 := "|Pluviometro | Talhao |        |  Ano | Jan | Fev | Mar | Abr | Mai | Jun | Jul | Ago | Set | Out | Nov | Dez |   Media | Acumulado|"
Cabec2 := ""

dbSelectArea('NN2')
dbSetOrder(2)
dbSeek(xFilial('NN2')+mv_par01)
                                                                                                              
If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
	If nLin < 80
  		Roda()
  	EndIf
	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
	nLin := 9
EndIf

@nLin, 000 PSay '+'+Replicate('-',130)+'+'; nLin++
@nLin, 000 PSay '|'
@nLin, 001 PSay PadR(NN2->NN2_CODIGO+'-'+NN2->NN2_NOME,40)
@nLin, 131 PSay '|'

cFilNNP += "NNP_FAZ = '"+mv_par01+"' .And. "
cFilNNP += "NNP_TALHAO >= '"+mv_par02+"' .And. NNP_TALHAO <= '"+mv_par03+"' .And. "
cFilNNP += "NNP_CODIGO >= '"+mv_par06+"' .And. NNP_CODIGO <= '"+mv_par07+"' .And. "
If mv_par08 == 1
	cFilNNP += "NNP_FILIAL >= '"+mv_par09+"' .And. NNP_FILIAL <= '"+mv_par10+"'"
Else
	cFilNNP += "NNP_FILIAL = '"+xFilial('NNP')+"'"
EndIf
dbSelectArea('NNP')
dbSetOrder(2)
dbSetFilter( {|| &cFilNNP }, cFilNNP )
dbGotop()
While .Not. Eof()

	//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
	//³ Avalia filtro do usuario                        ³
	//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If !Empty(cFiltUser).And.!(&cFiltUser)
		NNP->(dbSkip())
		Loop
	EndIf

   	If lAbortPrint
      	@nLin,00 Psay "*** CANCELADO PELO OPERADOR ***"
      	Exit
   	Endif
                                                                                                              
   	If nLin > 55 // Salto de Página. Neste caso o formulario tem 55 linhas...
      	If nLin < 80
	  		Roda()
	  	EndIf
      	Cabec(Titulo,Cabec1,Cabec2,NomeProg,Tamanho,nTipo)
      	nLin := 9
   	EndIf
    //---Imprime pluviometro na lista...

	For nX := 1 to Len(aAnoMes)
		For nY := 1 to 12
			aAnoMes[nX,nY] := 0
		Next nY
	Next nX

	//---Filtrar arquivo NQP por codigo do pluviometro...
	cFilNQP =  "NQP_CODPLU = '"+NNP->NNP_CODIGO+"' .And. "
	cFilNQP += "DTOS(NQP_DATA) >= '"+DTOS(mv_par04)+"' .And. DTOS(NQP_DATA) <= '"+DTOS(mv_par05)+"'"
    
    
	dbSelectArea('NQP')
	dbSetOrder(1)
	dbSetFilter( {|| &cFilNQP }, cFilNQP )
	dbGoTop()
	While .Not. Eof()
					
		For nX := 1 to Len(aUteis)
            If aUteis[nX] = Year(NQP->NQP_DATA)
                aAnoMes[nX,Month(NQP->NQP_DATA)] += NQP->NQP_INDICE
            EndIf
       Next nX    
  		
		dbSelectArea('NQP')
       dbSkip()        
		
	EndDo

	nLin++
	@nLin, 000 PSay '+'+Replicate('-',130)+'+'
	lPluvio := .t.

	For nX := 1 to Len(aAnoMes)
		nLin++
		@nLin, 000 PSay '|'
		If lPluvio
			@nLin, 001 PSay PadR(NNP->NNP_CODIGO, 06)
			@nLin, 013 PSay '|'
			@nLin, 015 PSay PadR(NNP->NNP_TALHAO, 03)
			@nLin, 022 PSay '|'
			lPluvio := .f.
			nTotalAno := 0
		EndIf
		@nLin, 031 PSay '|'
		@nLin, 033 PSay PadC(aUteis[nX], 04)
		@nLin, 038 PSay '|'
		@nLin, 040 Psay Transform(aAnoMes[nX,01], '@E 9999')
		nTotalAno += aAnoMes[nX,01]
		@nLin, 044 PSay '|'
		@nLin, 046 Psay Transform(aAnoMes[nX,02], '@E 9999')
		nTotalAno += aAnoMes[nX,02]
		@nLin, 050 PSay '|'
		@nLin, 052 Psay Transform(aAnoMes[nX,03], '@E 9999')
		nTotalAno += aAnoMes[nX,03]
		@nLin, 056 PSay '|'
		@nLin, 058 Psay Transform(aAnoMes[nX,04], '@E 9999')
		nTotalAno += aAnoMes[nX,04]
		@nLin, 062 PSay '|'
		@nLin, 064 Psay Transform(aAnoMes[nX,05], '@E 9999')
		nTotalAno += aAnoMes[nX,05]
		@nLin, 068 PSay '|'
		@nLin, 070 Psay Transform(aAnoMes[nX,06], '@E 9999')
		nTotalAno += aAnoMes[nX,06]
		@nLin, 074 PSay '|'
		@nLin, 076 Psay Transform(aAnoMes[nX,07], '@E 9999')
		nTotalAno += aAnoMes[nX,07]
		@nLin, 080 PSay '|'
		@nLin, 082 Psay Transform(aAnoMes[nX,08], '@E 9999')
		nTotalAno += aAnoMes[nX,08]
		@nLin, 086 PSay '|'
		@nLin, 088 Psay Transform(aAnoMes[nX,09], '@E 9999')
		nTotalAno += aAnoMes[nX,09]
		@nLin, 092 PSay '|'
		@nLin, 094 Psay Transform(aAnoMes[nX,10], '@E 9999')
		nTotalAno += aAnoMes[nX,10]
		@nLin, 098 PSay '|'
		@nLin, 100 Psay Transform(aAnoMes[nX,11], '@E 9999')
		nTotalAno += aAnoMes[nX,11]
		@nLin, 104 PSay '|'
		@nLin, 106 Psay Transform(aAnoMes[nX,12], '@E 9999')
		nTotalAno += aAnoMes[nX,12]
		@nLin, 110 PSay '|'	
		@nLin, 112 PSay Transform(nTotalAno/12,'@E 9999,999')
		@nLin, 120 PSay '|'	
		@nLin, 122 PSay Transform(nTotalAno ,'@E 9,999,999')
		@nLin, 131 PSay '|'
	next nX

	nTotalAno := 0
	nLin++
	@nLin, 000 PSay '+'+Replicate('-',130)+'+'

	dbSelectArea('NNP')
	dbSkip()

EndDo

Roda()
RestArea(aArea)

SET DEVICE TO SCREEN

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return()

