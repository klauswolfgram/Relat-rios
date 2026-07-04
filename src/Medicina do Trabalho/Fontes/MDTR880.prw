/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "Mdtr880.ch"
#Include "Protheus.ch"

#DEFINE _nVERSAO 02 //Versao do fonte
//---------------------------------------------------------------------
/*/{Protheus.doc} MDT110DTA
Relatorio de Questionario Padrao.                      
O objetivo desse relatorio e' fazer com que os funcionarios 
respondam esse questionario.

@author Denis Hyroshi de Souza
@since 04/09/02
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function MDTR880()
//---------------------------------------------------------------
// Armazena variaveis p/ devolucao (NGRIGHTCLICK) 				  		  
//---------------------------------------------------------------
Local aNGBEGINPRM := NGBEGINPRM(_nVERSAO)

//---------------------------------------------------------------
// Define Variaveis                                             
//---------------------------------------------------------------
LOCAL wnrel   := "MDTR880"
LOCAL limite  := 80
LOCAL cDesc1  := STR0001 //"    Relatorio de apresentacao do questionario padrao.              "
LOCAL cDesc2  := STR0002 //"    Os campos dos questionarios estarao vazios, para que os funcio-"
LOCAL cDesc3  := STR0003 //" narios possam preencher os campos manualmente.                    "
LOCAL cString := "TMG"

lSigaMdtPS := If( SuperGetMv("MV_MDTPS",.F.,"N") == "S", .t. , .f. )

PRIVATE nomeprog := "MDTR880"
PRIVATE tamanho  := "P"
PRIVATE aReturn  := { STR0004, 1,STR0005, 1, 1, 1, "",1 }      //"Zebrado"###"Administracao"
PRIVATE titulo   := STR0006 //"Questionario Padrao"
PRIVATE ntipo    := 0
PRIVATE nLastKey := 0
PRIVATE cabec1, cabec2

//---------------------------------------------------------------
// Verifica as perguntas selecionadas                          
//---------------------------------------------------------------
Private cPerg := If(!lSigaMdtps,"MDT880    ","MDT880PS  ")

/*----------------------------------
//PADRÃO								|
| De  Questionario ?					|
| Ate Questionario ?					|
| Quantidade Copias ?				|
| Termo de Responsabilidade ?		|
| 										|
//PRESTADOR							|
| De Cliente ?						|
| Loja									|
| Até Cliente ?						|
| Loja									|
| De  Questionario ?					|
| Ate Questionario ?					|
| Quantidade Copias ?				|
| Termo de Responsabilidade ?		|
------------------------------------*/

Pergunte(cPerg,.F.)

//---------------------------------------------------------------
// Envia controle para a funcao SETPRINT                        
//---------------------------------------------------------------
wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"",.F.)

If nLastKey == 27
   Set Filter to
   //---------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)                         
	//---------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
   Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Set Filter to
   //---------------------------------------------------------------
	// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
	//---------------------------------------------------------------
	NGRETURNPRM(aNGBEGINPRM)
   Return
Endif

RptStatus({|lEnd| U_R880Imp(@lEnd,wnRel,titulo,tamanho)},titulo)

//---------------------------------------------------------------
// Devolve variaveis armazenadas (NGRIGHTCLICK)                          
//---------------------------------------------------------------
NGRETURNPRM(aNGBEGINPRM)

Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} R880Imp
Chama Relatório

@param lEnd - Cancela relatório.
@param wnRel - Programa utilizado.
@param titulo - Titulo do Relatório
@param tamanho - Tamanho do Relatório.

@author Denis Hyroshi de Souza
@since 04/09/02
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function R880Imp(lEnd,wnRel,titulo,tamanho)

//---------------------------------------------------------------
// Define Variaveis                                             
//---------------------------------------------------------------
LOCAL cRodaTxt := ""
LOCAL nCntImpr := 0
Local oTempTRB, oTempTRB2
//---------------------------------------------------------------
// Variaveis para controle do cursor de progressao do relatorio 
//---------------------------------------------------------------
LOCAL nTotRegs := 0 ,nMult := 1 ,nPosAnt := 4 ,nPosAtu := 4 ,nPosCnt := 0

//---------------------------------------------------------------
// Variaveis locais exclusivas deste programa                   
//---------------------------------------------------------------

LOCAL cChave           := SPACE(16)
Local cTipoRes := "C"
LOCAL lContinua        := .T.,LinhaCorrente,xx
Local nLinCor, nLinhaResp
Local nSizeTMH := (TAMSX3("TMH_PERGUN")[1])
Local nSizeRes := (TAMSX3("TMH_COMBO")[1])
Local lRespPer := .F.

nSizeTMH := If( nSizeTMH > 0 , nSizeTMH , 60 )

nSizeRes := If( nSizeRes > 0 , nSizeRes , 250 )
nSizeRes += 250
nSizeRes := 10
cTipoRes := "M"

//---------------------------------------------------------------
// Contadores de linha e pagina                                 
//---------------------------------------------------------------
PRIVATE li := 80 ,m_pag := 1

//---------------------------------------------------------------
// Verifica se deve comprimir ou nao                            
//---------------------------------------------------------------
nTipo  := IIF(aReturn[4]==1,15,18)

//---------------------------------------------------------------
// Monta os Cabecalhos                                          
//---------------------------------------------------------------
cabec1 := ""
cabec2 := ""

If lSigaMdtps

	aDBF := {}
	AADD(aDBF,{ "CLIENT" , "C" ,nTa1, 0 })
	AADD(aDBF,{ "LOJA"   , "C" ,nTa1L, 0 })
	AADD(aDBF,{ "NOME"   , "C" ,40, 0 })
	AADD(aDBF,{ "QUEST"  , "C" ,06, 0 })
	AADD(aDBF,{ "NOMEQ"  , "C" ,40, 0 })
	
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"CLIENT","LOJA","QUEST"} )
	oTempTRB:Create()
	
	aDBF2 := {}
	AADD(aDBF2,{ "CLIENT", "C" ,nTa1, 0 })
	AADD(aDBF2,{ "LOJA"  , "C" ,nTa1L, 0 })
	AADD(aDBF2,{ "QUEST" , "C" ,06, 0 })
	AADD(aDBF2,{ "PERGT" , "C" ,03, 0 })
	AADD(aDBF2,{ "NOMEP" , "C" ,nSizeTMH, 0 })
	AADD(aDBF2,{ "RESPP" , cTipoRes ,nSizeRes, 0 })
	
	oTempTRB2 := FWTemporaryTable():New( "TRB2", aDBF2 )
	oTempTRB2:AddIndex( "1", {"CLIENT","LOJA","QUEST","PERGT"} )
	oTempTRB2:Create()
	
	dbSelectArea("TMG")
	dbSetOrder(02)  //TMG_FILIAL+TMG_CLIENT+TMG_LOJA+TMG_QUESTI
	dbSeek(xFilial("TMG")+MV_PAR01+MV_PAR02,.T.)
	SetRegua(LastRec())
	//---------------------------------------------------------------
	// Correr TMG para ler as  Questoes                         
	//---------------------------------------------------------------
	While !Eof()                                   .AND.;
			TMG->TMG_FILIAL == xFIlial('TMG')        .AND.;
			TMG->(TMG_CLIENT+TMG_LOJA) <= MV_PAR03+MV_PAR04
	      
		If TMG->TMG_QUESTI < MV_PAR05 .or. TMG->TMG_QUESTI > MV_PAR06
			dbSelectArea("TMG")
			dbSkip()
			Loop
		Endif
	                
		cClient := TMG->(TMG_CLIENT+TMG_LOJA)
		cQuest := TMG->TMG_QUESTI
		IncRegua()
	
		dbSelectArea("TMH")
		dbSetOrder(02)  //TMH_FILIAL+TMH_CLIENT+TMH_LOJA+TMH_QUESTI+TMH_QUESTA
		dbSeek(xFilial("TMH")+cClient+TMG->TMG_QUESTI)
	      
		While !Eof() .and. TMH->TMH_QUESTI = cQuest .and. cClient = TMH->(TMH_CLIENT+TMH_LOJA)
	                                                       
			Dbselectarea("TRB")
			If !Dbseek(cClient+cQuest)
				TRB->(DbAppend())
				TRB->CLIENT := TMH->TMH_CLIENT
				TRB->LOJA   := TMH->TMH_LOJA
				TRB->NOME   := NGSEEK("SA1",TRB->CLIENT+TRB->LOJA,1,"SA1->A1_NOME")
				TRB->QUEST := cQuest
				TRB->NOMEQ := TMG->TMG_NOMQUE
			Endif
	              
			TRB2->(DbAppend())
			TRB2->CLIENT := TMH->TMH_CLIENT
			TRB2->LOJA   := TMH->TMH_LOJA
			TRB2->QUEST := cQuest
			TRB2->PERGT := TMH->TMH_QUESTA
			TRB2->NOMEP := TMH->TMH_PERGUN
			TRB2->RESPP := TMH->TMH_RESPOS
			dbSelectArea("TMH")
			dbSKIP()
	          
		End
		dbSelectArea("TMG")
		dbSKIP()
	End
	                        
	For xx := 1 to Mv_par07
		li := 80
		cClient := ""
	    	    
		dbSelectArea("TRB")
		dbGotop()
	
		While !eof()
	
			lInicio := .f.
			If cClient <> TRB->CLIENT+TRB->LOJA
				lInicio := .t.
				li := 2000
				cClient := TRB->CLIENT + TRB->LOJA
			Endif
			cQuest := TRB->QUEST
	
			Somalinha();Somalinha()
			lInicio := .f.
			cNome := trim(cQuest) + ' - ' + trim(TRB->NOMEQ)
			@Li,000 Psay STR0008 + cNome     //"Codigo: "
			Somalinha();Somalinha()
			@Li,000 Psay STR0009 //"Perguntas                                      Resp.   Qtde. Complemento"
			Somalinha()
	          
			lRespPer := .F.
			dbSelectArea("TRB2")
			Dbgotop()
			dbSeek(cClient+cQuest)
	 
			While !Eof() .and. cQuest = TRB2->QUEST .and. cClient = TRB2->CLIENT+TRB2->LOJA
				If TRB2->RESPP <> "1="+STR0023+";"+"2="+STR0024+";"+"3="+STR0025//"Sim"###"Nao"###"Sem Resposta"
					lRespPer := .T.
				Endif
				dbSkip()
			End
	          
			dbSelectArea("TRB2")
			Dbgotop()
			dbSeek(cClient+cQuest)
			While !Eof() .and. cQuest = TRB2->QUEST
				SomaLinha()
				@ Li,000 Psay TRB2->PERGT
				@ Li,004 Psay '-'
					
				nLinhasMemo := MLCOUNT(Alltrim(TRB2->NOMEP),40)
				For LinhaCorrente := 1 to nLinhasMemo
					If LinhaCorrente = 1
						@ Li,006 Psay (MemoLine(Alltrim(TRB2->NOMEP),40,LinhaCorrente))
						@ Li,047 Psay If(!Empty(TRB2->RESPP),"(   )   ____  ___________________","              ___________________")
					Else
						Somalinha()
						@ Li,006 Psay (MemoLine(Alltrim(TRB2->NOMEP),40,LinhaCorrente))
						Somalinha()
					Endif
				Next LinhaCorrente
				If nLinhasMemo = 0
					@ Li,047 Psay If(!Empty(TRB2->RESPP),"(   )   ____  ___________________","              ___________________")
					Somalinha()
				ElseIf nLinhasMemo = 1
					Somalinha()
				Endif
				If !Empty(TRB2->RESPP) .and. lRespPer
					cResp := ""
					nPos := 0
					nPos := rAt(";",TRB2->RESPP)
					cResp := SubStr(TRB2->RESPP,1,nPos-1)+" ou "+SubStr(TRB2->RESPP,nPos+1)
					cResp := StrTran(cResp,";",", ")
					cResp := StrTran(cResp,"="," - ")
					If Len(AllTrim(cResp)) > 69
						nLinhaResp := MLCOUNT(AllTrim(cResp),69)
						For nLinCor := 1 To nLinhaResp
							If nLinCor = 1
								Somalinha()
								@ Li,000 Psay STR0028//"Respostas: "
								@ Li,011 Psay (MemoLine(Alltrim(cResp),69,nLinCor))
							Else
								Somalinha()
								@ Li,011 Psay (MemoLine(Alltrim(cResp),69,nLinCor))
							Endif
						next nLinCor
					Else
						Somalinha()
						@ Li,000 Psay STR0028//"Respostas: "
						@ Li,011 Psay AllTrim(cResp)
						Somalinha()
					Endif
				Endif
					
				DbSelectArea("TRB2")
				dbskip()

			Enddo
			If !lRespPer
				SomaLinha()
				@ Li,000 Psay STR0026//"Todas as perguntas devem ser respondidas conforme abaixo:"
				SomaLinha()
				@ Li,000 Psay "1 - "+STR0023+", "+"2 - "+STR0024+" ou "+"3 - "+STR0025//"Sim"###"Nao"###"Sem Resposta"
			Else
				SomaLinha()
				@ Li,000 Psay STR0027//"As perguntas devem ser respondidas conforme as indicações de resposta."
				SomaLinha()
			Endif
	          
			lPrimeiro := .t.
			If !Empty(Mv_par08)
				Somalinha()
				@Li,000 Psay replicate("_",80)
				Somalinha()
				Somalinha()
				dbSelectArea("TMZ")
				dbSetorder(01)
				dbSeek(xFilial("TMZ")+mv_par08)
				@Li,000 Psay STR0015 + TMZ->TMZ_NOMTER //"Termo de Responsabilidade: "
				Somalinha()
				Somalinha()
				nLinhasMemo := MLCOUNT(TMZ->TMZ_DESCRI,80)
				For LinhaCorrente := 1 to nLinhasMemo
					If lPrimeiro
						If !empty((MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente)))
							@ Li,000 PSAY (MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente))
							lPrimeiro := .f.
						Else
							Exit
						Endif
					Else
						@ Li,000 PSAY (MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente))
					EndIf
					Somalinha()
				Next
			EndIf
	          			
			Dbselectarea("TRB")
			Dbskip()
		Enddo
	Next xx

Else

	aDBF := {}
	AADD(aDBF,{ "QUEST"  , "C" ,06, 0 })
	AADD(aDBF,{ "NOMEQ"  , "C" ,40, 0 })
	
	oTempTRB := FWTemporaryTable():New( "TRB", aDBF )
	oTempTRB:AddIndex( "1", {"QUEST"} )
	oTempTRB:Create()
	
	aDBF2 := {}
	AADD(aDBF2,{ "QUEST" , "C" ,06, 0 })
	AADD(aDBF2,{ "PERGT" , "C" ,03, 0 })
	AADD(aDBF2,{ "NOMEP" , "C" ,nSizeTMH, 0 })
	AADD(aDBF2,{ "RESPP" , cTipoRes ,nSizeRes, 0 })

	oTempTRB2 := FWTemporaryTable():New( "TRB2", aDBF2 )
	oTempTRB2:AddIndex( "1", {"QUEST","PERGT"} )
	oTempTRB2:Create()
	
	dbSelectArea("TMG")
	dbSetOrder(01)
	dbSeek(xFilial("TMG")+MV_PAR01,.T.)
	SetRegua(LastRec())
	//---------------------------------------------------------------
	// Correr TMG para ler as  Questoes                         
	//---------------------------------------------------------------
	While lContinua                                .And.;
			!Eof()                                   .AND.;
			TMG->TMG_FILIAL == xFIlial('TMG')        .AND.;
			TMG->TMG_QUESTI <= MV_PAR02
	
		If lEnd
			@ PROW()+1,001 PSay STR0007 //"CANCELADO PELO OPERADOR"
			Exit
		EndIf
	                
		cQuest := TMG->TMG_QUESTI
		IncRegua()
	
		dbSelectArea("TMH")
		dbSetOrder(01)
		dbSeek(xFilial("TMH")+TMG->TMG_QUESTI)
	      
		While !Eof() .and. TMH->TMH_QUESTI = cQuest
	                                                       
			Dbselectarea("TRB")
			If !Dbseek(cQuest)
				TRB->(DbAppend())
				TRB->QUEST := cQuest
				TRB->NOMEQ := TMG->TMG_NOMQUE
			Endif
	              
			TRB2->(DbAppend())
			TRB2->QUEST := cQuest
			TRB2->PERGT := TMH->TMH_QUESTA
			TRB2->NOMEP := TMH->TMH_PERGUN
			TRB2->RESPP := TMH->TMH_RESPOS
					
			dbSelectArea("TMH")
			dbSKIP()
	          
		End
		dbSelectArea("TMG")
		dbSKIP()
	End
	                        
	For xx := 1 to Mv_par03
		li := 80
		lInicio := .t.
	  
		dbSelectArea("TRB")
		dbGotop()
	
		While !eof()
	
			cQuest := TRB->QUEST
	
			Somalinha();Somalinha()
			lInicio := .f.
			cNome := trim(cQuest) + ' - ' + trim(TRB->NOMEQ)
			@Li,000 Psay STR0008 + cNome     //"Codigo: "
			Somalinha();Somalinha()
			@Li,000 Psay STR0009 //"Perguntas                                      Resp.   Qtde. Complemento"
			Somalinha()
	          
			lRespPer := .F.
			dbSelectArea("TRB2")
			Dbgotop()
			dbSeek(cQuest)
			While !Eof() .and. cQuest = TRB2->QUEST
				If TRB2->RESPP <> "1="+STR0023+";"+"2="+STR0024+";"+"3="+STR0025//"Sim"###"Nao"###"Sem Resposta"
					lRespPer := .T.
				Endif
				dbSkip()
			End
	          
			dbSelectArea("TRB2")
			Dbgotop()
			dbSeek(cQuest)
			While !Eof() .and. cQuest = TRB2->QUEST
	           
				SomaLinha()
				@ Li,000 Psay TRB2->PERGT
				@ Li,004 Psay '-'
					
				nLinhasMemo := MLCOUNT(Alltrim(TRB2->NOMEP),40)
				For LinhaCorrente := 1 to nLinhasMemo
					If LinhaCorrente = 1
						@ Li,006 Psay (MemoLine(Alltrim(TRB2->NOMEP),40,LinhaCorrente))
						@ Li,047 Psay If(!Empty(TRB2->RESPP),"(   )   ____  ___________________","              ___________________")
					Else
						Somalinha()
						@ Li,006 Psay (MemoLine(Alltrim(TRB2->NOMEP),40,LinhaCorrente))
					Endif
				Next LinhaCorrente
				If nLinhasMemo = 0
					@ Li,047 Psay If(!Empty(TRB2->RESPP),"(   )   ____  ___________________","              ___________________")
					Somalinha()
				ElseIf nLinhasMemo = 1
					Somalinha()
				Endif
				If !Empty(TRB2->RESPP) .and. lRespPer
					cResp := ""
					nPos := 0
					nPos := rAt(";",TRB2->RESPP)
					cResp := SubStr(TRB2->RESPP,1,nPos-1)+" ou "+SubStr(TRB2->RESPP,nPos+1)
					cResp := StrTran(cResp,";",", ")
					cResp := StrTran(cResp,"="," - ")
					If Len(AllTrim(cResp)) > 69
						nLinhaResp := MLCOUNT(AllTrim(cResp),69)
						For nLinCor := 1 To nLinhaResp
							If nLinCor = 1
								Somalinha()
								@ Li,000 Psay STR0028//"Respostas: "
								@ Li,011 Psay (MemoLine(Alltrim(cResp),69,nLinCor))
							Else
								Somalinha()
								@ Li,011 Psay (MemoLine(Alltrim(cResp),69,nLinCor))
							Endif
						next nLinCor
					Else
						Somalinha()
						@ Li,000 Psay STR0028//"Respostas: "
						@ Li,011 Psay AllTrim(cResp)
						Somalinha()
					Endif
				Endif
					
				DbSelectArea("TRB2")
				dbskip()

			Enddo
	          
			If !lRespPer
				SomaLinha()
				@ Li,000 Psay STR0026//"Todas as perguntas devem ser respondidas conforme abaixo:"
				SomaLinha()
				@ Li,000 Psay "1 - "+STR0023+", "+"2 - "+STR0024+" ou "+"3 - "+STR0025//"Sim"###"Nao"###"Sem Resposta"
			Else
				SomaLinha()
				@ Li,000 Psay STR0027//"As perguntas devem ser respondidas conforme as indicações de resposta."
				SomaLinha()
			Endif
	          
			lPrimeiro := .t.
			If !Empty(Mv_par04)
				Somalinha()
				@Li,000 Psay replicate("_",80)
				Somalinha()
				Somalinha()
				dbSelectArea("TMZ")
				dbSetorder(01)
				dbSeek(xFilial("TMZ")+mv_par04)
				@Li,000 Psay STR0015 + TMZ->TMZ_NOMTER //"Termo de Responsabilidade: "
				Somalinha()
				Somalinha()
				nLinhasMemo := MLCOUNT(TMZ->TMZ_DESCRI,80)
				For LinhaCorrente := 1 to nLinhasMemo
					If lPrimeiro
						If !empty((MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente)))
							@ Li,000 PSAY (MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente))
							lPrimeiro := .f.
						Else
							Exit
						Endif
					Else
						@ Li,000 PSAY (MemoLine(TMZ->TMZ_DESCRI,80,LinhaCorrente))
					EndIf
					Somalinha()
				Next
			EndIf
	          			
			Dbselectarea("TRB")
			Dbskip()
		Enddo
	Next xx

Endif


Roda(nCntImpr,cRodaTxt,Tamanho)
//---------------------------------------------------------------
// Devolve a condicao original do arquivo principal             
//---------------------------------------------------------------
RetIndex("TMG")
RetIndex("TMH")
Set Filter To

dbSelectArea("TRB")
dbGotop()
If RecCount()==0
	MsgInfo(STR0014)	//"Não há nada para imprimir no relatório."
	Use 
	dbSelectArea("TRB2")
	use	
	Return .F.
EndIf 

Set device to Screen

If aReturn[5] = 1
   Set Printer To
   dbCommitAll()
   OurSpool(wnrel)
Endif
MS_FLUSH()

dbSelectArea("TRB")
use
dbSelectArea("TRB2")
use
Return NIL
//---------------------------------------------------------------------
/*/{Protheus.doc} Somalinha
Incrementa Linha e Controla Salto de Pagina 

@author Denis Hyroshi de Souza
@since 04/09/02
@return Nil
/*/ 
//---------------------------------------------------------------------
Static Function Somalinha()
    Li++
    If Li > 58
       Cabec(titulo,cabec1,cabec2,nomeprog,tamanho,nTipo)
       If lInicio
          U_Cabec880()
          lInicio := .f.
       Endif  
    EndIf
Return  
//---------------------------------------------------------------------
/*/{Protheus.doc} Cabec880
 Imprime cabecalho de dados do funcionario  

@sample MDTR880

@author Denis Hyroshi de Souza
@since 04/09/02
@return Nil
/*/ 
//---------------------------------------------------------------------
User Function Cabec880()
Somalinha()
If lSigaMdtps
	@Li,000 Psay STR0013 + AllTrim(TRB->CLIENT) + "-" + AllTrim(TRB->LOJA) + " - " + AllTrim(TRB->NOME) //"Cliente/Loja: 000002-0000 - IBM Ferro Velho S.A.
	Somalinha();Somalinha()	
Endif
@Li,000 Psay STR0010 //"Matricula.:___________ Nome.:__________________________________ Data.:__/__/__"
Somalinha();Somalinha()
@Li,000 Psay STR0011 //"Cargo.:______________________ Funcao.:________________________________________"
Somalinha();Somalinha();Somalinha()
@Li,000 Psay STR0012 //"Assinatura.:__________________________"
Somalinha()
@Li,000 Psay replicate("_",80)
Somalinha()
Return
/*/
          1         2         3         4         5         6         7         8         9         0         1         2         3
012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901
************************************************************************************************************************************
Matricula.:__________  Nome.:____________________________________  Data.:__/__/__

Cargo.:_____________________  Funcao.:___________________________________________


Assinatura.:__________________________ 
_________________________________________________________________________________

Código:  XXXXXX  -  XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX

Perguntas                                      Resp.   Qtde. Complemento

XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (   )   ____  ____________________
      XXXXXXXXXXXXXXX
Respostas: XXX - XXXXXXXXXXXXX
XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX               ____________________
              
XXX - XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX (   )   ____  ____________________
Respostas: XXX - XXXXXXXXXXXXX

As perguntas devem ser respondidas conforme as indicações de resposta.
/*/