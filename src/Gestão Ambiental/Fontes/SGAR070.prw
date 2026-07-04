/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "sgar070.ch"
#include "Protheus.ch"
#include "ap5mail.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} SGAR070
Inventario Nacional de Residuos Solidos Industriais.

@author  Thiago Olis Machado
@since   10/02/2005

@return  Lógico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function SGAR070()

	Local aNGBEGINPRM := NGBEGINPRM()

	Private cStartPath := AllTrim(GetSrvProfString("Startpath",""))
	Private oPrintRes
	Private nPaginaRes := 1
	Private cPerg    := PadR( "SGR070" , 10 )

	Private aUsuario  := "", cTitulo, oDlgMail, cDiretorio:="", x:=1, cBody:=""
	Private cServer   := AllTrim( GetMV( "MV_RELSERV" , , " " ) )
	Private cAccount  := AllTrim( GetMV( "MV_RELACNT" , , " " ) )
	Private cPassword := AllTrim( GetMV( "MV_RELPSW"  , , " " ) )
	Private cUserAut  := AllTrim( GetMV( "MV_RELAUSR" , , cAccount ) )//Usuário para Autenticação no Servidor de Email
	Private cPassAut  := AllTrim( GetMV( "MV_RELAPSW" , , cPassword ) )//Senha para Autenticação no Servidor de Email
	Private lSmtpAuth := GetMv( "MV_RELAUTH" , , .F. )
	Private cFrom     := cAccount
	Private cAnexos   := ""
	Private cTo       := space(200)
	Private cCC       := space(200)
	Private cSubject  := space(250)
	Private lOk       := .T.
	Private lAutOk    := .F.
	Private aFiles    := {} // Array que irá conter todas as páginas geradas

	nProcessa := 1
	If pergunte(cPerg,.T.)
		If mv_par04 == 3
			nProcessa := U_ResConfMail()
		EndIf
		If nProcessa == 1
			Processa({|lEnd| U_SgR070Imp()}) // MONTE TELA PARA ACOMPANHAMENTO DO PROCESSO.
		EndIf
	Endif

	NGRETURNPRM(aNGBEGINPRM)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SGR070IMP
Inventario Nacional de Residuos Solidos Industriais.

@author  Thiago Olis Machado
@since   10/02/2005
/*/
//-------------------------------------------------------------------
User Function SgR070Imp()
	Local mPri := 0, pAnu := 0, nRes := 0, nTrat := 0, nDest := 0, nCDes := 0, nReAn := 0, nEta := 0, nCoor := 0
	Local cSMCOD := If(FindFunction("FWGrpCompany"),FWGrpCompany(),SM0->M0_CODIGO)
	Local cSMFIL := If(FindFunction("FWCodFil"),FWCodFil(),SM0->M0_CODFIL)
	Private lin := 0
	Private aContTec := {}, aCarAti := {}, aCarTrat := {}, aCarReAt := {}, aCarCDes := {}, aCarReAn := {}, aCoorDest := {}
	Private aCarEta := {}
	Private oFont06,oFont07,oFont08,oFont09,oFont09n,oFont08n,oFont10,oFont11,oFont12,oFont13,oFont14,oFont15,oFont10n
	Private vRetS := {}, lRetS := .F.

	vRetS := NGCADICBASE('TAF_ETAPA','A','TAF')
	lRetS := If(!vRetS[1],.F.,.T.)

	oFont06 := TFont():New("Courier New",06,06,,.F.,,,,.F.,.F.)
	oFont07 := TFont():New("Courier New",07,07,,.F.,,,,.F.,.F.)
	oFont08 := TFont():New("Courier New",08,08,,.F.,,,,.F.,.F.)
	oFont08n := TFont():New("Courier New",08,08,,.T.,,,,.F.,.F.)
	oFont09 := TFont():New("Courier New",09,09,,.F.,,,,.F.,.F.)
	oFont09n := TFont():New("Courier New",09,09,,.T.,,,,.F.,.F.)
	oFont10 := TFont():New("Courier New",10,10,,.F.,,,,.F.,.F.)
	oFont10n := TFont():New("Courier New",10,10,,.T.,,,,.F.,.F.)
	oFont11 := TFont():New("Courier New",11,11,,.F.,,,,.F.,.F.)
	oFont12 := TFont():New("Courier New",12,12,,.T.,,,,.T.,.T.)
	oFont13 := TFont():New("Courier New",13,13,,.T.,,,,.F.,.F.)
	oFont14 := TFont():New("Courier New",14,14,,.T.,,,,.F.,.F.)
	oFont15 := TFont():New("Courier New",15,15,,.T.,,,,.F.,.F.)

	oPrintRes	:= TMSPrinter():New(OemToAnsi(STR0008)) //"Inventario Nacional de Residuos"
	oPrintRes:SetPortrait()
	oPrintRes:Setup()

	lin := 100
	oPrintRes:StartPage()
	cLogo := cStartPath+"LGRL"+cSMCOD+cSMFIL+".BMP"
	If !File(cLogo)
		cLogo := cStartPath+"LGRL"+cSMCOD+".BMP"
	EndIf

	If File(cLogo)
		oPrintRes:SayBitMap(lin,1000,cLogo,295,145)
	Endif
	ProcRegua(11)//Quantidade de secoes
	lin := 180
	oPrintRes:Say(lin+100,100,STR0009,oFont13) //"INVENTÁRIO NACIONAL DE RESÍDUOS"
	oPrintRes:Line(lin,1600,lin,2350)
	oPrintRes:Line(lin,1600,lin+200,1600)
	oPrintRes:Line(lin,2350,lin+200,2350)

	oPrintRes:Say(lin+20,1690,STR0010,oFont13) //"Período de Referência"
	oPrintRes:Line(lin+100,1600,lin+100,2350)
	oPrintRes:Line(lin+100,1975,lin+200,1975)
	oPrintRes:Say(lin+105,1630,STR0011,oFont09n) //"Início"
	oPrintRes:Say(lin+155,1630,DtoC(Mv_Par01),oFont09)
	oPrintRes:Say(lin+105,2010,STR0012,oFont09n) //"Término"
	oPrintRes:Say(lin+155,2010,DtoC(Mv_Par02),oFont09)

	oPrintRes:Box(lin+200,50,lin+380,2350)


	// I - Primeira parte
	IncProc()
	DbSelectArea("SM0")
	DbSeek(mv_par05+Trim(mv_par06),.T.)

	oPrintRes:Say(lin+220,90,"I",oFont13)
	oPrintRes:Line(lin+200,150,lin+280,150)
	oPrintRes:Say(lin+220,160,STR0013,oFont13) //"INFORMAÇÕES GERAIS"
	oPrintRes:Line(lin+280,50,lin+280,2350)
	oPrintRes:Say(lin+285,60,STR0014,oFont09n) //"Razão Social"
	oPrintRes:Say(lin+330,60,SM0->M0_NOMECOM,oFont09)
	SomaLinha(380)

	IncProc()


	// II - Segunda parte
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,70,"II",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0015,oFont13) //"ENDEREÇO DA UNIDADE"
	Somalinha(80)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0016,oFont09n)  //"Logradouro/nº"
	oPrintRes:Say(lin+50,60,SM0->M0_ENDENT,oFont09)
	oPrintRes:Line(lin,1060,lin+100,1060)
	oPrintRes:Say(lin+5,1070,STR0017,oFont09n) //"Bairro/Distrito"
	oPrintRes:Say(lin+50,1070,SM0->M0_ENDENT,oFont09)
	oPrintRes:Line(lin,2010,lin+100,2010)
	oPrintRes:Say(lin+5,2020,STR0018,oFont09n)         //"CEP"
	oPrintRes:Say(lin+50,2020,SM0->M0_CEPENT,oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0019,oFont09n)       //"Município"
	oPrintRes:Say(lin+50,60,SM0->M0_CIDENT,oFont09)
	oPrintRes:Line(lin,1060,lin+100,1060)
	oPrintRes:Say(lin+5,1070,STR0020,oFont09n) //"Telefone"
	oPrintRes:Say(lin+50,1070,SM0->M0_TEL,oFont09)
	oPrintRes:Line(lin,1590,lin+100,1590)
	oPrintRes:Say(lin+5,1600,STR0021,oFont09n) //"CGC/TE"
	oPrintRes:Line(lin,2010,lin+100,2010)
	oPrintRes:Say(lin+5,2020,STR0022,oFont09n) //"CNPJ"

	If SM0->M0_TPINSC == 2
		oPrintRes:Say(lin+50,1600,Transform(SM0->M0_CGC,"@R 99999999/9999-99"),oFont09)
	Else
		oPrintRes:Say(lin+50,1600,Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"),oFont09)
	Endif

	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)

	IncProc()


	// III - Terceira parte
	SomaLinha(100)
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,60,"III",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0023,oFont13) //"ENDEREÇO PARA CORRESPONDÊNCIA"
	Somalinha(80)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0016,oFont09n)  //"Logradouro/nº"
	oPrintRes:Say(lin+50,60,SM0->M0_ENDCOB,oFont09)
	oPrintRes:Line(lin,1060,lin+100,1060)
	oPrintRes:Say(lin+5,1070,STR0017,oFont09n) //"Bairro/Distrito"
	oPrintRes:Say(lin+50,1070,SM0->M0_ENDCOB,oFont09)
	oPrintRes:Line(lin,2010,lin+100,2010)
	oPrintRes:Say(lin+5,2020,STR0018,oFont09n)         //"CEP"
	oPrintRes:Say(lin+50,2020,SM0->M0_CEPCOB,oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0019,oFont09n)       //"Município"
	oPrintRes:Say(lin+50,60,SM0->M0_CIDCOB,oFont09)
	oPrintRes:Line(lin,1060,lin+100,1060)
	oPrintRes:Say(lin+5,1070,STR0020,oFont09n) //"Telefone"
	oPrintRes:Say(lin+50,1070,SM0->M0_TEL,oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)

	IncProc()


	// IV - Quarta parte
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,70,"IV",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0024,oFont13) //"CONTATO TÉCNICO"

	aContTec := U_SgrConTec()
	Somalinha(80)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0025,oFont09n)  //"Nome"
	oPrintRes:Say(lin+50,60,aContTec[1],oFont09)
	oPrintRes:Line(lin,1300,lin+100,1300)
	oPrintRes:Say(lin+5,1310,STR0026,oFont09n) //"Cargo"
	oPrintRes:Say(lin+50,1310,aContTec[2],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0027,oFont09n)       //"Telefone de Contato"
	oPrintRes:Say(lin+50,60,aContTec[3],oFont09)
	oPrintRes:Line(lin,550,lin+100,550)
	oPrintRes:Say(lin+5,560,STR0028,oFont09n) //"Fax"
	oPrintRes:Say(lin+50,560,aContTec[4],oFont09)
	oPrintRes:Line(lin,1050,lin+100,1050)
	oPrintRes:Say(lin+5,1060,STR0029,oFont09n)         //"e-mail"
	oPrintRes:Say(lin+50,1060,aContTec[5],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)

	IncProc()


	// V - Quinta parte
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,85,"V",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0030,oFont13) //"CARACTERÍSTICAS DA ATIVIDADE"

	aCarAti := U_SgrCarAti()
	Somalinha(80)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0031,oFont09n)  //"Atividade principal"
	oPrintRes:Say(lin+50,60,aCarAti[1],oFont09)
	oPrintRes:Line(lin,1900,lin+100,1900)
	oPrintRes:Say(lin+5,1910,STR0032,oFont09n) //"Código CNAE"
	oPrintRes:Say(lin+50,1910,aCarAti[2],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0033,oFont09n)       //"Período de produção"
	oPrintRes:Say(lin+50,60,STR0034,oFont09n) //"Horas por dia:"
	oPrintRes:Say(lin+50,350,aCarAti[3],oFont09)
	oPrintRes:Say(lin+50,0860,STR0035,oFont09n)         //"Dias por mês:"
	oPrintRes:Say(lin+50,1120,aCarAti[4],oFont09)
	oPrintRes:Say(lin+50,1860,STR0036,oFont09n)         //"Meses por ano:"
	oPrintRes:Say(lin+50,2140,aCarAti[5],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)
	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0037,oFont09n)       //"Número total de funcionários nas seguintes áreas da indústria"
	oPrintRes:Say(lin+50,60,STR0038,oFont09n) //"Produção:"
	oPrintRes:Say(lin+50,250,aCarAti[6],oFont09)
	oPrintRes:Say(lin+50,860,STR0039,oFont09n)         //"Administração:"
	oPrintRes:Say(lin+50,890,aCarAti[7],oFont09)
	oPrintRes:Say(lin+50,1860,STR0040,oFont09n)         //"Outras áreas:"
	oPrintRes:Say(lin+50,1870,aCarAti[8],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)

	Somalinha(100)
	oPrintRes:Line(lin,50,lin+150,50)
	oPrintRes:Say(lin+5,60,STR0041,oFont09n)       //"Área útil total (m2)"
	oPrintRes:Say(lin+100,160,aCarAti[9],oFont09)
	oPrintRes:Line(lin,550,lin+150,550)
	oPrintRes:Say(lin+5,560,STR0042,oFont09n) //"Coordenadas Geográficas da unidade"
	oPrintRes:Say(lin+50,560,STR0043,oFont09n) //"Latitude"
	oPrintRes:Say(lin+50,1560,STR0044,oFont09n) //"Longitude"
	oPrintRes:Say(lin+100,560,STR0045,oFont09n) //"Graus:"
	oPrintRes:Say(lin+100,720,aCarAti[10],oFont09)
	oPrintRes:Say(lin+100,960,STR0046,oFont09n) //"Minutos:"
	oPrintRes:Say(lin+100,1140,aCarAti[11],oFont09)
	oPrintRes:Say(lin+100,1560,STR0045,oFont09n) //"Graus:"
	oPrintRes:Say(lin+100,1720,aCarAti[12],oFont09)
	oPrintRes:Say(lin+100,1960,STR0046,oFont09n) //"Minutos:"
	oPrintRes:Say(lin+100,2140,aCarAti[13],oFont09)
	oPrintRes:Line(lin,2350,lin+150,2350)
	oPrintRes:Line(lin+150,50,lin+150,2350)

	IncProc()


	// VI - Sexta parte
	Somalinha(150)
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,70,"VI",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0047,oFont13) //"RESPONSÁVEL"

	Somalinha(80)
	aCarRes := SgrCarRes()
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+50,60,STR0048,oFont09n) //"Nome:"
	oPrintRes:Say(lin+50,180,aCarRes[1],oFont09)
	oPrintRes:Say(lin+50,0860,STR0049,oFont09n)         //"Cargo:"
	oPrintRes:Say(lin+50,1050,aCarRes[2],oFont09)
	oPrintRes:Line(lin,2350,lin+100,2350)

	Somalinha(100)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0050,oFont09n)       //"Declaro, sob as penas da Lei, a veracidade das informações prestadas no presente formulário."
	oPrintRes:Say(lin+50,60,STR0051,oFont09n) //"Em:"
	oPrintRes:Say(lin+50,230,DtoC( dDataBase ),oFont09)
	oPrintRes:Say(lin+50,860,STR0052,oFont09n)         //"Assinatura:"
	oPrintRes:Line(lin,2350,lin+100,2350)
	oPrintRes:Line(lin+100,50,lin+100,2350)

	IncProc()


	// VII - Setima parte

	Somalinha(100)
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,60,"VII",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0053,oFont13) //"MATÉRIA PRIMA"

	Somalinha(80)
	aCarMPri := SgrCarMPri({"MP"})

	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0055,oFont09n)       //"Matérias-primas e Insumos"
	oPrintRes:Line(lin,870,lin+100,870)
	oPrintRes:Say(lin+5,880,STR0056,oFont09n) //"Quantidade Atual (por ano)"
	oPrintRes:Line(lin,1420,lin+100,1420)
	oPrintRes:Say(lin+5,1430,STR0057,oFont09n) //"Capacidade Máxima (por ano)"
	oPrintRes:Line(lin,1990,lin+100,1990)
	oPrintRes:Say(lin+5,2000,STR0058,oFont09n) //"Unidade de Medida"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For mPri:= 1 To Len( aCarMPri )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarMPri[mPri][1],oFont09)
		oPrintRes:Line(lin,870,lin+100,870)
		oPrintRes:Say(lin+50,880,aCarMPri[mPri][2],oFont09)
		oPrintRes:Line(lin,1420,lin+100,1420)
		oPrintRes:Say(lin+50,1430,aCarMPri[mPri][3],oFont09)
		oPrintRes:Line(lin,1990,lin+100,1990)
		oPrintRes:Say(lin+50,2000,aCarMPri[mPri][4],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		Somalinha(50)
	Next mPri

	If Len( aCarMPri ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	IncProc()


	// VIII - Oitava parte
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,60,"VIII",oFont13)
	oPrintRes:Line(lin,170,lin+80,170)
	oPrintRes:Say(lin+20,180,STR0059,oFont13) //"PRODUÇÃO ANUAL"

	Somalinha(80)
	aCarPAnu := SgrCarMPri({"PA","PI"})

	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0061,oFont09n)       //"Produtos"
	oPrintRes:Line(lin,870,lin+100,870)
	oPrintRes:Say(lin+5,880,STR0056,oFont09n) //"Quantidade Atual (por ano)"
	oPrintRes:Line(lin,1420,lin+100,1420)
	oPrintRes:Say(lin+5,1430,STR0057,oFont09n) //"Capacidade Máxima (por ano)"
	oPrintRes:Line(lin,1990,lin+100,1990)
	oPrintRes:Say(lin+5,2000,STR0058,oFont09n) //"Unidade de Medida"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For pAnu:= 1 To Len( aCarPAnu )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarPAnu[pAnu][1],oFont09)
		oPrintRes:Line(lin,870,lin+100,870)
		oPrintRes:Say(lin+50,880,aCarPAnu[pAnu][2],oFont09)
		oPrintRes:Line(lin,1420,lin+100,1420)
		oPrintRes:Say(lin+50,1430,aCarPAnu[pAnu][3],oFont09)
		oPrintRes:Line(lin,1990,lin+100,1990)
		oPrintRes:Say(lin+50,2000,aCarPAnu[pAnu][4],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		Somalinha(50)
	Next pAnu

	If Len( aCarPAnu ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	IncProc()


	// IX - Nona parte
	If lRetS
		aCarEta := U_SgrCarEta()
	Else
		aCarEta := {}
	EndIf
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,70,"IX",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0063,oFont13) //"ETAPAS DO PROCESSO DE PRODUÇÃO"

	Somalinha(80)
	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0105,oFont09n) //"Etapa"
	oPrintRes:Line(lin,180,lin+100,180)//270
	oPrintRes:Say(lin+5,190,STR0065,oFont09n) //"Descrição"//280
	oPrintRes:Line(lin,910,lin+100,910)//1070
	oPrintRes:Say(lin+5,920,STR0072,oFont09n) //"Resíduo"//1080
	oPrintRes:Line(lin,1550,lin+100,1550)//1370
	oPrintRes:Say(lin+5,1560,STR0065,oFont09n) //"Descrição"// 1380
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nEta := 1 To Len(aCarEta)
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarEta[nEta][1],oFont09)
		oPrintRes:Line(lin,180,lin+100,180)
		oPrintRes:Say(lin+50,190,aCarEta[nEta][2],oFont09)
		oPrintRes:Line(lin,910,lin+100,910)
		oPrintRes:Say(lin+50,920,aCarEta[nEta][3],oFont09)
		oPrintRes:Line(lin,1550,lin+100,1550)
		oPrintRes:Say(lin+50,1560,aCarEta[nEta][4],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		Somalinha(50)
	Next

	If Len( aCarEta ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	IncProc()


	// X - Decima parte
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,85,"X",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0066,oFont13) //"INFORMAÇÃO SOBRE OS RESÍDUOS SÓLIDOS GERADOS"

	Somalinha(80)
	aCarReAt := SgrCarReAt()
	oPrintRes:Line(lin,50,lin+100,50)

	oPrintRes:Say(lin+5,60,STR0103,oFont09n) //"Grupo"
	oPrintRes:Line(lin,200,lin+100,200) //450
	oPrintRes:Say(lin+5,210,STR0104,oFont09n) //"Descrição do Grupo"
	oPrintRes:Line(lin,1370,lin+100,1370)
	oPrintRes:Say(lin+5,1380,STR0069,oFont09n) //"Quantidade (ton/ano)"
	oPrintRes:Line(lin,1930,lin+100,1930)
	oPrintRes:Say(lin+5,1940,STR0070,oFont09n) //"Estado Físico"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nRes:= 1 To Len( aCarReAt )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarReAt[nRes][1],oFont09)
		oPrintRes:Line(lin,200,lin+100,200)
		oPrintRes:Say(lin+50,210,aCarReAt[nRes][2],oFont09)
		oPrintRes:Line(lin,1370,lin+100,1370)
		oPrintRes:Say(lin+50,1380,AllTrim( Str( aCarReAt[nRes][3] ) ),oFont09)
		oPrintRes:Line(lin,1930,lin+100,1930)
		oPrintRes:Say(lin+50,1940,aCarReAt[nRes][4],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		SomaLinha(50,.T.)
	Next nRes

	If Len( aCarReAt ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	aCarTrat := SgrCarTrat()
	oPrintRes:Line(lin,50,lin+130,50)

	oPrintRes:Say(lin+5,60,STR0103,oFont09n) //"Grupo"
	oPrintRes:Line(lin,270,lin+130,270)
	oPrintRes:Say(lin+5,280,STR0071,oFont09n) //"Código do"
	oPrintRes:Say(lin+35,280,STR0073,oFont09n) //"Armazenamento"
	oPrintRes:Line(lin,630,lin+130,630)
	oPrintRes:Say(lin+5,640,STR0074,oFont09n) //"Código do Destino"
	oPrintRes:Say(Lin+35,640,STR0109,oFont09n) //"(Indústria)"
	oPrintRes:Line(lin,1020,lin+130,1020)
	oPrintRes:Say(lin+5,1030,STR0076,oFont09n) //"Descrição do Destino"
	oPrintRes:Line(lin,1930,lin+130,1930)
	oPrintRes:Say(lin+5,1940,STR0077,oFont09n) //"Quantidade Destinada"
	oPrintRes:Say(lin+35,1940,STR0078,oFont09n) //"(ton/ano)"
	oPrintRes:Line(lin,2350,lin+130,2350)

	SomaLinha(30)
	For nTrat := 1 To Len( aCarTrat )
		oPrintRes:Line(lin,50,lin+130,50)

		oPrintRes:Say(lin+50,60,aCarTrat[nTrat][1],oFont09)
		oPrintRes:Line(lin,270,lin+130,270)
		oPrintRes:Say(lin+50,280,aCarTrat[nTrat][2],oFont09)
		oPrintRes:Line(lin,630,lin+130,630)
		oPrintRes:Say(lin+50,640,aCarTrat[nTrat][3],oFont09)
		oPrintRes:Line(lin,1020,lin+130,1020)
		oPrintRes:Say(lin+50,1030,aCarTrat[nTrat][4],oFont09)
		oPrintRes:Line(lin,1930,lin+130,1930)
		oPrintRes:Say(lin+50,1940,Alltrim( Str ( aCarTrat[nTrat][5] ) ),oFont09)
		oPrintRes:Line(lin,2350,lin+130,2350)
		SomaLinha(50)
	Next nTrat

	If Len( aCarTrat ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+80,50,lin+80,2350)
		SomaLinha(80)
	EndIf

	aCoorDest := SgrGetCoor()

	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Line(lin+100,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0043,oFont09n)  //"Latitude"
	oPrintRes:Say(lin+50,60,STR0045,oFont09) 	//"Graus:"
	oPrintRes:Say(lin+50,390,STR0046,oFont09) //"Minutos:"

	oPrintRes:Line(lin,730,lin+100,730)
	oPrintRes:Say(lin+5,740,STR0044,oFont09n) //"Longitude"
	oPrintRes:Say(lin+50,740,STR0045,oFont09)	//"Graus:"
	oPrintRes:Say(lin+50,1070,STR0046,oFont09)//"Minutos:"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nCoor := 1 To Len( aCoorDest )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,200, AllTrim( Str( aCoorDest[nCoor][1] ) + "°"),oFont09)
		oPrintRes:Line(lin,730,lin+100,730)
		oPrintRes:Say(lin+50,560, AllTrim( Str( aCoorDest[nCoor][2] ) + "'"),oFont09)
		oPrintRes:Say(lin+50,900, AllTrim( Str( aCoorDest[nCoor][3] ) + "°"),oFont09)
		oPrintRes:Say(lin+50,1240,AllTrim( Str( aCoorDest[nCoor][4] ) + "'"),oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		SomaLinha(50)
	Next

	If Len( aCoorDest ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	aCarDest := SgrCarDest()
	oPrintRes:Line(lin,50,lin+100,50)

	oPrintRes:Say(lin+5,60,STR0103,oFont09n)//"Grupo"
	oPrintRes:Line(lin,430,lin+100,430)
	oPrintRes:Say(lin+5,440,STR0079,oFont09n) //"Código do Destino ou Tratamento"
	oPrintRes:Line(lin,1180,lin+100,1180)
	oPrintRes:Say(lin+5,1190,STR0080,oFont09n) //"Razão Social ou Nome do Destino"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nDest := 1 To Len( aCarDest )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarDest[nDest][1],oFont09)
		oPrintRes:Line(lin,430,lin+100,430)
		oPrintRes:Say(lin+50,440,aCarDest[nDest][2],oFont09)
		oPrintRes:Line(lin,1180,lin+100,1180)
		oPrintRes:Say(lin+50,1190,aCarDest[nDest][3],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		SomaLinha(50)
	Next nDest

	If Len( aCarDest ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	aCarCDes := SgrCarCDes()

	oPrintRes:Line(lin,50,lin+100,50)
	oPrintRes:Say(lin+5,60,STR0079,oFont09n)  //"Código do Destino ou Tratamento"
	oPrintRes:Line(lin,730,lin+100,730)
	oPrintRes:Say(lin+5,740,STR0016,oFont09n) //"Logradouro/Nº"
	oPrintRes:Line(lin,1600,lin+100,1600)
	oPrintRes:Say(lin+5,1610,STR0019,oFont09n) //"Município"
	oPrintRes:Line(lin,2000,lin+100,2000)
	oPrintRes:Say(lin+5,2010,STR0081,oFont09n) //"Estado"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nCDes := 1 To Len( aCarCDes )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarCDes[nCDes][1],oFont09)
		oPrintRes:Line(lin,730,lin+100,730)
		oPrintRes:Say(lin+50,740,aCarCDes[nCDes][2],oFont09)
		oPrintRes:Line(lin,1600,lin+100,1600)
		oPrintRes:Say(lin+50,1610,aCarCDes[nCDes][3],oFont09)
		oPrintRes:Line(lin,2000,lin+100,2000)
		oPrintRes:Say(lin+50,2010,aCarCDes[nCDes][4],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		SomaLinha(50)
	Next nCDes

	If Len( aCarCDes ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	IncProc()

	// XI - Decima primeira parte
	oPrintRes:Line(lin,50,lin+80,50)
	oPrintRes:Line(lin,2350,lin+80,2350)
	oPrintRes:Line(lin+80,50,lin+80,2350)
	oPrintRes:Say(lin+20,85,"XI",oFont13)
	oPrintRes:Line(lin,150,lin+80,150)
	oPrintRes:Say(lin+20,160,STR0082,oFont13) //"INFORMAÇÃO SOBRE OS RESÍDUOS SÓLIDOS GERADOS NOS ANOS ANTERIORES"

	Somalinha(80)

	aCarReAn := SgrCarReAn()
	oPrintRes:Line(lin,50,lin+100,50)

	oPrintRes:Say(lin+5,60,STR0103,oFont09n) //"Grupo"
	oPrintRes:Line(lin,430,lin+100,430)
	oPrintRes:Say(lin+5,440,STR0104,oFont09n) //"Descrição do Grupo"
	oPrintRes:Line(lin,1200,lin+100,1200)
	oPrintRes:Say(lin+5,1210,STR0083,oFont09n) //"Quantidade (t)"
	oPrintRes:Line(lin,1500,lin+100,1500)
	oPrintRes:Say(lin+5,1510,STR0070,oFont09n) //"Estado Fisico"
	oPrintRes:Line(lin,1800,lin+100,1800)
	oPrintRes:Say(lin+5,1810,STR0085,oFont09n) //"Código do Armazenamento"
	oPrintRes:Line(lin,2350,lin+100,2350)

	For nReAn := 1 To Len( aCarReAn )
		oPrintRes:Line(lin,50,lin+100,50)
		oPrintRes:Say(lin+50,60,aCarReAn[nReAn][1],oFont09)
		oPrintRes:Line(lin,430,lin+100,430)
		oPrintRes:Say(lin+50,440,aCarReAn[nReAn][2],oFont09)
		oPrintRes:Line(lin,1200,lin+100,1200)
		oPrintRes:Say(lin+50,1210,AllTrim( Str( aCarReAn[nReAn][3] ) ),oFont09)
		oPrintRes:Line(lin,1500,lin+100,1500)
		oPrintRes:Say(lin+50,1510,aCarReAn[nReAn][4],oFont09)
		oPrintRes:Line(lin,1800,lin+100,1800)
		oPrintRes:Say(lin+50,1810,aCarReAn[nReAn][5],oFont09)
		oPrintRes:Line(lin,2350,lin+100,2350)
		SomaLinha(50)
	Next nReAn

	If Len( aCarReAn ) == 0
		oPrintRes:Line(lin+100,50,lin+100,2350)
		Somalinha(100)
	Else
		oPrintRes:Line(lin+50,50,lin+50,2350)
		SomaLinha(50)
	EndIf

	oPrintRes:Say(3100,1170,Str(nPaginaRes,3),oFont09n)

	If Mv_Par04 == 1
		oPrintRes:Preview()
	ElseIf Mv_Par04 == 2
		oPrintRes:Print()
	Else
		U_ResSendMail()
	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} SomaLinha
Incrementa Linha

@author  Thiago Olis Machado
@since   10/02/05

@sample  Somalinha(100)

@param   _li, Numerico, param_descr
@param   _linha, Logico, Define se sera tracada um linha no final da pagina
@param   _pula, Logico, Define se havera quebra de página idenpendente da linha atual
/*/
//-------------------------------------------------------------------
Static Function Somalinha(_li, _linha, _pula)

	If _li != nil
		lin += _li
	Else
		lin += 60
	Endif

	If lin > 2990 .or. _pula

		If _linha
			oPrintRes:Line(lin+50,50,lin+50,2350)
		Endif

		If Len( aCarReAt ) == 0 .and. !_linha
			oPrintRes:Line(3050,50,3050,2350)
		EndIf

		oPrintRes:Say(3100,1170,Str(nPaginaRes,3),oFont09n)
		oPrintRes:EndPage()
		nPaginaRes++
		oPrintRes:StartPage()
		lin := 180

		oPrintRes:Say(lin+100,100,STR0009,oFont13) //"INVENTÁRIO NACIONAL DE RESÍDUOS"
		oPrintRes:Line(lin,1600,lin,2350)
		oPrintRes:Line(lin,1600,lin+200,1600)
		oPrintRes:Line(lin,2350,lin+200,2350)
		oPrintRes:Say(lin+20,1690,STR0010,oFont13) //"Período de Referência"
		oPrintRes:Line(lin+100,1600,lin+100,2350)
		oPrintRes:Line(lin+100,1975,lin+200,1975)
		oPrintRes:Say(lin+105,1630,STR0011,oFont09n) //"Início"
		oPrintRes:Say(lin+155,1630,DtoC(Mv_Par01),oFont09)
		oPrintRes:Say(lin+105,2010,STR0012,oFont09n) //"Término"
		oPrintRes:Say(lin+155,2010,DtoC(Mv_Par02),oFont09)

		lin := 380
		oPrintRes:Line(lin,50,lin,2350)

	Endif

Return

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrConTec
Busca as informacoes do Contato Tecnico da Empresa

@author  Thiago Olis Machado
@since   10/02/05

@return  Array, Informacoes do contato tecnico
/*/
//-------------------------------------------------------------------
User Function SgrConTec()
	Local aArray := {}

	DbSelectArea("TAR")
	DbSetOrder(1)
	DbSeek(xFilial("TAR"))

	DbSelectArea("QAA")
	DbSetOrder(1)
	DbSeek(xFilial("QAA")+TAR->TAR_CODFUN)
	aAdd(aArray, QAA->QAA_NOME)

	DbSelectArea("QAC")
	DbSetOrder(1)
	DbSeek(xFilial("QAC")+QAA->QAA_CODFUN)
	aAdd(aArray, QAC->QAC_DESC)
	aAdd(aArray, QAA->QAA_FONE)
	aAdd(aArray, QAA->QAA_FAX)
	aAdd(aArray, QAA->QAA_EMAIL)
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarAti
Busca informacoes relacionadas a atividade da empresa

@author  Thiago Olis Machado
@since   10/02/05

@return  Array, Atividades da empresa
/*/
//-------------------------------------------------------------------
User Function SgrCarAti()
	Local aArray  := {}
	Local aCalend := {}
	Local i,x := 0,nDias

	DbSelectArea("TAR")
	DbSetOrder(1)
	DbSeek(xFilial("TAR"))
	aAdd(aArray, TAR->TAR_DESATI)
	aAdd(aArray, SM0->M0_CNAE)
	aCalend := NGCALENDAH(TAR->TAR_CODCAL)
	If Len(aCalend) == 0
		aAdd(aArray, '0')
	Else
		aAdd(aArray, aCalend[2][1])
	EndIf
	For i := 1 To Len( aCalend )
		If aCalend[i][1] <> '00:00'
			x++
		EndIf
	Next i
	nDias := x*4
	aAdd(aArray, AllTrim(Str(nDias)))
	aAdd(aArray, '12')
	aAdd(aArray, AllTrim(Str(TAR->TAR_NUMPRO)))
	aAdd(aArray, Str(TAR->TAR_NUMADM))
	aAdd(aArray, Str(TAR->TAR_NUMOUT))
	aAdd(aArray, AllTrim(Str(TAR->TAR_AREA)))
	aAdd(aArray, AllTrim(Str(TAR->TAR_LAT)))
	aAdd(aArray, AllTrim(Str(TAR->TAR_LATMIN)))
	aAdd(aArray, AllTrim(Str(TAR->TAR_LONG)))
	aAdd(aArray, AllTrim(Str(TAR->TAR_LONGMI)))
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarRes
Busca informacoes relacionadas ao responsavel da Empresa

@author  Thiago Olis Machado
@since   10/02/05

@return  Array, Informacoes do reposavel da empresa
/*/
//-------------------------------------------------------------------
Static Function SgrCarRes()
	Local aArray := {}

	DbSelectArea("QAA")
	DbSetOrder(1)
	If DbSeek(xFilial("QAA")+Mv_Par03)
		DbSelectArea("QAC")
		DbSetOrder(1)
		If DbSeek(xFilial("QAC")+QAA->QAA_CODFUN)
			aAdd( aArray, QAA->QAA_NOME )
			aAdd( aArray, QAC->QAC_DESC )
		Else
			aAdd( aArray," " )
			aAdd( aArray," " )
		EndIf
	Else
		aAdd( aArray," " )
		aAdd( aArray," " )
	EndIf
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarMPri
Busca informacoes relacionadas as materias primas utilizadas

@author  Thiago Olis Machado
@since   10/02/05

@sample  SgrCarMPri({"MP"})
@param   aChave, Array, Cahve usada para a pesquisa de materias-primas

@return  Array, Informacoes das materias-primas
/*/
//-------------------------------------------------------------------
Static Function SgrCarMPri(aChave)
	Local nI := 1
	Local aArray := {}
	Local nQAtual := 0

	For nI := 1 to Len(aChave)
		DbSelectArea("SB1")
		DbSetOrder(2)
		DbSeek(xFilial("SB1")+aChave[nI])
		Do While !Eof() .and. xFilial("SB1") == SB1->B1_FILIAL .and. SB1->B1_TIPO == aChave[nI]

			DbSelectArea("SB2")
			DbSetOrder(1)
			DbSeek(xFilial("SB2")+SB1->B1_COD)
			Do While !Eof() .and. xFilial("SB2") == SB2->B2_FILIAL .and. SB2->B2_COD == SB1->B1_COD

				nQAtual += SB2->B2_QATU
				DbSkip()
			EndDo

			aAdd( aArray,{SubStr(SB1->B1_DESC,1,40),AllTrim( Str( nQAtual ) ),AllTrim( Str( SB1->B1_EMAX ) ),SB1->B1_UM } )
			nQAtual := 0

			DbSelectArea("SB1")
			DbSkip()
		EndDo
	Next

Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarReAt
Busca informacoes relacionadas ao Residuos atuais

@author  Thiago Olis Machado
@since   10/02/05

@return  Array, Residuos atuais
/*/
//-------------------------------------------------------------------
Static Function SgrCarReAt()
	Local aArray  := {}
	Local nQtAtu  := 0
	Local cEstado := ''
	Local nPos := 0

	dbSelectArea("TAX")
	dbSetOrder(1)
	dbSeek(xFilial("TAX"))
	While !Eof() .And. TAX->TAX_FILIAL == xFilial("TAX")

		If TAX->TAX_ESTADO == '1'
			cEstado := STR0106 //"Solido"
		ElseIf TAX->TAX_ESTADO == '2'
			cEstado := STR0107 //"Liquido"
		Else
			cEstado := STR0108 //"Gasoso"
		EndIf

		DbSelectArea("SB1")
		DbSetOrder(1)
		DbSeek(xFilial("SB1")+TAX->TAX_CODRES)

		dbSelectArea("SBM")
		dbSetOrder(1)
		If dbSeek(xFilial("SBM")+SB1->B1_GRUPO)

			dbSelectArea("TB0")
			dbSetOrder(2)
			dbSeek(xFilial("TB0")+TAX->TAX_CODRES)
			While !Eof() .And. TB0->TB0_FILIAL == xFilial("TB0") .And. TB0->TB0_CODRES == TAX->TAX_CODRES

				If TB0->TB0_DATA >= Mv_Par01 .and. TB0->TB0_DATA <= Mv_Par02
					If TB0->TB0_FATOR > 0
						nQtAtu := (TB0->TB0_QTDE * TB0->TB0_FATOR)
					Else
						nQtAtu := TB0->TB0_QTDE
					Endif

					nPos := aScan( aArray, { |x| x[1]+x[4] == SBM->BM_GRUPO+cEstado })
					If nPos == 0
						aAdd( aArray, { SBM->BM_GRUPO, SubStr(SBM->BM_DESC,1,30), nQtAtu , cEstado } )
					Else
						aArray[nPos][3] +=  nQtAtu
					EndIf
				EndIf

				dbSelectArea("TB0")
				dbSkip()
			End

		Endif

		dbSelectArea("TAX")
		dbSkip()
	End
	//Ordena por grupo
	aSort(aArray,,, {|x,y| x[1]+x[4] < y[1]+y[4]})
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarTrat
Busca informacoes relacionadas aos Residuos atuais

@author  Thiago Olis Machado
@since   25/05/2005

@return  Array, Informacoes sobre o destino dos residuos
/*/
//-------------------------------------------------------------------
Static Function SgrCarTrat()
	Local aArray := {}
	Local i      := 0
	Local cArm   := ''
	Local cDesc  := ''
	Local nQtAtu := 0
	Local nPos

	For i := 1 To Len(aCarReAt)
		dbSelectArea("SB1")
		dbSetOrder(4)
		dbSeek(xFilial("SB1")+aCarReAt[i][1])
		While !Eof() .and. xFilial("SB1")+aCarReAt[i][1] == SB1->B1_FILIAL+SB1->B1_GRUPO
			dbSelectArea("TB7")
			dbSetOrder(1)
			If dbSeek(xFilial("TB7")+SB1->B1_COD)
				cArm := TB7->TB7_CODTIP
			EndIf

			DbSelectArea("TB4")
			DbSetOrder(2)
			DbSeek(xFilial("TB4")+SB1->B1_COD)
			nQtAtu := 0
			While !Eof() .and. xFilial("TB4")+SB1->B1_COD == TB4->TB4_FILIAL+TB4->TB4_CODRES
				DbSelectArea("TB0")
				DbSetOrder(1)
				DbSeek(xFilial("TB0")+TB4->TB4_CODOCO)
				If TB0->TB0_DATA < Mv_Par01 .or. TB0->TB0_DATA > mv_par02
					DbSelectArea("TB4")
					DbSkip()
					Loop
				EndIf

				DbSelectArea("TB2")
				DbSetOrder(1)
				If DbSeek(xFilial("TB2")+TB4->TB4_CODDES)
					If TB2->TB2_TIPO == '1'
						cDesc := TB2->TB2_DESLOC
					Else
						DbSelectArea("SA2")
						DbSetOrder(1)
						If DbSeek(xFilial("SA2")+TB4->TB4_CODDES)
							cDesc := SA2->A2_NREDUZ
						EndIf
					EndIf
				EndIf
				If TB0->TB0_FATOR > 0
					nQtAtu := (TB4->TB4_QUANTI * TB0->TB0_FATOR)
				Else
					nQtAtu := TB4->TB4_QUANTI
				Endif

				nPos := aScan( aArray, { |x| x[3]+x[2]+x[1] == TB4->TB4_CODDES+cArm+aCarReAt[i][1] })
				If nPos == 0
					aAdd( aArray, { aCarReAt[i][1], cArm, TB4->TB4_CODDES, cDesc, nQtAtu } )
				Else
					aArray[nPos][5] +=  nQtAtu
				EndIf

				DbSelectArea("TB4")
				DbSkip()
			End
			dbSelectArea("SB1")
			dbSkip()
		End
	Next i
	//Ordena por grupo
	aSort(aArray,,, {|x,y| x[1]+x[2] < y[1]+y[2]})
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarDest
Busca informacoes relacionadas ao Residuos atuais

@author  Thiago Olis Machado
@since   25/05/2005

@return  Array, Informacoes sobre transferencias dos residuos
/*/
//-------------------------------------------------------------------
Static Function SgrCarDest()
	Local aArray := {}
	Local i
	Local lCodigo := NGCADICBASE("TBA_CODREC","A","TBA",.F.)

	For i := 1 To Len(aCarReAt)
		dbSelectArea("SB1")
		dbSetOrder(4)
		dbSeek(xFilial("SB1")+aCarReAt[i][1])
		While !Eof() .and. xFilial("SB1")+aCarReAt[i][1] == SB1->B1_FILIAL+SB1->B1_GRUPO
			DbSelectArea("TBA")
			DbSetOrder(1)
			DbSeek(xFilial("TBA")+SB1->B1_COD)
			While !Eof() .and. xFilial("TB4")+SB1->B1_COD == TBA->TBA_FILIAL+TBA->TBA_CODRES
				If lCodigo
					If !Empty(TBA->TBA_CODREC) .AND. TBA->TBA_DTTRAN >= Mv_Par01 .and. TBA->TBA_DTTRAN <= Mv_Par02
						nPos := aScan( aArray, { |x| x[1]+x[2] == aCarReAt[i][1]+TBA->TBA_CODREC })
						If nPos == 0
							aAdd( aArray, { aCarReAt[i][1], TBA->TBA_CODREC, SG280INFD(TBA->TBA_CODREC,'NOME') } )
						Endif
					Endif
				Else
					If !Empty(TBA->TBA_FORNEC) .AND. TBA->TBA_DTTRAN >= Mv_Par01 .and. TBA->TBA_DTTRAN <= Mv_Par02

						DbSelectArea("SA2")
						DbSetOrder(1)
						Dbseek(xFilial("SA2")+TBA->TBA_FORNEC)
						nPos := aScan( aArray, { |x| x[1]+x[2] == aCarReAt[i][1]+TBA->TBA_FORNEC })
						If nPos == 0
							aAdd( aArray, { aCarReAt[i][1], TBA->TBA_FORNEC, SA2->A2_NOME } )
						Endif
					Endif
				Endif

				DbSelectArea("TBA")
				DbSkip()
			End

			If AliasInDic("TDI")
				DbSelectArea("TDI")
				DbSetOrder(2)
				DbSeek(xFilial("TDI")+SB1->B1_COD)
				While !Eof() .and. xFilial("TDI")+SB1->B1_COD == TDI->TDI_FILIAL+TDI->TDI_CODRES
					If !Empty(TDI->TDI_CODREC) .AND. TDI->TDI_DTCOMP >= Mv_Par01 .and. TDI->TDI_DTCOMP <= Mv_Par02
						If (nPos := aScan( aArray, { |x| x[1]+x[2] == aCarReAt[i][1]+TDI->TDI_CODREC })) == 0
							aAdd( aArray, { aCarReAt[i][1], TDI->TDI_CODREC, SG280INFD(TDI->TDI_CODREC,'NOME') } )
						Endif
					Endif
					DbSelectArea("TDI")
					DbSkip()
				End
			Endif
			dbSelectArea("SB1")
			dbSkip()
		End
	Next i
	//Ordena por grupo
	aSort(aArray,,, {|x,y| x[1]+x[3] < y[1]+y[3]})
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarCDes
Busca informacoes relacionadas ao Residuos atuais

@author  Thiago Olis Machado
@since   25/05/2005

@return  Array, Informacoes sobre os fornecedores dos residuos
/*/
//-------------------------------------------------------------------
Static Function SgrCarCDes()
	Local aArray := {}
	Local i
	Local nPos
	Local lCodigo := NGCADICBASE("TBA_CODREC","A","TBA",.F.)

	For i:= 1 To Len( aCarDest )

		If lCodigo
			nPos := aScan( aArray, { |x| x[1] == aCarDest[i][2] })
			If nPos == 0
				aAdd( aArray, { aCarDest[i][2],SG280INFD(aCarDest[i][2],'END'), SG280INFD(aCarDest[i][2],'MUN'), SG280INFD(aCarDest[i][2],'EST') } )
			EndIf
		Else
			DbSelectArea("SA2")
			DbSetOrder(1)
			Dbseek(xFilial("SA2")+aCarDest[i][2])
			nPos := aScan( aArray, { |x| x[1] == aCarDest[i][2] })
			If nPos == 0
				aAdd( aArray, { aCarDest[i][2],SA2->A2_END, SA2->A2_MUN, SA2->A2_EST } )
			EndIf
		Endif
	Next i
	//Ordena por grupo
	aSort(aArray,,, {|x,y| x[1]+x[4]+x[3] < y[1]+y[4]+y[3]})
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarReAn
Busca informacoes relacionadas ao Residuos anteriores

@author  Thiago Olis Machado
@since   25/05/2005

@return  Array, Informacoes sobre o grupo de produto do residuo
/*/
//-------------------------------------------------------------------
Static Function SgrCarReAn()
	Local aArray  := {}
	Local nQtAtu  := 0
	Local cEstado := ''
	Local nPos
	Local cArm := ''

	dbSelectArea("TB0")
	dbSetOrder(2)
	dbSeek(xFilial("TB0"))
	While !Eof() .and. xFilial("TB0") == TB0->TB0_FILIAL

		If TB0->TB0_DATA < Mv_Par01 .and. TB0->TB0_DATA > (MV_PAR01-366)//Verifica so os 12 ultimos meses
			DbSelectArea("SB1")
			DbSetOrder(1)
			DbSeek(xFilial("SB1")+TB0->TB0_CODRES)
			//Verifica se existe grupo
			dbSelectArea("SBM")
			dbSetOrder(1)
			If dbSeek(xFilial("SBM")+SB1->B1_GRUPO)
				DbSelectArea("TAX")
				DbSetOrder(1)
				DbSeek(xFilial("TAX")+TB0->TB0_CODRES)

				dbSelectArea("TB7")
				dbSetOrder(1)
				If dbSeek(xFilial("TB7")+TB0->TB0_CODRES)
					cArm := TB7->TB7_CODTIP
				Else
					cArm := ""
				EndIf

				If TAX->TAX_ESTADO == "1"
					cEstado := STR0106 //"Solido"
				ElseIf TAX->TAX_ESTADO == "2"
					cEstado := STR0107 //"Liquido"
				Else
					cEstado := STR0108 //"Gasoso"
				EndIf
				If TB0->TB0_FATOR > 0
					nQtAtu := (TB0->TB0_QTDE * TB0->TB0_FATOR)
				Else
					nQtAtu := TB0->TB0_QTDE
				Endif

				nPos := aScan( aArray, { |x| x[1]+x[5] == SBM->BM_GRUPO+cArm })
				If nPos == 0
					aAdd( aArray, { SBM->BM_GRUPO, SubStr(SBM->BM_DESC,1,30), nQtAtu , cEstado, cArm } )
				Else
					aArray[nPos][3] +=  nQtAtu
				EndIf
			Endif
		EndIf

		dbSelectArea("TB0")
		dbSkip()
	End
	//Ordena por grupo
	aSort(aArray,,, {|x,y| x[1]+x[5] < y[1]+y[5]})
Return aArray

//-------------------------------------------------------------------
/*/{Protheus.doc} ResConfMail
Verifica os parametros do SX6 usados para enviar email.
Exibe janela para o usuario entrar os dados.

@author  Thiago Olis Machado
@since   24/05/2005

@return  return_type, Opcao escolhida na tela de envio de relatorio por email
/*/
//-------------------------------------------------------------------
User Function ResConfMail()

	Local nOpca := 0

	//Verifica se existe o SMTP Server
	If	Empty(cServer)
		MsgStop(STR0087 ,STR0088) //"O Servidor de SMTP não foi configurado !!!"###"Atenção"
		Return 0
	EndIf

	If lSmtpAuth

		//Verifica se existe a CONTA
		If Empty(cAccount)
			Msgstop(STR0089 ,STR0088) //"A Conta do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

		//Verifica se existe a Senha
		If Empty(cPassword)
			Msgstop(STR0090 ,STR0088) //"A Senha do email não foi configurada !!!"###"Atenção"
			Return 0
		EndIf

	EndIf

	PswOrder(1)
	PswSeek(__CUSERID,.T.)
	aUsuario := PswRet(1)
	cTitulo := STR0091 //"Dados do E-mail"

	DEFINE MSDIALOG oDlgMail OF oMainWnd FROM 0,0 TO 200,544 PIXEL TITLE cTitulo

		@ 05,04 To 079,268 OF oDlgMail PIXEL
		@ 18,08 Say STR0092     Size 012,08          OF oDlgMail PIXEL //"De: "
		@ 33,08 Say STR0093    Size 016,08          OF oDlgMail PIXEL //"Para:"
		@ 48,08 Say STR0094      Size 016,08          OF oDlgMail PIXEL //"CC:"
		@ 63,08 Say STR0095 Size 021,08          OF oDlgMail PIXEL //"Assunto:"

		@ 18,33 MSGet cFrom    Size 233,10 When .F. OF oDlgMail PIXEL
		@ 33,33 MSGet cTo      Size 233,10          OF oDlgMail PIXEL
		@ 48,33 MSGet cCC      Size 233,10          OF oDlgMail PIXEL
		@ 63,33 MSGet cSubject Size 233,10          OF oDlgMail PIXEL

		DEFINE SBUTTON FROM 85,100 TYPE 1 ACTION (If(!Empty(cTo),If(oDlgMail:End(),nOpca:=1,nOpca:=1),Help("",1,"AVG0001054"))) ENABLE OF oDlgMail PIXEL
		DEFINE SBUTTON FROM 85,140 TYPE 2 ACTION (oDlgMail:End()) ENABLE OF oDlgMail PIXEL

	ACTIVATE MSDIALOG oDlgMail CENTERED

Return nOpca

//-------------------------------------------------------------------
/*/{Protheus.doc} ResSendMail
Envia email do relatorio, conforme parametros definidos no SX6 e informacoes entradas pelo usuario

@author  Thiago Olis Machado
@since   24/05/2005

@sample  U_ResSendMail( "\DOCUMENTOS\" )

@param   cPrefixo, Caracter, Complemento para o caminho aonde o relatorio sera salvo

@return  Logico, Sempre .T.
/*/
//-------------------------------------------------------------------
User Function ResSendMail(cPrefixo)
	Local nI

	If nProcessa == 1

	cDiretorio := AllTrim(GetNewPar("MV_RELT"," "))
	cAnexos    := ""
	If EMPTY(cDiretorio)
		cDiretorio := "\"
	EndIf

		nLargura := 931  //700
		nAltura  := 1330 //1000
		nZoom    := 150  //110

		cPrefixo := cDiretorio+"SGR070_"+DtoS(dDatabase)+"_"+StrZero(HtoM(Time()),4)
		If !oPrintRes:SaveAllAsJPEG(cPrefixo,nLargura,nAltura,nZoom)
			MsgStop(STR0096,STR0097) //"Não foi possível gravar o relatório"###"AVISO"
			Return .F.
		EndIf

		cBody  := STR0098 + oPrintRes:cDocument //"Segue em anexo relatório de "

		// Varre o diretório e procura pelas páginas gravadas.
		aFiles := Directory( cPrefixo+"*.jpg" )

		// Monta um Vetor com o path e nome do arquivo em cada linha para passar via email
		For nI:= 1 to Len(aFiles)
			cAnexos += cDiretorio+aFiles[nI,1] + "; "
		Next nI

		CONNECT SMTP SERVER cServer ACCOUNT cAccount PASSWORD cPassword Result lOk
		If !lAutOk
			If ( lSmtpAuth )
				lAutOk := MailAuth(cUserAut,cPassAut)
			Else
				lAutOk := .T.
			EndIf
		EndIf
		If lOk .and. lAutOk
			If !Empty(cCC)
				SEND MAIL FROM cFrom TO cTo CC cCC SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
			Else
				SEND MAIL FROM cFrom TO cTo SUBJECT Alltrim(cSubject) BODY cBody ATTACHMENT cAnexos Result lOk
			EndIf
			If lOk
				MsgInfo(STR0099) //"Email enviado com sucesso"
			Else
				GET MAIL ERROR cErro
				MsgStop(STR0100 +Chr(13)+Chr(10)+ cErro,STR0097) //"Não foi possível enviar o Email."###"AVISO"
				Return .f.
			EndIf
		Else
			GET MAIL ERROR cErro
			MsgStop(STR0101 +Chr(13)+Chr(10)+ cErro,STR0097) //"Erro na conexão com o SMTP Server."###"AVISO"
			Return .f.
		EndIf
		DISCONNECT SMTP SERVER

	EndIf
	If MsgYesNo(STR0102) //"Deseja visualizar o relatório?"
		oPrintRes:Preview()
	EndIf

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} SgrCarEta
Carrega as Etapas do Processo de Producao.

@author  Rafael Diogo Richter
@since   20/05/2008

@return  Array, Informacoes sobre as etapas do processo do residuo
/*/
//-------------------------------------------------------------------
User Function SgrCarEta()
	Local aArray := {}
	Local cCodNivel := ""
	Local lImprime := .T.

	dbSelectArea("TAV")
	dbSetOrder(2)
	dbSeek(xFilial("TAV")+"001")
	While !Eof() .And.  TAV->TAV_FILIAL == xFilial("TAV") .And. TAV->TAV_CODEST == "001"
		If cCodNivel <> TAV->TAV_CODNIV
			cCodNivel := TAV->TAV_CODNIV
			lImprime := .T.
		Else
			lImprime := .F.
		EndIf
		dbSelectArea("TAF")
		dbSetOrder(2)
		If dbSeek(xFilial("TAF")+"001"+TAV->TAV_CODNIV)
			If TAF->TAF_ETAPA == "1"
				dbSelectArea("SB1")
				dbSetOrder(1)
				dbSeek(xFilial("SB1")+TAV->TAV_CODRES)
				If lImprime
					aAdd(aArray,{TAF->TAF_CODNIV,SubStr(AllTrim(TAF->TAF_NOMNIV),1,35),AllTrim(TAV->TAV_CODRES),Substr(SB1->B1_DESC,1,35)})
				Else
					aAdd(aArray,{"","",AllTrim(TAV->TAV_CODRES),Substr(SB1->B1_DESC,1,35)})
				EndIf
			EndIf
		EndIf
		TAV->(dbSkip())
	End

Return aArray

//---------------------------------------------------------------------
/*/{Protheus.doc} SGR070DAT
Função para validar os parametros para impressão do relatório.

@param nParam   Parametro utilizado para identificar qual a validação que
o campo deve usar.

@author Gabriel Werlich
@since 05/11/2013
@version MP11
@return lRet caso .T. a validação está ok.
/*/
//---------------------------------------------------------------------
User Function SGR070DAT(nParam)
	Local lRet := .F.

	If nParam == 1
		If Empty(mv_par02) .OR. VALDATA(mv_par01,mv_par02,'DATAMAIOR')
			lRet:= .T.
		EndIf
	ElseIf nParam == 2
		If VALDATA(mv_par01, mv_par02, 'DATAMENOR')
			lRet:= .T.
		EndIf
	EndIf

Return lRet

//---------------------------------------------------------------------
/*/{Protheus.doc} SgrGetCoor
Busca coordenadas geográficas de latitude e longitude das respectivas
destinações(TB2) internas.

@author Gabriel Werlich
@since 03/09/2015

@return aArray
/*/
//---------------------------------------------------------------------
Static Function SgrGetCoor()

	Local i
	Local aArray := {}

	If !Empty(aCarTrat)
		DbSelectArea("TB2")
		DbSetOrder(1)
		For i:= 1 To Len(aCarTrat)
			If dbSeek(xFilial("TB2")+aCarTrat[i][3])
				aAdd( aArray, { TB2->TB2_GRAUS1 , TB2->TB2_MINUT1 , TB2->TB2_GRAUS2 , TB2->TB2_MINUT2 })
			EndIf
		Next
	EndIf

Return aArray
