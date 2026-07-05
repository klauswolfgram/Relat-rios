/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
//-------------------------------------------------------------------
//Inclusão Pátios 12.1.4
/*---------------------------------------------------------
{Protheus.doc} GFER519
	
@author helder.santos
@since 03/03/2014
@version 1.0

@description
Relatório de Movimentação Diária

-------------------------------------------------------------*/

User Function GFER519()
	Local oReport
	Local aArea := GetArea()
	Private cTabTotMD	// registros referentes a totalizadores
	Private cAliasMD	// Registros referente a consultaSQL
	Private cSit := ""
	
	If TRepInUse()
		//+------------------------------------------------------------------------+
		//| "Interface de impressao                                                  |
		//+------------------------------------------------------------------------+
		oReport := ReportDef()
		oReport:PrintDialog()
	EndIf
	
	RestArea(aArea)
	If !Empty(cAliasMD)
		(cAliasMD)->(dbCloseArea())
	EndIf
Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportDef
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario. 

@author helder.santos
@version 1.0
@return oReport Objeto do Relatorio.
/*/
//--------------------------------------------------------------------------------------------------------

Static Function ReportDef()
	Local oReport, oSection, oSection2, oSection3, oSection4, oSection5, oSection6, oSection7, oSection8, oSection9
	Local aOrdem		:= {}
	Private cDesConf 	:= ""
	Private cDesEmit 	:= ""
	Private cDesEnd	:= ""
	Private cPlaca	:= ""
	Private cCdProp 	:= ""
	Private cNmProp	:= ""
	Private cModelo	:= ""
	Private cAnoFab	:= ""
	Private cSitMov	:= ""
	Private cImped	:= ""
	Private cNmVisi	:= ""
	Private cNmVulgo	:= ""
	Private cCPFVisi	:= ""
	Private cNmMotora	:= ""
	Private cApMotora	:= ""
	Private cCPF		:= ""
	Private cEspaco	:= ""

	//+------------------------------------------------------------------------+
//| "Criacao do componente de impressao                                      | "
//| "                                                                        | "
//| "TReport():New                                                           | "
//| "ExpC1 : Nome do relatorio                                               | "
//| "ExpC2 : Titulo                                                          | "
//| "ExpC3 : Pergunte                                                        | "
//| "ExpB4 : Bloco de codigo que sera executado na confirmacao da impressao  | "
//| "ExpC5 : Descricao                                                       | "
//| "                                                                        | "
//+------------------------------------------------------------------------+

	Aadd( aOrdem, "Movimentação Diária" ) // "Movimentação Diária"

	oReport := TReport():New("GFER519","Movimentação Diária","GFER519", {|oReport| ReportPrint(oReport)},"Emite relatório de Movimentação Diária conforme os parâmetros informados."/*Descricao do relatório*/)
	oReport:SetLandscape(.T.)   //Define a orientação de página do relatório como paisagem  ou retrato. .F.=Retrato; .T.=Paisagem
	oReport:SetTotalInLine(.T.) //Define se os totalizadores serão impressos em linha ou coluna 
	oReport:HideParamPage() //Oculta página de parametros
	If !Empty(oReport:uParam)
	    Pergunte(oReport:uParam,.F.)
	EndIf
	oSection := TRSection():New(oReport,"Movimentação Diária",{"(cAliasMD)"},aOrdem/*{Array com as ordens do relatório}*/,/*Campos do SX3*/,/*Campos do SIX*/)
//Exemplo utilizando a tabela de clientes.
//oSection := TRSection():New(oReport,"Clientes",{"SA1"})
	oSection:SetTotalInLine(.T.)  //Define se os totalizadores serão impressos em linha ou coluna. .F.=Coluna; .T.=Linha
	
//+------------------------------------------------------------------------+
//|Criacao da celulas da secao do relatorio                                |
//|                                                                        |
//|TRCell():New                                                            |
//|ExpO1 : Objeto TSection que a secao pertence                            |
//|ExpC2 : Nome da celula do relatório. O SX3 será consultado              |
//|ExpC3 : Nome da tabela de referencia da celula                          |
//|ExpC4 : Titulo da celula                                                |
//|        Default : X3Titulo()                                            |
//|ExpC5 : Picture                                                         |
//|        Default : X3_PICTURE                                            |
//|ExpC6 : Tamanho                                                         |
//|        Default : X3_TAMANHO                                            |
//|ExpL7 : Informe se o tamanho esta em pixel                              |
//|        Default : False                                                 |
//|ExpB8 : Bloco de código para impressao.                                 |
//|        Default : ExpC2                                                 |
//|                                                                        |
//+------------------------------------------------------------------------+
//	GetSx3Inf @return aRetorno Array {cTitulo,cCbox,cPicture}
	//TRCell():New(oSection,/*X3_CAMPO*/,/*Tabela*/,/*Titulo*/,/*Picture*/,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
 
	TRCell():New(oSection,"(cAliasMD)->GX3_DTCRIA" ,"(cAliasMD)","Data"                ,                           ,10         ,/*lPixel*/,{||If(Vazio((cAliasMD)->GX3_DTCRIA),(cAliasMD)->GX3_DTCRIA,SubStr((cAliasMD)->GX3_DTCRIA,7,2) + '/' + SubStr((cAliasMD)->GX3_DTCRIA,5,2) + '/' + SubStr((cAliasMD)->GX3_DTCRIA,1,4))})
	TRCell():New(oSection,"(cAliasMD)->QTD_MOVTOS" ,"(cAliasMD)","Qtd Movimentações"   ,"@E 9999999"               ,/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_COMAGE" ,"(cAliasMD)","Com Agendamento"     ,GetSx3Inf("QTD_COMAGE" )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_SEMAGE" ,"(cAliasMD)","Sem Agendamento"     ,GetSx3Inf("QTD_SEMAGE" )[3],/*Tamanho*/,/*lPixel*/,{|| (cAliasMD)->QTD_MOVTOS - (cAliasMD)->QTD_COMAGE })
	TRCell():New(oSection,"(cAliasMD)->QTD_CANCEL" ,"(cAliasMD)","Canceladas"          ,GetSx3Inf("QTD_CANCEL" )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_CONCLU" ,"(cAliasMD)","Concluídas"          ,GetSx3Inf("QTD_CONCLU" )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_OCOR"   ,"(cAliasMD)","Qtd Ocorrências"     ,GetSx3Inf("QTD_OCOR"   )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_VEI"    ,"(cAliasMD)","Qtd Veículos"        ,GetSx3Inf("QTD_VEI"    )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_MOT"    ,"(cAliasMD)","Qtd Motoristas"      ,GetSx3Inf("QTD_MOT"    )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_DOCCARG","(cAliasMD)","Qtd Doc Carga"       ,GetSx3Inf("QTD_DOCCARG")[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection,"(cAliasMD)->QTD_ENDUTI" ,"(cAliasMD)","Endereços Utilizados",GetSx3Inf("QTD_ENDUTI" )[3],/*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection2 := TRSection():New(oSection,"Movimentação",{"GX3"},aOrdem) // "Movimentação"
	oSection2:SetTotalInLine(.F.)
	oSection2:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection2,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection2,"GX3_NRMOV" ,"GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GX3_CDOPER","GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GX3_SEQ"  	,"GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"cDesConf" 	,"","Desc Config","@!",30,/*lPixel*/,{|| cDesConf })
	TRCell():New(oSection2,"GX3_CDEMIT","GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"cDesEmit"  ,"","Nome Emit","@!",55,/*lPixel*/,{|| cDesEmit })
	TRCell():New(oSection2,"GX3_SIT"  	,"GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GX3_DTCRIA","GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection2,"GX3_HRCRIA","GX3",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)

	oSection3 := TRSection():New(oSection2,"Mov x Pontos de controle",{"GX4"},aOrdem) // "Movimentação"
	oSection3:SetTotalInLine(.F.)
	oSection3:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection3,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection3,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection3,"GX4_SEQ" 	,"GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_CDPTCT","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_SIT" 	,"GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_DTENTR","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_HRENTR","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_DTSAI" ,"GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_HRSAI" ,"GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_QTPESO","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_VLTARA","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_VLHODO","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"cDesEnd"  	,"","Descrição Endereço","@!",45,/*lPixel*/,{|| cDesEnd })
	TRCell():New(oSection3,"GX4_DTCHEN","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_HRCHEN","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_DTSAEN","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection3,"GX4_HRSAEN","GX4",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
// “Sequência”, “Pto Controle”, “Situação”, “Dt Entrada”, “Hr Entrada”, “Dt Saída”, “Hr Saída”, “Peso”, “Tara”, “Hodômetro”, “Endereço”, “Dt Ent End”, “Hr Ent End”, “Dt Sai End”, “Hr Sai End”;

	oSection4 := TRSection():New(oSection3,"Mov x Ponto de Controle x Pergunta",{"GX5"},aOrdem) // "Mov x Ponto de Controle x Pergunta"
	oSection4:SetTotalInLine(.F.)
	oSection4:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection4,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection4,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection4,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection4,"GX5_CDPERG","GX5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection4,"cImped"  	,"","Impeditiva","@!",3,/*lPixel*/,{|| cImped })
	TRCell():New(oSection4,"GX5_RESPOS","GX5",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//1.1.1.1	Mov x Ponto de Controle x Pergunta (GX5): “Pergunta”, “Impeditiva”, “Resposta”;

	oSection5 := TRSection():New(oSection3,"Mov x Ponto de Controle x Doc Carga",{"GXA"},aOrdem) // "Mov x Ponto de Controle x Doc Carga"
	oSection5:SetTotalInLine(.F.)
	oSection5:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection5,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection5,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection5,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection5,"GXA_CDTPDC","GXA",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GXA_EMISDC","GXA",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GXA_SERDC" ,"GXA",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection5,"GXA_NRDC" 	,"GXA",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//1.1.1.2	Mov x Ponto de Controle x Doc Carga (GXA): “Tipo”, “Emissor”, “Série”, “Número”;

	oSection6 := TRSection():New(oSection2,"Mov x Veículo",{"GX6"},aOrdem) // "Mov x Veículo"
	oSection6:SetTotalInLine(.F.)
	oSection6:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection6,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection6,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection6,"GX6_CDVEIC","GX6",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection6,"cPlaca" 	,"","Placa",PesqPict('GU8','GU8_PLACA'),8,/*lPixel*/,{|| cPlaca })
	TRCell():New(oSection6,"cCdProp"  	,"","Cd Proprietário","@!",14,/*lPixel*/,{|| cCdProp })
	TRCell():New(oSection6,"cNmProp"  	,"","Nm Proprietário","@!",55,/*lPixel*/,{|| cNmProp })
	TRCell():New(oSection6,"cModelo"  	,"","Marca/Modelo","@!",30,/*lPixel*/,{|| cModelo })
	TRCell():New(oSection6,"cAnoFab"  	,"","Ano Fabricação","@!",5,/*lPixel*/,{|| cAnoFab })
//1.1.2	Mov x Veículo (GX6): “Cd Veic”, “Placa”, “Cd Proprietário”, “Nm Proprietário”, “Marca/Modelo”, “Ano Fabricação”;

	oSection7 := TRSection():New(oSection2,"Mov x Visitante",{"GX7"},aOrdem) // "Mov x Visitante"
	oSection7:SetTotalInLine(.F.)
	oSection7:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection7,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection7,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection7,"GX7_CDVISI","GX7",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection7,"cNmVisi"  	,"","Nome","@!",5,/*lPixel*/,{|| cNmVisi })
	TRCell():New(oSection7,"cNmVulgo"  ,"","Apelido","@!",5,/*lPixel*/,{|| cNmVulgo })
	TRCell():New(oSection7,"cCPFVisi"  ,"","CPF","@!",5,/*lPixel*/,{|| cCPFVisi })
//1.1.3	Mov x Visitante (GX7): “Cd Visi”, “Nome”, “Apelido”, “CPF”;

	oSection8 := TRSection():New(oSection2,"Mov x Motorista",{"GX8"},aOrdem) // "Mov x Motorista"
	oSection8:SetTotalInLine(.F.)
	oSection8:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection8,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection8,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection8,"GX8_CDMTR"	,"GX8",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection8,"cNmMotora"	,"","Nome","@!",5,/*lPixel*/,{|| cNmMotora })
	TRCell():New(oSection8,"cApMotora"	,"","Apelido","@!",5,/*lPixel*/,{|| cApMotora })
	TRCell():New(oSection8,"cCPF"	 	,"","CPF","@!",5,/*lPixel*/,{|| cCPF })
//1.1.4	Mov x Motorista (GX8): “Cd Mot”, “Nome”, “Apelido”, “CPF”;

	oSection9 := TRSection():New(oSection2,"Agendamentos",{"GWV"},aOrdem) // "Agendamentos"
	oSection9:SetTotalInLine(.F.)
	oSection9:SetHeaderSection(.T.) //Define que imprime cabeçalho das células na quebra de seção
	TRCell():New(oSection9,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection9,"cEspaco" 	,"","","@!",1,/*lPixel*/,{|| cEspaco })
	TRCell():New(oSection9,"GWV_NRAGEN","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection9,"GWV_IDTIPO","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection9,"GWV_NRROM","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
	TRCell():New(oSection9,"GWV_PESOR","GWV",/*cTitle*/,/*Picture*/,  /*Tamanho*/,/*lPixel*/,/*{|| code-block de impressao }*/)
//1.1.5	Agendamentos (GWV): “Nr Agend”, “Tipo”;

Return oReport

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  ReportPrint
A funcao estatica ReportDef devera ser criada para todos os relatorios que poderao ser agendados pelo usuario.  

@param oReport Objeto do relatório  
@author helder.santos
@version 1.0
@since 03/03/2014
@return Nil
/*/
//--------------------------------------------------------------------------------------------------------
Static Function ReportPrint(oReport)
	Local oSection  	:= oReport:Section(1)	// 1
	Local oSection2  	:= oSection:Section(1)	// 1.1
	Local oSection3  	:= oSection2:Section(1)	// 1.1.1
	
	Local oSection4  	:= oSection3:Section(1)	// 1.1.1.1
	Local oSection5  	:= oSection3:Section(2)	// 1.1.1.2
	
	Local oSection6  	:= oSection2:Section(2)	// 1.1.2
	Local oSection7  	:= oSection2:Section(3)	// 1.1.3
	Local oSection8  	:= oSection2:Section(4)	// 1.1.4
	Local oSection9	:= oSection2:Section(5)	// 1.1.5

	cEspaco := " "

	CarregaDados()

	oReport:SetMeter((cAliasMD)->(LastRec()))
	
	//RecLock((cTabTotMD), .T.)
	While !oReport:Cancel() .AND. !(cAliasMD)->( Eof() )
		//(cTabTotMD)->QTD_MOVTOS += (cAliasMD)->QTD_MOVTOS
		oSection:Init()
		oSection:PrintLine()
		oSection:Finish()		
				
		If MV_PAR13 == 2	// 1=Resumido ou 2=Detalhado
		
			dbSelectArea("GX3")		// Movimentacao
			GX3->( dbSetOrder(4) )	// GX3_DTCRIA + GX3_HRCRIA
			GX3->( dbSeek( (cAliasMD)->GX3_FILIAL + (cAliasMD)->GX3_DTCRIA) )
			While GX3->( !Eof() ) .And. GX3->GX3_FILIAL == (cAliasMD)->GX3_FILIAL .And. DTOS(GX3->GX3_DTCRIA) == (cAliasMD)->GX3_DTCRIA
			
				// Verifica se está filtrando por Agendamento	
				If AllTrim(MV_PAR12) != "" .And. MV_PAR12 != Posicione("GWV",4,GX3->GX3_FILIAL + GX3->GX3_NRMOV,"GWV_NRAGEN")
					GX3->( dbSkip() )
					Loop
				EndIf
	
				If	GX3->GX3_CDEMIT >= MV_PAR03 .And. GX3->GX3_CDEMIT <= MV_PAR04 .And. GX3->GX3_CDOPER >= MV_PAR07 .And. GX3->GX3_CDOPER <= MV_PAR09 .And.;
					GX3->GX3_SEQ    >= MV_PAR08 .And. GX3->GX3_SEQ 	 <= MV_PAR10 .And. GX3->GX3_SIT $ cSit
	
					cDesConf := Posicione("GVI",1,xFilial("GVI")+GX3->GX3_CDOPER + GX3->GX3_SEQ,"GVI_DSCONF") 
					cDesEmit := Posicione("GU3",1,xFilial("GU3")+GX3->GX3_CDEMIT,"GU3_NMEMIT")
	
					oSection2:Init()
					oSection2:PrintLine()
					
					// 1.1.1	GX4
					// Mov x Pontos de controle (GX4): “Sequência”, “Pto Controle”, “Situação”, “Dt Entrada”, “Hr Entrada”, “Dt Saída”, “Hr Saída”, “Peso”, “Tara”, “Hodômetro”, “Endereço”, “Dt Ent End”, “Hr Ent End”, “Dt Sai End”, “Hr Sai End”;
					dbSelectArea("GX4")		// Mov x Pontos de controle
					GX4->( dbSetOrder(4) )	// GX4_FILIAL+GX4_NRMOV+GX4_SEQ+GX4_CDPTCT
					GX4->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV ) ) 
					While GX4->( !Eof() ) .And. GX4->GX4_FILIAL == (cAliasMD)->GX3_FILIAL .And. GX4->GX4_NRMOV == GX3->GX3_NRMOV
					
						cDesEnd := Posicione("GVD",1,xFilial("GVD")+GX4->GX4_CDENDE,"GVD_DSENDE")
					 
						oSection3:Init()
						oSection3:PrintLine()
	
						// INICIO GX5 - 1.1.1.1	Mov x Ponto de Controle x Pergunta (GX5): “Pergunta”, “Impeditiva”, “Resposta”;
						dbSelectArea("GX5")		// MOVIMEN PONTO COTROLE PERGUNTA
						GX5->( dbSetOrder(1) )	// GX5_FILIAL+GX5_NRMOV+GX5_CDPTCT+GX5_SEQ+GX5_CDPERG
						GX5->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV + GX4->GX4_CDPTCT ) )
						
						oSection4:Init()
						 
						While GX5->( !Eof() ) .And. GX5->GX5_FILIAL == (cAliasMD)->GX3_FILIAL .And. GX5->GX5_NRMOV == GX3->GX3_NRMOV .And. GX5->GX5_CDPTCT = GX4->GX4_CDPTCT
							
							cImped := If (Posicione("GVH",1,xFilial("GVH")+GX3->GX3_CDEMIT,"GVH_IDIMPE") == "1","Sim","Não")
							oSection4:PrintLine()
							
							GX5->( dbSkip() )
						EndDo
						
						oSection4:Finish()
						
						// FIM GX5
						
						// INICIO GXA	- 1.1.1.2	 Mov x Ponto de Controle x Doc Carga (GXA): “Tipo”, “Emissor”, “Série”, “Número”;
						dbSelectArea("GXA")		// MOVIM PTO CONTROLE DOC CARGA 
						GXA->( dbSetOrder(1) )	// GXA_FILIAL+GXA_NRMOV+GXA_CDPTCT+GXA_SEQ+GXA_CDTPDC+GXA_EMISDC+GXA_SERDC+GXA_NRDC
						GXA->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV + GX4->GX4_CDPTCT + GX4->GX4_SEQ ) )
						oSection5:Init() 
						While GXA->( !Eof() ) .And. GXA->GXA_FILIAL == (cAliasMD)->GX3_FILIAL .And. GXA->GXA_NRMOV == GX3->GX3_NRMOV .And. GXA->GXA_CDPTCT = GX4->GX4_CDPTCT
							
							oSection5:PrintLine()
							
							GXA->( dbSkip() )
						EndDo
						oSection5:Finish()
						
						// FIM GXA
						oSection3:Finish()
						
						GX4->( dbSkip() )
					EndDo
					
					// FIM GX4
	
					// INICIO GX6	- 1.1.2 Mov x Veículo (GX6): “Cd Veic”, “Placa”, “Cd Proprietário”, “Nm Proprietário”, “Marca/Modelo”, “Ano Fabricação”;
					dbSelectArea("GX6")		//	MOVIMENTACAO VEICULO      
					GX6->( dbSetOrder(1) )	//	GX6_FILIAL+GX6_NRMOV+GX6_CDVEIC
					GX6->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV ) )
					oSection6:Init()
					While GX6->( !Eof() ) .And. GX6->GX6_FILIAL == (cAliasMD)->GX3_FILIAL .And. GX6->GX6_NRMOV == GX3->GX3_NRMOV
	
						cPlaca		:= Posicione("GU8",1,xFilial("GU8")+GX6->GX6_CDVEIC,"GU8_PLACA")
						cCdProp 	:= Posicione("GU8",1,xFilial("GU8")+GX6->GX6_CDVEIC,"GU8_CDPROP")
						cNmProp	:= Posicione("GU3",1,xFilial("GU3")+cCdProp,"GU3_NMEMIT")
						cModelo	:= Posicione("GU8",1,xFilial("GU8")+GX6->GX6_CDVEIC,"GU8_MMOD")
						cAnoFab	:= Posicione("GU8",1,xFilial("GU8")+GX6->GX6_CDVEIC,"GU8_ANOFAB")

						oSection6:PrintLine()
	
						GX6->( dbSkip() )
					EndDo
					oSection6:Finish()
					// FIM GX6
	
					// INICIO GX7	- 1.1.3	Mov x Visitante (GX7): “Cd Visi”, “Nome”, “Apelido”, “CPF”;
					dbSelectArea("GX7")		//	MOVIMENTACAO VISITANTE
					GX7->( dbSetOrder(1) )	//	GX7_FILIAL+GX7_NRMOV+GX7_CDVISI
					GX7->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV ) )
					oSection7:Init() 
					While GX7->( !Eof() ) .And. GX7->GX7_FILIAL == (cAliasMD)->GX3_FILIAL .And. GX7->GX7_NRMOV = GX3->GX3_NRMOV
					
						cNmVisi	:= Posicione("GVE",1,xFilial("GVE")+GX7->GX7_CDVISI,"GVE_NMVISI")
						cNmVulgo	:= Posicione("GVE",1,xFilial("GVE")+GX7->GX7_CDVISI,"GVE_APVISI")
						cCPFVisi	:= Posicione("GVE",1,xFilial("GVE")+GX7->GX7_CDVISI,"GVE_CPF")
	
						oSection7:PrintLine()
	
						GX7->( dbSkip() )
					EndDo
					oSection7:Finish()
					// FIM GX7
	
					// INICIO GX8	- 1.1.4	Mov x Motorista (GX8): “Cd Mot”, “Nome”, “Apelido”, “CPF”;
					dbSelectArea("GX8")		//	MOVIMENTACAO MOTORISTA
					GX8->( dbSetOrder(1) )	//	GX8_FILIAL+GX8_NRMOV+GX8_CDMTR
					GX8->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV ) )
					oSection8:Init() 
					While GX8->( !Eof() ) .And. GX8->GX8_FILIAL == (cAliasMD)->GX3_FILIAL .And. GX8->GX8_NRMOV = GX3->GX3_NRMOV
	
						cNmMotora	:= Posicione("GUU",1,xFilial("GUU")+GX8->GX8_CDMTR,"GUU_NMMTR")
						cApMotora	:= Posicione("GUU",1,xFilial("GUU")+GX8->GX8_CDMTR,"GUU_PSEUD")
						cCPF		:= Posicione("GUU",1,xFilial("GUU")+GX8->GX8_CDMTR,"GUU_IDFED")
	
						oSection8:PrintLine()
	
						GX8->( dbSkip() )
					EndDo
					oSection8:Finish()
					// FIM GX8
	
					// INICIO GWV	- 1.1.5	Agendamentos (GWV): “Nr Agend”, “Tipo”;
					dbSelectArea("GWV")		//	AGENDAMENTOS
					GWV->( dbSetOrder(4) )	//	GWV_FILIAL+GWV_NRMOV
					GWV->( dbSeek( (cAliasMD)->GX3_FILIAL + GX3->GX3_NRMOV ) )
					oSection9:Init() 
					While GWV->( !Eof() ) .And. GWV->GWV_FILIAL == (cAliasMD)->GX3_FILIAL .And. GWV->GWV_NRMOV = GX3->GX3_NRMOV
						
						oSection9:PrintLine()
	
						GWV->( dbSkip() )
					EndDo
					oSection9:Finish()
					// FIM GWV
					
					oSection2:Finish()
				EndIf

				GX3->( dbSkip() )
			EndDo
			
		EndIf
		
		(cAliasMD)->( dbSkip() )
	EndDo

	//MsUnlock((cTabTotMD))

Return Nil

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CarregaDados
A funcao estatica CarregaDados Alimentam as tabelas temporárias cTabTotMD 
Faz a leitura do Pergunte GFER519
@author helder.santos
@version 1.0
@since 03/03/2014
@return Nil

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CarregaDados()
	Local aArea := GetArea(), cQuery := ""
	Local cFltrGX3 := "", cFltrGWV := "" 

	CriaTabTemp()
	
	/*
	01 Filial de					GX3_FILIAL
	02 Filial até					
	03 Transportador de			GU3_CDEMIT
	04 Transportador até			
	05 Data Movimentação de		GX3_DTCRIA
	06 Data Movimentação até 
	07 Operação de				GVI_CDOPER		14
	08 Seq de						GVI_SEQ		3
	09 Operação até				GVI_CDOPER
	10 Seq até						GVI_SEQ
	11 Situação					GX3_SIT	(1=Aberto; 2=Movimentado; 3=Em Fila; 4=Endereçado; 5=Cancelado; 6=Concluído)
	12 Agendamento				GWV_NRAGEN
	13 Resumido ou Detalhado
	*/

	cFltrGX3 += " AND GX3.GX3_FILIAL >= '" + MV_PAR01 		+ "' AND GX3.GX3_FILIAL 	<= '" + MV_PAR02 + "' "	
	cFltrGX3 += " AND GX3.GX3_CDEMIT >= '" + MV_PAR03 		+ "' AND GX3.GX3_CDEMIT 	<= '" + MV_PAR04 + "' "
	cFltrGX3 += " AND GX3.GX3_DTCRIA >= '" + DTOS(MV_PAR05) + "' AND GX3.GX3_DTCRIA 	<= '" + DTOS(MV_PAR06) + "' " 
	cFltrGX3 += " AND GX3.GX3_CDOPER >= '" + MV_PAR07 		+ "' AND GX3.GX3_CDOPER 	<= '" + MV_PAR09 + "' "
	cFltrGX3 += " AND GX3.GX3_SEQ    >= '" + MV_PAR08 		+ "' AND GX3.GX3_SEQ 	<= '" + MV_PAR10 + "' "

	// SITUACAO MOV. (1=Aberto; 2=Movimentado; 3=Em Fila; 4=Endereçado; 5=Cancelado; 6=Concluído)
	Do Case
		Case MV_PAR11 == 1
			cFltrGX3 += " AND GX3.GX3_SIT IN('1','2','3','4') "
			cSit     := " ('1','2','3','4') "
		Case MV_PAR11 == 2
			cFltrGX3 += " AND GX3.GX3_SIT = '5' "
			cSit     := " '5' "
		Case MV_PAR11 == 3
			cFltrGX3 += " AND GX3.GX3_SIT = '6' "
			cSit     := " '6' "
	EndCase
	
	If AllTrim(MV_PAR12) != ""
		cFltrGWV += " AND GWV.GWV_NRAGEN = '" + MV_PAR12 + "' "
	EndIf
	
	cAliasMD := GetNextAlias()

	cQuery += "SELECT	GX3.GX3_FILIAL, GX3.GX3_DTCRIA,"
	cQuery += "		COUNT(DISTINCT GX3.GX3_NRMOV) QTD_MOVTOS,"
	cQuery += "		SUM(GWV.QTD) QTD_COMAGE,"
	cQuery += "		COUNT(CASE WHEN GX3_SIT = '5' THEN 1 END) QTD_CANCEL,"
	cQuery += "		COUNT(CASE WHEN GX3_SIT = '6' THEN 1 END) QTD_CONCLU,"
	cQuery += "		SUM(GWD.QTD) QTD_OCOR,"
	cQuery += "		SUM(GX6.QTD) QTD_VEI,"
	cQuery += "		SUM(GX8.QTD) QTD_MOT,"
	cQuery += "		SUM(GXA.QTD) QTD_DOCCARG,"
	cQuery += "		SUM(GX4.QTD) QTD_ENDUTI"
	cQuery += "  FROM "+ RetSQLName("GX3") +" GX3"

	cQuery += "  LEFT JOIN ( SELECT GWV_FILIAL, GWV_NRMOV, GWV_NRAGEN, COUNT(*) QTD" 
	cQuery += "                FROM "+ RetSQLName("GWV") +" GWV"
	cQuery += "               WHERE GWV.D_E_L_E_T_ = ''"
	cQuery += "			     GROUP BY GWV_FILIAL, GWV_NRMOV, GWV_NRAGEN"
	cQuery += "			  ) GWV ON GWV.GWV_FILIAL = GX3.GX3_FILIAL"
	cQuery += "					AND GWV.GWV_NRMOV  = GX3.GX3_NRMOV"

	cQuery += "  LEFT JOIN "+ RetSQLName("GU3") +" GU3 ON GU3.GU3_CDEMIT = GX3.GX3_CDEMIT"
	cQuery += "						  					 AND GU3.D_E_L_E_T_ = ''"

	cQuery += "  LEFT JOIN ( SELECT GWD_FILIAL, GWD_NRMOV, COUNT(*) QTD"
	cQuery += "                FROM "+ RetSQLName("GWD") +" GWD"
	cQuery += "			     WHERE GWD.D_E_L_E_T_ = ''"
	cQuery += "			     GROUP BY GWD_FILIAL, GWD_NRMOV"
	cQuery += "			  ) GWD ON GWD.GWD_FILIAL = GX3.GX3_FILIAL"
	cQuery += "                 AND GWD.GWD_NRMOV  = GX3.GX3_NRMOV"

	cQuery += "  LEFT JOIN (	SELECT GX6_FILIAL, GX6_NRMOV, COUNT(*) QTD" 
	cQuery += "				  FROM "+ RetSQLName("GX6") +" GX6"
	cQuery += "				 WHERE GX6.D_E_L_E_T_ = ''"
	cQuery += "				 GROUP BY GX6_FILIAL, GX6_NRMOV"
	cQuery += "			  ) GX6 ON GX6.GX6_FILIAL = GX3.GX3_FILIAL"
	cQuery += "                 AND GX6.GX6_NRMOV  = GX3.GX3_NRMOV"

	cQuery += "  LEFT JOIN ( SELECT GX8_FILIAL, GX8_NRMOV, COUNT(*) QTD" 
	cQuery += "			      FROM "+ RetSQLName("GX8") +" GX8"
	cQuery += "			     WHERE GX8.D_E_L_E_T_ = ''"
	cQuery += "			     GROUP BY GX8_FILIAL, GX8_NRMOV"
	cQuery += "			  ) GX8 ON GX8.GX8_FILIAL = GX3.GX3_FILIAL"
	cQuery += "                 AND GX8.GX8_NRMOV  = GX3.GX3_NRMOV"

	cQuery += "  LEFT JOIN (	SELECT GXA_FILIAL, GXA_NRMOV, COUNT(*) QTD" 
	cQuery += "				  FROM "+ RetSQLName("GXA") +" GXA"
	cQuery += "			     WHERE GXA.D_E_L_E_T_ = ''"
	cQuery += "			     GROUP BY GXA_FILIAL, GXA_NRMOV"
	cQuery += "			  ) GXA ON GXA.GXA_FILIAL = GX3.GX3_FILIAL"
	cQuery += "                 AND GXA.GXA_NRMOV  = GX3.GX3_NRMOV"

	cQuery += "  LEFT JOIN ( SELECT GX4_FILIAL, GX4_NRMOV, COUNT(*) QTD" 
	cQuery += "				  FROM "+ RetSQLName("GX4") +" GX4"
	cQuery += "			     WHERE GX4.D_E_L_E_T_ = ''"
	cQuery += "			       AND GX4.GX4_CDENDE != ''"
	cQuery += "			     GROUP BY GX4_FILIAL, GX4_NRMOV"
	cQuery += "			  ) GX4 ON GX4.GX4_FILIAL = GX3.GX3_FILIAL"
	cQuery += "                 AND GX4.GX4_NRMOV  = GX3.GX3_NRMOV"

	cQuery += " WHERE GX3.D_E_L_E_T_ = '' "
	cQuery += cFltrGX3 + cFltrGWV
	cQuery += " GROUP BY GX3.GX3_FILIAL, GX3.GX3_DTCRIA"

	cQuery := ChangeQuery(cQuery)

	dbUseArea( .T., "TOPCONN", TCGENQRY(,,cQuery),cAliasMD, .F., .T.)
	dbSelectArea((cAliasMD))
	(cAliasMD)->( dbGoTop() )

	RestArea(aArea)
Return

//--------------------------------------------------------------------------------------------------------
/*/ {Protheus.doc}  CriaTabTemp
Esta funcao estatica cria a struct dos dados do relatório e cria as tabelas temporárias, privadas em U_GFER519() 

@author helder.santos
@version 1.0
@since 03/03/2014
@return {aStruOpTot} Array com Struct dos campos

/*/
//--------------------------------------------------------------------------------------------------------

Static Function CriaTabTemp()
	Local aStruOpTot
	
	aStruOpTot :=	{	{"GX3_DTCRIA","D",8,0},;
						{"QTD_MOVTOS","N",9,0};
					}

	cTabTotMD := GFECriaTab({aStruOpTot,{"QTD_MOVTOS"}})
	
Return {aStruOpTot}


/*/{Protheus.doc} GetSx3Inf
	
@author helder.santos
@since 03/03/2014
@version 1.0

@param cCampo, character, Campo  do Banco de dados 
@param aRetorno, array, Opcional, Informações de Retorno caso não encontre o Campo

@description

Função que busca no sx3 as informações de titulo,cbox,picture e descrição do campo
e retorna um array nessa ordem, ou caso não encontre o campo, retorna o segundo parametro

@example

GetSx3Inf("GW1_FILIAL") Retorno {"Filial","","@!","Filial"}
GetSx3Inf("GW1_FILI",{"Fila","1=Sim;2=Nao","","Fila de espera"})Retorno {"Fila","1=Sim;2=Nao","","Fila de espera"} 

@return aArray:={X3Titulo, X3Cbox,X3Picture,X3DESCRIC}
/*/

Static Function GetSx3Inf(cCampo,aRetorno)
Local nCont := 1
Local aArea := GetArea("SX3")
Default aRetorno := {"","","",""}
	For nCont := 1 to 4-Len(aRetorno)
		aAdd(aRetorno,"")
	Next
	dbSelectArea("SX3")
	dbSetOrder(2)
	If dbSeek( cCampo )   
		aRetorno[1] := X3Titulo()
		aRetorno[2] := X3Cbox()
		aRetorno[3] := X3Picture()
		aRetorno[4] := X3DESCRIC()
	EndIf
	RestArea(aArea)
Return aRetorno