/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prАtica e de fАcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "MATR710.CH"
#INCLUDE "PROTHEUS.CH"

#define DESLOC_ETQ  57
/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё MATR710  Ё Autor Ё Paulo Boschetti       Ё Data Ё 13.05.92 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Etiquetas para os volumes                                  Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠ЁSintaxe   Ё U_MATR710(void)                                              Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё Generico                                                   Ё╠╠
╠╠цддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё ATUALIZACOES SOFRIDAS DESDE A CONSTRUCAO INICIAL.                     Ё╠╠
╠╠цддддддддддддддбддддддддбддддддбдддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё PROGRAMADOR  Ё DATA   Ё BOPS Ё  MOTIVO DA ALTERACAO                   Ё╠╠
╠╠юддддддддддддддаддддддддаддддддадддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
User Function Matr710()
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL titulo 	:= OemToAnsi(STR0001)	//"Etiquetas para embalagens"
LOCAL cDesc1 	:= OemToAnsi(STR0002)	//"Este programa   ira emitir as etiquetas"
LOCAL cDesc2 	:= OemToAnsi(STR0003)	//"para as embalagens a serem despachadas."
LOCAL cDesc3 	:= ""
LOCAL wnrel
LOCAL tamanho	:= "G"
LOCAL cString	:= "SF2"
LOCAL aOrd      := { OemToAnsi(STR0004) }		//" Etiqueta - 36 X 81mm  4 colunas "
LOCAL aImp      := 0

PRIVATE aReturn := { OemToAnsi(STR0005), 1,OemToAnsi(STR0006), 2, 2, 1, "",1 }		//"Etiqueta"###"Producao"
PRIVATE nomeprog:="MATR710"
PRIVATE aLinha  := { },nLastKey := 0
PRIVATE cPerg   :="MTR710"

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Variaveis utilizadas para Impressao do Cabecalho e Rodape    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

If FATPDUserAcc() 
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica as perguntas selecionadas                           Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	pergunte("MTR710",.F.)
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Variaveis utilizadas para parametros                         Ё
	//Ё mv_par01        	// Qual Serie De Nota Fiscal             Ё
	//Ё mv_par02        	// Nota Fiscal de                        Ё
	//Ё mv_par03        	// Nota Fiscal ate                       Ё
	//Ё mv_par04        	// Emite por   Pedido   Nota Fiscal      Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Envia controle para a funcao SETPRINT                        Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	wnrel:="MATR710"             //Nome Default do relatorio em Disco
	wnrel:=SetPrint(cString,wnrel,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,tamanho)

	If nLastKey == 27
		dbClearFilter()
		Return
	Endif

	SetDefault(aReturn,cString)

	If nLastKey == 27
		dbClearFilter()
		Return
	Endif

	RptStatus({|lEnd| C710Imp(@lEnd,wnRel,cString)},Titulo)
Endif

Return

/*/
эээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээээ
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
╠╠зддддддддддбддддддддддбдддддддбдддддддддддддддддддддддбддддддбдддддддддд©╠╠
╠╠ЁFun┤┘o    Ё C710IMP  Ё Autor Ё Rosane Luciane Chene  Ё Data Ё 09.11.95 Ё╠╠
╠╠цддддддддддеддддддддддадддддддадддддддддддддддддддддддаддддддадддддддддд╢╠╠
╠╠ЁDescri┤┘o Ё Chamada do Relatorio                                       Ё╠╠
╠╠цддддддддддедддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд╢╠╠
╠╠Ё Uso      Ё MATR550			                                          Ё╠╠
╠╠юддддддддддадддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды╠╠
╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠
ъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъъ
/*/
Static Function C710Imp(lEnd,WnRel,cString)
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Define Variaveis                                             Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
LOCAL CbTxt
LOCAL titulo 	:= OemToAnsi(STR0001)	//"Etiquetas para embalagens"
LOCAL cDesc1 	:= OemToAnsi(STR0002)	//"Este programa   ira emitir as etiquetas"
LOCAL cDesc2 	:= OemToAnsi(STR0003)	//"para as embalagens a serem despachadas."
LOCAL cDesc3 	:= ""
LOCAL nTipo, nOrdem
LOCAL CbCont,cabec1,cabec2
LOCAL tamanho	:= "P"
LOCAL limite 	:= 80
LOCAL lContinua := .T.
LOCAL nVolume 	:= 0
LOCAL nVolumex	:= 0
LOCAL aEtiq[8,4]
LOCAL nEtiqueta := 1
LOCAL G 		:= 1
LOCAL I 		:= 1
LOCAL J 		:= 1
LOCAL aOrd      := { OemToAnsi(STR0004) }	//" Etiqueta - 36 X 81mm  4 colunas "
LOCAL aImp      := 0
LOCAL nEstaOk   := 0
LOCAL nContCol  := 1
LOCAL cPedi     := ""
Local cX
Local cIndex
Local lRet      := .F.
Local cCadastro := OemToAnsi(STR0007)	//"Etiquetas de Volume"
//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Definicao do cabecalho e tipo de impressao do relatorio      Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
cbtxt    := SPACE(10)
cbcont   := 0
li       := 0
col      := 0
m_pag    := 1

titulo := STR0008	//"ETIQUETAS PARA EMBALAGENS"
cabec1 := ""
cabec2 := ""

nTipo  := 18

nOrdem := aReturn[8]

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Analisa o parametro mv_par04                                 Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

dbSelectArea("SD2")
If mv_par04 == 1
	cIndex := CriaTrab(nil,.f.)
	IndRegua("SD2",cIndex,"D2_FILIAL+D2_DOC+D2_SERIE+D2_ITEM",,,OemToAnsi(STR0019))		//"Selecionando Registros..."
Else
	dbSetOrder(3)
EndIf

//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Acesso nota fiscal informada pelo usuario                    Ё
//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
dbSelectArea("SF2")
dbSeek(xFilial()+mv_par02+mv_par01,.T.)

SetRegua(RecCount())		// Total de Elementos da regua

//зддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
//Ё Faz manualmente porque nao chama a funcao Cabec()                 Ё
//юддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды

While !eof() .and. lContinua .And. xFilial()==F2_FILIAL .And. F2_DOC <= mv_par03
	
	IncRegua()
	
	If SerieNfId("SF2",2,"F2_SERIE") != mv_par01
		dbskip()
		Loop
	EndIf

	If IsRemito(1,"SF2->F2_TIPODOC")
		dbSkip()
		Loop
	Endif
			
	IF lEnd
		@PROW()+1,001 Psay STR0009	//"CANCELADO PELO OPERADOR"
		lContinua := .F.
		EXIT
	Endif
	
	dbSelectArea("SD2")
	If mv_par04 == 2
		dbSetOrder(3)
	EndIf
	dbSeek(xFilial()+SF2->F2_DOC+SF2->F2_SERIE)
	
    If SD2->D2_TIPO $"DB"
	    dbSelectArea("SA2")
    	dbSetOrder(1)
    	dbSeek(xFilial()+SF2->F2_CLIENTE+SF2->F2_LOJA)
    Else
	    dbSelectArea("SA1")
    	dbSetOrder(1)
    	dbSeek(xFilial()+SF2->F2_CLIENTE+SF2->F2_LOJA)
	Endif
	
	dbSelectArea("SA4")
	dbSetOrder(1)                                         
	dbSeek(xFilial()+SF2->F2_TRANSP)
	
	//здддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддд©
	//Ё Verifica se mesmo mudando a Nota fiscal o pedido e' o mesmo  Ё
	//Ё imprime apenas uma vez a etiqueta de volume                  Ё
	//юдддддддддддддддддддддддддддддддддддддддддддддддддддддддддддддды
	If mv_par04 == 1
		If cPedi == SD2->D2_PEDIDO
			dbSelectArea("SF2")
			dbSkip()
			Loop
		Endif
	EndIf
	
	cPedi := SD2->D2_PEDIDO
	
	For G:=1 to 4
		cX := "SF2->F2_VOLUME"+str(G,1)
		nVolume := nVolumex := &cx
		While nVolume != 0
			If nOrdem == 1
				If aImp == 0
					While !lRet
						lRet := (MsgYesNo(OemToAnsi(STR0010),OemToAnsi(STR0011)))			//"O Alinhamento da Impressora esta correto ?"###"Aten┤└o"
					End
				EndIf
				_n_Lin := pRow()
				_n_Col := pCol()
				@ _n_Lin,_n_Col Psay chr( getMV( "MV_COMP" ) )
				setPrc( _n_Lin,_n_Col )
				cX := "SF2->F2_ESPECI"+str(G,1)
				Do Case
					Case nEtiqueta == 1
						If nVolume != 0
        					aEtiq[1,nEtiqueta] := IIF(SD2->D2_TIPO $"DB",STR0020,STR0012)+PadR(SD2->D2_CLIENTE,20)+STR0013+SD2->D2_PEDIDO				//"Cliente: "###"Pedido: "
		
                            If SD2->D2_TIPO $"DB"
     					    	aEtiq[2,nEtiqueta] := SA2->A2_NOME
	     						aEtiq[3,nEtiqueta] := Subs(SA2->A2_END,1,49)
		    					aEtiq[4,nEtiqueta] := STR0014+Trans(SA2->A2_CEP,"@R 99999-999")+" "+AllTrim(SA2->A2_MUN)+" "+SA2->A2_EST		//"Cep: "
		                    Else
     					    	aEtiq[2,nEtiqueta] := SA1->A1_NOME
	     						aEtiq[3,nEtiqueta] := IIF(!empty(SA1->A1_ENDENT),Subs(SA1->A1_ENDENT,1,49),Subs(SA1->A1_END,1,49))
		    					aEtiq[4,nEtiqueta] := STR0014+Trans(SA1->A1_CEP,"@R 99999-999")+" "+AllTrim(SA1->A1_MUN)+" "+SA1->A1_EST		//"Cep: "
                            Endif
		                    
							aEtiq[5,nEtiqueta] := STR0015		//"Transportadora: "
							aEtiq[6,nEtiqueta] := SA4->A4_NOME
							aEtiq[7,nEtiqueta] := STR0016+AllTrim(STR((nVolumex-nVolume)+1))+"/"+AllTrim(STR(nVolumex))+" "+STR0017+&cX			//"Volume: "###"    Especie: "
							aEtiq[8,nEtiqueta] := STR0018+SF2->F2_DOC+"/"+mv_par01		//"Nota Fiscal/Serie: "
							nVolume--
							nEtiqueta++
						EndIf
					Case nEtiqueta == 2
						If nVolume != 0
        					aEtiq[1,nEtiqueta] := IIF(SD2->D2_TIPO $"DB",STR0020,STR0012)+PadR(SD2->D2_CLIENTE,20)+STR0013+SD2->D2_PEDIDO				//"Cliente: "###"Pedido: "

                            If SD2->D2_TIPO $"DB"
   		       					aEtiq[2,nEtiqueta] := SA2->A2_NOME
           		  				aEtiq[3,nEtiqueta] := Subs(SA2->A2_END,1,49)
				      			aEtiq[4,nEtiqueta] := STR0014+Trans(SA2->A2_CEP,"@R 99999-999")+" "+AllTrim(SA2->A2_MUN)+" "+SA2->A2_EST			//"Cep: "
                            Else
   		       					aEtiq[2,nEtiqueta] := SA1->A1_NOME
           		  				aEtiq[3,nEtiqueta] := IIF(!empty(SA1->A1_ENDENT),Subs(SA1->A1_ENDENT,1,49),Subs(SA1->A1_END,1,49))
				      			aEtiq[4,nEtiqueta] := STR0014+Trans(SA1->A1_CEP,"@R 99999-999")+" "+AllTrim(SA1->A1_MUN)+" "+SA1->A1_EST			//"Cep: "
                            Endif

  							aEtiq[5,nEtiqueta] := STR0015		//"Transportadora: "
							aEtiq[6,nEtiqueta] := SA4->A4_NOME
							aEtiq[7,nEtiqueta] := STR0016+AllTrim(STR((nVolumex-nVolume)+1))+"/"+AllTrim(STR(nVolumex))+" "+STR0017+&cX			//"Volume: "###"    Especie: "
							aEtiq[8,nEtiqueta] := STR0018+SF2->F2_DOC+"/"+mv_par01				//"Nota Fiscal/Serie: "
							nVolume--
							nEtiqueta++
						EndIf
					Case nEtiqueta == 3
						If nVolume != 0
							aEtiq[1,nEtiqueta] := IIF(SD2->D2_TIPO $"DB",STR0020,STR0012)+PadR(SD2->D2_CLIENTE,20)+STR0013+SD2->D2_PEDIDO			//"Cliente: "###"Pedido: "

                            If SD2->D2_TIPO $"DB"
   		       					aEtiq[2,nEtiqueta] := SA2->A2_NOME
           		  				aEtiq[3,nEtiqueta] := Subs(SA2->A2_END,1,49)
				      			aEtiq[4,nEtiqueta] := STR0014+Trans(SA2->A2_CEP,"@R 99999-999")+" "+AllTrim(SA2->A2_MUN)+" "+SA2->A2_EST			//"Cep: "
							Else
							    aEtiq[2,nEtiqueta] := SA1->A1_NOME
							    aEtiq[3,nEtiqueta] := IIF(!empty(SA1->A1_ENDENT),Subs(SA1->A1_ENDENT,1,49),Subs(SA1->A1_END,1,49))
							    aEtiq[4,nEtiqueta] := STR0014+Trans(SA1->A1_CEP,"@R 99999-999")+" "+AllTrim(SA1->A1_MUN)+" "+SA1->A1_EST			//"Cep: "
                            Endif
                             
							aEtiq[5,nEtiqueta] := STR0015		//"Transportadora: "
							aEtiq[6,nEtiqueta] := SA4->A4_NOME
							aEtiq[7,nEtiqueta] := STR0016+AllTrim(STR((nVolumex-nVolume)+1))+"/"+AllTrim(STR(nVolumex))+" "+STR0017+&cX			//"Volume: "###"    Especie: "
							aEtiq[8,nEtiqueta] := STR0018+SF2->F2_DOC+"/"+mv_par01			//"Nota Fiscal/Serie: "
							nVolume--
							nEtiqueta++
						EndIf
					Case nEtiqueta == 4
						If nVolume != 0
							aEtiq[1,nEtiqueta] := IIF(SD2->D2_TIPO $"DB",STR0020,STR0012)+PadR(SD2->D2_CLIENTE,20)+STR0013+SD2->D2_PEDIDO			//"Cliente: "###"Pedido: "
						
                            If SD2->D2_TIPO $"DB"
   		       					aEtiq[2,nEtiqueta] := SA2->A2_NOME
           		  				aEtiq[3,nEtiqueta] := Subs(SA2->A2_END,1,49)
				      			aEtiq[4,nEtiqueta] := STR0014+Trans(SA2->A2_CEP,"@R 99999-999")+" "+AllTrim(SA2->A2_MUN)+" "+SA2->A2_EST			//"Cep: "
							Else
							    aEtiq[2,nEtiqueta] := SA1->A1_NOME
							    aEtiq[3,nEtiqueta] := IIF(!empty(SA1->A1_ENDENT),Subs(SA1->A1_ENDENT,1,49),Subs(SA1->A1_END,1,49))
							    aEtiq[4,nEtiqueta] := STR0014+Trans(SA1->A1_CEP,"@R 99999-999")+" "+Trim(SA1->A1_MUN)+" "+SA1->A1_EST			//"Cep: "
                            Endif  
                            
   							aEtiq[5,nEtiqueta] := STR0015		//"Transportadora: "
							aEtiq[6,nEtiqueta] := SA4->A4_NOME
							aEtiq[7,nEtiqueta] := STR0016+AllTrim(STR((nVolumex-nVolume)+1))+"/"+AllTrim(STR(nVolumex))+" "+STR0017+&cX			//"Volume: "###"    Especie: "
							aEtiq[8,nEtiqueta] := STR0018+SF2->F2_DOC+"/"+mv_par01			//"Nota Fiscal/Serie: "
							nVolume--
							nEtiqueta := 1
							For I:= 1 TO 8
								For J:=1 TO 4
									@Li , COL  Psay aEtiq[I,J]
									COL += DESLOC_ETQ
								Next j
								Li++
								COL := 0
							Next I
							For I:= 1 TO 8
								For J:=1 TO 4
									aEtiq[I,J] := ""
								NEXT J
							NEXT I
							Li++
							If Li>80
								Li :=1
								m_pag++
							EndIf
						EndIf
				EndCase
			EndIf
		End
		dbSelectArea("SD2")
		dbSkip()
	Next G
	
	dbSelectArea("SF2")
	dbSkip()
End

If nOrdem == 1
	For I:= 1 TO 8
		For J:=1 TO 4
			If !EMPTY(aEtiq[I,J])
				@Li , COL  Psay aEtiq[I,J]
				COL += DESLOC_ETQ
			EndIf
		NEXT J
		Li++
		COL := 0
	Next I
EndIf
@ Li+1,0 Psay ""
Setprc(0,0)

dbSelectArea("SD2")
RetIndex("SD2")
dbSetOrder(1)

dbSelectArea("SF2")

If mv_par04==1
	RetIndex("SD2")

Endif

dbSelectArea("SF2")
dbClearFilter()
dbSetOrder(1)

If aReturn[5] == 1
	Set Printer TO
	dbCommitAll()
	ourspool(wnrel)
Endif

MS_FLUSH()

Return .T.

//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDUserAcc
    @description
    Verifica se o usuario logado possui acesso a dados sensiveis e pessoais
    Exibindo mensagem de Help caso usuario nЦo possua acesso.
	Remover essa funГЦo quando nЦo houver releases menor que 12.1.27

    @type  Function
    @sample FATPDUserAcc()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Retorna se Usuario possui acesso a dados protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDUserAcc()

    Local lRet := .T.  

    If FATPDActive()
        lRet := FTPDUserAcc()
    Endif

Return lRet


//-----------------------------------------------------------------------------
/*/{Protheus.doc} FATPDActive
    @description
    FunГЦo que verifica se a melhoria de Dados Protegidos existe.

    @type  Function
    @sample FATPDActive()
    @author Squad CRM & Faturamento
    @since 17/12/2019
    @version P12    
    @return lRet, Logico, Indica se o sistema trabalha com Dados Protegidos
/*/
//-----------------------------------------------------------------------------
Static Function FATPDActive()

    Static _lFTPDActive := Nil
  
    If _lFTPDActive == Nil
        _lFTPDActive := ( GetRpoRelease() >= "12.1.027" .Or. !Empty(GetApoInfo("FATCRMPD.PRW")) )  
    Endif

Return _lFTPDActive  
