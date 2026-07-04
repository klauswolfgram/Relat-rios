/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 20     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#Include "OFIOR600.ch"
#include "TopConn.ch"
#Include "protheus.ch"
#include "Totvs.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFIOR600 ³ Autor ³ Emilton/Fabio         ³ Data ³ 21/11/00 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Relatorio de Agendamentos                                  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIOR600

Local cDesc1      := STR0001 //Impressao do agendamento
Local cDesc2      := ""
Local cDesc3      := ""
Local cAlias      := "VSO"
Local aRegistros	:= {}
Private nLin      := 0
Private m_Pag     := 1
Private aPag      := 1
Private nIte      := 1
Private aReturn   := { STR0002, 1,STR0003, 2, 2, 1, "",1 } //"Zebrado"###"Administracao"
Private cTamanho  := "G"           		// P/M/G
Private Limite    := 220           		// 80/132/220
Private aOrdem    := {}           		// Ordem do Relatorio
Private cTitulo   := STR0008    //Relacao de Agendamentos
Private cNomeRel  := "OFIOR600"
Private nLastKey  := 0
Private cPerg	    := "OFR600"      
Private cFiltroVX5:= "048"

DbSelectArea("VSO")

cNomeRel := SetPrint(cAlias,cNomeRel,cPerg,@cTitulo,cDesc1,cDesc2,cDesc3,.f.,,,cTamanho)

If nLastKey == 27

   Return

Endif       

PERGUNTE("OFR600",.F.) 

SetDefault(aReturn,cAlias)

RptStatus( { |lEnd| U_ImpOR600(@lEnd,cNomeRel,cAlias) } , cTitulo )

If aReturn[5] == 1
	OurSpool( cNomeRel )
EndIf

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_IMPR600ºAutor  ³Fabio               º Data ³  06/13/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Impressao                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function ImpOR600(lEnd,cNomeRel,cAlias)

Local cObs        := ""
Local nPos        := 0
Local cFunAge     := ""
Local cGestor     := ""
Local cNumOrc     := space(8)
Local cNumOsv     := space(8)  
Local cCodRec     := "" // Silvania - 22/07/2019 0 - nao se sbae pra que serve - como está com problema no tamanho do Cabecalho, será tirado - space(8)
Local cDurac      := "00:00"
Local cOSStat     := Space(9)
Local dDatCheg    := ctod("  /  /  ")
Local dDatAbe     := ctod("  /  /  ")
Local cRegAtu     := SM0->M0_CODIGO + SM0->M0_CODFIL
Local nStat1      := 0
Local nStat2      := 0
Local nStat3      := 0
Local nStat4      := 0
Local nStat5      := 0
Local lVSO_TIPAGE := VSO->(FieldPos("VSO_TIPAGE")) <> 0

// MV_PAR01 - Data inicial
// MV_PAR02 - Hora inicial
// MV_PAR03 - Data final
// MV_PAR04 - Hora final
// MV_PAR05 - Box
// MV_PAR06 - Status
// MV_PAR07 - Chv Veiculo
// MV_PAR08 - Proprietario do veiculo
// MV_PAR09 - Loja
// MV_PAR10 - Nome do proprietario
// MV_PAR11 - Funcionario do agendamento
// MV_PAR12 - Numero de identificacao
// MV_PAR13 - Consultor
// MV_PAR14 - Tipo de Manutenção  
// MV_PAR15 - Opção de Visualização    
// MV_PAR16 - Listar Reclamação      
// MV_PAR17 - Lista Veiculo          
// MV_PAR18 - Tipo de Agendamento (1=Ativo , 2=Reativo, 3=Todos)

dbselectarea("VX5")
VX5->(dbSetOrder(1))
SA1->(dbSetOrder(1))
VAI->(DbSetOrder(1))
SA3->(DbSetOrder(1))
VAM->(DbSetOrder(1))
VST->(DbSetOrder(1))
VSK->(DbSetOrder(1))
VSL->(DbSetOrder(1))
SYP->(DbSetOrder(1))
VO1->(DbSetOrder(1))

dbselectarea("VSO")			

If Select("TMPVSO") > 0
	TMPVSO->(DbCloseArea())
EndIf	

cQuery := " Select VSO.VSO_PROVEI, VSO.VSO_LOJPRO, VSO.VSO_DATAGE, VSO.VSO_HORAGE, VSO.VSO_STATUS, VSO.VSO_NUMBOX, VSO.VSO_PLAVEI, VSO.VSO_GETKEY, "
cQuery += " 	    VSO.VSO_FUNAGE, VSO.VSO_GESTOR, VSO.VSO_NUMIDE, VSO.VSO_OBSMEM, VSO.VSO_CODMAR, VSO.VSO_KILOME, VSO.VSO_TPMANU, VSO.VSO_RESPAG, "
cQuery += " 	    VSO.VSO_TELCT1, VSO.VSO_TELCT2, VSO.VSO_NOMPRO, VSO.VSO_ENDPRO, VSO.VSO_CIDPRO, VSO.VSO_ESTPRO, VSO.VSO_FONPRO, "
If lVSO_TIPAGE
	cQuery += " VSO.VSO_TIPAGE,"
Endif
cQuery += "        VE1.VE1_DESMAR, VV2.VV2_DESMOD, VON.VON_CODPRO "
cQuery += " From "+ RetSqlName("VSO")+" VSO "
cQuery += " Left Join " +RetSqlName("VON")+ " VON On ( VON.VON_Filial = '"+xFilial("VON")+"' And VON.VON_NUMBOX = VSO.VSO_NUMBOX And VON.D_E_L_E_T_= ' ' ) "
cQuery += " Left Join " +RetSqlName("VV2")+ " VV2 On ( VV2.VV2_Filial = '"+xFilial("VV2")+"' And VV2.VV2_CODMAR = VSO.VSO_CODMAR And VV2.VV2_MODVEI = VSO.VSO_MODVEI And VV2.D_E_L_E_T_= ' ' ) "
cQuery += " Left Join " +RetSqlName("VE1")+ " VE1 On ( VE1.VE1_Filial = '"+xFilial("VE1")+"' And VE1.VE1_CODMAR = VSO.VSO_CODMAR And VE1.D_E_L_E_T_= ' ' ) "
cQuery += " Left Join " +RetSqlName("SA1")+ " SA1 On ( SA1.A1_Filial  = '"+xFilial("SA1")+"' And SA1.A1_COD = VSO.VSO_PROVEI And SA1.A1_LOJA = VSO.VSO_LOJPRO And SA1.D_E_L_E_T_= ' ' ) "
cQuery += " Left Join " +RetSqlName("VAM")+ " VAM On ( VAM.VAM_Filial = '"+xFilial("VAM")+"' And VAM.VAM_IBGE = SA1.A1_IBGE And VAM.D_E_L_E_T_= ' ' ) "
cQuery += " Where VSO.D_E_L_E_T_= ' ' "
cQuery += "       AND VSO.VSO_FILIAL = '"+xFilial("VSO")+"' "
cQuery += "       AND VSO.VSO_DATAGE >= '"+Dtos(MV_PAR01)+"' "
cQuery += "       AND VSO.VSO_DATAGE <= '"+Dtos(MV_PAR03)+"' "

if !empty(MV_PAR02)
	cQuery += "       AND VSO.VSO_HORAGE >= '"+MV_PAR02+"' "
endif
	
if !empty(MV_PAR04)
	cQuery += "       AND VSO.VSO_HORAGE <= '"+MV_PAR04+"' "
endif

if !empty(MV_PAR05)
	cQuery += "       AND VSO.VSO_NUMBOX = '"+MV_PAR05+"' "
endif

if Str(MV_PAR06,1) <> "5" .and. !empty(MV_PAR06)
	cQuery += "       AND VSO.VSO_STATUS = '"+str(MV_PAR06,1)+"' "
endif

if !empty(MV_PAR07)
	cQuery += "       AND VSO.VSO_GETKEY = '"+MV_PAR07+"' "
endif

if !empty(MV_PAR08) .and. !empty(MV_PAR09)
	cQuery += "       AND VSO.VSO_PROVEI = '"+MV_PAR08+"' AND VSO.VSO_LOJPRO = '"+MV_PAR09+"'      "
endif

if !empty(MV_PAR10)
	cQuery += "       AND VSO.VSO_NOMPRO = '"+MV_PAR10+"' "
endif

if !empty(MV_PAR11)
	cQuery += "       AND VSO.VSO_FUNAGE = '"+MV_PAR11+"' "
endif

if !empty(MV_PAR12)
	cQuery += "       AND VSO.VSO_NUMIDE = '"+MV_PAR12+"' "
endif

if !empty(MV_PAR13)
	cQuery += "       AND VSO.VSO_GESTOR = '"+MV_PAR13+"' "
endif

if !empty(MV_PAR14)
	cQuery += "       AND VSO.VSO_TPMANU = '"+MV_PAR14+"' "
endif

if MV_PAR17 = 1 //REGIAO    
	cQuery += "       AND VAM.VAM_REGATU = '"+cRegAtu+"' "
elseif MV_PAR17 = 2 //FORA REGIAO
	cQuery += "       AND (VAM.VAM_REGATU = '    ' or VAM.VAM_REGATU <> '"+cRegAtu+"') "
endif

If lVSO_TIPAGE .and. !Empty(MV_PAR18) .and. MV_PAR18 <> 3
	cQuery += " AND VSO.VSO_TIPAGE = '"+ strzero(MV_PAR18,1) + "'"
Endif

cQuery += " Group by VSO.VSO_PROVEI, VSO.VSO_LOJPRO, VSO.VSO_DATAGE, VSO.VSO_HORAGE, VSO.VSO_STATUS, VSO.VSO_NUMBOX, VSO.VSO_PLAVEI, VSO.VSO_GETKEY, "
cQuery += " 	      VSO.VSO_FUNAGE, VSO.VSO_GESTOR, VSO.VSO_NUMIDE, VSO.VSO_OBSMEM, VSO.VSO_CODMAR, VSO.VSO_KILOME, VSO.VSO_TPMANU, VSO.VSO_RESPAG, "
cQuery += " 	      VSO.VSO_TELCT1, VSO.VSO_TELCT2, VSO.VSO_NOMPRO, VSO.VSO_ENDPRO, VSO.VSO_CIDPRO, VSO.VSO_ESTPRO, VSO.VSO_FONPRO, "
If lVSO_TIPAGE
	cQuery += " VSO.VSO_TIPAGE,"
Endif
cQuery += "          VE1.VE1_DESMAR, VV2.VV2_DESMOD, VON.VON_CODPRO "

if MV_PAR15 = 1 .or. MV_PAR15 = 3
	cQuery += " Order by  VSO.VSO_DATAGE, VSO.VSO_HORAGE, VSO.VSO_GETKEY"
elseif MV_PAR15 = 2
	cQuery += " Order by  VSO.VSO_DATAGE, VSO.VSO_GESTOR, VSO.VSO_HORAGE"
endif	

TCQUERY cQuery NEW ALIAS "TMPVSO"

cQuebra  := ctod("  /  /  ") //"INICIO"
cQuebra1 := ""
cQuebra2 := ""
lSA1    := .F.

@ FS_CABR600() , 00 psay  "" //Imprime o cabecalho - Rafael 13/02 - sexta feira!

TMPVSO->( DbGoTop() )                 
While !TMPVSO->( Eof() ) 

	lSA1    := .F.
	if SA1->(dbSeek(xFilial("SA1")+TMPVSO->(VSO_PROVEI) + TMPVSO->(VSO_LOJPRO) ))
      lSA1 := .T.
   endif
   
   if MV_PAR17 = 1 //região
	   if lSA1
   	   VAM->()
	   endif
   
   elseif MV_PAR17 = 2  //fora região
   
   endif
      
	if TMPVSO->(VSO_STATUS) == "1"
		cStatus := STR0012    //Agendado
		nStat1 ++ 
	Elseif TMPVSO->(VSO_STATUS) == "2"
		cStatus := STR0013    //OS Aberta
		nStat2 ++ 
	Elseif TMPVSO->(VSO_STATUS) == "3"
		cStatus := STR0014    //Finalizado
		nStat2 ++ 
	Elseif TMPVSO->(VSO_STATUS) == "4"
		cStatus := STR0015    //Cancelado
		nStat4 ++ 
	Else
		cStatus := STR0016    //Orcto Aberto
		nStat5 ++ 
	Endif
			
	VAI->(DbSeek(xFilial("VAI")+TMPVSO->(VON_CODPRO)))//mecanico
	SA3->(DbSeek(xFilial("SA3")+VAI->VAI_CODVEN))
   cMec := SA3->A3_NREDUZ

	VAI->(DbSeek(xFilial("VAI")+TMPVSO->(VSO_FUNAGE) ))
	SA3->(DbSeek(xFilial("SA3")+VAI->VAI_CODVEN))	
	cFunAge := SA3->A3_NREDUZ
				

	VAI->(DbSeek(xFilial("VAI")+TMPVSO->(VSO_GESTOR) ))
	SA3->(DbSeek(xFilial("SA3")+VAI->VAI_CODVEN))			
	cGestor := SA3->A3_NREDUZ
 
	cTipAge := STR0022 // "Todos"
	If lVSO_TIPAGE
		If TMPVSO->(VSO_TIPAGE) == '1'
			cTipAge := STR0020 //"Ativo"
		ElseIf TMPVSO->(VSO_TIPAGE) == '2'
			cTipAge := STR0021 //"Reativo"
		Endif
	Endif

	VX5->(dbseek(xFilial("VX5")+"048"+TMPVSO->(VSO_TPMANU) ))		   
  
	If mv_par15 = 1 //por box      

		If cQuebra <> Stod(TMPVSO->(VSO_DATAGE))
			nLin++
			@ FS_CABR600() , 00 psay STR0018 + Dtoc(Stod(TMPVSO->(VSO_DATAGE)))
			nLin++
		Endif

		If cQuebra1 <> TMPVSO->(VSO_NUMBOX)
			nLin++		
			@ FS_CABR600() , 00 psay space(5) + STR0041 + TMPVSO->(VSO_NUMBOX) // "Box: "
			nLin++
		Endif                                                                              
		
		cPlaca := ""
		If empty(TMPVSO->(VSO_PLAVEI))
			If len(alltrim(TMPVSO->(VSO_GETKEY))) <= 10
				cPlaca := left(alltrim(TMPVSO->(VSO_GETKEY))+space(10),10)
			Else	
				cPlaca := right(alltrim(TMPVSO->(VSO_GETKEY)),10)
			Endif
		Else
			cPlaca := TMPVSO->(VSO_PLAVEI)
		Endif

		@ FS_CABR600() , 00 psay space(8) + Transform(TMPVSO->(VSO_HORAGE),"@R 99:99")+" "+cPlaca+" "+;
										Substr(TMPVSO->(VE1_DESMAR),1,9)+" "+ Substr(TMPVSO->(VV2_DESMOD),1,20)+" "+left(TMPVSO->(VSO_PROVEI)+space(6),6)+" "+;
										left(TMPVSO->(VSO_LOJPRO)+space(2),2)+" "+ if( lSA1,left(SA1->A1_NOME+space(30),30),TMPVSO->(VSO_NOMPRO)+space(10) )+"  "+;
										Left(VX5->VX5_DESCRI,25)+" "+TMPVSO->(VON_CODPRO) + "-" +cMec+"  "+TMPVSO->(VSO_GESTOR)+"-"+cGestor+"  "+cDurac+" "+cCodRec+"  "+cTipAge
	
		cQuebra  := Stod(TMPVSO->(VSO_DATAGE))
		cQuebra1 := TMPVSO->(VSO_NUMBOX)

	Elseif mv_par15 = 2 //por consultor   

		if cQuebra <> Stod(TMPVSO->(VSO_DATAGE))
			nLin++
			@ FS_CABR600() , 00 psay STR0018 + Dtoc(Stod(TMPVSO->(VSO_DATAGE)))
			nLin++
		Endif

		if cQuebra1 <> TMPVSO->(VSO_GESTOR)
			nLin++		
			@ FS_CABR600() , 00 psay space(5) + STR0033 + TMPVSO->(VSO_GESTOR) + "-" + cGestor // "Consultor: "
			nLin++
		Endif

		cPlaca := ""
		if empty(TMPVSO->(VSO_PLAVEI))
			if len(alltrim(TMPVSO->(VSO_GETKEY))) <= 10
				cPlaca := left(alltrim(TMPVSO->(VSO_GETKEY))+space(10),10)
			else	
				cPlaca := right(alltrim(TMPVSO->(VSO_GETKEY)),10)
			endif
  		else
				cPlaca := TMPVSO->(VSO_PLAVEI)         
		endif   

		@ FS_CABR600() , 00 psay space(8) + Transform(TMPVSO->(VSO_HORAGE),"@R 99:99")+" "+cPlaca+" "+;
										Substr(TMPVSO->(VE1_DESMAR),1,9)+" "+ Substr(TMPVSO->(VV2_DESMOD),1,20)+" "+left(TMPVSO->(VSO_PROVEI)+space(6),6)+" "+;
										left(TMPVSO->(VSO_LOJPRO)+space(2),2)+" "+ if( lSA1,left(SA1->A1_NOME+space(30),30),TMPVSO->(VSO_NOMPRO)+space(10) )+"  "+;
										Left(VX5->VX5_DESCRI,40)+" "+TMPVSO->(VON_CODPRO) + "-" +cMec+"  "+left(TMPVSO->(VSO_NUMBOX)+space(3),3)+" "+cDurac+" "+cCodRec+"  "+cTipAge
	
		cQuebra  := Stod(TMPVSO->(VSO_DATAGE))
		cQuebra1 := TMPVSO->(VSO_GESTOR)

	Elseif mv_par15 = 3 //Relação de Agendamento

		If cQuebra <> Stod(TMPVSO->(VSO_DATAGE))
			@ FS_CABR600() , 00 psay STR0018 + Dtoc(Stod(TMPVSO->(VSO_DATAGE)))
			nLin++
		Endif

		cOSStat := Space(9)
		dDatAbe := ctod("  /  /  ")

		If Select("TMPVS1") > 0
			TMPVS1->(DbCloseArea())     
		EndIf	

		cQuery := "SELECT VS1.VS1_NUMORC, VS1.VS1_NUMOSV "
		cQuery += " FROM "+RetSqlName("VS1")+" VS1 "
		cQuery += " WHERE "
		cQuery += "   VS1.VS1_FILIAL = '"+xFilial("VS1")+"' AND VS1.VS1_NUMAGE = '"+TMPVSO->VSO_NUMIDE+"' AND "
		cQuery += "   VS1.D_E_L_E_T_ = ' '"     
	
		TCQuery cQuery New Alias "TMPVS1"
		
		cNumOrc  := TMPVS1->VS1_NUMORC                   
		cNumOsv  := TMPVS1->VS1_NUMOSV
	      
		If empty(cNumOsv)

			If Select("TMPVO1") > 0
				TMPVO1->(DbCloseArea())     
			EndIf	

			cQuery := "SELECT VO1.VO1_NUMOSV "
			cQuery += " FROM "+RetSqlName("VO1")+" VO1 "
			cQuery += " WHERE "
			cQuery += "   VO1.VO1_FILIAL = '"+xFilial("VO1")+"' AND VO1.VO1_NUMAGE = '"+TMPVSO->VSO_NUMIDE+"' AND "
			cQuery += "   VO1.D_E_L_E_T_ = ' '"     
		
			TCQuery cQuery New Alias "TMPVO1"

			cNumOsv  := TMPVO1->VO1_NUMOSV	      
   
		Endif

		VO1->(dbseek(xFilial("VO1")+cNumOsv))
		dDatAbe := VO1->VO1_DATABE
		If VO1->VO1_STATUS = "A"
			cOSStat := Padr(STR0037,9) // "ABERTA   "
		Elseif VO1->VO1_STATUS = "L"
			cOSStat := Padr(STR0038,9) // "LIBERADA "
		Elseif VO1->VO1_STATUS = "F"         
			cOSStat := Padr(STR0039,9) // "FECHADA  "
		Elseif VO1->VO1_STATUS = "C"                  
			cOSStat := Padr(STR0040,9) // "CANCELADA"         
		Endif
         
		dDatCheg  := ctod("  /  /  ")
		If !empty(cNumOsv)
			If Select("TMPVZW") > 0
				TMPVZW->(DbCloseArea())     
			EndIf	

			cQuery := "SELECT VZW.VZW_CODIGO, VZY.VZY_CODVZW, VZY.VZY_DATREG "
			cQuery += " FROM "+RetSqlName("VZW")+" VZW "
			cQuery += " Left  Join " + RetSqlName("VZY") + " VZY ON ( VZY.VZY_FILIAL = '"+xfilial('VZY')+"' And VZY.VZY_CODVZW = VZW.VZW_CODIGO AND VZY.d_e_l_e_t_ = '  '   ) "	
			cQuery += " WHERE "
			cQuery += "   VZW.VZW_FILIAL = '"+xFilial("VZW")+"' AND VZW.VZW_NUMOSV = '"+cNumOsv+"' AND VZY.VZY_ORIGEM = '008' AND VZW.D_E_L_E_T_ = ' '"
			TCQuery cQuery New Alias "TMPVZW

			dDatCheg := stod(TMPVZW->VZY_DATREG)
		Endif
		
		@ FS_CABR600() , 00 psay space(5)+Transform(TMPVSO->(VSO_HORAGE),"@R 99:99")+" "+left(TMPVSO->(VSO_NUMBOX)+space(3),3)+" "+Left(cStatus+space(16),16)+" "+left(TMPVSO->(VSO_GETKEY)+space(25),25)+" "+TMPVSO->(VSO_PLAVEI)+" "+Substr(TMPVSO->(VE1_DESMAR),1,9)+" "+Substr(TMPVSO->(VV2_DESMOD),1,20)+" "+TMPVSO->(VSO_NUMIDE)+" "+Left(VX5->VX5_DESCRI,25)+" "+transform(TMPVSO->(VSO_KILOME),"@E 99999999")+" "+cNumOrc+"  "+"N/A    "+" "+dtoc(dDatCheg)+" "+cNumOsv+" "+dtoc(dDatAbe)+"  "+cOSStat+" "+cCodRec+" "+cTipAge
	
		@ FS_CABR600() , 00 psay space(5)+STR0032+" "+TMPVSO->(VSO_FUNAGE)+" "+cFunAge + space(5) + STR0033 + TMPVSO->(VSO_GESTOR) + " " + cGestor + space(5)+ STR0034 + " " + TMPVSO->(VON_CODPRO) + " " +cMec // "Resp. Agendamento:"   "Consultor:"   "Mecânico:"

		@ FS_CABR600() , 00 psay space(5)+left(TMPVSO->(VSO_PROVEI)+space(6),6)+" "+left(TMPVSO->(VSO_LOJPRO)+space(2),2)+" "+;
										 		    if( lSA1,left(SA1->A1_NOME+space(30),30),TMPVSO->(VSO_NOMPRO)+space(10) )+" "+;
  										 		    if( lSA1,left(SA1->A1_END+space(20),20),left(TMPVSO->(VSO_ENDPRO),20) )+" "+;
										 		    if( lSA1,left(SA1->A1_MUN+space(20),20),TMPVSO->(VSO_CIDPRO) )+" "+;
										 		    if( lSA1,left(SA1->A1_EST+space(2),2),TMPVSO->(VSO_ESTPRO) )+" "+;
										 		    if( lSA1,"("+SA1->A1_DDD+")"+left(transform(SA1->A1_TEL,"@R 9999-9999"),15),left(transform(TMPVSO->(VSO_FONPRO),"@R 9999-9999"),15) )+" "+;
										 		    STR0035 + TMPVSO->(VSO_RESPAG)+" "+left(transform(TMPVSO->(VSO_TELCT1),"@R 9999-9999"),15)+" "+left(transform(TMPVSO->(VSO_TELCT2),"@R 9999-9999"),15)  // "Contato: "
				
		if MV_PAR16 = 1

			If SYP->(DbSeek( xFilial("SYP") + TMPVSO->(VSO_OBSMEM) ))
				cObs := ""
				@ FS_CABR600() , 05 psay STR0036 // "Reclamação:" 
				While !SYP->(eof()) .and. TMPVSO->(VSO_OBSMEM) == SYP->YP_CHAVE
					nPos := AT("\13\10",SYP->YP_TEXTO)
					if nPos > 0
						nPos -= 1
					Else
						nPos := Len(SYP->YP_TEXTO)
					Endif
					cObs := alltrim(Substr(SYP->YP_TEXTO,1,nPos))
					If !Empty(cObs)
						@ FS_CABR600() , 09 psay "- " + cObs
					EndIf
					SYP->(DbSkip())
				Enddo
			EndIf
			
		Endif
      
		If VST->(DbSeek( xFilial("VST") + "3" + TMPVSO->(VSO_NUMIDE) ))
	
			@ FS_CABR600() , 00 psay space(5) + STR0004 // "Grupo  Descricao----------------- Codigo-- ------ Descricao------------------ "'
				
			Do While !Eof() .And. VST->VST_FILIAL+VST->VST_CODIGO == xFilial("VSO") + TMPVSO->(VSO_NUMIDE)
					
				VSK->(DbSeek( xFilial("VSK") + TMPVSO->(VSO_CODMAR) + VST->VST_GRUINC ))
				VSL->(DbSeek( xFilial("VSL") + TMPVSO->(VSO_CODMAR) + VST->VST_GRUINC + VST->VST_CODINC ))
	
				@ FS_CABR600() , 00 psay space(5) + Transform(VST->VST_GRUINC,Repl("!",Len(VSP->VSP_CODGRU))) +"    "+left(VSK->VSK_DESGRU+space(26),26)+" "+VST->VST_CODINC+" "+Substr(VSL->VSL_DESINC,1,27)
				DbSelectArea("VST")
				DbSkip()
	
			EndDo	
	
		EndIf

		@ FS_CABR600() , 00 psay  ""
		
		cQuebra := Stod(TMPVSO->(VSO_DATAGE))

	endif
	
   TMPVSO->( DbSkip() )            

enddo


nLin:= nLin+3
@ FS_CABR600() , 00 psay space(20) + STR0030 // "Status dos Agendamentos"
@ FS_CABR600() , 00 psay space(35) + STR0012 + "........: " + transform(nStat1,"@E 999999") // "Agendado"
@ FS_CABR600() , 00 psay space(35) + STR0013 + ".......: "  + transform(nStat2,"@E 999999") // "OS Aberta"
@ FS_CABR600() , 00 psay space(35) + STR0014 + "......: "   + transform(nStat3,"@E 999999") // "Finalizado"
@ FS_CABR600() , 00 psay space(35) + STR0015 + ".......: "  + transform(nStat4,"@E 999999") // "Cancelado"
@ FS_CABR600() , 00 psay space(35) + STR0016 + ": "         + transform(nStat5,"@E 999999") // "Orçamento Aberto"

If Select("TMPVSO") > 0
	TMPVSO->(DbCloseArea())     
EndIf	

Eject

Set Printer to
Set Device  to Screen

MS_Flush()

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±±ºPrograma  ³FS_CABR600ºAutor  ³Fabio               º Data ³  06/13/01   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºDesc.     ³Cabecalho                                                   º±±
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±±ºUso       ³ Oficina                                                    º±±
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function FS_CABR600()

//Private cTitulo , cabec1 , cabec2 , nomeprog , tamanho , nCaracter
Private cbTxt,cbCont,cString,Li,wnRel,cTitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter

cbTxt    := Space(10)
cbCont   := 0
cString  := "TRA"
Li       := 80
wnRel    := "OFIOR600"

//cTitulo:= STR0005 //Relatorio de agendamento
if MV_PAR15 = 1
	cTitulo:= STR0023 // " Agenda por Box"
	cabec1 := STR0042 //"        Hora  Placa      Marca     Modelo               Cliente                                   Serviço                    Mecânico                         Consultor                        Duração  Tipo Agendto"
	cabec2 := ""
elseif MV_PAR15 = 2
	cTitulo:= STR0025 // " Agenda por Consultor"
	cabec1 := STR0043 // "        Hora  Placa      Marca     Modelo               Cliente                                   Serviço                                  Mecânico                         Box Duração  Tipo Agendto"
	cabec2 := ""
elseif MV_PAR15 = 3
	cTitulo:= STR0027 // "Relação de Agendamento"
	cabec1 := STR0044 // "     Hora  Box Satus            Chv Veículo               Placa.     Marca     Modelo               N.Ident. Serviço                   KM Revis Orçamento Duração Dt.Chegada Ord.Srv. Dt.Abertura Status     Tipo Agendto"
	cabec2 := STR0029 // "     Cliente                                  Endereco             Cidade               UF Telefone"
endif


nomeprog	:="OFIOR600"
tamanho	:="G"
nCaracter:=15
                                     
If nLin == 0 .Or. nLin >= 63
	nLin := cabec(ctitulo,cabec1,cabec2,nomeprog,tamanho,nCaracter) + 2   
Else
	nLin++
EndIf

Return( nLin )

/////////////////////////
User Function Ofr600vhor(nPar)
////////////////////////
Local lRet := .t.
if nPar == 1
	IF val(Substr(MV_PAR02,1,2))>23 .OR. val(Substr(MV_PAR02,3,2))>60 .OR. val(Substr(MV_PAR02,1,2))<0 .OR. val(Substr(MV_PAR02,3,2))<0
		MsgAlert(STR0009,STR0010)   //Hora Inicial InvalidA ### Atencao
		lRet := .f.
	endif  
else
	IF val(Substr(MV_PAR04,1,2))>23 .OR. val(Substr(MV_PAR04,3,2))>60 .OR. val(Substr(MV_PAR04,1,2))<0 .OR. val(Substr(MV_PAR04,3,2))<0
		MsgAlert(STR0011,STR0010)    //Hora Final Invalida ### Atencao
		lRet := .f.
	Endif
endif  
Return(lRet)

