/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma pr·tica e de f·cil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "GPER270.CH"
#include "report.ch"

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Programa  ≥ GPER270  ≥ Autor ≥ Equipe RH          ≥ Data ≥  09/04/06      ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Descricao ≥  Ficha Financeira                                             ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫         ATUALIZACOES SOFRIDAS DESDE A CONSTRUÄAO INICIAL                 ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Programador ≥ Data   ≥ FNC 		   ≥  Motivo da Alteracao 	             ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Raquel Hager∫13/03/13∫M12RH01 RQ4501∫Unificacao das Folhas de Pagamento.  ∫±±
±±∫Raquel Hager∫24/10/13∫M12RH01 RQ4501∫Correcao na query para captura de    ∫±±
±±∫        	   ∫        ∫              ∫Filial em CTT/SRJ.			         ∫±±
±±∫Mariana M.  ∫21/01/16∫              ∫Ajuste no alinhamento dos valores do ∫±±
±±∫        	   ∫        ∫              ∫relatorio							 ∫±±
±±∫Raquel Hager∫17/05/16∫TUGZN1		   ∫Captura dos dados do 13 Salario      ∫±±
±±∫        	   ∫        ∫              ∫pelo roteiro de calculo(131/132)     ∫±±
±±∫        	   ∫        ∫              ∫Ajuste no posicionamento quando      ∫±±
±±∫        	   ∫        ∫              ∫impressa a quantidade de horas.      ∫±±
±±∫Raquel Hager∫03/06/16∫TUGZN1		   ∫Captura dos dados do 13 Salario      ∫±±
±±∫        	   ∫        ∫              ∫pelo roteiro de calculo(131/132)     ∫±±
±±∫        	   ∫        ∫              ∫para impressao por Competencia.      ∫±±
±±∫Flavio Corr.∫07/06/16∫TVBWVZ        ∫CorreÁ„o titulo relatÛrio            ∫±±
±±∫Gabriel A.  ∫13/06/16∫TVBWVZ        ∫Alterado para vincular o fonte.      ∫±±
±±∫Matheus B.  ∫13/01/17∫MRH-4752      ∫Melhoria na ficha financeira para    ∫±±
±±∫            ∫        ∫              ∫exibir uma linha referente provento  ∫±±
±±∫            ∫        ∫              ∫atual, e o desconto do mÍs anterior  ∫±±
±±∫            ∫        ∫              ∫Facilitando a conferÍncia da DIRF    ∫±±
±±∫Henrique F. ∫15/01/18∫DRHPAG-5815   ∫Ajuste na impress„o do nome do       ∫±±
±±∫            ∫        ∫              ∫funcion·rio (RA_NOME) da 20 para 30  ∫±±
±±∫            ∫        ∫              ∫caracteres                           ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/
User Function GPER270()
Local oReport
Private cAliasSRA 	:= "SRA"
Private cAliasSRD	:= GetNextAlias()
Private aTotalSub	:= {}
Private cFilAntSv	:= ""
Private nXMes		:= 1
Private nYMes		:= 1
Private aMeses		:= {}
Private cDesc_Txt 	:= ""
Private cCpdVb   	:= ""
Private cInciden  	:= ""
Private oBreak4
Private nPDB		:= 1
Private cDescInsFer  	:= SuperGetMV("MV_DINSSFM", Nil, "S")

		// Interface de impressao
		Pergunte("GP270R",.F.)

		// Variaveis utilizadas para parametros
		// mv_par01        //  Filial
		// mv_par02        //  Centro de Custo
		// mv_par03        //  Matricula
		// mv_par04        //  Nome
		// mv_par05        //  Ano Base
		// mv_par06        //  Situacoes
		// mv_par07        //  Categorias
		// mv_par08        //  Imprime Incidencias	: 1-"Sim";2-"Nao"
		// mv_par09        //	Incidencias a Imprimir
		// mv_par10        //	Ficha Financeira: 1 - "Compet.";2-"DtPag.
		// mv_par11        //	Imprime Horas   : 1 - "Sim"	; 2 - "Nao"

	   	oReport := ReportDef()
	   	oReport:SetLandScape()
		oReport:PrintDialog()

Return


/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Funcao    ≥ ReportDef ≥ Autor ≥ Equipe RH          ≥ Data ≥  12/06/06  ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ GPER270                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/
Static Function ReportDef()
Local oReport
Local oSRA,oSRD2,oSRD3,oSRD4
Local cDesc		:=	STR0001		// "Relacao da Ficha Financeira"
Local aOrd		:= {STR0004,STR0005,STR0006}	// "Matricula"###"Centro de Custo"###"Nome"
Local cTit		:= STR0010
Local nCodFunc	:= TamSx3("RJ_FUNCAO")[1]

	DEFINE REPORT oReport NAME "GPER270" TITLE OemToAnsi(cTit) PARAMETER "GP270R" ACTION {|oReport| R270Imp(oReport)} DESCRIPTION OemtoAnsi(STR0060)

		DEFINE SECTION oSRA OF oReport TITLE OemToAnsi(STR0061) ORDERS aOrd TABLES "SRA","CTT","SRJ" PAGE HEADER

			// O filtro esta sendo feito sobre o (cAlias) alias SRJ e nao pelo SRA
			TRPosition():New(oSRA,"CTT",1,{|| xFilial("CTT",cFilAntSv)+(cAliasSRA)->RA_CC    } ,.T.  )
			TRPosition():New(oSRA,"SRJ",1,{|| xFilial("SRJ",cFilAntSv)+(cAliasSRA)->RA_CODFUNC },.T. )

			DEFINE CELL NAME "RA_FILIAL" 	OF oSRA					SIZE 15 BLOCK {|| cFilAntSv + " " + aInfo[1] }
			DEFINE CELL NAME "RA_MAT"		OF oSRA ALIAS "SRA"		SIZE 17
			DEFINE CELL NAME "RA_CC"		OF oSRA ALIAS "SRA"		SIZE 12
			DEFINE CELL NAME "CTT_DESC01"	OF oSRA ALIAS "CTT"		SIZE 20	 					TITLE STR0066
			DEFINE CELL NAME "RA_NOME"		OF oSRA ALIAS "SRA" 	SIZE 30
			DEFINE CELL NAME "RA_CATFUNC"	OF oSRA ALIAS "SRA" 	SIZE 5 						TITLE STR0017
			DEFINE CELL NAME "RA_SALARIO"	OF oSRA ALIAS "SRA" 	PICTURE "@E 999,999,999.99" TITLE OEMTOANSI(STR0018)
			DEFINE CELL NAME "RA_CODFUNC"	OF oSRA ALIAS "SRA"		SIZE nCodFunc
			DEFINE CELL NAME "RJ_DESC"		OF oSRA ALIAS "SRJ"		SIZE 15
			DEFINE CELL NAME "CODCBO"		OF oSRA					BLOCK {|| fCodCBO(cFilAntSv,SRA->RA_CODFUNC,cAnoBase) }
			DEFINE CELL NAME "RA_ADMISSA"	OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_OPCAO"		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_DEMISSA"	OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_NUMCP"		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_SERCP"		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_CIC" 		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_PIS"		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_RG"		OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_HRSMES"	OF oSRA ALIAS "SRA"
			DEFINE CELL NAME "RA_HRSEMAN"	OF oSRA ALIAS "SRA"
			oSRA:SetLineStyle()  // Horizontal descricao
			oSRA:SetHeaderBreak(.F.)
			oSRA:SetLineBreak(.T.)
			oSRA:AutoSize(.T.)
			oSRA:SetCharSeparator(":")
			oSRA:SetColSpace(5)  	// Espaco entre colunas - importante quando o conte˙do campo usar o espaÁo todo disponÌvel

		// Section VERBAS
		DEFINE SECTION oSRD2 OF oReport TITLE OemToAnsi(STR0062) TABLES "SRD","SRV"

			DEFINE CELL NAME "RD_PD" 		OF oSRD2 	TITLE STR0062	ALIAS "SRD" SIZE 05	BLOCK {|| aMeses[ nXMes , 1]  }
			DEFINE CELL NAME "RV_DESC" 		OF oSRD2	                ALIAS "SRV" SIZE 15
			DEFINE CELL NAME "CINCID"		OF oSRD2 	TITLE STR0046  	SIZE 11	BLOCK {|| cInciden	}
			DEFINE CELL NAME "JANEIRO"		OF oSRD2 	TITLE STR0047  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 01 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "FEVEREIRO"	OF oSRD2 	TITLE STR0048  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 02 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "MARCO"		OF oSRD2 	TITLE STR0049  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 03 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "ABRIL"		OF oSRD2 	TITLE STR0050  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 04 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "MAIO"			OF oSRD2 	TITLE STR0051  	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 05 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "JUNHO"		OF oSRD2 	TITLE STR0052  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 06 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "JULHO"		OF oSRD2 	TITLE STR0053  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 07 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "AGOSTO"		OF oSRD2 	TITLE STR0054  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 08 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "SETEMBRO"		OF oSRD2 	TITLE STR0055  	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 09 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "OUTUBRO"		OF oSRD2 	TITLE STR0056  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 10 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "NOVEMBRO"		OF oSRD2 	TITLE STR0057  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 11 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "DEZEMBRO"		OF oSRD2 	TITLE STR0058  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 12 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "13SALARIO"	OF oSRD2 	TITLE STR0059  	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 4 , nYMes , 13 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "TOTAL"		OF oSRD2 	TITLE STR0044  	SIZE 12	Align LEFT BLOCK {|| nValorRet }						Picture "@E 99999999999.99"
			oSRD2:SetHeaderBreak(.F.)

		// Section HORA
		DEFINE SECTION oSRD3 OF oReport  TITLE OemToAnsi(STR0063) TABLES "SRD"

			DEFINE CELL NAME "RD_PD" 		OF oSRD3 	TITLE STR0062	SIZE 05	BLOCK {|| " "  }
			DEFINE CELL NAME "HORA"			OF oSRD3 	TITLE STR0045   Size 14  BLOCK {|| STR0069 }
			DEFINE CELL NAME "CINCID"		OF oSRD3 	TITLE STR0046   Size 12
			DEFINE CELL NAME "HJANEIRO"		OF oSRD3 	TITLE STR0047	Size 12	Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 01 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HFEVEREIRO"	OF oSRD3 	TITLE STR0048	SIZE 12	Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 02 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HMARCO"		OF oSRD3 	TITLE STR0049	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 03 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HABRIL"		OF oSRD3 	TITLE STR0050	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 04 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HMAIO"		OF oSRD3 	TITLE STR0051	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 05 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HJUNHO"		OF oSRD3 	TITLE STR0052	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 06 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HJULHO"		OF oSRD3 	TITLE STR0053	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 07 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HAGOSTO"		OF oSRD3 	TITLE STR0054	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 08 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HSETEMBRO"	OF oSRD3 	TITLE STR0055	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 09 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HOUTUBRO"		OF oSRD3 	TITLE STR0056	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 10 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HNOVEMBRO"	OF oSRD3 	TITLE STR0057	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 11 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HDEZEMBRO"	OF oSRD3 	TITLE STR0058	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 12 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "H13SALARIO"	OF oSRD3 	TITLE STR0059	SIZE 12 Align LEFT BLOCK {|| aMeses[ nXMes , 5 , nYMes , 13 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HTOTAL"		OF oSRD3 	TITLE STR0044	SIZE 14 Align LEFT BLOCK {|| nValorRet  }						Picture "@E 99999999999.99"
			oSRD3:SetHeaderBreak(.F.)
			oSRD3:SetHeaderSection(.F.)

		// Section PROVENTOS/DESCONTO/BASE
		DEFINE SECTION oSRD4 OF oReport  TITLE OemToAnsi(STR0064) TABLES "SRD"

			If cPaisLoc == "BOL"
				DEFINE CELL NAME "RD_MAT"		OF oSRD4    ALIAS "SRD"		SIZE 17 BLOCK {|| cRA_Mat }
				DEFINE CELL NAME "RD_CC"		OF oSRD4    ALIAS "SRD"		SIZE 17 BLOCK {|| cRA_CC }
			Endif
			DEFINE CELL NAME "MSDIRF" 		OF oSRD4 	TITLE ''		SIZE 34 BLOCK {|| ''  }
			DEFINE CELL NAME "RD_PD" 		OF oSRD4 	TITLE STR0062	SIZE 05 BLOCK {|| STR0044  }
			DEFINE CELL NAME "HORA"			OF oSRD4 	TITLE STR0045   Size 14 BLOCK {|| " " }
			DEFINE CELL NAME "CINCID"		OF oSRD4 	TITLE STR0046   Size 12
			DEFINE CELL NAME "HJANEIRO"		OF oSRD4 	TITLE STR0047	Size 12	Align LEFT BLOCK {|| aTotalSub[nPDB,2,01 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HFEVEREIRO"	OF oSRD4 	TITLE STR0048	SIZE 12	Align LEFT BLOCK {|| aTotalSub[nPDB,2,02 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HMARCO"		OF oSRD4 	TITLE STR0049	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,03 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HABRIL"		OF oSRD4 	TITLE STR0050	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,04 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HMAIO"		OF oSRD4 	TITLE STR0051	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,05 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HJUNHO"		OF oSRD4 	TITLE STR0052	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,06 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HJULHO"		OF oSRD4 	TITLE STR0053	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,07 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HAGOSTO"		OF oSRD4 	TITLE STR0054	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,08 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HSETEMBRO"	OF oSRD4 	TITLE STR0055	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,09 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HOUTUBRO"		OF oSRD4 	TITLE STR0056	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,10 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HNOVEMBRO"	OF oSRD4 	TITLE STR0057	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,11 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HDEZEMBRO"	OF oSRD4 	TITLE STR0058	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,12 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "H13SALARIO"	OF oSRD4 	TITLE STR0059	SIZE 12 Align LEFT BLOCK {|| aTotalSub[nPDB,2,13 ] }   Picture "@E 999999999.99"
			DEFINE CELL NAME "HTOTAL"		OF oSRD4 	TITLE STR0044	SIZE 14 Align LEFT BLOCK {|| nValorRet  }			 Picture "@E 99999999999.99"
			oSRD4:SetHeaderBreak(.F.)

Return( oReport )

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Funcao    ≥ R270Imp  ≥ Autor ≥ Equipe RH          ≥ Data ≥  09/05/06   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ GPER270                                                    ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/
Static Function R270Imp(oReport)
//-- Objeto
Local oSection1 	:= oReport:Section(1)
Local oSection2 	:= oReport:Section(2)
Local oSection3 	:= oReport:Section(3)
Local oSection4 	:= oReport:Section(4)
Local nOrdem		:= oSection1:GetOrder()
Local oBreakcc

Local aCodFol   	:= {}
Local COL	   		:= ""
Local cFi			:= ""
Local cMa			:= ""
Local cCPd			:= ""
Local cDesc			:= ""
Local cCab			:= ""
Local cCab1	   		:= ""
Local cAlter		:= ""
Local cMesBase		:= ""
Local cMesDtAr		:= ""
Local cAnoDtAr		:= ""
Local cBlank		:= ""
Local cSitQuery 	:= ""
Local cCatQuery 	:= ""
Local cFilCTT 		:= ""
Local cFilSRJ 		:= ""
Local cData_Ini 	:= ""
Local cData_Fim 	:= ""
Local cDet
Local CbTxt
Local CbCont
Local lQuery    	:= .F.
Local lPrnProv 		:= .F.
Local lPrnDesc		:= .F.
Local lProvent 		:= .F.
Local lDescont		:= .F.
Local lFirst		:= .T.
Local Vetor     	:= 0.00
Local nX			:= 0.00
Local nY			:= 0.00
Local nW			:= 0.00
Local nPos			:= 0.00
Local nTotac		:= 0.00
Local nTotHo		:= 0.00
Local nTotLi		:= 0.00
Local nValLinha 	:= 0.00
Local nHorLinha 	:= 0.00
Local nLegenda 		:= 1.00
Local nREg 			:= 0
// Variaveis de Acesso do Usuario
Local cAcessaSRA	:= fSFiltrSQL(ChkRH( "GPER270" , "SRA" , "2" ))
Local cWhereSRA		:= "%%"
Local cAcessaSRD	:= fSFiltrSQL(ChkRH( "GPER270" , "SRD" , "2" ))
Local cRaisPar		:= ""
Local cCond			:= ""
Local cCond2		:= ""
Local cOrdem		:= ""
Local cRoteiro
Local cRotFol		:= fGetRotOrdinar()
Local lPass			:= .T.
Local nCont			:= 0
Local nFor        	:= 0
Local aMesAux		:= {}
Local cPerFimAdi	:=  ""
Local cAdiDesc		:=  ""
Local lRegTrans		:= .F.
Local aTransf		:= {}

// Define Variaveis Private(Programa)
Private aTotais[2,2,13]
Private cFilSRV		:= ""
Private cRots		:= ""
Private cRA_Filial	:= ""
Private cRA_Mat 	:= ""
Private cRA_CC 		:= ""
Private aPosicao1 	:= {}
Private aTotCc1   	:= {}
Private aTotFil1  	:= {}
Private aTotEmp1  	:= {}
Private aInfo     	:= {}
Private cLinAux	  	:= ""
Private nChave    	:= 0
Private nValorRet 	:= 0
// Variaveis Utilizadas na funcao IMPR
Private cPict1	:=	If (MsDecimais(1)==2,"@E 999999999.99",TM(999999999,12,MsDecimais(1)))  // "@E 99999999999.99
Private cPict2	:=	If (MsDecimais(1)==2,"@E 999,999,999.99",TM(999999999,12,MsDecimais(1)))  // "@E 99999999999.99
Private ADI     :=  0
Private nTotFer	:=  0

	// Carregando variaveis mv_par?? para Variaveis do Sistema.
	cFilPar		:= mv_par01							//  Filial
	cCcPar		:= mv_par02							//  Centro de Custo
	cMatPar		:= mv_par03							//  Matricula
	cNomePar	:= mv_par04							//  Nome
	cAnoBase	:= mv_par05							//  Ano Base
	cSituacao	:= mv_par06							//  Situacoes
	cCategoria	:= mv_par07							//  Categorias
	lImprInc	:= IF(mv_par08 == 1 .And. cPaisLoc == "BRA", .T. , .F. )	//	Imprime Incidencias	: 1 - "Sim"			; 2 - "Nao"
	cIncImpr    := AllTrim( mv_par09 )				//	Incidencias a Imprimir
	lCompetenc	:= IF( mv_par10 == 1 , .T. , .F. )	//	Ficha Financeira	: 1 - "Competencia" ; 2 - "Data Pagamento"
	lImprimeHr	:= IF( mv_par11 == 1 , .T. , .F. )	//	Imprime Horas   	: 1 - "Sim"			; 2 - "Nao"
	cRoteiro	:= mv_par12
	nADI		:= Iif(Empty(mv_par13),2,mv_par13)
	nFer		:= Iif(Empty(mv_par14),2,mv_par14)

	//⁄ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒø
	//≥ Mascara do Relatorio                                         ≥
	//¿ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ
	//"       F I C H A    F I N A N C E I R A    "###"COMPETENCIA"###"DATA DE PAGAMENTO"
	/*"VER DESCRICAO               1-2-3-4-5       JANEIRO    FEVEREIRO        MARCO        ABRIL         MAIO        JUNHO        JULHO       AGOSTO     SETEMBRO      OUTUBRO     NOVEMBRO     DEZEMBRO  13o SALARIO        TOTAL"
	            10        20        30        40        50        60        70        80        90       100       110       120       130       140       150       160       170       180       190       200       210       220
	   1234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890
	   CCC AAAAAAAAAAAAAAAAAAAA    A-A-A-A-A  999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999,99 999999999.99
	   123 12345678901234567890    123456789  123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012 123456789012
	   H O R A S		   						999,99       999.99       999,99       999,99       999,99       999,99       999,99       999,99       999,99       999,99       999,99       999,99       999,99     99999.99*/


	// Colunas dos Valores
	COL01 := 039	// JANEIRO
	COL02 := 052	// FEVEREIRO
	COL03 := 065	// MARCO
	COL04 := 078	// ABRIL
	COL05 := 091	// MAIO
	COL06 := 104	// JUNHO
	COL07 := 117	// JULHO
	COL08 := 130	// AGOSTO
	COL09 := 143	// SETEMBRO
	COL10 := 156	// OUTUBRO
	COL11 := 169	// NOVEMBRO
	COL12 := 182	// DEZEMBRO
	COL13 := 195	// 13o SALARIO
	COLTO := 208	// TOTAL

	// Nao Imprime a Legenda
	If cPaisLoc<>"BRA"
		cLinAux := Stuff( cLinAux , At("1-",cLinAux) , 9 , Space( 09 ) )
		nLegenda := 0.00
	EndIf

	For nX := 1 To 2
		For nY := 1 To 2
			aFill( aTotais[ nX , nY ] , 0 )
		Next nX
	Next nX

	If nOrdem == 1
		oBreakCc 	:= TRBreak():New(oSection1,{|| (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT},STR0004, .F.,,.t.) 		// quebra por Matricula
	ElseIf nOrdem == 2
		oBreakCc 	:= TRBreak():New(oSection1,{|| (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_CC},STR0005, .F.,,.t.)		// Centro de custo
	ElseIf nOrdem == 3
		oBreakCc 	:= TRBreak():New(oSection1,{|| (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_NOME},STR0006, .F.,,.t.) 	// Nome
	EndIf

	oBreakCc:SetPageBreak()

	cAliasSRA := GetNextAlias()

	// Modifica variaveis para a Query
	cSitQuery := ""
	For nReg := 1 to Len(cSituacao)
		cSitQuery += "'"+Subs(cSituacao,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cSituacao)
			cSitQuery += ","
		EndIf
	Next nReg
	cSitQuery := "%" + cSitQuery + "%"

	cCatQuery := ""
	For nReg := 1 to Len(cCategoria)
		cCatQuery += "'"+Subs(cCategoria,nReg,1)+"'"
		If ( nReg+1 ) <= Len(cCategoria)
			cCatQuery += ","
		EndIf
	Next nReg
	cCatQuery := "%" + cCatQuery + "%"

	If !Empty(cRoteiro)
		cRots:=""
		For nFor := 1 To Len(ALLTRIM(cRoteiro)) Step 3
			cRots+= "'"+Subs(cRoteiro,nFor,3)+"'"
			If Len(ALLTRIM(cRoteiro)) > ( nFor+3 )
				cRots += ","
			EndIf
		Next nFor
		cRots := "%SRD.RD_ROTEIR IN  (" + cRots + ")%"
	Else
		cRots := "% ' ' = ' ' %"
	EndIf

	If !Empty(cAcessaSRA) .And. cAcessaSRA != ".T."
		cWhereSRA := "%" + cAcessaSRA + " AND %"
	EndIf
	// Transforma parametros do tipo Range em expressao ADVPL para ser utilizada no filtro
	MakeSqlExpr("GP270R")

	oReport:SetTitle(STR0010 + mv_par05 + " " + IF(lCompetenc,STR0040,STR0041 ))

	BEGIN REPORT QUERY oSection1

	If nOrdem == 1
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_MAT%"
	ElseIf nOrdem == 2
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_CC,SRA.RA_MAT%"
	ElseIf nOrdem == 3
		cOrdem := "%SRA.RA_FILIAL,SRA.RA_NOME,SRA.RA_MAT%"
	EndIf

	cFilCTT := "%AND " + FWJoinFilial("CTT", "SRA") + "%"
	cFilSRJ := "%AND " + FWJoinFilial("SRJ", "SRA") + "%"

	BeginSql alias cAliasSRA
		SELECT 	SRA.RA_FILIAL,	SRA.RA_MAT, 	SRA.RA_TNOTRAB, SRA.RA_SITFOLH, SRA.RA_CATFUNC, SRA.RA_CC,
				SRA.RA_NOME,	SRA.RA_DEMISSA,	SRA.RA_ADMISSA, SRA.RA_CODFUNC,	SRA.RA_SALARIO, SRA.RA_OPCAO,
				SRA.RA_NUMCP,   SRA.RA_SERCP,   SRA.RA_CIC,  	SRA.RA_PIS,  	SRA.RA_HRSMES, SRA.RA_HRSEMAN, SRA.RA_RG
		FROM %table:SRA% SRA
		LEFT JOIN %table:CTT% CTT
			ON	SRA.RA_CC	=	CTT.CTT_CUSTO
			%exp:cFilCTT%

		LEFT JOIN %table:SRJ% SRJ
			ON	SRA.RA_CODFUNC	=	SRJ.RJ_FUNCAO
			%exp:cFilSRJ%


		WHERE	SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
			    SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
				%exp:cWhereSRA%
				SRA.%notDel% AND CTT.%notDel% AND SRJ.%notDel%
		ORDER BY %exp:cOrdem%
	EndSql

	END REPORT QUERY oSection1 PARAM mv_par01, mv_par02, mv_par03, mv_par04

	cAliasTMP := "QNRO"
	BeginSql alias cAliasTMP
		SELECT COUNT(*) as NROREG
		FROM %table:SRA% SRA
		LEFT JOIN %table:CTT% CTT
			ON	SRA.RA_CC	=	CTT.CTT_CUSTO
			%exp:cFilCTT%

		LEFT JOIN %table:SRJ% SRJ
			ON	SRA.RA_CODFUNC	=	SRJ.RJ_FUNCAO
			%exp:cFilSRJ%

		WHERE	SRA.RA_SITFOLH	IN	(%exp:Upper(cSitQuery)%) 	AND
			    SRA.RA_CATFUNC	IN	(%exp:Upper(cCatQuery)%)	AND
				%exp:cWhereSRA%
				SRA.%notDel% AND CTT.%notDel% AND SRJ.%notDel%
	EndSql

	nRegProc := (cAliasTMP)->(NROREG)
	( cAliasTMP )->( dbCloseArea() )

	// Define o total da regua da tela de processamento do relatorio
	oReport:SetMeter(nRegProc)
	oSection1:Init()
	oSection3:Init()

	cFilAntSv := Replicate("!", FwGetTamFilial)
	(cAliasSRA)->( dbGotop())

	While !(cAliasSRA)->(EOF() )

		// Incrementa a rÈgua da tela de processamento do relatÛrio
		oReport:IncMeter()

		// Verifica se o usu·rio cancelou a impress„o do relatorio
		If oReport:Cancel()
			Exit
		EndIf

		If (cAliasSRA)->RA_FILIAL # cFilAntSv
			If !Fp_CodFol(@aCodFol,(cAliasSRA)->RA_FILIAL) .Or. !fInfo(@aInfo,(cAliasSRA)->RA_FILIAL)
				Exit
			Endif
			dbSelectArea( cAliasSRA )
			cFilAntSv := (cAliasSRA)->RA_FILIAL
		EndIf

		// Consiste Filiais e Acessos
		If !( (cAliasSRA)->RA_FILIAL $ fValidFil() )
			dbSelectArea(cAliasSRA)
	      	dbSkip()
	       	Loop
		EndIf

		cRA_Filial 	:= (cAliasSRA)->RA_FILIAL
		cRA_MAT		:= (cAliasSRA)->RA_MAT
		cRA_CC		:= (cAliasSRA)->RA_CC

		// Zero transferÍncias do funcion·rio anterior para carregar transferÍncias do funcion·rio atual
		aTransf	:= {}
		SRA->(dbSetOrder(1))
		SRA->(dbSeek(cRA_Filial+cRA_MAT))
		fTransf(@aTransf)

		If !Empty(cAcessaSRD) .And. cAcessaSRD != ".T."
			cBlank := "%' ' AND " + cAcessaSRD + "%"
		Else
			cBlank:= "%' '%"
		EndIf

		cFilSRV := "%AND SRV.RV_FILIAL  = '" + xFilial("SRV", cRA_Filial) + "'%"

		If lCompetencia
			cOrdem := "%RD_FILIAL , RD_MAT , RD_PD , RD_DATARQ%"
			oSection2:BeginQuery()

			BeginSql alias cAliasSRD
				SELECT SRD.*
				FROM %table:SRD% SRD
					LEFT JOIN %table:SRV% SRV
				ON	SRD.RD_PD	=	SRV.RV_COD
				%exp:cFilSRV%

				WHERE	SRD.RD_FILIAL = %exp:cRA_Filial% AND
						SRD.RD_MAT 	  = %exp:cRA_Mat%    AND
						%exp:cRots%	  AND
					 	SRD.RD_DATARQ	between	(%exp:Upper(cAnoBase+'00')%)AND (%exp:Upper(cAnobase+'99')%)	AND
				 		SRD.RD_EMPRESA = %exp:cBlank% AND
					  	SRD.%notDel% AND SRV.%notDel%
				ORDER BY %exp:cOrdem%
			EndSql
			oSection2:EndQuery()

		Else
			cOrdem := "%RD_FILIAL , RD_MAT , RD_PD , RD_DATPGT%"
 			cData_Ini := (cAnoBase+"0101" )
			cData_Fim := (cAnoBase+"1231" )
			cPerFimAdi	:=  (cAnoBase+"12" )
			cAdiDesc	:= aCodFol[0007,1]

			oSection2:BeginQuery()

			If nAdi == 1
				BeginSql alias cAliasSRD
					SELECT SRD.*
					FROM %table:SRD% SRD

					LEFT JOIN %table:SRV% SRV
					ON	SRD.RD_PD	=	SRV.RV_COD
					%exp:cFilSRV%

					WHERE	SRD.RD_FILIAL  = %exp:cRA_Filial% AND
							SRD.RD_MAT 	   = %exp:cRA_Mat%    AND
							%exp:cRots%	  AND
							((SRD.RD_DATPGT	between	(%exp:cData_Ini%) AND (%exp:cData_Fim%)) OR
							(SRD.RD_MES = '12' AND SRD.RD_PERIODO = (%exp:cPerFimAdi%) AND SRD.RD_pd = (%exp:cAdiDesc%) ))
							 AND
							SRD.RD_EMPRESA = %exp:cBlank% AND
							SRD.%notDel% AND SRV.%notDel%
					ORDER BY %exp:cOrdem%
				EndSql
			Else
				BeginSql alias cAliasSRD
					SELECT SRD.*
					FROM %table:SRD% SRD

					LEFT JOIN %table:SRV% SRV
					ON	SRD.RD_PD	=	SRV.RV_COD
					%exp:cFilSRV%

					WHERE	SRD.RD_FILIAL  = %exp:cRA_Filial% AND
							SRD.RD_MAT 	   = %exp:cRA_Mat%    AND
							%exp:cRots%	  AND
							SRD.RD_DATPGT	between	(%exp:cData_Ini%) AND (%exp:cData_Fim%) AND
							SRD.RD_EMPRESA = %exp:cBlank% AND
							SRD.%notDel% AND SRV.%notDel%
					ORDER BY %exp:cOrdem%
				EndSql
			EndIf

			oSection2:EndQuery()
		EndIf

		// Utiliza a query do Pai (Section2) - Funcionarios
		oSection2:SetParentQuery()

		// Executa a query do SRD
		oSection2:ExecSQl()

		If  ( (cAliasSRA)->RA_FILIAL + (cAliasSRA)->RA_MAT = (cAliasSRD)->RD_FILIAL + (cAliasSRD)->RD_MAT )
			lFirst	:= .f.
			If cPaisLoc <> "BRA"
				oSection1:Cell("CODCBO"):Disable()
				oSection1:Cell("RA_ADMISSA"):Disable()
				oSection1:Cell("RA_OPCAO"):Disable()
				oSection1:Cell("RA_DEMISSA"):Disable()
				oSection1:Cell("RA_NUMCP"):Disable()
				oSection1:Cell("RA_SERCP"):Disable()
				oSection1:Cell("RA_CIC"):Disable()
				oSection1:Cell("RA_PIS"):Disable()
				If cPaisLoc == "BOL"
					oSection1:Cell("RA_ADMISSA"):Enable()
					oSection1:Cell("RA_DEMISSA"):Enable()
					oSection1:Cell("RA_CIC"):Enable()
					oSection1:Cell("RA_RG"):Enable()
				EndIf
			EndIf

			If (cAliasSRD)->( !Eof())
				oSection1:PrintLine()
			EndIf

			cAlter := STR0069	//"HORA/DIA"
			While (cAliasSRD)->( !Eof())  .And. (cAliasSRD)->(RD_FILIAL+RD_MAT) = (cAliasSRA)->(RA_FILIAL+RA_MAT) .And. ;
					If(lCompetenc .Or. (nAdi = 1 .And. (cAliasSRD)->RD_PERIODO == cPerFimAdi .And. (cAliasSRD)->RD_PD == cAdiDesc),Left((cAliasSRD)->RD_DATARQ,4),StrZero(Year((cAliasSRD)->RD_DATPGT),4)) == cAnoBase
				// Consiste Filiais e Acessos
				If !( (cAliasSRD)->RD_FILIAL $ fValidFil() )
					dbSelectArea(cAliasSRD)
					dbSkip()
					Loop
				EndIf

				If Len(aTransf) > 0 .And. (cAliasSRD)->RD_TIPO2 == 'F'
					For nX := 1 To Len(aTransf)
						If !lRegTrans
							If ( aTransf[nX][8] <> aTransf[nX][10]) .And. AnoMes((cAliasSRD)->RD_DATPGT) <= aTransf[nX, 12]
								lRegTrans := .T.
							EndIf
						EndIf
					Next nX
					If lRegTrans
						lRegTrans := .F.
						(cAliasSRD)->( dbSkip() )
						Loop
					EndIf
				EndIf

				// N„o considero valor de ReduÁ„o PPE caso tenha sido gerada no Adiantamento
				// Considera provento de Adiantamento (ID 0006) pago em Dezembro quando Regime Caixa
				If If(!Empty(cRoteiro),cRotFol $ cRoteiro, .T.)  .And. ((cAliasSRD)->RD_PD == aCodFol[0006,1] .Or. (cAliasSRD)->RD_PD == aCodFol[1397,1]) .And.;
						fGetTipoRot((cAliasSRD)->RD_ROTEIR) $ "2" .And. (cAliasSRD)->RD_TIPO2 $ "A*I"
					dbSelectArea(cAliasSRD)
					dbSkip()
					Loop
				Endif

				// N„o considero valor de desconto Adiantamento (ID 007) do ano anterior na coluna de Dezembro (Ano Base)
				// Essa verba assume Data de Pagamento (RD_DATPGT) da Folha e Data de ReferÍncia (RD_DTREF) com a Data de Pagamento do Adiantamento
				// para Regime Caixa
				If If(!Empty(cRoteiro),cRotFol $ cRoteiro, .T.) .And. (cAliasSRD)->RD_PD == aCodFol[0007,1]  .And.;
						fGetTipoRot((cAliasSRD)->RD_ROTEIR) $ "1" .And. (cAliasSRD)->RD_TIPO2 $ "A*I" .And. ;
						cAnoBase > SubStr(DtoS((cAliasSRD)->RD_DTREF),1,4)
					dbSelectArea(cAliasSRD)
					dbSkip()
					Loop
				Endif

				cCpd 	:= (cAliasSRD)->RD_PD
				cFi		:= (cAliasSRD)->RD_FILIAL
				cMa		:= (cAliasSRD)->RD_MAT

			  	While (cAliasSRD)->( !Eof() )  .And. (cAliasSRD)->RD_FILIAL+(cAliasSRD)->RD_MAT+(cAliasSRD)->RD_PD == cFi+cMa+cCpd .and. ;
				    If(lCompetenc .Or. (nAdi = 1 .And. (cAliasSRD)->RD_PERIODO == cPerFimAdi .And. (cAliasSRD)->RD_PD == cAdiDesc),Left((cAliasSRD)->RD_DATARQ,4),StrZero(Year((cAliasSRD)->RD_DATPGT),4)) == cAnoBase
					PosSrv( (cAliasSRD)->RD_PD , (cAliasSRA)->RA_FILIAL )
	 		 				lProvent	:= (  SRV->RV_TIPOCOD == "1" )
	 		 				lDescont	:= (  SRV->RV_TIPOCOD == "2" )
					If lCompetenc
						COL			:= "COL"+Iif(Right((cAliasSRD)->RD_DATARQ,2) # "99",If(!(RD_ROTEIR $ "131/132"),Right((cAliasSRD)->RD_DATARQ,2),"13"),"12")
						Vetor		:= IF(Right((cAliasSRD)->RD_DATARQ,2) # "99",If(!(RD_ROTEIR $ "131/132"),Val(Right((cAliasSRD)->RD_DATARQ,2)),13),12)
						cMesBase	:= Right((cAliasSRD)->RD_DATARQ,2)
					Else
						COL			:= "COL"+(cAliasSRD)->(IF(!(RD_ROTEIR $ "131/132"),StrZero(Month(RD_DATPGT),2),"13"))
						Vetor		:= (cAliasSRD)->(IF(!(RD_ROTEIR $ "131/132"),If (RD_ROTEIR $ 'FOL' .AND. RD_TIPO2 = 'A' .AND. !Empty(RD_DTREF), Month(RD_DTREF) ,Month(RD_DATPGT)),13))
						If nAdi = 1 .And. (cAliasSRD)->RD_PERIODO == cPerFimAdi .And. (cAliasSRD)->RD_PD == cAdiDesc
							cMesBase	:= StrZero(Month((cAliasSRD)->RD_DTREF),2)
						Else
							cMesBase	:= StrZero(Month((cAliasSRD)->RD_DATPGT),2)
						EndIf
					EndIf
	 				cMesDtAr	:= Subst( (cAliasSRD)->RD_DATARQ , -2 )
					cAnoDtAr	:= left(  (cAliasSRD)->RD_DATARQ , 4  )
	 				If( nPos := aScan( aMeses, { |x| x[1] == (cAliasSRD)->RD_PD } ) ) == 0
	 					aAdd( aMeses , { (cAliasSRD)->RD_PD , cDesc , Array(3,13) , Array(3,13) , Array(3,13) , SRV->RV_TIPOCOD,SRV->RV_CODFOL } )
	 					nPos := Len( aMeses )
	 					For nX := 1 To 3
	 						aFill( aMeses[ nPos , 3 , nX ] , 0 )
	 						aFill( aMeses[ nPos , 4 , nX ] , 0 )
	 						aFill( aMeses[ nPos , 5 , nX ] , 0 )
	 					Next nX
	 				EndIf
					nValLinha	:= 0.00
					nHorLinha	:= 0.00
	 				If (cAliasSRD)->( !Eof() .and. (cAliasSRD)->RD_FILIAL+(cAliasSRD)->RD_MAT+(cAliasSRD)->RD_PD == cFi+cMa+cCpd .and. ;
				              If(lCompetenc .Or. (nAdi = 1 .And. (cAliasSRD)->RD_PERIODO == cPerFimAdi .And. (cAliasSRD)->RD_PD == cAdiDesc),Left((cAliasSRD)->RD_DATARQ,4) ,StrZero(Year((cAliasSRD)->RD_DATPGT) ,4)) == cAnoBase .and. ;
	 					      If(lCompetenc .Or. (nAdi = 1 .And. (cAliasSRD)->RD_PERIODO == cPerFimAdi .And. (cAliasSRD)->RD_PD == cAdiDesc),Right((cAliasSRD)->RD_DATARQ,2),StrZero(Month((cAliasSRD)->RD_DATPGT),2)) == cMesBase )
						nValLinha += (cAliasSRD)->RD_VALOR
						If lImprimeHr
							nHorLinha += (cAliasSRD)->RD_HORAS
						EndIf
					EndIf

					If lProvent	.Or. (SRV->RV_CODFOL == "0007" .And. nAdi == 1 .And. SRV->RV_IR == "S" .And. SRV->RV_ADIANTA == "N"	)	//Proventos
						aTotais[1,1,Vetor]		:= &COL
						aTotais[1,2,Vetor]		+= nValLinha
						aMeses[nPos,3,1,Vetor]	:= &COL
						aMeses[nPos,4,1,Vetor]	+= nValLinha
						aMeses[nPos,5,1,Vetor]	+= nHorLinha
					ElseIf lDescont							//Descontos
						aTotais[2,1,Vetor]	    := &COL
						aTotais[2,2,Vetor]	    += nValLinha
						aMeses[nPos,3,2,Vetor] := &COL
						aMeses[nPos,4,2,Vetor] += nValLinha
						aMeses[nPos,5,2,Vetor] += nHorLinha
					Else									//Base
						aMeses[nPos,3,3,Vetor] := &COL
						aMeses[nPos,4,3,Vetor] += nValLinha
						aMeses[nPos,5,3,Vetor] += nHorLinha
					EndIf
					(cAliasSRD)->(dbSkip())
				Enddo
			Enddo

			If !Empty( aMeses )
				If ( nPos := aScan( aMeses, { |x| x[6] == "2" } ) ) == 0
					aAdd( aMeses , { "ZZZ" , "NAO_IMPRIME" , Array(3,13) , Array(3,13) , Array(3,13) , "2","" } )
					nPos := Len( aMeses )
					For nX := 1 To 3
						aFill( aMeses[ nPos , 3 , nX ] , 0 )
						aFill( aMeses[ nPos , 4 , nX ] , 0 )
						aFill( aMeses[ nPos , 5 , nX ] , 0 )
					Next nX
				EndIf
				If ( nPos := aScan( aMeses, { |x| x[1] == "3" } ) ) == 0
					aAdd( aMeses , { "ZZZ" , "NAO_IMPRIME" , Array(3,13) , Array(3,13) , Array(3,13) , "3","" } )
					nPos := Len( aMeses )
					For nX := 1 To 3
						aFill( aMeses[ nPos , 3 , nX ] , 0 )
						aFill( aMeses[ nPos , 4 , nX ] , 0 )
						aFill( aMeses[ nPos , 5 , nX ] , 0 )
					Next nX
				EndIf
			EndIf

			aSort( aMeses,,,{ |x,y| ( x[6]+x[1] ) < ( y[6]+y[1] ) } )

			oSection2:Init()
			oSection4:Init(.F.)

			aMesAux := aClone(aMeses)
			If nADI == 1
				U_GetFolADI(Nil,aMeses,.T., oReport:nDevice) // .T. informando que se trata das cÈlulas de desconto.
			EndIf

			For nX := 1 To Len( aMeses )   // TODAS AS VERBAS APRESENTADAS
				If aMeses[ nX , 6 ] > "1" .and. !lPrnProv	//Proventos
					nTotac := 0
					For nCont:= 1 to 13
						nValorRet:=	nValorRet + aTotais[1,2,nCont]
					Next
					nPDB		:= 1
					aTotalSub	:= aClone(aTotais)

					If nADI == 1
						U_GetFolADI(oSection4,aMesAux, .F., oReport:nDevice)
					EndIf

					If nFer == 1 .And. !lCompetenc
						U_GetTotFer(oSection4,aMesAux)
					EndIf

					oSection4:Cell("MSDIRF"):Disable()

					If oreport:nDevice <> 4  .And. cPaisLoc == 'BOL'
						oSection4:Cell("RD_MAT"):Disable()
						oSection4:Cell("RD_CC"):Disable()
					Endif

					oSection4:Cell("HORA"):SetValue(STR0042)  // TOTAL PROVENTOS
					oSection4:PrintLine()
					oReport:SkipLine()
					oReport:ThinLine()
					oReport:ThinLine()
					oReport:SkipLine()

					nValorRet := 0
					lPrnProv	:= !lPrnProv
				ElseIf aMeses[ nX , 6 ] > "2" .and. !lPrnDesc	//Descontos
					nTotac := 0
					For nCont:= 1 to 13
						nValorRet:=	nValorRet + aTotais[2,2,nCont]
					Next

					nPDB		:= 2
					aTotalSub	:= aClone(aTotais)

					oReport:SkipLine() 					   		// Avanca uma linha no relatorio
					oSection4:Cell("HORA"):SetValue(STR0043) 	// "TOTAL DESCONTOS"
					oSection4:PrintLine()                   	// Seta a impressao da seccao 4
					oReport:SkipLine()
					oReport:ThinLine()							// Imprime uma linha pontilhada
					oReport:ThinLine()							// Imprime uma linha pontilhada
					oReport:SkipLine()

					nValorRet := 0
					lPrnDesc	:= !lPrnDesc
				EndIf
				If AllTrim( Upper( aMeses[ nX , 2 ] ) ) == "NAO_IMPRIME"
					Loop
				EndIf

				nTotLi := 0

				For nY := 1 To Len( aMeses[ nX , 4 ] )
					nXMes := nX
					nYMes := nY

					For nCont:= 1 to 13
						nValorRet:=	nValorRet + aMeses[ nXMes , 4 , nYMes , nCont ]
					Next

					If nValorRet > 0
						// Carregar a variavel cInciden que aponta as incidencias das verbas.
						PosSrv( aMeses[ nXMes , 1], cRA_Filial)
						U_fMontaIncid()
						oSection2:PrintLine()
					EndIf
					nValorRet	:= 0
				Next nY

				If lImprimeHr
					For nY := 1 To Len( aMeses[ nX , 5 ] )   // HORA
						nTotHo := 0
						nXMes	:= nX
						nYMes	:= nY

						For nCont:= 1 to 13
							nValorRet:=	nValorRet + aMeses[ nXMes , 5 , nYMes , nCont ]
						Next
						If nValorRet > 0
							oSection3:PrintLine()
							oReport:SkipLine()
						EndIf
						nValorRet	:= 0
						If nTotHo # 0.00
							nTotHo := 0.00
						EndIf
					Next nY
				EndIf

			Next nX

			oSection2:Finish()
			oSection4:Finish()

			lPrnProv	:= .F.
			lPrnDesc	:= .F.
			aMeses		:= {}
			For nX := 1 To 2
				For nY := 1 To 2
					aFill( aTotais[ nX , nY ] , 0 )
				Next nX
			Next nX
		EndIf

		oReport:SetPageFooter(3, {|| oReport:ThinLine()	, oReport:PrintText(STR0039 + STR0033 + " - " + STR0034 + " - " + STR0035 + " - " + STR0036 + " - " + STR0037 ) })

		(cAliasSRA)->(dbSkip())

	Enddo
	oSection3:Finish()
	oSection1:Finish()
Return

/*
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±…ÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕ—ÕÕÕÕÕÕ—ÕÕÕÕÕÕÕÕÕÕÕÕÕª±±
±±∫Funcao    ≥ fMontaIncid ≥ Autor ≥ Equipe RH       ≥ Data ≥  --/--/--   ∫±±
±±ÃÕÕÕÕÕÕÕÕÕÕÿÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕπ±±
±±∫Uso       ≥ Montagem das incidencias para a celula 12345.              ∫±±
±±»ÕÕÕÕÕÕÕÕÕÕœÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕÕº±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ*/
User Function fMontaIncid()
Local cRaisPar

	// Carrega as Incidencias das Verbas
	If lImprInc
		cInciden := ""
		If "1" $ cIncImpr
			cInciden += ( SRV->RV_DIRF + "-" )
		Else
			cInciden += ( Space(01) + "-" )
		EndIf
		If "2" $ cIncImpr
			cInciden += ( SRV->RV_FGTS + "-" )
		Else
			cInciden += ( Space(01) + "-" )
		EndIf
		If "3" $ cIncImpr
			cInciden += ( SRV->RV_INSS + "-" )
		Else
			cInciden += ( Space(01) + "-" )
		EndIf
		If "4" $ cIncImpr
			cInciden += ( SRV->RV_IR + "-" )
		Else
			cInciden += ( Space(01) + "-" )
		EndIf
		If "5" $ cIncImpr
			cRaisPar	:= Alltrim(StrTran(Alltrim(StrTran(SRV->RV_RAIS,"*","")),"-",""))
			cInciden += Substr(cRaisPar,1,4)
		Else
			cInciden += ( Space(01) )
		EndIf
	Else
		cInciden	:= ( Space(09) )
	EndIf

Return ( cInciden )

/*/
‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹‹
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±⁄ƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¬ƒƒƒƒƒƒ¬ƒƒƒƒƒƒƒƒƒƒø±±
±±≥Funcao	 ≥ fIncidencias≥ Autor ≥ Marinaldo de Jesus ≥ Data ≥ 13/04/95 ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Descricao ≥ Retornar Codigo de Incidencias Validos            		  ≥±±
±±√ƒƒƒƒƒƒƒƒƒƒ≈ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒ¥±±
±±≥Uso		 ≥ GPER270													  ≥±±
±±¿ƒƒƒƒƒƒƒƒƒƒ¡ƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒƒŸ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂﬂ/*/
User Function fIncidencias()
Local cTitulo	:=""
Local MvPar
Local MvParDef	:=""
Local oWnd
Local aInc		:={}

	#IFDEF WINDOWS
		oWnd := GetWndDefault()
	#ENDIF

	MvPar		:=	&(Alltrim(ReadVar()))						// Carrega Nome da Variavel do Get em Questao
	mvRet		:=	Alltrim(ReadVar())			 				// Iguala Nome da Variavel ao Nome variavel de Retorno
	aInc		:=	{STR0033,STR0034,STR0035,STR0036,STR0037}	//"DIRF"###"FGTS"###"INSS"###"IRRF"###"RAIS"
	MvParDef	:=	"12345"
	cTitulo		:=	STR0038								  		//"Incidencias"
	f_Opcoes(@MvPar,cTitulo,aInc,MvParDef,12,49,.F.)	  		// Chama funcao f_Opcoes

	&MvRet := mvpar										  		// Devolve Resultado

Return( .T. )


User Function GetFolADI(oSection,aMeses, lDesconto, nDevice)

// - Vari·veis para guardar os valores
Local cValuePD		:= ""
Local cValueHR		:= ""
Local cValueInc		:= ""
Local cValueHJ		:= ""
Local cValueHF		:= ""
Local cValueHM		:= ""
Local cValueHA		:= ""
Local cValueHMA		:= ""
Local cValueHJN		:= ""
Local cValueHJU		:= ""
Local cValueHAG		:= ""
Local cValueHSE		:= ""
Local cValueHOU		:= ""
Local cValueHNO		:= ""
Local cValueHDZ		:= ""
Local cValue13		:= ""
Local cValueHTOT	:= ""
Local oObjSect		:= Nil
Local aMesAux		:= {}
Local cData_Ini  	:= ""
Local cData_Fim		:= ""
Local cAliasQry		:= GetNextAlias()
Local cOrdem		:= ""
Local cBlank		:= "%' '%"

// - Vari·veis de processamento
Local nCount		:= 0
Local nPosADI		:= 0
Local cPdDesc		:= ""
Local cIdDesc		:= ""
Local cIdProv		:= ""
Local cPdProv		:= ""
Local nValor		:= 0

DEFAULT aMeses	  := {}
DEFAULT oSection  := NIL
DEFAULT lDesconto := .F.
DEFAULT nDevice	  := 1

oObjSect := oSection

// - Busca nos meses o ID 0007 - ADIANTAMENTO.
For nCount :=  1 to Len(aMeses)
	If aMeses[nCount][7] == "0007"
		cIdDesc		:= aMeses[nCount][7]
		nPosADI 	:= nCount
		cPdDesc		:= aMeses[nCount][1]
	ElseIf aMeses[nCount][7] == "0006"
		cIdProv		:= aMeses[nCount][7]
		cPdProv		:= aMeses[nCount][7]
	EndIf
Next nCount

// - Garante que a base estar· configurada para Regime CAIXA
// - -----------------------------------------------------------
// - | Id de C·lculo | DescriÁ„o 			  | Ref.Adto | IRRF |
// - | --------------+------------------------+----------+----- |
// - | 0006 		 | Adiantamento (provento)|   SIM    |  SIM |
// - | 0007 		 | Adiantamento (desconto)|   N√O  	 |  SIM |
// - -----------------------------------------------------------

// - Verifica se possui o Desconto (ID 0007) e se est· sem o Provento (ID 0006) nos meses
If cIdDesc == "0007" .And. Empty(cIdProv)

	If  cIdDesc == "0007" .And. PosSrv(cPdDesc, xFilial("SRV"), "RV_IR") == "S" .And. PosSrv(cPdDesc, xFilial("SRV"), "RV_ADIANTA") == "N"

		// - ObtÈm os valores das cÈlulas para n„o alter·-los
		If !lDesconto
			cValuePD 		:= oObjSect:Cell("RD_PD"):GetValue()
			cValueHR		:= oObjSect:Cell("HORA"):GetValue()
			cValueInc		:= oObjSect:Cell("CINCID"):GetValue()
			cValueHJ		:= oObjSect:Cell("HJANEIRO"):GetValue()
			cValueHF		:= oObjSect:Cell("HFEVEREIRO"):GetValue()
			cValueHM		:= oObjSect:Cell("HMARCO"):GetValue()
			cValueHA		:= oObjSect:Cell("HABRIL"):GetValue()
			cValueHMA		:= oObjSect:Cell("HMAIO"):GetValue()
			cValueHJN		:= oObjSect:Cell("HJUNHO"):GetValue()
			cValueHJU		:= oObjSect:Cell("HJULHO"):GetValue()
			cValueHAG		:= oObjSect:Cell("HAGOSTO"):GetValue()
			cValueHSE		:= oObjSect:Cell("HSETEMBRO"):GetValue()
			cValueHOU		:= oObjSect:Cell("HOUTUBRO"):GetValue()
			cValueHNO		:= oObjSect:Cell("HNOVEMBRO"):GetValue()
			cValueHDZ		:= oObjSect:Cell("HDEZEMBRO"):GetValue()
			cValue13		:= oObjSect:Cell("H13SALARIO"):GetValue()
			cValueHTOT		:= oObjSect:Cell("HTOTAL"):GetValue()
		EndIf

		// - Seta os novos valores e Cria uma 'Linha fantasma'
		// - |*DIRF - ADIANTAMENTO M.S |Janeiro, |Fevereiro|
		// - |*DIRF - ADIANTAMENTO     |2.501,00 |2.502,00 |

		If !lDesconto

			oObjSect:Cell("MSDIRF"):SetValue('*DIRF - ADIANTAMENTO M S SEGUINTE')
			oObjSect:Cell("MSDIRF"):Enable()
			oObjSect:Cell("RD_PD"):Disable()
			If nDevice <> 4 // N„o È Planilha Excel
				oObjSect:Cell("HORA"):Disable()
				oObjSect:Cell("CINCID"):Disable()
			EndIf
			oObjSect:Cell("HJANEIRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 01 ])
			oObjSect:Cell("HFEVEREIRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 02 ])
			oObjSect:Cell("HMARCO"):SetValue(aMeses[ nPosADI , 4 , 01 , 03 ])
			oObjSect:Cell("HABRIL"):SetValue(aMeses[ nPosADI , 4 , 01 , 04 ])
			oObjSect:Cell("HMAIO"):SetValue(aMeses[ nPosADI , 4 , 01 , 05 ])
			oObjSect:Cell("HJUNHO"):SetValue(aMeses[ nPosADI , 4 , 01 , 06 ])
			oObjSect:Cell("HJULHO"):SetValue(aMeses[ nPosADI , 4 , 01 , 07 ])
			oObjSect:Cell("HAGOSTO"):SetValue(aMeses[ nPosADI , 4 , 01 , 08 ])
			oObjSect:Cell("HSETEMBRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 09 ])
			oObjSect:Cell("HOUTUBRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 10 ])
			oObjSect:Cell("HNOVEMBRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 11 ])
			oObjSect:Cell("HDEZEMBRO"):SetValue(aMeses[ nPosADI , 4 , 01 , 12 ])
			oObjSect:Cell("H13SALARIO"):SetValue(aMeses[ nPosADI , 4 , 01 , 13 ])
			oObjSect:Cell("HTOTAL"):SetValue()
			oObjSect:PrintLine()

		Else

			aMesAux := aClone(aMeses)

			If lCompetencia
				cOrdem := "%RD_FILIAL , RD_MAT , RD_PD , RD_DATPGT%"

				BeginSql alias cAliasQry
					SELECT SRD.*
					FROM %table:SRD% SRD

					WHERE	SRD.RD_FILIAL  = %exp:cRA_Filial% AND
							SRD.RD_MAT 	   = %exp:cRA_Mat%    AND
							%exp:cRots%	  AND
						 	SRD.RD_DATARQ	= %exp:cValToChar(Val(cAnoBase)-1) + "12"%	AND
						 	SRD.RD_EMPRESA = %exp:cBlank% AND
						  	SRD.%notDel%
					ORDER BY %exp:cOrdem%
				EndSql
			Else
				cOrdem := "%RD_FILIAL , RD_MAT , RD_PD , RD_DTREF%"
	 			cData_Ini := ( cValToChar((Val(cAnoBase)-1)) + "1201" )
				cData_Fim := ( cValToChar((Val(cAnoBase)-1)) + "1231" )

				BeginSql alias cAliasQry
					SELECT SRD.*
					FROM %table:SRD% SRD

					WHERE	SRD.RD_FILIAL  = %exp:cRA_Filial% AND
							SRD.RD_MAT 	   = %exp:cRA_Mat%    AND
							%exp:cRots%	  AND
						 	SRD.RD_DTREF  between	(%exp:cData_Ini%) AND (%exp:cData_Fim%) AND
						 	SRD.RD_EMPRESA = %exp:cBlank% AND
						  	SRD.%notDel%
					ORDER BY %exp:cOrdem%
				EndSql

			EndIf

			While (cAliasQry)->(!Eof())
				If PosSrv((cAliasQry)->RD_PD, xFilial("SRV"), "RV_CODFOL") == "0007"
					nValor := (cAliasQry)->RD_VALOR
				EndIf
				(cAliasQry)->(DbSkip())
			EndDo

			(cAliasQry)->(DbCloseArea())

			aMeses[ nPosADI , 4 , 01 , 01 ] := nValor
			aMeses[ nPosADI , 4 , 01 , 02 ] := aMesAux[ nPosADI , 4 , 01 , 01 ]
			aMeses[ nPosADI , 4 , 01 , 03 ] := aMesAux[ nPosADI , 4 , 01 , 02 ]
			aMeses[ nPosADI , 4 , 01 , 04 ] := aMesAux[ nPosADI , 4 , 01 , 03 ]
			aMeses[ nPosADI , 4 , 01 , 05 ] := aMesAux[ nPosADI , 4 , 01 , 04 ]
			aMeses[ nPosADI , 4 , 01 , 06 ] := aMesAux[ nPosADI , 4 , 01 , 05 ]
			aMeses[ nPosADI , 4 , 01 , 07 ] := aMesAux[ nPosADI , 4 , 01 , 06 ]
			aMeses[ nPosADI , 4 , 01 , 08 ] := aMesAux[ nPosADI , 4 , 01 , 07 ]
			aMeses[ nPosADI , 4 , 01 , 09 ] := aMesAux[ nPosADI , 4 , 01 , 08 ]
			aMeses[ nPosADI , 4 , 01 , 10 ] := aMesAux[ nPosADI , 4 , 01 , 09 ]
			aMeses[ nPosADI , 4 , 01 , 11 ] := aMesAux[ nPosADI , 4 , 01 , 10 ]
			aMeses[ nPosADI , 4 , 01 , 12 ] := aMesAux[ nPosADI , 4 , 01 , 11 ]

			aTotais[ 2 , 2 , 01 ]+= nValor
			aTotais[ 2 , 2 , 02 ]+= aMesAux[ nPosADI , 4 , 01 , 01 ]
			aTotais[ 2 , 2 , 03 ]+= aMesAux[ nPosADI , 4 , 01 , 02 ]
			aTotais[ 2 , 2 , 04 ]+= aMesAux[ nPosADI , 4 , 01 , 03 ]
			aTotais[ 2 , 2 , 05 ]+= aMesAux[ nPosADI , 4 , 01 , 04 ]
			aTotais[ 2 , 2 , 06 ]+= aMesAux[ nPosADI , 4 , 01 , 05 ]
			aTotais[ 2 , 2 , 07 ]+= aMesAux[ nPosADI , 4 , 01 , 06 ]
			aTotais[ 2 , 2 , 08 ]+= aMesAux[ nPosADI , 4 , 01 , 07 ]
			aTotais[ 2 , 2 , 09 ]+= aMesAux[ nPosADI , 4 , 01 , 08 ]
			aTotais[ 2 , 2 , 10 ]+= aMesAux[ nPosADI , 4 , 01 , 09 ]
			aTotais[ 2 , 2 , 11 ]+= aMesAux[ nPosADI , 4 , 01 , 10 ]
			aTotais[ 2 , 2 , 12 ]+= aMesAux[ nPosADI , 4 , 01 , 11 ]
		EndIf

		If !lDesconto

			// - Habilita novamente as cÈlulas apÛs a impress„o da 'Linha fantasma'
			// - E printa a totalizaÁ„o de Proventos.
			oObjSect:Cell("RD_PD"):Enable()
			oObjSect:Cell("HORA"):Enable()
			oObjSect:Cell("CINCID"):Enable()

			oObjSect:Cell("RD_PD"):SetValue(cValuePD)
			oObjSect:Cell("HORA"):SetValue(cValueHR)
			oObjSect:Cell("CINCID"):SetValue(cValueInc)
			oObjSect:Cell("HJANEIRO"):SetValue(cValueHJ)
			oObjSect:Cell("HFEVEREIRO"):SetValue(cValueHF)
			oObjSect:Cell("HMARCO"):SetValue(cValueHM)
			oObjSect:Cell("HABRIL"):SetValue(cValueHA)
			oObjSect:Cell("HMAIO"):SetValue(cValueHMA)
			oObjSect:Cell("HJUNHO"):SetValue(cValueHJN)
			oObjSect:Cell("HJULHO"):SetValue(cValueHJU)
			oObjSect:Cell("HAGOSTO"):SetValue(cValueHAG)
			oObjSect:Cell("HSETEMBRO"):SetValue(cValueHSE)
			oObjSect:Cell("HOUTUBRO"):SetValue(cValueHOU)
			oObjSect:Cell("HNOVEMBRO"):SetValue(cValueHNO)
			oObjSect:Cell("HDEZEMBRO"):SetValue(cValueHDZ)
			oObjSect:Cell("H13SALARIO"):SetValue(cValue13)
			oObjSect:Cell("HTOTAL"):SetValue(cValueHTOT)

		EndIf

	EndIf

EndIf

Return( .T. )

//-------------------------------------------------------------------
/*/{Protheus.doc} GetTotFer
Cria linha com o total pago referente a fÈrias que seja tribut·vel
@author lidio.oliveira
@since 13/01/2023
/*/
//------------------------------------------------------------------
User Function GetTotFer(oSection, aMeses)

	Local cValuePD		:= ""
	Local cValueHR		:= ""
	Local cValueInc		:= ""
	Local cValueHJ		:= ""
	Local cValueHF		:= ""
	Local cValueHM		:= ""
	Local cValueHA		:= ""
	Local cValueHMA		:= ""
	Local cValueHJN		:= ""
	Local cValueHJU		:= ""
	Local cValueHAG		:= ""
	Local cValueHSE		:= ""
	Local cValueHOU		:= ""
	Local cValueHNO		:= ""
	Local cValueHDZ		:= ""
	Local cValue13		:= ""
	Local cValueHTOT	:= ""
	Local nVlrFer01		:= 0
	Local nVlrFer02		:= 0
	Local nVlrFer03		:= 0
	Local nVlrFer04		:= 0
	Local nVlrFer05		:= 0
	Local nVlrFer06		:= 0
	Local nVlrFer07		:= 0
	Local nVlrFer08		:= 0
	Local nVlrFer09		:= 0
	Local nVlrFer10		:= 0
	Local nVlrFer11		:= 0
	Local nVlrFer12		:= 0
	Local nVlrTot		:= 0
	Local oObjSect		:= Nil
	Local cIdDed  	    := "0232*0164*1890"
	Local lAbatMes      := .T.
	// - Vari·veis de processamento
	Local nCount		:= 0

	DEFAULT aMeses	  := {}
	DEFAULT oSection  := NIL

	oObjSect := oSection

	If cDescInsFer == "R" .And. Len(aMeses) > 0
		If aScan( aMeses, { |x| x[7] == "0164" } ) == 0
			lAbatMes := .F.
		Endif	
	Endif

	// - Busca OS valoresde fÈrias
	For nCount :=  1 to Len(aMeses)
		If RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_TIPOCOD") = "1" .And. RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_REFFER") = 'S' .And. RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_DIRF") = 'A'
			nVlrFer01 += aMeses[ nCount , 4 , 01 , 01 ]
			nVlrFer02 += aMeses[ nCount , 4 , 01 , 02 ]
			nVlrFer03 += aMeses[ nCount , 4 , 01 , 03 ]
			nVlrFer04 += aMeses[ nCount , 4 , 01 , 04 ]
			nVlrFer05 += aMeses[ nCount , 4 , 01 , 05 ]
			nVlrFer06 += aMeses[ nCount , 4 , 01 , 06 ]
			nVlrFer07 += aMeses[ nCount , 4 , 01 , 07 ]
			nVlrFer08 += aMeses[ nCount , 4 , 01 , 08 ]
			nVlrFer09 += aMeses[ nCount , 4 , 01 , 09 ]
			nVlrFer10 += aMeses[ nCount , 4 , 01 , 10 ]
			nVlrFer11 += aMeses[ nCount , 4 , 01 , 11 ]
			nVlrFer12 += aMeses[ nCount , 4 , 01 , 12 ]
		ElseIf (aMeses[nCount][7] $ cIdDed .And. lAbatMes ) .Or. ;
		      (RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_REFFER") = 'S' .And. RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_DIRF") = 'A') .And.;
				!(AllTrim(RetValSRV(aMeses[nCount][1], SRA->RA_FILIAL, "RV_DIRF")) $ "C")
			nVlrFer01 -= aMeses[ nCount , 4 , 02 , 01 ]
			nVlrFer02 -= aMeses[ nCount , 4 , 02 , 02 ]
			nVlrFer03 -= aMeses[ nCount , 4 , 02 , 03 ]
			nVlrFer04 -= aMeses[ nCount , 4 , 02 , 04 ]
			nVlrFer05 -= aMeses[ nCount , 4 , 02 , 05 ]
			nVlrFer06 -= aMeses[ nCount , 4 , 02 , 06 ]
			nVlrFer07 -= aMeses[ nCount , 4 , 02 , 07 ]
			nVlrFer08 -= aMeses[ nCount , 4 , 02 , 08 ]
			nVlrFer09 -= aMeses[ nCount , 4 , 02 , 09 ]
			nVlrFer10 -= aMeses[ nCount , 4 , 02 , 10 ]
			nVlrFer11 -= aMeses[ nCount , 4 , 02 , 11 ]
			nVlrFer12 -= aMeses[ nCount , 4 , 02 , 12 ]
		EndIf
	Next nCount

	//Verifica o valor total das fÈrias
	nVlrTot :=  nVlrFer01 + nVlrFer02 + nVlrFer03 + nVlrFer04 + nVlrFer05 + nVlrFer06 + nVlrFer07 + nVlrFer08 + nVlrFer09 + nVlrFer10 + nVlrFer11 + nVlrFer12

	If nVlrTot > 0
		cValuePD 		:= oObjSect:Cell("RD_PD"):GetValue()
		cValueHR		:= oObjSect:Cell("HORA"):GetValue()
		cValueInc		:= oObjSect:Cell("CINCID"):GetValue()
		cValueHJ		:= oObjSect:Cell("HJANEIRO"):GetValue()
		cValueHF		:= oObjSect:Cell("HFEVEREIRO"):GetValue()
		cValueHM		:= oObjSect:Cell("HMARCO"):GetValue()
		cValueHA		:= oObjSect:Cell("HABRIL"):GetValue()
		cValueHMA		:= oObjSect:Cell("HMAIO"):GetValue()
		cValueHJN		:= oObjSect:Cell("HJUNHO"):GetValue()
		cValueHJU		:= oObjSect:Cell("HJULHO"):GetValue()
		cValueHAG		:= oObjSect:Cell("HAGOSTO"):GetValue()
		cValueHSE		:= oObjSect:Cell("HSETEMBRO"):GetValue()
		cValueHOU		:= oObjSect:Cell("HOUTUBRO"):GetValue()
		cValueHNO		:= oObjSect:Cell("HNOVEMBRO"):GetValue()
		cValueHDZ		:= oObjSect:Cell("HDEZEMBRO"):GetValue()
		cValue13		:= oObjSect:Cell("H13SALARIO"):GetValue()
		cValueHTOT		:= oObjSect:Cell("HTOTAL"):GetValue()

		//Imprime a nova linha
		oObjSect:Cell("MSDIRF"):Disable("")
		oObjSect:Cell("RD_PD"):SetValue("*DIRF -")
		oObjSect:Cell("HORA"):SetValue(" TOT FERIAS")
		oObjSect:Cell("CINCID"):SetValue("PROV - DESC")
		oObjSect:Cell("HJANEIRO"):SetValue(nVlrFer01)
		oObjSect:Cell("HFEVEREIRO"):SetValue(nVlrFer02)
		oObjSect:Cell("HMARCO"):SetValue(nVlrFer03)
		oObjSect:Cell("HABRIL"):SetValue(nVlrFer04)
		oObjSect:Cell("HMAIO"):SetValue(nVlrFer05)
		oObjSect:Cell("HJUNHO"):SetValue(nVlrFer06)
		oObjSect:Cell("HJULHO"):SetValue(nVlrFer07)
		oObjSect:Cell("HAGOSTO"):SetValue(nVlrFer08)
		oObjSect:Cell("HSETEMBRO"):SetValue(nVlrFer09)
		oObjSect:Cell("HOUTUBRO"):SetValue(nVlrFer10)
		oObjSect:Cell("HNOVEMBRO"):SetValue(nVlrFer11)
		oObjSect:Cell("HDEZEMBRO"):SetValue(nVlrFer12)
		oObjSect:Cell("H13SALARIO"):SetValue(nVlrFer12)
		oObjSect:Cell("HTOTAL"):SetValue()
		oObjSect:PrintLine()

		// - Habilita novamente as cÈlulas apÛs a impress„o
		// - E printa a totalizaÁ„o de Proventos.
		oObjSect:Cell("MSDIRF"):Enable()
		oObjSect:Cell("RD_PD"):Enable()
		oObjSect:Cell("HORA"):Enable()
		oObjSect:Cell("CINCID"):Enable()
		oObjSect:Cell("RD_PD"):SetValue(cValuePD)
		oObjSect:Cell("HORA"):SetValue(cValueHR)
		oObjSect:Cell("CINCID"):SetValue(cValueInc)
		oObjSect:Cell("HJANEIRO"):SetValue(cValueHJ)
		oObjSect:Cell("HFEVEREIRO"):SetValue(cValueHF)
		oObjSect:Cell("HMARCO"):SetValue(cValueHM)
		oObjSect:Cell("HABRIL"):SetValue(cValueHA)
		oObjSect:Cell("HMAIO"):SetValue(cValueHMA)
		oObjSect:Cell("HJUNHO"):SetValue(cValueHJN)
		oObjSect:Cell("HJULHO"):SetValue(cValueHJU)
		oObjSect:Cell("HAGOSTO"):SetValue(cValueHAG)
		oObjSect:Cell("HSETEMBRO"):SetValue(cValueHSE)
		oObjSect:Cell("HOUTUBRO"):SetValue(cValueHOU)
		oObjSect:Cell("HNOVEMBRO"):SetValue(cValueHNO)
		oObjSect:Cell("HDEZEMBRO"):SetValue(cValueHDZ)
		oObjSect:Cell("H13SALARIO"):SetValue(cValue13)
		oObjSect:Cell("HTOTAL"):SetValue(cValueHTOT)
	EndIf

Return( .T. )
