/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ษออออออออหออออออออป
// บ Versao บ 10     บ
// ศออออออออสออออออออผ
#INCLUDE "OFIGR050.ch" 
#INCLUDE "PROTHEUS.CH"       
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณOFIGR050  บ Autor ณ Ricardo Farinelli  บ Data ณ  02/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Relatorio de Garantias Solicitadas                         บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function OFIGR050()

Local aOrd           := {}
Local cDesc1         := STR0001 //"Este programa tem como objetivo imprimir as garantias"
Local cDesc2         := STR0002 //"solicitadas a Montadora              "
Local cDesc3         := ""
Local cPict          := ""
Local imprime        := .T.
Local cString        := "VO6"
Local cIndice        := ""
Local cChave         := ""
Local cCondicao      := ""
Local nIndice 		   := 0
Private cMontadora   := ""
Private wnrel        := "OFIGR050"
Private cTitulo      := STR0003 //"Garantias Solicitadas             "
Private Cabec1       := STR0004 //" [Nro.OS] [Dt.Abe] [Ch.I] [Chassi do Veiculo------] [Modelo----------------------] [Proprietario-----------------------] [CR] [GR]"
Private Cabec2       := STR0023 
Private Cabec3       := STR0005 //"          [Gar] [Dt.Rep] [Dt.Ven] [Km Veic.] [Segmento] [DN--] [AutFab] [NF.Pc---] [Total Pcs-] [T.Pad] [Total Srvs] [Especie de Garantia-]"
Private nLin         := 80
Private lEnd         := .F.
Private lAbortPrint  := .F.
Private limite       := 220
Private tamanho      := "M"
Private nTipo        := 15
Private aReturn      := {STR0006, 1,STR0007, 1, 2, 1, "", 1} //"Zebrado"###"Administracao"
Private nLastKey     := 0
Private cPerg        := "OGR050"
Private cbtxt        := Space(10)
Private cbcont       := 00
Private CONTFL       := 01
Private m_pag        := 01
Private cIndVG5		:= ""
Private nIndVG5		:= 0

ValidPerg()

wnrel := SetPrint(cString,wnrel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.F.,aOrd,.F.,Tamanho,,.F.)

If nLastKey == 27
	Return
Endif

pergunte(cPerg,.F.)

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

If MV_PAR01 == 1
   cTitulo += STR0021 // Data de Referencia: Fechamento
Else
   cTitulo += STR0022 // Data de Referencia: Transmissao
EndIf
cTitulo +=STR0008 +dToc(MV_PAR02) //" de "
cTitulo +=STR0009+dToc(MV_PAR03) //" a "
cTitulo +=STR0010+Iif(mv_par06==1,STR0011,Iif(mv_par06==2,STR0012,STR0013)) //" Tipo Garantia: "###"Solicitadas "###"Cupons Rev. "###"Ambas "

nTipo := If(aReturn[4]==1,15,18)

&& Ordena arquivo por itens
cIndVG5 := CriaTrab(nil,.F.)
cChave  := "VG5_FILIAL+VG5_CODMAR+VG5_NUMOSV+VG5_ORDITE+VG5_CODITE"

IndRegua("VG5",cIndVG5,cChave,,"",STR0024) //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VG5")
nIndVG5 := RetIndex("VG5") + 1
#IFNDEF TOP
   dbSetIndex(cIndVG5+ordBagExt())
#ENDIF
dbSetOrder(nIndVG5)
                             
cMontadora := MV_PAR09 // Traz o codigo de montadora padrao    
cIndice    := CriaTrab(nil,.F.)

cCondicao += "VGA_CODMAR=='"+cMontadora+"'"

If MV_PAR01 == 1
   If !Empty(MV_PAR02)
     cCondicao += ".and. ( Empty(MV_PAR02) .Or. DTOS(VGA_DATFEC)>='"+DTOS(MV_PAR02-365)+"' ) "
   Endif
  
   If !Empty(MV_PAR03)
     cCondicao += ".and. ( Empty(MV_PAR03) .Or. Str(Year(VGA_DATFEC),4)+Str(Month(VGA_DATFEC),2) <= '"+Str(Year(MV_PAR03),4)+Str(Month(MV_PAR03),2)+"' ) "
   Endif
Else
   If !Empty(MV_PAR02)
     cCondicao += ".and. ( Empty(MV_PAR02) .Or. DTOS(VGA_DATTRA)>='"+DTOS(MV_PAR02-365)+"' ) "
   Endif
  
   If !Empty(MV_PAR03)
     cCondicao += ".and. ( Empty(MV_PAR03) .Or. Str(Year(VGA_DATTRA),4)+Str(Month(VGA_DATTRA),2) <= '"+Str(Year(MV_PAR03),4)+Str(Month(MV_PAR03),2)+"' ) "
   Endif
EndIf

If mv_par06==1
  cCondicao += ".and. VGA_ESPGAR=='S'"
Elseif mv_par06==2
  cCondicao +=".and. VGA_ESPGAR=='R'"
Endif  

cCondicao += " .and. ( Empty(MV_PAR04) .Or. VGA_NUMOSV >= '"+MV_PAR04+"' ) .and. ( Empty(MV_PAR05) .Or. VGA_NUMOSV <= '"+MV_PAR05+"' )"
                                                 
If MV_PAR01 == 1
   cChave := "VGA_FILIAL+DTOS(VGA_DATFEC)+VGA_NUMOSV"
else
   cChave := "VGA_FILIAL+DTOS(VGA_DATTRA)+VGA_NUMOSV"
endif

IndRegua("VGA",cIndice,cChave,,cCondicao,STR0024) //"Aguarde Selecionando Registro para Impressao"

DbSelectArea("VGA")
nIndice := RetIndex("VGA") + 1
#IFNDEF TOP
   dbSetIndex(cIndice+ordBagExt())
#ENDIF
dbSetOrder(nIndice)

RptStatus({|lEnd| U_OFIG050IMP(@lEnd,wnrel,cString)},cTitulo)

DbSelectArea("VGA")
RetIndex()

#IFNDEF TOP
   If File(cIndice+OrdBagExt())
      fErase(cIndice+OrdBagExt())
   Endif
   If File(cIndVG5+OrdBagExt())
      fErase(cIndVG5+OrdBagExt())
   Endif
#ENDIF

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณOFIG050IMPบ Autor ณ Ricardo Farinelli  บ Data ณ  02/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao auxiliar para a impressao do relatorio              บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Gestao de Concessionarias                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function OFIG050IMP(lEnd,wnrel,cString)

Local nCntFor
Local nTotSrv 	:= 0 , nTotPOsv := 0 , nIte := 0
Local nTotPec 	:= 0 , nPos := 0
Local aResumo 	:= {}
Local lA1_IBGE 	:= If(SA1->(FieldPos("A1_IBGE"))>0,.t.,.f.)

Local nI			:= 0
Local aCausaCampos	:= {"VG5_CAUSA","VG5_CAUSA1","VG5_CAUSA2","VG5_CAUSA3"}
Local aReparCampos	:= {"VG5_REPARO","VG5_REPAR1","VG5_REPAR2","VG5_REPAR3"}
Local aOutrosCampos	:= {"VG5_OUTROS","VG5_OUTRO1","VG5_OUTRO2","VG5_OUTRO3"}

/*
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณMV_PAR01 = Qual data sera considerada para o relatorio: 1-Data do Fechamento/2-Data da Transmissao    ณ
//ณMV_PAR02 = Data Inicial - Data de inicio ou branco para desde o comeco                                ณ
//ณMV_PAR03 = Data Final - Data final para o escopo do relatorio                                         ณ
//ณmv_par06 = 1 - Garantias Solicitadas, 2 - Cupons de Revisao ou 3 - Ambos                              ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
*/

DbselectArea("VGA")

SetRegua(RecCount())

DbSeek(xFilial("VGA"))
Do While VGA->VGA_FILIAL == xFilial("VGA") .and. !VGa->(Eof())

  If ( MV_PAR01 == 1 .And. ( ( Empty(MV_PAR02) .Or. DTOS(VGA_DATFEC) >= DTOS(MV_PAR02) ) .And. ( Empty(MV_PAR03) .Or. DTOS(VGA_DATFEC) <= DTOS(MV_PAR03) ) ) ) ;
     .Or. ( MV_PAR01 == 2 .And. ( ( Empty(MV_PAR02) .Or. DTOS(VGA_DATTRA) >= DTOS(MV_PAR02) ) .And. ( Empty(MV_PAR03) .Or. DTOS(VGA_DATTRA) <= DTOS(MV_PAR03) ) ) )
	
	  If lAbortPrint .or. lEnd
	    @ FS_QUEBPAG() ,00 PSAY STR0014 //"*** CANCELADO PELO OPERADOR ***"
	    Exit
	  Endif
	  
	  If MV_PAR07 == 2
	    nLin := 0
	  Endif
	  
	  VE4->(DbSetOrder(1))
	  VE4->(Dbseek(xFilial("VE4")+cMontadora))  
	  VV1->(DbSetOrder(1))
	  VV1->(Dbseek(xFilial("VV1")+VGA->VGA_CHAINT))
	  VO5->(DbSetOrder(1))
	  VO5->(Dbseek(xFilial("VO5")+VGA->VGA_CHAINT))
	  VO1->(DbSetOrder(1))
	  VO1->(Dbseek(xFilial("VO1")+VGA->VGA_NUMOSV))
	  SA1->(DbSetOrder(1))
	  SA1->(Dbseek(xFilial("SA1")+VGA->(VGA_CODCLI+VGA_LOJA)))
	  VG3->(DbsetOrder(1))
	  VG3->(Dbseek(xFilial("VG3")+VGA->(VGA_CODMAR+VGA_ESPGAR)))
	  
	  @ FS_QUEBPAG() ,001       PSAY if(!emptY(VGA->VGA_NUMOSV),VGA->VGA_NUMOSV,VGA->VGA_NUMNFI)
	  @ nLin,pcol()+01 PSAY VGA->VGA_ABEGAR
	  @ nLin,pcol()+01 PSAY VGA->VGA_CHAINT
	  @ nLin,pcol()+01 PSAY VV1->VV1_CHASSI
	  @ nLin,pcol()+01 PSAY VV1->VV1_MODVEI
	  @ nLin,pcol()+01 PSAY VGA->VGA_CODCLI+"/"+VGA->VGA_LOJA
	  @ nLin,pcol()+01 PSAY Substr(SA1->A1_NOME,1,27)
	
	  @ FS_QUEBPAG(),010 PSAY Substr(SA1->A1_END ,1,40)
	  If lA1_IBGE
		  VAM->(DbSetOrder(1))
		  VAM->(Dbseek(xFilial("VAM")+SA1->A1_IBGE))
		  @ nLin,pcol()+01 PSAY Substr(VAM->VAM_DESCID,1,15)
		  @ nLin,pcol()+01 PSAY Substr(VAM->VAM_ESTADO,1,02)
	  Else
		  @ nLin,pcol()+01 PSAY Substr(SA1->A1_MUN,1,15)
		  @ nLin,pcol()+01 PSAY Substr(SA1->A1_EST,1,02)
	  EndIf
	  @ nLin,pcol()+01 PSAY Substr(SA1->A1_CEP ,1,08)
	  @ nLin,pcol()+01 PSAY Substr(SA1->A1_TEL ,1,15)
	  @ nLin,pcol()+01 PSAY VGA->VGA_CODREV
	  @ nLin,pcol()+01 PSAY VGA->VGA_GRUREV
	  
	  @ FS_QUEBPAG(),010 PSAY VGA->VGA_CODGAR
	  @ nLin,pcol()+01 PSAY VGA->VGA_DATFEC
	  @ nLin,pcol()+01 PSAY VGA->VGA_DATTRA
	  @ nLin,pcol()+01 PSAY VO5->VO5_DATVEN
	  @ nLin,pcol()+01 PSAY Transform(VO1->VO1_KILOME,"@E 99999,999")
	  @ nLin,pcol()+01 PSAY VV1->VV1_SEGMOD
	  @ nLin,pcol()+01 PSAY if(MV_PAR06=2,VGA->VGA_DNRESP,VE4->VE4_CODCON)
	  @ nLin,pcol()+01 PSAY VGA->VGA_AUTFAB
	  @ nLin,pcol()+03 PSAY VGA->VGA_NFIFEC
	  @ nLin,pcol()+01 PSAY Transform(VGA->VGA_VALPEC,"@E 9999,999.99")
	  @ nLin,pcol()+01 PSAY Transform(VGA->VGA_TEMPAD,"@E 999:99")
	  @ nLin,pcol()+01 PSAY Transform(VGA->VGA_VALTPO,"@E 9999,999.99")
	  @ nLin,pcol()+01 PSAY VGA->VGA_ESPGAR+ " "+Substr(VG3->VG3_DESREC,1,20)
	 
	  @ FS_QUEBPAG(),010 PSAY STR0015 //"Motivo: "
	
	  DbSelectArea("SYP")
	  DbSeek(xFilial("SYP")+VGA->VGA_OBSMEM )
	           
	  Do While !Eof() .And. SYP->YP_CHAVE == VGA->VGA_OBSMEM .And. SYP->YP_FILIAL == xFilial("SYP")
			
		  cTexPart = Stuff(SYP->YP_TEXTO, If( (nPos:=At("\13\10",SYP->YP_TEXTO))<=0 ,80,nPos) ,6,Space(6))
		  
		  for nCntFor = 1 to Len(cTexPart) step 80
	      	@ FS_QUEBPAG(),10 PSAY SUBS(cTexPart,nCntFor,80)
	      next 
	
		   DbSelectArea("SYP")
	      DbSkip()
	               
     EndDo

	  nLin++
	
	  nTotPec += VGA->VGA_VALPEC
	  nTotSrv += VGA->VGA_VALTPO
	                     
	  @ FS_QUEBPAG(),001 PSAY  "         " + STR0025 //"Seq Grp  Codigo da Peca------------- Descr Peca----- Def For Qtdade ------Valor -GS Codigo Servico- Descr Servico- Tpo Gar."

	  nTotPOsv := 0		
	  
		For nIte:=0 to 1
		
			DbSelectArea("VG5")
			DbSetOrder(nIndVG5)
			
			If VG5->(Dbseek(xFilial("VG5")+VGA->VGA_CODMAR+VGA->VGA_NUMOSV ))
		
			nLin++   

			@ FS_QUEBPAG(),011 PSAY If(nIte==0,STR0026,STR0027)  //ITENS NORMAIS","ITENS ADICIONAIS"
			
			Do While VG5->VG5_FILIAL+VG5->VG5_CODMAR+VG5->VG5_NUMOSV == xFilial("VG5") + VGA->VGA_CODMAR + VGA->VGA_NUMOSV .and. !VG5->(Eof())
							
				If !Empty(VG5->VG5_ITEEXT) .And. VG5->VG5_ITEEXT # Str(nIte,1) ;
				.Or. !Empty(VG5->VG5_SEREXT) .And. VG5->VG5_SEREXT # Str(nIte,1)
					
					DbSelectArea("VG5")
					DbSkip()
					Loop
					
				EndIf
					
				SB1->(DbsetOrder(1))
				SB1->(Dbseek(xFilial("SB1")+VG5->VG5_PECINT))
				VO6->(DbsetOrder(1))
				VO6->(Dbseek(xFilial("VO6")+VG5->VG5_SERINT))
				
				@ FS_QUEBPAG(),011 PSAY VG5->VG5_ORDITE
				@ nLin,pCol()+1 PSAY VG5->VG5_GRUITE
				@ nLin,pCol()+1 PSAY VG5->VG5_CODITE
				@ nLin,pCol()+1 PSAY Substr(SB1->B1_DESC,1,15)
				@ nLin,pCol()+1 PSAY VG5->VG5_CODDEF
				@ nLin,pCol()+1 PSAY VG5->VG5_CODFOR
				@ nLin,pCol()+1 PSAY Transform(VG5->VG5_QTDITE,"@E 999999")
				@ nLin,pCol()+1 PSAY Transform(VG5->VG5_VALPEC,"@E 9999,999.99")
				@ nLin,pCol()+2 PSAY VO6->VO6_GRUSER
				@ nLin,pCol()+1 PSAY VG5->VG5_CODSER
				@ nLin,pCol()+1 PSAY Substr(VO6->VO6_DESSER,1,14)
				@ nLin,pCol()+1 PSAY Transform(VG5->VG5_TEMPAD,"@E 999:99")
			
				If !Empty(VG5->VG5_OBSERV)
					@ FS_QUEBPAG(),011 PSAY STR0015 //"Motivo: "
					@ nLin,019 PSAY SUBS(Alltrim(VG5->VG5_OBSERV),1,71)
					for nCntFor = 72 to Len(Alltrim(VG5->VG5_OBSERV)) step 90
						nLin++
						@ nLin,019 PSAY SUBS(Alltrim(VG5->VG5_OBSERV),nCntFor,90)
					next
					nLin ++
				EndIf           
								
				//Renata
				@ FS_QUEBPAG(),011 PSAY STR0067 //"Causa: "
				For nI := 1 To Len(aCausaCampos)
					If VG5->(FieldPos(aCausaCampos[nI])) > 0
						If !Empty(VG5->&(aCausaCampos[nI]))
							@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aCausaCampos[nI])),1,71)
							for nCntFor = 72 to Len(Alltrim(VG5->&(aCausaCampos[nI]))) step 90
								nLin++
								@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aCausaCampos[nI])),nCntFor,90)
							next
							nLin ++
						EndIf
					Endif
				Next

				@ FS_QUEBPAG(),011 PSAY STR0068 //"Reparo: "
				For nI := 1 To Len(aReparCampos)
					If VG5->(FieldPos(aReparCampos[nI])) > 0
						If !Empty(VG5->&(aReparCampos[nI]))
							@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aReparCampos[nI])),1,71)
							for nCntFor = 72 to Len(Alltrim(VG5->&(aReparCampos[nI]))) step 90
								nLin++
								@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aReparCampos[nI])),nCntFor,90)
							next
							nLin ++
						EndIf  
					Endif
				Next

				 @ FS_QUEBPAG(),011 PSAY STR0069 //"Outros: "
				For nI := 1 To Len(aOutrosCampos)
					If VG5->(FieldPos(aOutrosCampos[nI])) > 0
						If !Empty(VG5->&(aOutrosCampos[nI]))
							@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aOutrosCampos[nI])),1,71)
							for nCntFor = 72 to Len(Alltrim(VG5->&(aOutrosCampos[nI]))) step 90
								nLin++
								@ nLin,019 PSAY SUBS(Alltrim(VG5->&(aOutrosCampos[nI])),nCntFor,90)
							next
							nLin ++
						EndIf  
					Endif
				Next 

				nTotPOsv += VG5->VG5_VALPEC	

				DbSelectArea("VG5")
				VG5->(Dbskip())
		
			Enddo

			Endif    

		Next
	   
	  @ FS_QUEBPAG(),058 PSAY STR0016+Transform(nTotPOsv,"@E 999,999,999.99")+Space(3)+STR0017+Transform(VGA->VGA_VALTPO,"@E 999,999,999.99") //"Valor de Pecas.: "###" Valor de Servicos.: "
	  nLin++	  
  
  EndIf	

  && Totaliza resumido
  U_FS_LEVRES(@aResumo,MV_PAR02,MV_PAR01)
  		
  IncRegua()

  DbSelectArea("VGA")
  VGA->(Dbskip())

Enddo

@ FS_QUEBPAG(),052 PSAY STR0018+Transform(nTotPec,"@E 999,999,999.99")+Space(2)+STR0019+Transform(nTotSrv,"@E 999,999,999.99") //"Valor Geral de Pecas.: "###" Valor Geral de Servicos.: "

If MV_PAR08 == 2                  
	&& Imprime resumido                           
	U_FS_IMPRES(aResumo,MV_PAR02)
EndIf
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Finaliza a execucao do relatorio...                                 ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

SET DEVICE TO SCREEN

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Se impressao em disco, chama o gerenciador de impressao...          ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

If aReturn[5]==1
   dbCommitAll()
   SET PRINTER TO
   OurSpool(wnrel)
Endif

MS_FLUSH()

Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณVALIDPERG บ Autor ณ Ricardo Farinelli  บ Data ณ  02/07/01   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Verifica a existencia das perguntas criando-as caso seja   บฑฑ
ฑฑบ          ณ necessario (caso nao existam).                             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Programa principal                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function ValidPerg

Local _sAlias := Alias()
Local aRegs := {}
Local i,j

dbSelectArea("SX1")
dbSetOrder(1)
cPerg := PADR(cPerg,10)

//aAdd(aRegs,{cPerg,"01",STR0020,"","","mv_ch1","D", 08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""}) //"Data Inicial      ?"
//aAdd(aRegs,{cPerg,"02","Data Final        ?","","","mv_ch2","D", 08,0,0,"G","","mv_par02","","","","","","","","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"08",STR0063,"","","mv_ch8","N",1,0,0,"C","NaoVazio()","mv_par08",STR0065,"","","","",STR0066,"","","","","","","","","","","","","","","","","","","",""})
Aadd(aRegs,{cPerg,"09",STR0064,"","","mv_ch9","C",TamSX3("VE1_CODMAR")[1],0,0,"G","","mv_par09","","","","","","","","","","","","","","","","","","","","","","","","","VE1",""})

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
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFS_QUEBPAGบAutor  ณFabio               บ Data ณ  02/19/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณPula pagina                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Oficina                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                    
Static Function FS_QUEBPAG()

If nLin == 0 .Or. nLin >= 63

	nLin := cabec(ctitulo,"","",wnRel,tamanho,nTipo)
	          
	If Type("Cabec1") # "U" .And. Type("Cabec2") # "U" .And. Type("Cabec3") # "U" 
	   @ ++nLin,000 PSAY cabec1
	   @ ++nLin,000 PSAY cabec2
	   @ ++nLin,000 PSAY cabec3
	   @ ++nLin,000 PSAY Replicate("_",132)
	EndIf

EndIf   
        
nLin += 1

Return( nLin )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFS_LEVRES บAutor  ณFabio               บ Data ณ  12/17/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณLevanta resumido                                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                            
User Function FS_LEVRES(aResumo,dDataRef,nDataValid)

Local bFound := {|cStr| ( cStrx := cStr , Ascan(aResumo,{|x| x[1] == cStrx }) ) } , nColVet := 0

Default nDataValid := 2
               
If Len(aResumo) == 0

	&& Total Creditos de solic. garantia
	Aadd(aResumo, { "01", STR0028  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Total de solicitacoes com erro"
	Aadd(aResumo, { "02", STR0029  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Total de solicitacoes pagas   "
	Aadd(aResumo, { "03", STR0030  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Total de solicitacoes nao Proc"
	Aadd(aResumo, { "04", STR0031  , 0, 0, 0 , "@R 99999999999:99" , .f. } ) //"Total horas creditadas        "
	Aadd(aResumo, { "05", STR0032  , 0, 0, 0 , "@R 99999999999:99" , .f. } ) //"Total horas por SG            "
	Aadd(aResumo, { "06", STR0033  , 0, 0, 0 , "@R 99999999999:99" , .f. } ) //"Total horas por reparo        "
	Aadd(aResumo, { "07", STR0034  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Total mao Obra creditada      "
	Aadd(aResumo, { "08", STR0035  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Total pecas creditadas        "
	Aadd(aResumo, { "09", STR0036  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Credito total                 "
	Aadd(aResumo, { "10", STR0037  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Taxa de mao de obra           "
	&& Total Debitos de solic. garantia
	Aadd(aResumo, { "11", STR0038  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Quantidade de solicitacoes    "
	Aadd(aResumo, { "12", STR0039  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"% sobre o credito             "
	Aadd(aResumo, { "13", STR0040  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Debito de mao de obra         "
	Aadd(aResumo, { "14", STR0039  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"% sobre o credito             "
	Aadd(aResumo, { "15", STR0042  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Debito total de pecas         "
	Aadd(aResumo, { "16", STR0039  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"% sobre o credito             "
	Aadd(aResumo, { "17", STR0044  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Debito total                  "
	Aadd(aResumo, { "18", STR0045  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"% debito / credito            " 
	Aadd(aResumo, { "19", STR0046  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Credito - Debito              "
	&& Total credito/debito cupom revisao
	Aadd(aResumo, { "20", STR0047  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Quantidade cupons creditados  "
	Aadd(aResumo, { "21", STR0048  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Quantidade cupons debitados   "
	Aadd(aResumo, { "22", STR0049  , 0, 0, 0 ,    "99999999999999" , .f. } ) //"Quantidade veiculos proprios  "
	Aadd(aResumo, { "23", STR0050  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor total creditado         "
	Aadd(aResumo, { "24", STR0051  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor total debitado          "
	Aadd(aResumo, { "25", STR0052  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor liquido                 "
   && Total valores garantia + revisoes
	Aadd(aResumo, { "26", STR0053  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor total creditado         "
	Aadd(aResumo, { "27", STR0054  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor total debitado          "
	Aadd(aResumo, { "28", STR0052  , 0, 0, 0 , "@E 999,999,999.99" , .f. } ) //"Valor liquido                 "

EndIf
                  
If nDataValid == 1

	If Month(dDataRef) == Month(VGA->VGA_DATFEC) .And. Year(dDataRef) == Year(VGA->VGA_DATFEC)			 && Total do Mes atual
		nColVet := 3
	ElseIf ( Str( Month(VGA->VGA_DATFEC) ,2)+Str( Year(VGA->VGA_DATFEC) ,4) == Str( Month( ((dDataRef)-30) ) ,2)+Str( Year( ((dDataRef)-30) ) ,4) )  && Total do mes anterior
		nColVet := 4
	ElseIf (VGA->VGA_DATFEC >= (dDataRef)-365) .And. (VGA->VGA_DATFEC <= dDataRef)   && Total de 12 meses
		nColVet := 5
	EndIf

Else

	If Month(dDataRef) == Month(VGA->VGA_DATTRA) .And. Year(dDataRef) == Year(VGA->VGA_DATTRA)			 && Total do Mes atual
		nColVet := 3
	ElseIf ( Str( Month(VGA->VGA_DATTRA) ,2)+Str( Year(VGA->VGA_DATTRA) ,4) == Str( Month( ((dDataRef)-30) ) ,2)+Str( Year( ((dDataRef)-30) ) ,4) )  && Total do mes anterior
		nColVet := 4
	ElseIf (VGA->VGA_DATTRA >= (dDataRef)-365) .And. (VGA->VGA_DATTRA <= dDataRef)   && Total de 12 meses
		nColVet := 5
	EndIf

EndIf

If !Empty(nColVet)
     
	If VGA->VGA_ESPGAR # "R" 	&& Garantia
	                 
		If VGA->VGA_SITUAC == "01"
	
			aResumo[Eval(bFound,"01"),nColVet] += 1
	
		ElseIf Empty(VGA->VGA_SITUAC)
	
			aResumo[Eval(bFound,"03"),nColVet] += 1
		                                 
		EndIf
		
		If VGA->VGA_SITUAC $ "02/08"			&& Garantia creditada
	
			If !Empty(VGA->VGA_DATCRE) .Or. !Empty(VGA->VGA_VALCRE)
			
				aResumo[Eval(bFound,"02"),nColVet] += 1
			
				aResumo[Eval(bFound,"04"),nColVet] += VGA->VGA_TEMPAD
			
			Else
			    
				aResumo[Eval(bFound,"05"),nColVet] += VGA->VGA_TEMPAD
			                                 
			EndIf
			
			//aResumo[Eval(bFound,"06"),nColVet] += VGA->VGA_TEMPAD
			
			aResumo[Eval(bFound,"07"),nColVet] += VGA->VGA_VALTPO
			aResumo[Eval(bFound,"08"),nColVet] += VGA->VGA_VALPEC
			
			aResumo[Eval(bFound,"09"),nColVet] := ( aResumo[Eval(bFound,"07"),nColVet] + aResumo[Eval(bFound,"08"),nColVet] )
				
			//aResumo[Eval(bFound,"10"),nColVet] += VGA->VGA_TEMPAD
	
		ElseIf VGA->VGA_SITUAC $ "03"			&& Garantia debitada
		
			aResumo[Eval(bFound,"11"),nColVet] += 1
	
			aResumo[Eval(bFound,"13"),nColVet] += VGA->VGA_VALTPO
	
			aResumo[Eval(bFound,"15"),nColVet] += VGA->VGA_VALPEC
	
			aResumo[Eval(bFound,"17"),nColVet] := ( aResumo[Eval(bFound,"13"),nColVet] + aResumo[Eval(bFound,"15"),nColVet] )
	
		EndIf                   
		
		If VGA->VGA_SITUAC $ "02/03/08"			&& Percentual Garantia creditada / Debitada
		
			aResumo[Eval(bFound,"12"),nColVet] := ( (aResumo[Eval(bFound,"11"),nColVet] * 100) / aResumo[Eval(bFound,"02"),nColVet] )
			aResumo[Eval(bFound,"14"),nColVet] := ( (aResumo[Eval(bFound,"13"),nColVet] * 100) / aResumo[Eval(bFound,"07"),nColVet] )
			aResumo[Eval(bFound,"16"),nColVet] := ( (aResumo[Eval(bFound,"15"),nColVet] * 100) / aResumo[Eval(bFound,"08"),nColVet] )
			aResumo[Eval(bFound,"18"),nColVet] := ( (aResumo[Eval(bFound,"17"),nColVet] * 100) / aResumo[Eval(bFound,"09"),nColVet] )
	
			aResumo[Eval(bFound,"19"),nColVet] := ( aResumo[Eval(bFound,"09"),nColVet] - aResumo[Eval(bFound,"17"),nColVet] )
	
		EndIf
	
	ElseIf VGA->VGA_ESPGAR == "R"	  && Revisao	
	               
		If !Empty(VGA->VGA_DATCRE) .Or. !Empty(VGA->VGA_VALCRE)
		
			aResumo[Eval(bFound,"20"),nColVet] += 1
	                             
			aResumo[Eval(bFound,"23"),nColVet] += VGA->VGA_VALCRE
	
		EndIf
		
		If !Empty(VGA->VGA_DATDEB) .Or. !Empty(VGA->VGA_VALDEB)
	
			aResumo[Eval(bFound,"21"),nColVet] += 1
	
			aResumo[Eval(bFound,"24"),nColVet] += VGA->VGA_VALDEB
	
		EndIf
	
	//	aResumo[Eval(bFound,"22"),nColVet] += 1
	                                      
		aResumo[Eval(bFound,"25"),nColVet] := ( aResumo[Eval(bFound,"23"),nColVet] - aResumo[Eval(bFound,"24"),nColVet] )
	
	EndIf                           
	
	aResumo[Eval(bFound,"26"),nColVet] := ( aResumo[Eval(bFound,"23"),nColVet] + aResumo[Eval(bFound,"09"),nColVet] )
	
	aResumo[Eval(bFound,"27"),nColVet] := ( aResumo[Eval(bFound,"24"),nColVet] + aResumo[Eval(bFound,"17"),nColVet] )
	
	aResumo[Eval(bFound,"28"),nColVet] := ( aResumo[Eval(bFound,"26"),nColVet] - aResumo[Eval(bFound,"27"),nColVet] )
	       
	&& Soma total por status    
	If Eval(bFound,VGA->VGA_ESPGAR+VGA->VGA_SITUAC) == 0
		Aadd( aResumo , { VGA->VGA_ESPGAR+VGA->VGA_SITUAC, VGA->VGA_SITUAC+" "+Substr(VGA->VGA_DESSIT,1,27)  , 0, 0, 0 ,    "@E 999,999,999.99" , .t. } )
	EndIf
	
	If Empty(VGA->VGA_SITUAC)
		aResumo[Eval(bFound,VGA->VGA_ESPGAR+VGA->VGA_SITUAC),2] :=	 Space(3)+left(STR0056+Space(28),28)  //"NAO PROCESSADO" 
	EndIf
	
	aResumo[Eval(bFound,VGA->VGA_ESPGAR+VGA->VGA_SITUAC),nColVet] += ( VGA->VGA_VALTPO + VGA->VGA_VALPEC )

EndIf

Return(aResumo)                    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFS_IMPRES บAutor  ณFabio               บ Data ณ  12/18/03   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Imprime resumo                                             บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP6                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                           
User Function FS_IMPRES(aResumo,dDataRef)

Local nContRes := 0

nLin := 0
Cabec1:=Cabec2:=Cabec3:=NIL

@ FS_QUEBPAG() , 34 PSay   Space(28-Len(FG_CMONTH(dDataRef)))             +Substr(FG_CMONTH(dDataRef),1,10)       +"/"+Str(Year(dDataRef),4) ;
						  		   + Space(29-Len(FG_CMONTH(dDataRef-30)))         +Substr(FG_CMONTH((dDataRef-30)),1,10) +"/"+Str(Year((dDataRef-30)),4) ;
						   		+ Space(18-( Len(FG_CMONTH(dDataRef-365)) *2) )+Substr(FG_CMONTH((dDataRef-365)),1,10)+"/"+Str(Year((dDataRef-365)),4) + STR0009 + Substr(FG_CMONTH(dDataRef),1,10)+"/"+Str(Year(dDataRef),4) //" a "
		
For nContRes := 1 to Len(aResumo)

   If StrZero(nContRes,2) $ "01/11/20/26/29"

		@ FS_QUEBPAG() , 0 PSay " "
				
	   If StrZero(nContRes,2) $ "01"
			@ FS_QUEBPAG() , 01 PSay STR0058 //"CREDITOS DE SOLIC. GARANTIA    *"
	   ElseIf StrZero(nContRes,2) $ "11"
			@ FS_QUEBPAG() , 01 PSay STR0059 //"DEBITO DE SOLIC. GARANTIA      *"
	   ElseIf StrZero(nContRes,2) $ "20"
			@ FS_QUEBPAG() , 01 PSay STR0060 //"CREDITOS/DEBITOS CUPOM REVISAO *"
		ElseIf StrZero(nContRes,2) $ "26"
			@ FS_QUEBPAG() , 01 PSay STR0061 //"VALORES DE GARANTIA + REVISAO  *"
		Else
			@ FS_QUEBPAG() , 01 PSay STR0062 //"VALORES DOS STATUS             *"
   	EndIf                                                     
                               
       	@ PRow() , PCol()+1 PSay Space(17)+ "  "+ LEFT(STR0057+Space(31),31)+"  "+  LEFT(STR0055+Space(20),20) + " " +STR0043

		
		@ FS_QUEBPAG() , 32 PSay "*"+Space(12)+STR0041+Space(14)+"US$"+Space(15)+STR0041+Space(14)+"US$"+Space(15)+STR0041+Space(14)+"US$"
	   
   EndIf
    
	@ FS_QUEBPAG() , 0 PSay aResumo[nContRes,2] + "  *" + Transform(aResumo[nContRes,3],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(FG_CalcMF( {{dDataRef , aResumo[nContRes,3]}} ), aResumo[nContRes,6]) , Space(14)) ;
																+ "  *" + Transform(aResumo[nContRes,4],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(FG_CalcMF( {{dDataRef , aResumo[nContRes,4]}} ), aResumo[nContRes,6]) , Space(14)) ;
																+ "  *" + Transform(aResumo[nContRes,3]+aResumo[nContRes,4]+aResumo[nContRes,5],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(FG_CalcMF( {{dDataRef , aResumo[nContRes,3]+aResumo[nContRes,4]+aResumo[nContRes,5]}} ) , aResumo[nContRes,6]) , Space(14))

/*	@ FS_QUEBPAG() , 0 PSay aResumo[nContRes,2] + "  *" + Transform(aResumo[nContRes,3],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(xMoeda( aResumo[nContRes,3] ,,, dDataRef ), aResumo[nContRes,6]) , Space(14)) ;
																+ "  *" + Transform(aResumo[nContRes,4],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(xMoeda( aResumo[nContRes,4] ,,, dDataRef ), aResumo[nContRes,6]) , Space(14)) ;
																+ "  *" + Transform(aResumo[nContRes,3]+aResumo[nContRes,4]+aResumo[nContRes,5],aResumo[nContRes,6]) + "  *" + If(aResumo[nContRes,7], Transform(xMoeda( aResumo[nContRes,3]+aResumo[nContRes,4]+aResumo[nContRes,5] ,,, dDataRef ), aResumo[nContRes,6]) , Space(14))
*/

Next                    
                    
Return
