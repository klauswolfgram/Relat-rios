/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "TOTVS.CH"
#INCLUDE "QDOR200.CH"
#INCLUDE "FONT.CH"
#INCLUDE "COLORS.CH"


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDOR200  ³ Autor ³ Newton R. Ghiraldelli           ³ Data ³ 08/09/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Reemissao de Documentos           				                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QDOR200()                                    			            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ Generico                                                   			³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³         		ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.       		³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Programador ³ Data   ³ BOPS ³  Motivo da Alteracao                     			³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Eduardo S.  ³03/01/02³ **** ³ Acerto no filtro do usuario destino.               ³±±
±±³Eduardo S.  ³01/04/02³ META ³ Alterado para utilizar o novo conceito de arquivos ³±±
±±³            ³        ³      ³ de Usuarios\Centros de Custo da programacao Quality³±±
±±³Eduardo S.  ³02/08/02³016480³ Incluido a opcao de pesquisa Documentos/Usuarios/  ³±±
±±³            ³        ³      ³ Pastas/Departamentos conforme a Folder selcionada. ³±±
±±³Eduardo S.  ³06/09/02³ **** ³ Acertado para filtar Documentos por filial         ³±±
±±³Eduardo S.  ³12/12/02³061382³ Incluido o ponto de entrada "QDR200FIL".           ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDOR200()

Local oQDC, oQDG1, oQAD, oQDJ2, oQD1
Local oDlgFolder
Local oFnt

Local aUsrMat  := QA_USUARIO()



Local ni       := 0
Local nAtu     := 0
Local aQD1List := {}
Local aQDGList := {}
Local aQDJ2List:= {}


Local aObjects 	:= {}
Local aSize	 	:= {}
Local aInfo	 	:= {}
Local aPosObj	:= {}
Local cFiltroQd1:= ""
Local cFiltroQdh:= ""
Local cFiltroQdg:= ""
Local cFiltroQaa:= ""
Local aButtons  := {}
Private oQDH
Private oQDJ
Private oQDG
Private oWord
Private oDlg
Private oGet
Private oEmissao
Private oBtnPesq
Private oSayM
Private aQDG     := {}
Private aQDJ     := {}
Private aQDH     := {}
Private aQD1     := {}
Private aQDG1    := {}
Private aQDJ1    := {}
Private aQDJ2    := {}
Private cMotivo  := Space( 100 )
Private lChProto := .f.
Private lChCopia := .f.
Private nOpca    := 0
Private nItem    := 2
Private cCadastro:= ""
Private cTpCod   := Space( 06 )
Private cCodAss  := Space( 06 )
Private cTpDes   := Space( 50 )
Private cDesAss  := Space( 30 )
Private bCampo   := { |nCPO| Field( nCPO ) }
Private hOK      := LoadBitmap( GetResources(), "LBTIK" )
Private hNo      := LoadBitmap( GetResources(), "LBNO" )
Private lApelido := aUsrMat[1]
Private cMatFil  := aUsrMat[2]
Private cMatCod  := aUsrMat[3]
Private cMatDep  := aUsrMat[4]
Private cCpo     := GetMV( "MV_QDOCPO" )
Private nTpImpr  := 2 // "Tipo Impressao - Documento"
Private cIndex1  := ""
Private lPastatus := .T.

Inclui := .f.

Aadd(aObjects,{1,1,.T.,.T.})                 

aSize	:= MsAdvSize(,.F.)
aInfo	:= {aSize[1],aSize[2],aSize[3],aSize[4],3,3}
aPosObj := MsObjSize(aInfo,aObjects,.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se Usuario Logado esta cadastrado no Cad.Usuarios/Responsaveis atraves   ³
//³ do Apelido cadastrado no Configurador                                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
//If !lApelido
//	Help( " ", 1, "QD_LOGIN") // "O usuario atual nao possui um Login" ### "cadastrado igual do configurador."
//	Return(Nil)
//Endif

DbSelectArea("QAA")
DbSetOrder(1)
	IF DbSeek(cMatFil+cMatCod)
		IF QAA->QAA_DISTSN=="2"
		MsgAlert(OemToAnsi(STR0068),OemToAnsi(STR0020)) //"Atencao" //"O usuario logado nao esta indicado como um distribuidor no cadastro !"
		Return(Nil)
		Endif
	Endif

MsgRun(OemToAnsi(STR0054),OemToAnsi(STR0053),{|| QDR200Fit()}) //"Selecionado Registros..."####"Aguarde..."

	If ExistBlock( "QDR200FIL" )
	ExecBlock( "QDR200FIL", .f., .f. )
	EndIf

	If Len(aQDH) == 0
	MsgAlert(OemToAnsi(STR0069),OemToAnsi(STR0020)) //"Atencao" //"Nao existem documentos com a responsabilidade de distribuidor para o usuario logado !"
	Return(Nil)	
	Endif

DEFINE MSDIALOG oDlgFolder FROM aSize[7],000 To aSize[6],aSize[5] OF GetWndDefault() TITLE OemToAnsi(STR0001) PIXEL // "Reemiss„o de Documentos"
       
@ aPosObj[1,1]+8,aPosObj[1,2] FOLDER oEmissao;
		SIZE aPosObj[1,4]-aPosObj[1,2],aPosObj[1,3]-aPosObj[1,1] OF oDlgFolder PIXEL;
		PROMPTS OemToAnsi( STR0024 ),;  // "Documentos"
  				OemToAnsi( STR0025 ),;  // "Usuarios por Documento"
                OemToAnsi( STR0034 ),;  // "Pastas por Documento"
                OemToAnsi( STR0037 )    // "Departamentos por Documento"
             
oEmissao:bSetOption:={|nAtu| U_FQD200Muda(nAtu,@oQDH,@oQAA,@oQDC,@oQAD,@oQDG,@oQDJ,@oQD1,@oQDG1,@oQDJ2) }

QD1->(DbSetOrder(6))
//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder 1 - Documentos X Usuarios                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 000,005 SAY OemToAnsi( STR0005 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[1] PIXEL // "Documentos"
@ 048,005 SAY OemToAnsi( STR0031 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[1] PIXEL // "Departamentos"
@ 100,005 SAY OemToAnsi( STR0004 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[1] PIXEL // "Usuarios"

@ 007, 002 LISTBOX oQDH;
           FIELDS " "," "," ";
           HEADER  OemToAnsi( STR0009 ),; //"Docto"
                   OemToAnsi( STR0010 ),; //"Rv"
                   OemToAnsi( STR0011 );  //"Titulo"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06,40;
           OF oEmissao:aDialogs[1] PIXEL 
oQDH:SetArray(aQDH)
oQDH:bLine:={|| {aQDH[oQDH:nAt,2], aQDH[oQDH:nAt,3], aQDH[oQDH:nAt,4]}}
                  

@ 55,002 	LISTBOX oQDJ;
           	FIELDS  U_QDA200SELE(.F.,QDJ->(Recno()),aQDJ),;
                   QDJ->QDJ_FILMAT+"-"+QDJ->QDJ_DEPTO ,;
	If(QDJ->QDJ_TIPO=="P",OemToAnsi(STR0032),OemToAnsi(STR0004)),;	// "Pasta" ### "Usuarios"
                   Left( Qa_nDept( QDJ->QDJ_DEPTO, .t., QDJ->QDJ_FILMAT ), 30 ) ;
           	HEADER  " ",;
                   OemToAnsi( STR0033 ),; //"Fil/Cod"
                   OemToAnsi( STR0030 ),; //"Tipo"
                   OemToAnsi( STR0029 ) ; //"Depto" 
           	SIZE aPosObj[1,4]-aPosObj[1,2]- 06,44;
           	OF oEmissao:aDialogs[1] PIXEL ALIAS "QDJ" ;
           	ON DBLCLICK (U_QDA200SELE(.T.,QDJ->(Recno()),aQDJ),U_FQD200MARQDG(lPastatus,.T.),;
                        oQDG:UpStable(),;
                        oQDG:GoTop(),;
                        oQDG:Refresh())

@ 107,002 	LISTBOX oQDG;
           	FIELDS U_QDA200SELE(.F.,QDG->(Recno()),aQDG),;
		If(QDG->QDG_TIPO=="D",QDG->QDG_FILMAT+"-"+QDG->QDG_MAT,QDG->QDG_CODMAN) ,;
				If(QDG->QDG_TIPO=="D",If(Empty(Qa_nUsr( QDG->QDG_FILMAT, QDG->QDG_MAT, .T.)),STR0072,Qa_nUsr( QDG->QDG_FILMAT, QDG->QDG_MAT, .T.)),IF(EMPTY(QDXFNANMAN(QDG->QDG_CODMAN,.T.,Iif(FWModeAccess("QDC")=="E",QDG->QDG_FILMAT,))),STR0073,QDXFNANMAN(QDG->QDG_CODMAN,.T.,Iif(FWModeAccess("QDC")=="E",QDG->QDG_FILMAT,)))),; //"Inativo" # "Inativa" // //!Empty(xFilial("QDC") //!Empty(xFilial("QDC")
				If(QDG->QDG_TIPO=="D",Qa_nUsr( QDG->QDG_FILMAT, QDG->QDG_MAT, .T. , "A"),OemToAnsi(STR0032)),;	// "Pastas"
                   QDXFNDsDtr( QDG->QDG_TPRCBT ) ;
           	HEADER  " ",;
                   OemToAnsi( STR0033 ),; //"Fil/Cod"
                   OemToAnsi( STR0006 ),; //"Nome Usuario/Descricao"
                   OemToAnsi( STR0007 ),; //"Apelido"
                   OemToAnsi( STR0030 ); //"Tipo"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06,54;
           OF oEmissao:aDialogs[1] PIXEL ALIAS "QDG";
           ON DBLCLICK (U_FQD200MARQDG(lPastatus,.F.),oQDG:UpStable(), oQDG:Refresh())
oQdg:nHeight := aPosObj[1][3] - 50

oQDH:bCHANGE:= {|| ( oQDJ:SetFilter("QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV",;
                                     aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3] ,;
                                     aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3]),;
                       oQDJ:UpStable(),oQDJ:GoTop(), oQDJ:Refresh())}


oQDJ:bCHANGE:= {|| U_FQDR200OQDJ(oQDJ,oQDG) }

oQDH:UpStable()
oQDH:Refresh()
oQDH:SetFocus(.t.)

oQDJ:SetFilter("QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV",;
                aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3],;
                aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3])
oQDJ:UpStable()
oQDJ:Refresh()
oQDJ:GoTop()

oQDG:SetFilter("QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO",;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO,;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO)
oQDG:UpStable()
oQDG:Refresh()
oQDG:GoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder 2 - Usuarios X Documentos                             ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 000,005 SAY OemToAnsi( STR0004 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[2] PIXEL // "Usu rios"
@ 086,005 SAY OemToAnsi( STR0005 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[2] PIXEL // "Documentos"

@ 007,002  LISTBOX oQAA;
           FIELDS  QAA->QAA_FILIAL+"-"+QAA->QAA_MAT,QAA->QAA_NOME, QAA->QAA_APELID,;
                   QDXFNDsDtr( QAA->QAA_TPRCBT );
           HEADER  OemToAnsi( STR0033 ),; //"Fil/Cod"
                   OemToAnsi( STR0006 ),; //"Nome Usuario/Descricao"
                   OemToAnsi( STR0007 ),; //"Apelido"
                   OemToAnsi( STR0030 ) ; //"Tipo"
           SIZE    aPosObj[1,4] - aPosObj[1,2] - 06,075 OF oEmissao:aDialogs[2] PIXEL ALIAS "QAA"

@ 093, 002 LISTBOX oQD1;
           FIELDS  	" "," "," "," " ;
           HEADER  	" ",;
           			OemToAnsi( STR0029 ),;	// "Depto"
                   	OemToAnsi( STR0009 ),; //"Documento"
                   	OemToAnsi( STR0010 ),; //"Rv"
                   	OemToAnsi( STR0011 );  //"T¡tulo"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06, 085 OF oEmissao:aDialogs[2] PIXEL;
           ON DBLCLICK (U_QDA200SELE(.T.,aQD1List[oQD1:nAt,5],aQD1), oQD1:UpStable(), oQD1:Refresh())

oQd1:nHeight := aPosObj[1][3] - 22

oQD1:SetArray(aQD1List)
oQD1:bLine:={|| { 	U_QDA200SELE(.F.,aQD1List[oQD1:nAt,5],aQD1), aQD1List[oQD1:nAt,6],;
					aQD1List[oQD1:nAt,2], aQD1List[oQD1:nAt,3], aQD1List[oQD1:nAt,4] }}

oQAA:bCHANGE:= {|| (U_FQD200QD1C(@aQD1List,aQD1),;
                     oQD1:aArray:=Aclone(aQD1List),;
                     oQD1:bLogicLen:={||Len(aQD1List)} ,;
                     oQD1:nAt:=1, oQD1:Refresh(), oQD1:GoTop()) }

oQD1:UpStable()
oQAA:SetFocus(.T.)

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder 3 - Pastas X Documentos                               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 000,005 SAY OemToAnsi( STR0032 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[3] PIXEL // "Pastas"
@ 086,005 SAY OemToAnsi( STR0005 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[3] PIXEL // "Documentos"

@ 007,002 LISTBOX oQDC;
           FIELDS  QDC->QDC_FILIAL+"-"+QDC->QDC_CODMAN,QDC->QDC_DESC,QDC->QDC_CODASS,QDC->QDC_CODTP ;
           HEADER  OemToAnsi( STR0033 ),; //"Fil/Cod"
                   OemToAnsi( STR0027 ),; //"Descricao"
                   OemToAnsi( STR0035 ),; //"Cod.Ass."
                   OemToAnsi( STR0036 ) ; //"Tp.Docto"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06, 075 OF oEmissao:aDialogs[3] PIXEL;
           ALIAS "QDC"

@ 093,002  LISTBOX oQDG1;
           FIELDS  " "," "," "," " ;
           HEADER  	" ",;
           			OemToAnsi( STR0029 ),;	// "Depto"
                   	OemToAnsi( STR0009 ),; 	//"Docto"
                   	OemToAnsi( STR0010 ),; //"Rv"
                   	OemToAnsi( STR0011 ); //"Titulo"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06,085 OF oEmissao:aDialogs[3] PIXEL;
           ON DBLCLICK (U_QDA200SELE(.T.,aQDGList[oQDG1:nAt,5],aQDG1), oQDG1:UpStable(), oQDG1:Refresh())

oQdg1:nHeight := aPosObj[1][3] - 22
U_FQD200QDGC(@aQDGList)
oQDG1:SetArray(aQDGList)
oQDG1:bLine:={|| { 	U_QDA200SELE(.F.,aQDGList[oQDG1:nAt,5],aQDG1), aQDGList[oQDG1:nAt,7],;
					aQDGList[oQDG1:nAt,2], aQDGList[oQDG1:nAt,3], aQDGList[oQDG1:nAt,4]}}

oQDC:bCHANGE:= {|| (U_FQD200QDGC(@aQDGList),;
                     oQDG1:aArray:=AClone(aQDGList),;
                     oQDG1:bLogicLen:={||Len(aQDGList)} ,;
                     oQDG1:nAt:=1, oQDG1:Refresh(), oQDG1:GoTop()) }

oQDC:UpStable()
oQDC:Refresh()
oQDC:SetFocus(.t.) 
oQDG1:Refresh()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Folder 4 - Departamentos X Documentos                        ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
@ 000,005 SAY OemToAnsi( STR0031 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[4] PIXEL // "Departamentos"
@ 086,005 SAY OemToAnsi( STR0005 ) COLOR CLR_HBLUE OF oEmissao:aDialogs[4] PIXEL // "Documentos"

@ 007,002 LISTBOX oQAD;
           FIELDS  QAD->QAD_FILIAL+"-"+QAD->QAD_CUSTO,QAD->QAD_DESC ;
           HEADER  OemToAnsi( STR0033 ),; //"Fil/Cod"
                   OemToAnsi( STR0027 ) ; //"Descricao"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06, 075 OF oEmissao:aDialogs[4] PIXEL;
           ALIAS "QAD"

@ 093,002  LISTBOX oQDJ2;
           FIELDS  " "," "," ";
           HEADER  " ",;
                   OemToAnsi( STR0009 ),; //"Docto"
                   OemToAnsi( STR0010 ),; //"Rv"
                   OemToAnsi( STR0011 ) ; //"Titulo"
           SIZE    aPosObj[1,4]-aPosObj[1,2] - 06,085 OF oEmissao:aDialogs[4] PIXEL;
           ON DBLCLICK (U_QDA200SELE(.T.,aQDJ2List[oQDJ2:nAt,5],aQDJ2), oQDJ2:UpStable(), oQDJ2:Refresh())
oQdj2:nHeight := aPosObj[1][3] - 22

oQDJ2:SetArray(aQDJ2List)
oQDJ2:bLine:={|| { U_QDA200SELE(.F.,aQDJ2List[oQDJ2:nAt,5],aQDJ2), aQDJ2List[oQDJ2:nAt,2], aQDJ2List[oQDJ2:nAt,3], aQDJ2List[oQDJ2:nAt,4] }}

oQAD:bCHANGE:= {|| (U_FQD200QDJ2(@aQDJ2List),;
                     oQDJ2:aArray:=AClone(aQDJ2List),;
                     oQDJ2:bLogicLen:={||Len(aQDJ2List)} ,;
                     oQDJ2:nAt:=1, oQDJ2:Refresh(), oQDJ2:GoTop()) }

oQDG:cToolTip:=  OemToAnsi(STR0008) // "Duplo clique para selecionar usuarios"
oQDG1:cToolTip:= OemToAnsi(STR0008) // "Duplo clique para selecionar usuarios"
oQD1:cToolTip:=  OemToAnsi(STR0012) // "Duplo clique para selecionar Documentos"
oQDJ2:cToolTip:=  OemToAnsi(STR0012) // "Duplo clique para selecionar Documentos"

oQDJ:SetFilter("QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV",;
                aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3],;
                aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3])
oQDJ:UpStable()
oQDJ:Refresh()
oQDJ:GoTop()

oQDG:SetFilter("QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO",;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO,;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO)

oQDG:UpStable()
oQDG:Refresh()
oQDG:GoTop()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Atualiza Listbox3 do Folder 1                                ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
U_FQDR200OQDJ(oQDJ,oQDG)

QD1->(DbSetOrder(1))
QDG->(DbSetOrder(1))


aAdd(aButtons,{"PESQUISA",{|| U_QDR200Pesq(@aQD1List,@aQDGList,@aQDJ2List)} ,OemtoAnsi(STR0062),OemtoAnsi(STR0062) } )  //"Distribuidores" //"Distrib"

aAdd(aButtons,{"EDIT",{|| QDR200Conf(@aQD1List,@aQDGList,@aQDJ2List),;
               oQDG:UpStable(),oQDG:GoTop(),;
               oQDG1:UpStable(),oQDG1:GoTop(),;
               oQD1:UpStable(),oQD1:GoTop(),;
               oQD1:Refresh(),oQDG:Refresh(),oQDG1:Refresh(),oQDJ2:Refresh()} ,OemtoAnsi(STR0064),OemtoAnsi(STR0064) } )  //"Distribuidores" //"Distrib"

@ 05,05 SAY oSayM;
        PROMPT If( cCpo == "N", OemToAnsi( STR0002 ), OemToAnsi( STR0003 ) ); // "Nao reemite documentos definidos como copia eletronica" ### "Reemite documentos definidos como copia eletronica"
        COLOR CLR_HRED,CLR_WHITE OF oDlgFolder SIZE 200,8 PIXEL

ACTIVATE MSDIALOG oDlgFolder;
         ON INIT (QDJ->(dbSetOrder(1)),QDJ->(dbSeek(aQDH[oQDH:nAt,1]+aQDH[oQDH:nAt,2]+aQDH[oQDH:nAt,3])),;
                  QDG->(dbSetOrder(1)),QDG->(dbSeek(QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO)),;
                  U_FQD200Muda(nAtu,@oQDH,@oQAA,@oQDC,@oQAD,@oQDG,@oQDJ,@oQD1,@oQDG1,@oQDJ2),;
                  EnchoiceBar(oDlgFolder,;
                            {||IF(U_FQDR200OK(),(U_FQDR200Imp(),oDlgFolder:End(),@oQD1,@oQDG,@oQDG1,@oQDJ2,@aQD1List,@aQDGList,@aQDJ2List),"")},;
                            {||oDlgFolder:End(),@oQD1,@oQDG,@oQDG1,@oQDJ2,@aQD1List,@aQDGList,@aQDJ2List},,aButtons))


DbSelectArea("QDH")
RetIndex("QDH")
Set Filter to
cIndex1 += OrDbagExt()
Delete File &(cIndex1)


DbSelectArea("QD1")
DbSetorder(1)
Set Filter to

DbSelectArea("QDG")
DbSetorder(1)
Set Filter to

DbSelectArea("QAA")
DbSetorder(1)
Set Filter to  

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ FQDR200OK  ³ Autor ³Newton R. Ghiraldelli ³ Data ³ 14/09/99³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Valida se foi digitado o motivo da revisao para impressao  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FQDR200OK()                                                ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200                                         			  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQDR200OK()

Local lRet := .T.

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi preenchido o Motivo da Revisao               ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Empty(cMotivo)
	MsgAlert( OemToAnsi( STR0041 ), OemToAnsi( STR0023 ) ) //"Motivo da reemissao nao preenchido. Utilize a op‡„o Configuracao." ### "Atencao"
	lRet := .F.
	Endif

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi selecionado algum lancamento                 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
	If Len(aQDG) == 0 .And. ;	// Usuarios
   Len(aQDJ) == 0 .And. ; // Depto X Usuarios
   Len(aQD1) == 0 .And. ; // Documentos
   Len(aQDG1) == 0 .And.; // Documentos
   Len(aQDJ2) == 0        // Documentos
	lRet := .F.
	Endif

aQDG  := aSort(aQDG)
aQDJ  := aSort(aQDJ)
aQD1  := aSort(aQD1)
aQDG1 := aSort(aQDG1)
aQDJ2 := aSort(aQDJ2)

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ FQD200CONF ³ Autor ³Newton R.Ghiraldelli ³ Data ³ 08/09/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Tela de configuracao de impressao de Documentos            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FQD200CONF(ExpA1,ExpA2,ExpA3)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 - Array contendo lancamentos do arquivo QD1          ³±±
±±³          ³ ExpA2 - Array contendo lancamentos do arquivo QDG          ³±±
±±³          ³ ExpA3 - Array contendo lancamentos do arquivo QDJ          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200CONF(aQD1List,aQDGList,aQDJ2List)

Local cMsg    := ""
Local cFiltro := ""
Local cNVal   := ""
local cQDOCPO := SuperGetMV("MV_QDOCPO", .F., "N") 

cMsg := OemToAnsi( STR0014 ) +; // "A configuracao atual esta para " 
	If( cCpo == "N", OemToansi( STR0015 ), OemToAnsi( STR0016 ) ) +; // "nao reemitir" ### "reemitir"
        OemToAnsi( STR0017 ) + chr( 13 ) +; // " documentos definidos como copias eletronicas"
        OemToAnsi( STR0018 ) +; // "Deseja mudar a configuracao para "
		If( cCpo == "N", OemToansi( STR0016 ), OemToAnsi( STR0015 ) ) +; // "reemitir" ### "nao reemitir"
        OemToansi( STR0019+"          " ) // " os documentos ?"

			If MsgYesNo( cMsg, OemToAnsi( STR0020 ) ) // "Atencao"
				If Alltrim(cQDOCPO) == "N"
		cNVal := "S"
				ElseIf Alltrim(cQDOCPO) == "S"
		cNVal := "N"
				Endif
	
	PutMv("MV_QDOCPO",cNVal) 
	cCpo := GetMV("MV_QDOCPO") 

	CursorWait()

				If oEmissao:nOption == 1
		dbSelectArea("QDG")
		cFiltro := 'QDG->QDG_RECEB == "S" .And. QDG->QDG_SIT <> "I"  .And. QDG->QDG_TPRCBT <> "4"'
					If cNVal == "N"
			cFiltro += ' .And. QDG->QDG_TPRCBT <> "1"'
					Endif
		Set Filter to &(cFiltro)
		DbSeek(xFilial("QDG"))
				ElseIf oEmissao:nOption == 2
		U_FQD200QD1C(@aQD1List)
				ElseIf oEmissao:nOption == 3
		U_FQD200QDGC(@aQDGList)
				ElseIf oEmissao:nOption == 4
		U_FQD200QDJ2(@aQDJ2List)
				EndIf
	
	CursorArrow()
			EndIf

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o    ³ QDA200SELE ³ Autor ³ Aldo Marini Junior  ³ Data ³ 25.04.01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Marcar/Desmarcar os Lactos selecionados                    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ FQAXA010 (lOpcao,nItem,array)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpL1 = Logico identificando se for selecionado            ³±±
±±³          ³ ExpN1 = Numero do registro do arquivo a ser selecionado    ³±±
±±³          ³ ExpA1 = Array correspondente ao arquivo a selecionar       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDA200SELE(lOpcao,nItem,aArray)

Local lRet:= hNo

	If nItem > 0
		If !lOpcao
			If ascan(aArray,nitem) > 0
			lRet := hOk
			Endif
		Else
			If (nPos:= ascan(aArray,nitem)) > 0
			Adel(aArray,nPos)
			aSize(aArray,Len(aArray)-1)
			Else
	      aAdd(aArray,nitem)
			Endif
		Endif
	Endif

Return lRet

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³FQD200MARQDG³Autor  ³Aldo Marini Junior   ³ Data ³ 25/04/01 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Marca/Desmarca os Destinatarios qdo Selecionar Depto       ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FQD200MARQDG()                                             ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso      ³ QDOR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200MARQDG(lPastatus,lMarkAll)

Local nPos  := 0
Local nPosJ := aScan(aQDJ,QDJ->(Recno()) )
Local nPosG := aScan(aQDG,QDG->(Recno()) )
//Local cFilPst:= xFilial("QDC")
Local lMarca:=.T.               
Local lUsur:= .F.                   
Local aArea:= GetArea()   
Local nNoMarc:=0
Local nMarc:=0

	IF lMarkAll
		While !QDG->(Eof()) .And. QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO == QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO
			IF QDG->QDG_TIPO=="P"
				IF FWModeAccess("QDC") == "C" //Empty(cFilPst)
					IF !QDC->(DbSeek(xFilial("QDC")+QDG->QDG_CODMAN))
					lMarca:=.F.    
					nNoMarc++
					QDG->(dbSkip())
					Loop
					Endif
				Else
					IF !QDC->(DbSeek(QDJ->QDJ_FILMAT+QDG->QDG_CODMAN))
					lMarca:=.F.   
					nNoMarc++
					QDG->(dbSkip())
					Loop
					Endif
				Endif
			Else
		 	QAA->(DBSETORDER(1))
				IF !QAA->(DbSeek(QDJ->QDJ_FILMAT+QDG->QDG_MAT))
				lMarca:=.F.
				lUsur:=.T. 
				QDG->(dbSkip())
				Loop
				Endif
			Endif
		nMarc++
			If nPosJ > 0
				If ( nPos:= aScan(aQDG,QDG->(Recno()) )) == 0
				aAdd(aQDG,QDG->(Recno()))
				Endif
			Else
				If ( nPos:= aScan(aQDG,QDG->(Recno()) )) > 0
				Adel(aQDG,nPos)
				aSize(aQDG,Len(aQDG)-1)
				Endif
			Endif
		
		QDG->(dbSkip())
		Enddo
		IF !lMarca .And. !lUsur
		MsgAlert(OemToAnsi(STR0070)) //"Existem Pastas selecionadas, que estão Inativas!"
			If nMarc == 0
			Adel(aQDJ,nPosJ)
			aSize(aQDJ,Len(aQDJ)-1)
			Endif
		Elseif !lMarca .And. lUsur
		MsgAlert(OemToAnsi(STR0075))//"Existem usuários que estão inativos"
			If nMarc == 0
			Adel(aQDJ,nPosJ)
			aSize(aQDJ,Len(aQDJ)-1) 
			Endif
		Endif

	Else
	lMarca:=.T.
		IF QDG->QDG_TIPO=="P"
			IF FWModeAccess("QDC") == "C" //Empty(cFilPst)
			lMarca:=QDC->(DbSeek(xFilial("QDC")+QDG->QDG_CODMAN))
			Else
			lMarca:=QDC->(DbSeek(QDG->QDG_FILMAT+QDG->QDG_CODMAN))
			Endif
		Else
		QAA->(DBSETORDER(1))
			IF !QAA->(DbSeek(QDJ->QDJ_FILMAT+QDG->QDG_MAT))
			lMarca:=.F.
			lUsur:=.T.
			Endif
		Endif
		IF lMarca
		U_QDA200SELE(.T.,QDG->(Recno()),aQDG)
		Elseif !lUsur
		MsgAlert(OemToAnsi(STR0071)) //"Esta Pasta não será selecionada, esta Inativa!"
		Else
		MsgAlert(STR0074)//"Usuário Inativo"
		Endif
	Endif

QDG->(dbGoTo(nPosG))

oQDG:SetFilter("QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO",;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO,;
                QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO)

	                
RestArea(aArea)

Return()

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ QDR200Conf ³ Autor ³Newton R. Ghiraldelli ³ Data ³ 14/09/99³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Configura os parametros do relatorio(Motivo,Copias,etc)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ QDR200Conf(ExpA1,ExpA2,ExpA3)                              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 - Array contendo lancamentos do arquivo QD1          ³±±
±±³          ³ ExpA2 - Array contendo lancamentos do arquivo QDG          ³±±
±±³          ³ ExpA3 - Array contendo lancamentos do arquivo QDJ          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³ QDOR200                                                    ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
Static Function QDR200Conf(aQD1List,aQDGList,aQDJ2List)

Local oDlg
Local oBtn1
Local oSay01
Local oChProto
Local oChCopia
Local oTpImpr
Local lLibCop:= .T.

	IF ExistBlock( "QDOAP30" )
		lLibCop:= ExecBlock( "QDOAP30", .f., .f., )
	Endif

DEFINE MSDIALOG oDlg FROM 100,128 TO 240,685 TITLE OemToAnsi( STR0040 ) PIXEL // "Configuracao da Reemissao"
       
@ 004,003 TO 025,276 LABEL OemToAnsi( STR0026 ) OF oDlg PIXEL	// "Motivo da Reemissao"

@ 011,008 SAY   OemToAnsi(STR0027)      SIZE 035,007 OF oDlg PIXEL // "Descricao"
@ 011,042 MSGET oGetMotRee VAR cMotivo Picture "@!S55" SIZE 227,008 OF oDlg PIXEL
oGetMotRee:bHelp := {|| ShowHelpCpo( STR0076,;    //"Motivo"
									{STR0077},2,; //"Deverá ser informado o motivo da reemissão do documento."
									{STR0078},2)} //"Este campo deve ser informado, não pode ser vazio."

@ 029,003 TO 056,098 PROMPT OemToAnsi( STR0023 ) OF oDlg PIXEL // " Opcoes para Emissao "        
@ 036,007 CHECKBOX oChProto VAR lChProto PROMPT OemToAnsi( STR0021 ) SIZE 57,10 OF oDlg PIXEL // "Protocolo"
@ 044,007 CHECKBOX oChCopia VAR lChCopia PROMPT OemToAnsi( STR0022 ) SIZE 57,10 OF oDlg PIXEL WHEN lLibCop // "Copia Controlada"

@ 060,003 SAY oSay01;
           PROMPT If( cCpo == "N", OemToAnsi( STR0002 ), OemToAnsi( STR0003 ) ); // "Nao reemite documentos definidos como copia eletronica" ### "Reemite documentos definidos como copia eletronica"
           COLOR CLR_HRED OF oDlg PIXEL
	If ExistBlock( "QDOCAPA" )
	@ 029,103 TO 056,208 PROMPT OemToAnsi(STR0050) OF oDlg PIXEL	// "Tipo de Impressao"
	@ 036,107 RADIO oTpImpr VAR nTpImpr ITEMS OemToAnsi(STR0051),OemToAnsi(STR0052); // "Capa" ### "Documento"
	           3D SIZE 040,007 OF oDlg PIXEL
	EndIf

DEFINE SBUTTON oBtn1 FROM 40,219 TYPE 11 ENABLE OF oDlg ACTION (U_FQD200Conf(@aQD1List,@aQDGList,@aQDJ2List),oDlg:Refresh())
DEFINE SBUTTON       FROM 40,247 TYPE 1  ENABLE OF oDlg ACTION oDlg:End()

oBtn1:cToolTip:= OemToAnsi(STR0013) // "Configuracao..."
oBtn1:cCaption:= OemToAnsi(STR0064) // "Config"
	
ACTIVATE MSDIALOG oDlg CENTERED

Return .T.


/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³FQDR200Muda ³ Autor ³Newton R. Ghiraldelli ³ Data ³ 14/09/99³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Configura os parametros do relatorio(Motivo,Copias,etc)    ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³U_FQD200Muda(nAtu,oQDH,oQAA,oQDC,oQAD,oQDG,oQDJ,oQD1,oQDG1,   ³±±
±±³          ³           oQDJ2)                                           ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpN1 - Numerico definindo Folder Atual                    ³±±
±±³          ³ ExpO1 - Objeto do Browser de Documentos                    ³±±
±±³          ³ ExpO2 - Objeto do Browser de Usuarios/Funcionarios         ³±±
±±³          ³ ExpO3 - Objeto do Browser de Pastas                        ³±±
±±³          ³ ExpO4 - Objeto do Browser de Centro de Custo/Depto         ³±±
±±³          ³ ExpO5 - Objeto do Browser de Destinatarios                 ³±±
±±³          ³ ExpO6 - Objeto do Browser de Destinos (Deptos)             ³±±
±±³          ³ ExpO7 - Objeto do Browser de Pendencias                    ³±±
±±³          ³ ExpO8 - Objeto do Browser de Destionatarios2               ³±±
±±³          ³ ExpO9 - Objeto do Browser de Destinos2 (Deptos)            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200Muda(nAtu,oQDH,oQAA,oQDC,oQAD,oQDG,oQDJ,oQD1,oQDG1,oQDJ2)

QDG->(dbSetOrder(1))
QAA->(dbSetOrder(3))

	If nAtu == 1
	oQDH:GoTop();Eval(oQDH:bChange);oQDH:UpStable();oQDH:Refresh()
	oQDJ:GoTop();Eval(oQDJ:bChange);oQDJ:UpStable();oQDJ:Refresh()
	oQDG:GoTop();Eval(oQDJ:bChange);oQDG:UpStable();oQDG:Refresh()
//	oBtnPesq:cToolTip:= OemToAnsi(STR0055) // "Pesquisa Documento"
	ElseIf nAtu == 2
	QAA->(dbSetOrder(3))
   QAA->(DbSeek(xFilial("QAA")))
	oQAA:GoTop();oQAA:UpStable();oQAA:Refresh()
	oQD1:GoTop();oQD1:UpStable();oQD1:Refresh()
//	oBtnPesq:cToolTip:= OemToAnsi(STR0056) // "Pesquisa Usuario"
	ElseIf nAtu == 3
   QDG->(dbSetOrder(5))
   QDG->(DbSeek(xFilial("QDG")))
   QDC->(DbSeek(xFilial("QDC")))
	oQDC:GoTop();oQDC:UpStable();oQDC:Refresh()
	oQDG1:GoTop();oQDG1:UpStable();oQDG1:Refresh()
//	oBtnPesq:cToolTip:= OemToAnsi(STR0057) // "Pesquisa Pasta"
	ElseIf nAtu == 4
	oQAD:GoTop();oQAD:UpStable();oQAD:Refresh()
	oQDJ2:GoTop();oQDJ2:UpStable();oQDJ2:Refresh()
//	oBtnPesq:cToolTip:= OemToAnsi(STR0058) // "Pesquisa Departamento"
	Endif

Return .T.

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao	 ³QDR200Imp   ³Autor ³Newton R. Ghiraldelli ³ Data ³ 16/09/99 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³Imprime o Docto e Protocolo						          ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200 	  												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQDR200Imp()

Local nC        := 0
Local aQPath    := QDOPATH()
Local cQPathTrm := aQPath[3]
Local nQD       := 0
Local cFilQAD   := ""
Local aData     := {}
Local aPrt      := {}
Local oTempTable:= NIL
Local nT
Local lImpUnCp  := If(GetMv("MV_QDIMPUM",.F.,.F.) == .T.,.T.,.F.)
Local lQDOCAPA  := ExistBlock( "QDOCAPA" )

Private cNomRece:= ""
Private cDepRece:= ""
Private lEditor := .T.
Private lFim    := .T.
Private oWord

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Criacao de arquivo temporario para impressao do Protocolo                  ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
Aadd( aPrt, { "TRB_FILIAL", "C", FWSizeFilial(), 00 } )
Aadd( aPrt, { "TRB_DOCTO" , "C", TamSX3("QDH_DOCTO")[1], 00 } )
Aadd( aPrt, { "TRB_RV"    , "C", TamSX3("QDH_RV")[1], 00 } )
Aadd( aPrt, { "TRB_FILMAT", "C", TamSX3("QAA_FILIAL")[1], 00 } )
Aadd( aPrt, { "TRB_MAT"   , "C", TamSX3("QAA_MAT")[1], 00 } )
Aadd( aPrt, { "TRB_DEPTO" , "C", TamSX3("QAA_CC")[1], 00 } )
Aadd( aPrt, { "TRB_TPRCBT", "C", 01, 00 } )
Aadd( aPrt, { "TRB_COPIAS", "N", 04, 00 } )
Aadd( aPrt, { "TRB_TIPO"  , "C", 01, 00 } )


oTempTable := FWTemporaryTable():New( "TRB" )
oTempTable:SetFields( aPrt )
oTempTable:AddIndex("indice1", {"TRB_FILIAL","TRB_DOCTO","TRB_RV","TRB_FILMAT","TRB_DEPTO","TRB_MAT"} )
oTempTable:Create()

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi selecionado algum lancamento de Deptos/Usuarios - Folder 1 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
QDH->(dbSetOrder(1))
QAA->(dbSetorder(1))

	If Len(aQDG) > 0
		For nQD := 1 to Len(aQDG)
		QDG->(DbGoto(aQDG[nQD]))
		DbSelectArea("QDH")
			If QDH->(DbSeek(QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV))
				For nC := 1 to FCount()
            	cCampo := Upper( Alltrim( FieldName( nC ) ) )
            	M->&cCampo. := FieldGet( nC )
				Next
         	cNomRece := ""
         	cDepRece := ""
			DbSelectArea("QAA")
				If QAA->(DbSeek(QDG->QDG_FILMAT+QDG->QDG_MAT))
					For nC := 1 to FCount()
		          cCampo := Upper( Alltrim( FieldName( nC ) ) )
		          M->&cCampo. := FieldGet( nC )
					Next
				cNomRece := QAA->QAA_NOME
				cDepRece := QAA->QAA_CC
				EndIf

         	cFilQAD := If(FWModeAccess("QAD")=="C",xFilial("QAD"),QDG->QDG_FILMAT) //Empty(xFilial("QAD")
			QAD->(DbSeek(cFilQAD+QDG->QDG_DEPTO))

				If QDG->QDG_TIPO == "P"
				cNomRece := Alltrim( QDG->QDG_CODMAN )+" - "+ QDXFNANMAN( QDG->QDG_CODMAN, .t. )+chr(13)+OemToAnsi(STR0042)+ cNomRece	 // "Responsavel: "
				Endif

				If nTpImpr == 1
					IF lQDOCAPA
					ExecBlock( "QDOCAPA", .f., .f.,{ 1 } )
					Endif
				Else
					If lImpUnCp //Imprime unica copia de documento na Reemissao de documentos
					ProcessaDoc( { || QdoDocRDoc(1,.T.)},;
	                           OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	                           cNomRece)
					Else
					ProcessaDoc( { || QdoDocRDoc(If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),.T.)},;
	                           OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	                           cNomRece)
					Endif
				EndIf
			lEditor := .F.
			
         	QD110GrLog(lChCopia,cMotivo,If(QDG->QDG_TIPO == "D","U","P"),If(lImpUnCp,1,(If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1))),cMatFil,cMatCod,QDG->QDG_FILMAT,QDG->QDG_MAT,QDG->QDG_TPRCBT)

         	aPrtMat := { 	QDG->QDG_FILIAL,;
            	           	QDG->QDG_DOCTO,;
	                       	QDG->QDG_RV,;
	                       	QDG->QDG_FILMAT,;
	                       	QDG->QDG_MAT,;
	                       	QDG->QDG_DEPTO,;
						  	QDG->QDG_TPRCBT,;
				If(lImpUnCp,1,If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1)),;
	                       	QDG->QDG_TIPO }

			U_FQD200PRT("QDG",aPrtMat)			
					EndIf
			Next
		EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi selecionado algum lancamento de Usuario/Doctos  - Folder 2 ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
		If Len(aQD1) > 0  // Documentos
	lEditor := .T.	
			For nQD := 1 to Len(aQD1)
		QD1->(DbGoto(aQD1[nQD]))
		DbSelectArea("QDH")
				If QDH->(DbSeek(QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV))
					For nC := 1 to FCount()
            	cCampo := Upper( Alltrim( FieldName( nC ) ) )
            	M->&cCampo. := FieldGet( nC )
					Next
         	cNomRece := ""
         	cDepRece := ""
			DbSelectArea("QAA")
					If QAA->(DbSeek(QD1->QD1_FILMAT+QD1->QD1_MAT))
						For nC := 1 to FCount()
		          cCampo := Upper( Alltrim( FieldName( nC ) ) )
		          M->&cCampo. := FieldGet( nC )
						Next
				cNomRece := QAA->QAA_NOME
				cDepRece := QAA->QAA_CC
					EndIf

         	cFilQAD:= If(FWModeAccess("QAD")=="C",xFilial("QAD"),QD1->QD1_FILMAT) //Empty(xFilial("QAD")
			QAD->(DbSeek(cFilQAD+QD1->QD1_DEPTO))

			QDG->(DbSetOrder(3))
					If QDG->(DbSeek(QD1->QD1_FILIAL+QD1->QD1_DOCTO+QD1->QD1_RV+QD1->QD1_FILMAT+QD1->QD1_DEPTO+QD1->QD1_MAT))
						If QDG->QDG_TIPO == "P"		// Pastas
					cNomRece := Alltrim( QDG->QDG_CODMAN )+" - "+ QDXFNANMAN( QDG->QDG_CODMAN, .t. )+chr(13)+OemToAnsi(STR0042)+ cNomRece	 // "Responsavel: "
						Endif
						If nTpImpr == 1
							IF lQDOCAPA
	  					ExecBlock( "QDOCAPA", .f., .f.,{ 1 } )
							Endif
						Else
							If lImpUnCp
			            ProcessaDoc( { || QdoDocRDoc(1,.T.)},;
	            	                   OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	        	                       cNomRece)
							Else
			            ProcessaDoc( { || QdoDocRDoc(If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),.T.)},;
	            	                   OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	        	                       cNomRece)
							Endif
						EndIf
				lEditor := .F.

		        QD110GrLog(lChCopia,cMotivo,If(QDG->QDG_TIPO == "D","U","P"),If(lImpUnCp,1,If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1)),cMatFil,cMatCod,QDG->QDG_FILMAT,QDG->QDG_MAT,QDG->QDG_TPRCBT)

	        	aPrtMat := { 	QDG->QDG_FILIAL,;
	            	           	QDG->QDG_DOCTO,;
	                	       	QDG->QDG_RV,;
		                       	QDG->QDG_FILMAT,;
		                       	QDG->QDG_MAT,;
	    	                   	QDG->QDG_DEPTO,;
								QDG->QDG_TPRCBT,;
						If(lImpUnCp,1,If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1)),;
	            	           	QDG->QDG_TIPO }
                       
				U_FQD200PRT("QDG",aPrtMat)
							EndIf
					EndIf
				Next
			EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi selecionado algum lancamento de Pastas/Doctos - Folder 3   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
			If Len(aQDG1) > 0  // Documentos
	lEditor := .T.
				For nQD := 1 to Len(aQDG1)
		QDG->(DbGoto(aQDG1[nQD]))
		DbSelectArea("QDH")
					If QDH->(DbSeek(QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV))
						For nC := 1 to FCount()
            cCampo := Upper( Alltrim( FieldName( nC ) ) )
            M->&cCampo. := FieldGet( nC )
						Next
         cNomRece := ""
         cDepRece := ""
			DbSelectArea("QAA")
						If QAA->(DbSeek(QDG->QDG_FILMAT+QDG->QDG_MAT))
							For nC := 1 to FCount()
		          cCampo := Upper( Alltrim( FieldName( nC ) ) )
		          M->&cCampo. := FieldGet( nC )
							Next
				cNomRece := QAA->QAA_NOME
				cDepRece := QAA->QAA_CC
						EndIf

         	cFilQAD := If(FWModeAccess("QAD")=="C",xFilial("QAD"),QDG->QDG_FILMAT) //Empty(xFilial("QAD")
			QAD->( DbSeek( cFilQAD+QDG->QDG_DEPTO ) )
			cNomRece := Alltrim( QDG->QDG_CODMAN )+" - "+ QDXFNANMAN( QDG->QDG_CODMAN, .t. )+chr(13)+OemToAnsi(STR0042)+ cNomRece	 // "Responsavel: "

						If nTpImpr == 1
							IF lQDOCAPA
	  				ExecBlock( "QDOCAPA", .f., .f.,{ 1 } )
							Endif
						Else
							If lImpUnCp
		            ProcessaDoc( { || QdoDocRDoc(1,.T.)},;
	            	                   OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	        	                       cNomRece)
							Else
					ProcessaDoc( { || QdoDocRDoc(If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),.T.)},;
	                           OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
	                           cNomRece)
							Endif
						EndIf
			lEditor := .F.

         	QD110GrLog(lChCopia,cMotivo,If(QDG->QDG_TIPO == "D","U","P"),If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),cMatFil,cMatCod,QDG->QDG_FILMAT,QDG->QDG_MAT,QDG->QDG_TPRCBT)

         	aPrtMat := { 	QDG->QDG_FILIAL,;
                       		QDG->QDG_DOCTO,;
                       		QDG->QDG_RV,;
                       		QDG->QDG_FILMAT,;
 	                      	QDG->QDG_MAT,;
                       		QDG->QDG_DEPTO,;
							QDG->QDG_TPRCBT,;
						If(lImpUnCp,1,If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1)),;
                       		QDG->QDG_TIPO }

			U_FQD200PRT("QDG",aPrtMat)			
							EndIf
					Next
				EndIf

//ÚÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ¿
//³ Verifica se foi selecionado algum lancamento de Deptos/Doctos - Folder 4   ³
//ÀÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ
				If Len(aQDJ2) > 0 // Documentos
	lEditor := .T.
					For nQD := 1 to Len(aQDJ2)
		QDG->(DbGoto(aQDJ2[nQD]))
						If QDJ->(DbSeek(QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO))
			DbSelectArea("QDH")
							If QDH->(DbSeek(QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV))
								For nC := 1 to FCount()
	            	cCampo := Upper( Alltrim( FieldName( nC ) ) )
	            	M->&cCampo. := FieldGet( nC )
								Next
				QDG->(DbSetOrder(1))
								If QDG->(DbSeek(QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO))
									While QDG->(!Eof()) .And. QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO == QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO
			         cNomRece := ""
			         cDepRece := ""
						DbSelectArea("QAA")
										If QAA->(DbSeek(QDG->QDG_FILMAT+QDG->QDG_MAT))
											For nC := 1 to FCount()
								cCampo := Upper( Alltrim( FieldName( nC ) ) )
								M->&cCampo. := FieldGet( nC )
											Next
							cNomRece := QAA->QAA_NOME
							cDepRece := QAA->QAA_CC
										EndIf

			         	cFilQAD := If(FWModeAccess("QAD")=="C",xFilial("QAD"),QDG->QDG_FILMAT) //Empty(xFilial("QAD")
						QAD->( DbSeek( cFilQAD+QDG->QDG_DEPTO ) )

										If QDG->QDG_TIPO == "P"
							cNomRece := Alltrim( QDG->QDG_CODMAN )+" - "+ QDXFNANMAN( QDG->QDG_CODMAN, .t. )+chr(13)+OemToAnsi(STR0042)+ cNomRece	 // "Responsavel: "
										Endif

										If nTpImpr == 1
											IF lQDOCAPA
								ExecBlock( "QDOCAPA", .f., .f.,{ 1 } )
											Endif
										Else
											If lImpUnCp
								ProcessaDoc( { || QdoDocRDoc(1,.T.)},;
		                                 OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
		                                 cNomRece)
											Else
								ProcessaDoc( { || QdoDocRDoc(If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),.T.)},;
		                                 OemToAnsi(STR0009)+" "+QDH->QDH_DOCTO+"-"+QDH->QDH_RV,; 	// "Docto"
		                                 cNomRece)
											Endif
										EndIf
						lEditor := .F.

			         	QD110GrLog(lChCopia,cMotivo,If(QDG->QDG_TIPO == "D","U","P"),If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1),cMatFil,cMatCod,QDG->QDG_FILMAT,QDG->QDG_MAT,QDG->QDG_TPRCBT)

			         	aPrtMat := { 	QDG->QDG_FILIAL,;
		                       			QDG->QDG_DOCTO,;
		                       			QDG->QDG_RV,;
		                       			QDG->QDG_FILMAT,;
		                       			QDG->QDG_MAT,;
		                       			QDG->QDG_DEPTO,;
									  	QDG->QDG_TPRCBT,;
										If(lImpUnCp,1,If(QDG->QDG_NCOP>0,QDG->QDG_NCOP,1)),;
                             			QDG->QDG_TIPO }
                             
						U_FQD200PRT("QDG",aPrtMat)
						QDG->(DbSkip())					
											Enddo
									Endif
								Endif
							Endif
						Next
					Endif

					If lChProto
   QDOR062()
					Endif

aData  := DIRECTORY(cQPathTrm+"*.CEL")
					For nT:= 1 to Len(aData)
						If File(cQPathTrm+AllTrim(aData[nT,1]))
		FErase(cQPathTrm+AllTrim(aData[nT,1]))
						Endif
					Next

aData  := DIRECTORY(cQPathTrm+"*.DOT")
					For nT:= 1 to Len(aData)
						If File(cQPathTrm+AllTrim(aData[nT,1]))
		FErase(cQPathTrm+AllTrim(aData[nT,1]))
						Endif
					Next

oTempTable:Delete()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ FQD200PRT  ³ Autor ³Newton R. Ghiraldelli ³ Data ³ 14/09/99³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Atualiza o arquivo temporario para impressao do protocolo  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FQD200PRT(cAlias,aPrtMat)                                  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpC1 - Caracter contendo o ultimo Alias()                 ³±±
±±³          ³ ExpA1 - Array contendo os dados a ser gravado              ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200PRT(cAlias,aPrtMat)

Local cPRT_FILIAL := aPrtMat[1]
Local cPRT_DOCTO  := aPrtMat[2]
Local cPRT_RV     := aPrtMat[3]
Local cPRT_FILMAT := aPrtMat[4]
Local cPRT_MAT    := aPrtMat[5]
Local cPRT_DEPTO  := aPrtMat[6]
Local cPRT_TPRCBT := aPrtMat[7]
Local cPRT_COPIAS := aPrtMat[8]
Local cPRT_TIPO   := aPrtMat[9]

DbSelectArea("TRB")
Reclock("TRB", .T.)

TRB->TRB_FILIAL := cPRT_FILIAL
TRB->TRB_DOCTO  := cPRT_DOCTO
TRB->TRB_RV     := cPRT_RV
TRB->TRB_FILMAT := cPRT_FILMAT
TRB->TRB_MAT    := cPRT_MAT
TRB->TRB_DEPTO  := cPRT_DEPTO
TRB->TRB_TPRCBT := cPRT_TPRCBT
TRB->TRB_COPIAS := If( cPRT_COPIAS == 0, 1, cPRT_COPIAS)
TRB->TRB_TIPO   := cPRT_TIPO

TRB->( MsUnlock() )

DbSelectArea( cAlias )

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³FQDR200OQDJ ³ Autor ³Newton R. Ghiraldelli ³ Data ³ 14/09/99³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Atualiza o ListBox de Destinatarios do Folder 1            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_FQDR200OQDJ(oQDJ,oQDG)                                     ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ ExpA1 - Array contendo os Lactos dos Departamentos(Pai)    ³±±
±±³          ³ ExpA2 - Array contendo os Lactos dos destinatarios (filhos)³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQDR200OQDJ(oQDJ,oQDG)

QDG->(dbSetOrder(1))
	If QDG->(dbSeek(QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO))
   oQDG:SetFilter("QDG->QDG_FILIAL+QDG->QDG_DOCTO+QDG->QDG_RV+QDG->QDG_TIPO+QDG->QDG_FILMAT+QDG->QDG_DEPTO",;
                   QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO,;
                   QDJ->QDJ_FILIAL+QDJ->QDJ_DOCTO+QDJ->QDJ_RV+QDJ->QDJ_TIPO+QDJ->QDJ_FILMAT+QDJ->QDJ_DEPTO)
	oQDG:UpStable()
	oQDG:GoTop()
	oQDG:Refresh()
	Else
	oQDG:Refresh()
	Endif

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±± Funcao     FQD200QD1C, Autor: Newton R. Ghiraldelli, Data: 14/09/99
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±± Descricao  Carrega dos Lactos de Pendencias (destinatarios) p/Selecao
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Sintaxe    U_FQD200QD1C(aQD1List)
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Parametros ExpA1 - Array onse sera armazenado os Lactos de Pendencias
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Uso        QDOR200
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200QD1C(aQD1List)
Local cQAAQDH    := "QDH.QDH_FILDEP = '" + cMatFil+ "'
Local cQuery     := ""
Local oQLTQueryM := Nil

	If FindClass("QLTQueryManager") 
		oQLTQueryM := QLTQueryManager():New()
		cQAAQDH := oQLTQueryM:MontaQueryComparacaoFiliaisComValorReferencia("QAD", "QDH.QDH_FILDEP", "QAA", cMatFil)
	EndIf

	CursorWait()

	aArea := GetArea()
	cQuery := " SELECT DISTINCT QD1.QD1_FILIAL, QD1.QD1_DOCTO, QD1.QD1_RV, QD1.QD1_DEPTO,"
	cQuery += " QD1.QD1_FILMAT, QD1.QD1_MAT, QD1.QD1_DTGERA, QD1.QD1_TPPEND, QDH.QDH_TITULO, QD1.R_E_C_N_O_ QD1RECNO"
	cQuery += " FROM " + RetSqlName("QD1")+" QD1, "
	cQuery += RetSqlName("QDG")+" QDG, "
	cQuery += RetSqlName("QDH")+" QDH, "
	cQuery += RetSqlName("QAA")+" QAA "
	cQuery += "WHERE QD1.QD1_SIT <> 'I' AND QD1.QD1_TPDIST <> '4' AND QD1.QD1_TPPEND = 'L  '"
	cQuery += " AND QD1.D_E_L_E_T_ = ' '"
	If cCpo == "N"
		cQuery += " AND QD1.QD1_TPDIST <> '1'"
		cQuery += " AND QDG.QDG_TPRCBT <> '1'"
	Endif
	cQuery += " AND QDG.QDG_RECEB = 'S' AND QDG.QDG_SIT <> 'I'  AND QDG.QDG_TPRCBT <> '4'"
	cQuery += " AND QDG.D_E_L_E_T_ = ' '"
	cQuery += " AND QDH.QDH_OBSOL = 'N' AND QDH.QDH_CANCEL <> 'S' AND QDH.QDH_STATUS = 'L  '"
	cQuery += " AND QDH.QDH_DTOIE <> 'E' AND QDH.D_E_L_E_T_ = ' '"
	cQuery += " AND ((" + cQAAQDH + " AND QDH.QDH_DEPTOD = '"+cMatDep+"')"
	cQuery += " OR (EXISTS(SELECT R_E_C_N_O_ FROM "+RetSqlName("QDZ")+" QDZ WHERE QDH.QDH_FILIAL = QDZ.QDZ_FILIAL AND QDH.QDH_DOCTO = QDZ.QDZ_DOCTO"
	cQuery += " AND QDH.QDH_RV = QDZ.QDZ_RV AND QDZ.QDZ_DEPTO ='"+cMatDep+"'" 
	cQuery += " AND QDZ.QDZ_MAT ='"+cMatCod+"' AND QDZ.QDZ_FILMAT ='"+cMatFil+"'"
	cQuery += " AND QDZ.D_E_L_E_T_ = ' ')))"		
	cQuery += " AND " + QA_FilSitF(.T., .T.) + " AND QAA.QAA_TPRCBT <> '4' AND QAA.D_E_L_E_T_ = ' '"
	cQuery += " AND QAA.QAA_FILIAL = '" + QAA->QAA_FILIAL + "' AND QAA.QAA_MAT = '"  +QAA->QAA_MAT+"'"
	cQuery += " AND QD1_FILMAT = '" + QAA->QAA_FILIAL + "' AND QD1.QD1_MAT = '"  +QAA->QAA_MAT+"'"
	cQuery += " AND QDH.QDH_FILIAL = QD1.QD1_FILIAL AND QDH.QDH_DOCTO = QD1.QD1_DOCTO"
	cQuery += " AND QDH.QDH_RV = QD1.QD1_RV"
	cQuery += " AND QDG.QDG_CODMAN = '" + Space(Len(QDC->QDC_CODMAN)) + "'"
	cQuery += " AND QDG.QDG_FILIAL = QD1.QD1_FILIAL AND QDG.QDG_DOCTO = QD1.QD1_DOCTO"
	cQuery += " AND QDG.QDG_RV = QD1.QD1_RV AND QDG.QDG_FILMAT = QD1.QD1_FILMAT"
	cQuery += " AND QDG.QDG_DEPTO = QD1.QD1_DEPTO AND QDG.QDG_MAT = QD1.QD1_MAT "
	cQuery += " ORDER BY " + SqlOrder(QD1->(IndexKey()))

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"QD1TMP", .F., .T.)		

	DbSelectArea("QD1TMP")
	aQD1List:= {}
	While QD1TMP->(!Eof())
		aAdd( aQD1List,{ " ",QD1TMP->QD1_DOCTO, QD1TMP->QD1_RV, QD1TMP->QDH_TITULO, QD1RECNO, QD1TMP->QD1_DEPTO })
		QD1TMP->(dbSkip())
	Enddo
	If Len(aQD1List) == 0
		aAdd( aQD1List,{ " ",	Space(Len(QD1TMP->QD1_DOCTO)),;
							Space(Len(QD1TMP->QD1_RV)),;
							Space(Len(QD1TMP->QDH_TITULO)),0,;
							Space(Len(QD1TMP->QD1_DEPTO)) })
	Endif
	dbCloseArea()
	RestArea(aArea)

	CursorArrow()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±± Funcao     FQD200QDGC, Autor: Newton R. Ghiraldelli, Data: 14/09/99
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±± Descricao  Carrega os Lactos de destinatarios para selecao/impressao
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Sintaxe    U_FQD200QDGC(aQDGList)
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Parametro  ExpA1 - Array onde sera armazenado os Lactos destinatarios
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Uso        QDOR200
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200QDGC(aQDGList)
Local cQAAQDH    := "QDH.QDH_FILDEP = '" + cMatFil+ "'
Local cQuery     := ""
Local oQLTQueryM := Nil

	If FindClass("QLTQueryManager") 
		oQLTQueryM := QLTQueryManager():New()
		cQAAQDH := oQLTQueryM:MontaQueryComparacaoFiliaisComValorReferencia("QAD", "QDH.QDH_FILDEP", "QAA", cMatFil)
	EndIf

	CursorWait()

	aArea := GetArea()
	cQuery:= " SELECT DISTINCT QDG.QDG_FILIAL, QDG.QDG_DOCTO, QDG.QDG_RV, QDG.QDG_CODMAN,"
	cQuery+= " QDG.QDG_FILMAT, QDG.QDG_DEPTO, QDG.QDG_TIPO, QDG.QDG_MAT, QDH.QDH_TITULO, QDG.R_E_C_N_O_ QDGRECNO"
	cQuery+= " FROM " + RetSqlName("QD1")+" QD1, "
	cQuery += RetSqlName("QDG")+" QDG, "
	cQuery += RetSqlName("QDH")+" QDH "
	cQuery += "WHERE QD1.QD1_SIT <> 'I' AND QD1.QD1_TPDIST <> '4' AND QD1.QD1_TPPEND = 'L  '"
	cQuery += " AND QD1.QD1_TPDIST <> '1' AND QD1.D_E_L_E_T_ = ' '"
	If cCpo == "N"
		cQuery += " AND QDG.QDG_TPRCBT <> '1'"
	Endif
	cQuery += " AND QDG.QDG_FILIAL = '" + xFilial("QDG") + "'"
	cQuery += " AND QDG.QDG_FILIAL = QD1.QD1_FILIAL"
	cQuery += " AND QDG.QDG_DOCTO = QD1.QD1_DOCTO AND QDG.QDG_RV = QD1.QD1_RV"
	cQuery += " AND QDG.QDG_DEPTO = QD1.QD1_DEPTO"
	cQuery += " AND QDG.QDG_RECEB = 'S' AND QDG.QDG_SIT <> 'I'  AND QDG.QDG_TPRCBT <> '4'"
	cQuery += " AND QDG.D_E_L_E_T_ = ' '"
	cQuery += " AND (QDG.QDG_CODMAN <> '" + Space(Len(QDC->QDC_CODMAN)) + "' AND QDG.QDG_CODMAN = '"+QDC->QDC_CODMAN+"')"
	cQuery += " AND QDH.QDH_FILIAL = QD1.QD1_FILIAL"
	cQuery += " AND QDH.QDH_DOCTO = QD1.QD1_DOCTO AND QDH.QDH_RV = QD1.QD1_RV"
	cQuery += " AND QDH.QDH_OBSOL = 'N' AND QDH.QDH_CANCEL <> 'S' AND QDH.QDH_STATUS = 'L  '"
	cQuery += " AND QDH.QDH_DTOIE <> 'E' AND QDH.D_E_L_E_T_ = ' '"
	cQuery += " AND ((" + cQAAQDH + " AND QDH.QDH_DEPTOD = '"+cMatDep+"')"
	cQuery += " OR (EXISTS(SELECT R_E_C_N_O_ FROM "+RetSqlName("QDZ")+" QDZ WHERE QDH.QDH_FILIAL = QDZ.QDZ_FILIAL AND QDH.QDH_DOCTO = QDZ.QDZ_DOCTO"
	cQuery += " AND QDH.QDH_RV = QDZ.QDZ_RV AND QDZ.QDZ_DEPTO ='"+cMatDep+"'" 
	cQuery += " AND QDZ.QDZ_MAT ='"+cMatCod+"' AND QDZ.QDZ_FILMAT ='"+cMatFil+"'"
	cQuery += " AND QDZ.D_E_L_E_T_ = ' ')))"
	cQuery += " ORDER BY " + SqlOrder(QDG->(IndexKey()))
			
	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"QDGTMP", .F., .T.)

	DbSelectArea("QDGTMP")
	aQDGList:= {}
	While QDGTMP->(!Eof())
		aAdd( aQDGList,{ " ",QDGTMP->QDG_DOCTO, QDGTMP->QDG_RV, QDGTMP->QDH_TITULO ,QDGTMP->QDGRECNO,QDGTMP->QDG_FILIAL+QDGTMP->QDG_DOCTO+QDGTMP->QDG_RV+'P',QDGTMP->QDG_DEPTO })
		QDGTMP->(dbSkip())
	Enddo
	If Len(aQDGList) == 0
		aAdd( aQDGList,{ " ",	Space(Len(QDGTMP->QDG_DOCTO)),;
							Space(Len(QDGTMP->QDG_RV)),;
							Space(Len(QDGTMP->QDH_TITULO)),0," ",;
							Space(Len(QDGTMP->QDG_DEPTO)) })
	Endif
	dbCloseArea()
	RestArea(aArea)

	CursorArrow()
Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±± Funcao     FQD200QDJ2,  Autor: Newton R. Ghiraldelli, Data: 14/09/99
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±± Descricao  Carrega os Lactos de Departamentos para selecao/impressao
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Sintaxe    U_FQD200QDJ2(aQDJ2List)
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Parametros ExpA1 - Array onde sera armazenado os Lactos de Deptos
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±± Uso        QDOR200
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function FQD200QDJ2(aQDJ2List)
Local aArea      := {}
Local cQAAQDH    := "QDH.QDH_FILDEP = '" + cMatFil+ "'
Local cQuery     := ""
Local oQLTQueryM := Nil

	If FindClass("QLTQueryManager") 
		oQLTQueryM := QLTQueryManager():New()
		cQAAQDH := oQLTQueryM:MontaQueryComparacaoFiliaisComValorReferencia("QAD", "QDH.QDH_FILDEP", "QAA", cMatFil)
	EndIf

	CursorWait()

	aArea  := GetArea()
	cQuery := " SELECT DISTINCT QDG.QDG_FILIAL, QDG.QDG_DOCTO, QDG.QDG_RV, QDG.QDG_CODMAN,"
	cQuery += " QDG.QDG_FILMAT, QDG.QDG_DEPTO, QDG.QDG_TIPO, QDG.QDG_MAT, QDH.QDH_TITULO, QDG.R_E_C_N_O_ QDJRECNO"
	cQuery += " FROM " + RetSqlName("QD1")+" QD1, "
	cQuery += RetSqlName("QDG")+" QDG, "
	cQuery += RetSqlName("QDH")+" QDH "
	cQuery += "WHERE QD1.QD1_SIT <> 'I' AND QD1.QD1_TPDIST <> '4' AND QD1.QD1_TPPEND = 'L  '"
	If FWModeAccess("QAD")=="C" //Empty(xFilial("QAD"))
		cQuery += " AND QD1.QD1_DEPTO = '"+QAD->QAD_CUSTO+"'"
	Else
		cQuery += " AND QD1.QD1_FILMAT = '"+QAD->QAD_FILIAL+"' AND QD1.QD1_DEPTO = '"+QAD->QAD_CUSTO+"'"
	Endif
	cQuery += " AND QD1.D_E_L_E_T_ = ' '"
	If cCpo == "N"
		cQuery += " AND QD1.QD1_TPDIST <> '1'"
		cQuery += " AND QDG.QDG_TPRCBT <> '1'"
	Endif
	cQuery += " AND QDG.QDG_RECEB = 'S' AND QDG.QDG_SIT <> 'I'  AND QDG.QDG_TPRCBT <> '4'"
	cQuery += " AND QDG.D_E_L_E_T_ = ' '"
	If FWModeAccess("QAD")=="C" //Empty(xFilial("QAD"))
		cQuery += " AND QDG.QDG_DEPTO = '"+QAD->QAD_CUSTO+"'"
	Else
		cQuery += " AND QDG.QDG_FILMAT = '"+QAD->QAD_FILIAL+"' AND QDG.QDG_DEPTO = '"+QAD->QAD_CUSTO+"'"
	Endif
	cQuery += " AND QDH.QDH_OBSOL = 'N' AND QDH.QDH_CANCEL <> 'S' AND QDH.QDH_STATUS = 'L  '"
	cQuery += " AND QDH.QDH_DTOIE <> 'E' AND QDH.D_E_L_E_T_ = ' '"
	cQuery += " AND QDG.QDG_FILIAL = '" + xFilial("QDG") + "'"
	cQuery += " AND QDG.QDG_FILIAL = QD1.QD1_FILIAL"
	cQuery += " AND QDG.QDG_DOCTO = QD1.QD1_DOCTO AND QDG.QDG_RV = QD1.QD1_RV"
	cQuery += " AND QDH.QDH_FILIAL = QD1.QD1_FILIAL"
	cQuery += " AND QDH.QDH_DOCTO = QD1.QD1_DOCTO AND QDH.QDH_RV = QD1.QD1_RV"
	cQuery += " AND ((" + cQAAQDH + " AND QDH.QDH_DEPTOD = '"+cMatDep+"')"
	cQuery += " OR (EXISTS(SELECT R_E_C_N_O_ FROM "+RetSqlName("QDZ")+" QDZ WHERE QDH.QDH_FILIAL = QDZ.QDZ_FILIAL AND QDH.QDH_DOCTO = QDZ.QDZ_DOCTO"
	cQuery += " AND QDH.QDH_RV = QDZ.QDZ_RV AND QDZ.QDZ_DEPTO ='"+cMatDep+"'" 
	cQuery += " AND QDZ.QDZ_MAT ='"+cMatCod+"' AND QDZ.QDZ_FILMAT ='"+cMatFil+"'"
	cQuery += " AND QDZ.D_E_L_E_T_ = ' ')))"			
	cQuery += " ORDER BY " +  SqlOrder(QDG->(IndexKey()))

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"QDJTMP", .F., .T.)

	DbSelectArea("QDJTMP")
	QDJTMP->(DbGotop())
	aQDJ2List:= {}
	cOldDoc:=""
	While QDJTMP->(!Eof())
		IF cOldDoc <> QDJTMP->QDG_FILIAL+QDJTMP->QDG_DOCTO+QDJTMP->QDG_RV
			aAdd( aQDJ2List,{ " ",QDJTMP->QDG_DOCTO, QDJTMP->QDG_RV, QDJTMP->QDH_TITULO ,QDJTMP->QDJRECNO })
			cOldDoc := QDJTMP->QDG_FILIAL+QDJTMP->QDG_DOCTO+QDJTMP->QDG_RV            
		Endif
		QDJTMP->(dbSkip())
	Enddo
	If Len(aQDJ2List) == 0
		aAdd( aQDJ2List,{ " ",	Space(Len(QDJTMP->QDG_DOCTO)),;
							Space(Len(QDJTMP->QDG_RV)),;
							Space(Len(QDJTMP->QDH_TITULO)),0 })
	Endif
	dbCloseArea()
	RestArea(aArea)

	CursorArrow()

Return

/*ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡ao    ³ QDR200Pesq ³ Autor ³ Eduardo de Souza     ³ Data ³ 02/08/02³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Pesquisa Documentos/Usuarios/Pastas/Departamentos.         ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe   ³ U_QDR200Pesq()                                               ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³                                                            ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Uso       ³QDOR200                                                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß*/
User Function QDR200Pesq(aQD1List,aQDGList,aQDJ2List)

Local nReg:= 0
Local nOrd:= 0

	If oEmissao:nOption == 1
	nOrd:= QDH->(IndexOrd())
	DbSelectArea("QDH")
	AxPesqui()
	nReg:= Ascan(aQDH,{|x| x[5]==QDH->(Recno())})
		If nReg <> 0 .AND. aQDH[oQDH:nAt,5] <> QDH->(Recno())
		oQDH:nAt:=nReg
		Eval(oQDH:bCHANGE)
		oQDH:UpStable()
		oQDH:Refresh()
		oQDH:SetFocus(.t.)
		EndIf
	QDH->(DbSetOrder(nOrd))	
	ElseIf oEmissao:nOption == 2
	nReg:= QAA->(Recno())
	nOrd:= QAA->(IndexOrd())
	DbSelectArea("QAA")
	U_Qa_PesquiF()
		If nReg <> QAA->(Recno())
		MsgRun(OemToAnsi(STR0054),OemToAnsi(STR0053), {|| U_FQD200QD1C(@aQD1List,aQD1) }) //"Selecionando Registros" ### "Aguarde..."	
		Else
		QAA->(DbSetOrder(nOrd))
		EndIf

	ElseIf oEmissao:nOption == 3
	nReg:= QDC->(Recno())
	nOrd:= QDC->(IndexOrd())
	DbSelectArea("QDC")
	U_Qa_PesquiF()
		If nReg <> QDC->(Recno())
		MsgRun(OemToAnsi(STR0054),OemToAnsi(STR0053), {|| U_FQD200QDGC(@aQDGList) }) //"Selecionando Registros" ### "Aguarde..."	
		Else
		QDC->(DbSetOrder(nOrd))
		EndIf

	ElseIf oEmissao:nOption == 4
   	nReg:= QAD->(Recno())
	nOrd:= QAD->(IndexOrd())
	DbSelectArea("QAD")
	U_Qa_PesquiF()
		If nReg <> QAD->(Recno())
		MsgRun(OemToAnsi(STR0054),OemToAnsi(STR0053), {|| U_FQD200QDJ2(@aQDJ2List) }) //"Selecionando Registros" ### "Aguarde..."	
		Else
		QAD->(DbSetOrder(nOrd))
		EndIf
	EndIf

Return

#DEFINE PESQ_SAY  10
#DEFINE PESQ_GET  70
#DEFINE PESQ_TOP  5
#DEFINE PESQ_SKIP 15

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡…o	 ³Qa_PesquiF³ Autor ³ Wagner Mobile Costa   ³ Data ³11.03.2003³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡…o ³ Pesquisas genericas por Filial							  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Sintaxe e ³ U_Qa_PesquiF()												  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³Parametros³ 															  ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄ´±±
±±³ Uso		 ³ Generico 												  ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
/*/
User Function Qa_PesquiF()
Local oDlg, oCbx, cOrd, oBigGet
Local cAlias, ni
Local nMaiorStr, cCpofil, dCampo
Local cIndice, nReg
Local cFil    := ""
Local nOrd    := 1
Local lSeek   := .F.
Local nChave  := 1
Local aLista  := {}
Local bSav12  := SetKey(VK_F12)
Local cCampo  := Space(40)

Local lDetail := .F.
Local lUseDetail := .F.
Local aAllLista
Local oDetail
Local aTemp		:= {}
Local aMyOrd	:= {}
Local aScroll	:= {}
Local lTabComp	:= .F.
Local aConteudo := {}

Private aOrd     := {}
Private aPesqVar := {}

	/*/
	aLista
	[1] := F3
	[2] := tipo
	[3] := tamanho
	[4] := decimais
	[5] := titulo
	/*/
	IF !IsInCallStack("QDOA080")
		If FWModeAccess()=="C" //Empty(xFilial())		// Caso seja compartilhada chama consulta padrao
			AxPesqui()
			Return .T.
		Endif
	Endif

	SetKey(VK_F12,{|| NIL})

	cAlias := Alias()
	DbSelectArea(cAlias)
	cCpofil  := PrefixoCpo(cAlias)+"_FILIAL"
	lTabComp := FWModeAccess()=="C" //Empty(xFilial())
	nOrd 	 := 1
	nMaiorStr := 0
	If !(cAlias $ "SX6/SX9/SX7")
		PesqOrd(cAlias,@aMyOrd)
	
		If ( ValType(aMyOrd[1]) != 'A' )
	
			aTemp	:= AClone(aMyOrd)
			aMyOrd	:= {}
		
			For nI := 1 To Len(aTemp)
				Aadd( aMyOrd, { nI, lTabComp } )	
			Next
		Else
			For nI := 1 To Len(aMyOrd)
				aMyOrd[nI][2] := lTabComp
			Next
		EndIf
	
		lUseDetail := .T.
	ElseIf cAlias == "SX7"
		cIndice	:= OemToAnsi(STR0059) // " Campo+Sequencia"
		nMaiorStr := Len(cIndice)
		Aadd(aOrd," "+cIndice)
		AADD(aMyOrd, { 1, .T. } )
		lUseDetail := .F.
	ElseIf cAlias == "SX6"
		cIndice	:= OemToAnsi(STR0060) // " Filial+Parametro"
		nMaiorStr := Len(cIndice)
		Aadd(aOrd," "+cIndice)
		AADD(aMyOrd, { 1, .T. } )
		lUseDetail := .F.
	Else
		cIndice	 := OemToAnsi(STR0061) //" Dominio+C.Dominio"
		nMaiorStr := Len(cIndice)
		Aadd(aOrd," "+cIndice)
		AADD(aMyOrd, { 1, .T. } )	
		lUseDetail := .F.
	EndIf

	cOrd := aOrd[1]
	cCampo:=SPACE(40)
	For nI := 1 To Len(aOrd)
		If cCpofil $ IndexKey(nI) .And. ! aMyOrd[nI][2]
			aOrd[nI] := OemToAnsi(AllTrim(RetTitle(cCpoFil)) + " +" + aOrd[nI])
		Else
			aOrd[nI] := OemToAnsi(AllTrim(aOrd[nI]))
		Endif
	Next

	If IndexOrd() > Len(aOrd)
		cOrd := 1 //aOrd[Len(aOrd)]
		nOrd := 1 //Len(aOrd)
	ElseIf IndexOrd() <= 1
		cOrd := aOrd[1]
		nOrd := 1
	Else
		cOrd := aOrd[IndexOrd()]
		nOrd := IndexOrd()
	EndIf

	DEFINE MSDIALOG oDlg FROM 00,00 TO 100,490 PIXEL TITLE OemToAnsi(STR0062) //"Pesquisa"

	@05,05 COMBOBOX oCBX VAR cOrd ITEMS aOrd SIZE 206,36 PIXEL OF oDlg

	@22,05 MSGET oBigGet VAR cCampo SIZE 206,10 PIXEL

	DEFINE SBUTTON FROM 05,215 TYPE 1 OF oDlg ENABLE ACTION (lSeek := .T.,oDlg:End())
	DEFINE SBUTTON FROM 20,215 TYPE 2 OF oDlg ENABLE ACTION oDlg:End()

	If ( lUseDetail )
		DEFINE SBUTTON oDetail FROM 35,215 TYPE 5 OF oDlg ENABLE ONSTOP STR0063 ACTION (lDetail := PesqDetail(lDetail,@oDlg,@aScroll,@oBigGet,nOrd))	//"Detalhes"
		
		oCbx:bChange := {|| PesqChange(@nOrd,oCbx:nAt,@aLista,cAlias,@aAllLista,@aScroll,@lDetail,@oDetail,@oDlg,@oBigGet)}
		aAllLista := PesqList(cAlias,@aScroll)	
		aLista := Aclone(aAllLista[nOrd])
	Else
		oCbx:bChange := {|| nOrd := oCbx:nAt}
	EndIf

	ACTIVATE MSDIALOG oDlg CENTERED

	IF !IsInCallStack("QDOA080")
		If ( lSeek )
			If ( lDetail )
				cCampo := ""
				For nI := 1 To Len(aPesqVar[nOrd])
					If ( aLista[nI][2] == "C" .And. (Len(cCampo) <> aLista[nI][3]) )
						cCampo += Subs(aPesqVar[nOrd][nI],1,aLista[nI][3])
					ElseIf ( aLista[nI][2] == "D" )
						cCampo += Dtos(aPesqVar[nOrd][nI])
					ElseIf ( aLista[nI][2] == "N" )
						cCampo += Str(aPesqVar[nOrd][nI],aLista[nI][3],aLista[nI][4])
					Else
						cCampo += aPesqVar[nOrd][nI]
					EndIf
				Next
			EndIf
			cCampo := Trim(cCampo)
			nReg := Recno()
			SET SOFTSEEK ON
			DbSetOrder(aMyOrd[nOrd, 1])
			If cCpofil $ IndexKey()  //Procura pela filial
				cFil := cFilial
				nChave := 11
			EndIf
		
			If !lDetail .and. (("DTOS" $ Upper(IndexKey(nOrd))) .Or. ("DTOC" $ Upper(IndexKey(nOrd)))) .And. cAlias != "SM2"
				cCampo := ConvData(IndexKey(nOrd),cCampo)
			EndIf
		
			If Subs(cAlias,1,3) == "SM2"
				dCampo:=Ctod(AllTrim(cCampo))
				DbSeek(dCampo)

			ElseIf !(cCpofil $ IndexKey()) .or. !aMyOrd[nOrd, 2]
				DbSeek(cCampo)

			Else
				DbSeek(cFilial+cCampo)
				If Subs(&(IndexKey()),1,2) != cFilial	 // IR Para EOF
					DbSeek(chr(255))
				EndIf
			EndIf
		
			If Eof()
				DbGoTo(nReg)
				Help(" ",1,"PESQ01")
			EndIf
			SET SOFTSEEK OFF
			lRefresh := .t.
			SetKey(VK_F12,bSav12)
		Else
			SetKey(VK_F12,bSav12)
			Return 0
		EndIf
	Else		
		If Empty(cCampo)
			cCampo := ""
			For nI := 1 To Len(aPesqVar[nOrd])
				If ( aLista[nI][2] == "C" .And. (Len(cCampo) <> aLista[nI][3]) )
					If Empty(cCampo)
						cCampo += AllTrim(Subs(aPesqVar[nOrd][nI],1,aLista[nI][3])+"-")
					Else
						cCampo += Subs(aPesqVar[nOrd][nI],1,aLista[nI][3])
					Endif
				ElseIf ( aLista[nI][2] == "D" )
					If Empty(cCampo)
						cCampo += AllTrim(Dtos(aPesqVar[nOrd][nI])+"-")
					Else		
						cCampo += Dtos(aPesqVar[nOrd][nI])
					Endif

				ElseIf ( aLista[nI][2] == "N" )
					If Empty(cCampo)
						cCampo += AllTrim(Str(aPesqVar[nOrd][nI],aLista[nI][3],aLista[nI][4])+"-")
					Else
						cCampo += Str(aPesqVar[nOrd][nI],aLista[nI][3],aLista[nI][4])
					Endif
				Else
					If Empty(cCampo)
						cCampo += AllTrim(aPesqVar[nOrd][nI]+"-")
					Else
						cCampo += aPesqVar[nOrd][nI]
					EndIf
				EndIf
			Next	
		Endif

		Aadd(aConteudo,{cCampo,nOrd,aLista})

		Return aConteudo    
	Endif

Return 1                                                                                                                                                                                

Static Function PesqChange(nOrd,nAt,aLista,cAlias,aAllLista,aScroll,lDetail,oDetail,oDlg,oBigGet)

	If nOrd <> nAt .and. aAllLista <> NIL
	aLista := Aclone(aAllLista[nAt])	
	aScroll[nOrd]:Hide()

		If Empty(aLista)
			lDetail := .T.
			lDetail := PesqDetail(lDetail,@oDlg,@oScroll,@oBigGet)
			oDetail:Disable()
		Else
		oDetail:Enable()
		EndIf
	
		If lDetail
		aScroll[nAt]:Show()
		EndIf
	nOrd := nAt
	EndIf
Return NIL

Static Function PesqInit(aLista,oFather,nAtu)
Local aItems  := {STR0079, STR0080}
Local bGet    := {||}
Local cPict   := ""
Local cVar    := ""
Local i       := 1
Local nRadio  := 1
Local nTop    := 0
Local nWidth  := 0
Local oGet    := Nil
Local oRadio  := Nil
Local oSay    := Nil

	If nAtu > 0
		aPesqVar[nAtu] := Array(Len(aLista))
		For i := 1 To Len(aLista)
			nTop := PESQ_TOP+((i-1)*PESQ_SKIP)
			cVar := "aPesqVar["+StrZero(nAtu, 2)+"]["+StrZero(i, 2)+"]"
			cGet  := "{ | u | If( PCount() == 0, "+cVar+","+cVar+" := u)}"
			If ( aLista[i][2] == "D" )
				cPict := "@D"
				aPesqVar[nAtu][i] := Ctod("")
				nWidth := 40
			Else
				If aLista[i][2] == "C"
					aPesqVar[nAtu][i] := Space(aLista[i][3])
				ElseIf Alltrim(Upper(aLista[i][7])) $ "QAA_NOME,QAC_DESC"
					aPesqVar[nAtu][i] := nRadio
				ElseIf aLista[i][2] == "N"
					aPesqVar[nAtu][i] := 0
				EndIf
				cPict := If(Empty(aLista[i][6]),NIL,AllTrim(aLista[i][6]))
				nWidth := CalcFieldSize(aLista[i][2],aLista[i][3],0,," ")
			EndIf
		
			If '"'$aLista[i][5]
				bGet := &("{|| '"+OemToAnsi(aLista [i][5])+"'}")
			Else
				bGet := &('{|| "'+OemToAnsi(aLista [i][5])+'"}')
			EndIf
	
			oSay := TSay():New(nTop, 10, bGet,oFather,,, .F., .F., .F., .T.,,, (Len(Trim(aLista [i][5]))*8), 15, .F., .F., .F., .F., .F. )
			nWidth += 10
			nWidth := Iif(nWidth > 130,130,nWidth)
			If ( Empty(aLista[i][1]) )
				oGet := TGet():New(nTop, 70, MontaBlock(cGet),oFather,nWidth,10,cPict,,,,,.F.,, .T.,, .F.,, .F., .F.,, .F., .F.,,cVar,,,,.T.)
			ElseIf Alltrim(Upper(aLista[i][7])) $ "QAA_NOME,QAC_DESC"
				oRadio 	:= TRadMenu():New (nTop,70,aItems,MontaBlock(cGet),oFather,,,,,,,,100,10,,,,.T.,.T.)
			Else
				oGet := TGet():New(nTop, 70, MontaBlock(cGet),oFather,nWidth,10,cPict,,,,,.F.,, .T.,, .F.,, .F., .F.,, .F., .F.,aLista[i][1],cVar,,,,.T.)
			EndIf
		Next
	EndIf
Return

Static Function PesqList(cAlias,aScroll)
Local aKey     := {}
Local aReturn  := {}, nI := 1
Local cChave   := ""
Local cF3      := ""
Local cSvAlias := Alias()
Local nAt1     := 0
Local nJ       := 1
Local nPos     := 0

	DbSelectArea("SIX")
	If SIX->(DbSeek(cAlias))
		While SIX->(!Eof()) .And. SIX->INDICE == cAlias

			If ( SIX->SHOWPESQ == 'N' )
				SIX->(DbSkip())
				Loop				
			EndIf

			nPos++
			Aadd(aReturn,{})
			Aadd(aPesqVar,{})
			Aadd(aScroll,NIL)
			@22,05 SCROLLBOX aScroll[nPos] VERTICAL SIZE 84,205 BORDER
			aScroll[nPos]:Hide()

			nI 	:= 0
			aKey:= StrTokArr( Upper(SIX->CHAVE), '+' )
			nAt1:= 1
		
			For nJ := 1 To Len( aKey )
			
				cChave := AllTrim(aKey [nJ])
				If ( '(' $ cChave )
					nAt1 := At('(', cChave )
					While ( nAt1 > 0 )
						cChave	:= Subs( cChave, nAt1 + 1 )
						nAt1	:= At('(', cChave )					
					End
					nAt1 := At(',', cChave )
					If ( nAt1 > 0 )
						cChave := Subs( cChave, 1, nAt1 - 1 )
					EndIf
					nAt1 := At(')', cChave )
					If ( nAt1 > 0 )
						cChave := Subs( cChave, 1, nAt1 - 1 )
					EndIf
				EndIf
				If ( '->' $ cChave )
					cChave := Subs(cChave,At('->',cChave)+2)
				EndIf
				cF3 := ""
				If !( 'FILIAL' $ cChave)
					nI++
					cF3 := PesqF3(SIX->F3,nI)
				Else
					cF3 := "SM0"
				Endif
				If !Empty(cChave)
					Aadd(aReturn[nPos],{cF3, GetSx3Cache(cChave, "X3_TIPO"), GetSx3Cache(cChave, "X3_TAMANHO"), GetSx3Cache(cChave, "X3_DECIMAL"), QAGetX3Tit(cChave), GetSx3Cache(cChave, "X3_PICTURE"),""})
				Else
					Aadd(aReturn[nPos],{})
				EndIf
				If Alltrim(Upper(cChave)) $ "QAA_NOME,QAC_DESC" 
					Aadd(aReturn[nPos],{"TipoOrdem","N",1,0,"","@9",cChave})
				EndIf
			Next
			PesqInit(aReturn[nPos],@aScroll[nPos],nPos)
			SIX->(DbSkip())

		End
	EndIf

	DbSelectArea(cSvAlias)
Return aReturn

Static Function PesqF3(cString,nPos)
Local cReturn := ""
Local i := 0, nAt

	If !Empty(cString)
		While ( i <= nPos )
		i++
		nAt := At("+",cString)
			If ( nAt == 0 )
			cReturn := Trim(cString)
			cString := ""
			Else
			cReturn := Trim(Subs(cString,1,nAt-1))
			cString := Subs(cString,nAt+1)
			EndIf
		
			If i == nPos
				If cReturn == "XXX"
				cReturn := ""
				EndIf
			Exit
			EndIf
		End
	EndIf
Return cReturn

Static Function PesqDetail(lDetail,oDlg,aScroll,oBigGet,nOrd)

oDlg:CoorsUpdate()
lDetail := !lDetail
	If ( lDetail )
	oBigGet:Hide()
	aScroll[nOrd]:Show()
	oDlg:Move(oDlg:nTop,oDlg:nLeft,498,250)
	Else
	aScroll[nOrd]:Hide()
	oBigGet:Show()
	oDlg:Move(oDlg:nTop,oDlg:nLeft,498,127)
	EndIf
Return lDetail



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÉÍÍÍÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÑÍÍÍÍÍÍÍÍÍÍÍÍÍ»±±
±± Programa QDR200Fit,	 Autor: Telso Carneiro, 	Data: 18/01/06
±±ÌÍÍÍÍÍÍÍÍÍÍØÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍ¹±±
±± Desc.    Filtra os arquivos com as Condicoes Correspondentes:
±±          QD1(Distribuicao) nao pode ser desativado(QDG_SIT) e so
±±          pendencia de Leitura
±±          QAA(Usuarios) Nao considerar demitidos e copia Nao recebe
±±          QDG(Destinatarios) nao pode ser desativado(QDG_SIT)
±±          QDH(Documentos) nao pode estar obsoleto e/ou cancelado
±±          e com documento que o usuario logado foi o distribuidor
±±ÈÍÍÍÍÍÍÍÍÍÍÏÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function QDR200Fit()

Local cFiltroQAA := ""
Local cFiltroQD1 := ""
Local cFiltroQDC := ""
Local cFiltroQDG := ""
Local cFiltroQDH := ""
Local cKey       := ""
Local cQAAQDH    := "QDH.QDH_FILDEP = '" + cMatFil+ "'
Local cQuery     := ""
Local oQLTQueryM := Nil

	If FindClass("QLTQueryManager") 
		oQLTQueryM := QLTQueryManager():New()
		cQAAQDH := oQLTQueryM:MontaQueryComparacaoFiliaisComValorReferencia("QAD", "QDH.QDH_FILDEP", "QAA", cMatFil)
	EndIf

	DbSelectArea("QD1")
	DbSetOrder(1)
	cFiltroQD1 := 'QD1->QD1_SIT <> "I" .And. QD1->QD1_TPDIST <> "4" .And. QD1->QD1_TPPEND == "L  "'
	If cCpo == "N"
		cFiltroQD1 += ' .And. QD1->QD1_TPDIST <> "1"'
	Endif
	Set Filter to &(cFiltroQD1)
	DbSeek(xFilial("QD1"))

	DbSelectArea("QDG")
	DbSetOrder(1)
	cFiltroQDG := 'QDG->QDG_RECEB == "S" .And. QDG->QDG_SIT <> "I"  .And. QDG->QDG_TPRCBT <> "4"'
	If cCpo == "N"
		cFiltroQDG += ' .And. QDG->QDG_TPRCBT <> "1"'
	Endif
	Set Filter to &(cFiltroQDG)
	DbSeek(xFilial("QDG"))

	cIndex1:= CriaTrab(Nil,.F.)
	cKey   := QDH->(IndexKey())
	cFiltroQDH := 'QDH->QDH_FILIAL == "'+xFilial("QDH")+'" .And. QDH->QDH_OBSOL == "N" .And. QDH->QDH_CANCEL <> "S" .And. QDH->QDH_STATUS == "L  " .And. QDH->QDH_DTOIE <> "E"'
	IndRegua("QDH",cIndex1,cKey,,cFiltroQDH,OemToAnsi(STR0054))	//"Selecionando Registros.."

	cQuery := " SELECT DISTINCT QDH.QDH_FILIAL, QDH.QDH_DOCTO, QDH.QDH_RV, QDH.QDH_TITULO, QDH.R_E_C_N_O_ QDHRECNO "
	cQuery += " FROM " + RetSqlName("QDH")+" QDH "
	cQuery += " WHERE QDH.QDH_OBSOL = 'N' AND QDH.QDH_CANCEL <> 'S' AND QDH.QDH_STATUS = 'L  '"
	cQuery += " AND QDH.QDH_DTOIE <> 'E' AND QDH.D_E_L_E_T_ = ' '"
	cQuery += " AND ((" + cQAAQDH + " AND QDH.QDH_DEPTOD ='"+cMatDep+"')"
	cQuery += " OR (EXISTS(SELECT R_E_C_N_O_ FROM "+RetSqlName("QDZ")+" QDZ WHERE QDH.QDH_FILIAL = QDZ.QDZ_FILIAL AND QDH.QDH_DOCTO = QDZ.QDZ_DOCTO"
	cQuery += " AND QDH.QDH_RV = QDZ.QDZ_RV AND QDZ.QDZ_DEPTO ='"+cMatDep+"'"
	cQuery += " AND QDZ.QDZ_MAT ='"+cMatCod+"' AND QDZ.QDZ_FILMAT ='"+cMatFil+"'"
	cQuery += " AND QDZ.D_E_L_E_T_ = ' ')))"
	cQuery += " ORDER BY " + SqlOrder(QDH->(IndexKey()))

	cQuery := ChangeQuery(cQuery)

	dbUseArea(.T., "TOPCONN", TCGenQry(,,cQuery),"QDHTMP", .F., .T.)

	DbSelectArea("QDHTMP")
	QDHTMP->(DbGotop())
	aQDH:= {}
	While QDHTMP->(!Eof())
		aAdd( aQDH,{ QDHTMP->QDH_FILIAL, QDHTMP->QDH_DOCTO, QDHTMP->QDH_RV, QDHTMP->QDH_TITULO, QDHTMP->QDHRECNO})
		QDHTMP->(dbSkip())
	Enddo
	dbCloseArea()

	DbSelectArea("QAA")
	DbSetOrder(3)
	cFiltroQAA := QA_FilSitF() + ' .And. QAA->QAA_TPRCBT <> "4"'
	Set Filter to &(cFiltroQAA)
	DbSeek(xFilial("QAA"))

	DbSelectArea("QDC")
	DbSetOrder(1)
	cFiltroQDC := 'QDC->QDC_STATUS <> "2"' // INATIVAS
	Set Filter to &(cFiltroQDC)
	DbSeek(xFilial("QDC"))

Return(Nil)

