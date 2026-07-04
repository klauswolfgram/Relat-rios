/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#include "MDTR830.ch"
#include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR830
Relatorio da CAT (Comunicacao de Acidente de Trabalho).
Para cada acidente do trabalho a empresas deve emitir a CAT
do trabalho devera emitir o Atestado de Saude Ocuacional -
para ser entregue ao INSS. Na cat deve constar informacoes
do acidente e se tiver do acidentado.
O programa buscara informacoes para imprimir a cat nas
Seguintes tabelas:
	TNC - Acidentes
	SRA - Funcionarios
	TMT - Diagnostico medic.

Apos a emissao da cat o campo data emissao sera atualizado
o programa, alertara o usuario no caso de alteracao ou
exclusao.

@author  Thiago Machado
@since   04/10/2000
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR830()

	//Armazena variaveis p/ devolucao (NGRIGHTCLICK)
	Local aNGBEGINPRM := NGBEGINPRM()

	//Define Variaveis
	Local wnrel   := "MDTR830"
	Local cDesc1  := STR0001 //"Comunicacao de Acidente de Trabalho ( CAT ) .                            "
	Local cDesc2  := STR0002 //"Emite a CAT com todas as informacoes referente ao acidente selecionado   "
	Local cDesc3  := STR0003 //"Apos a emissÆo a data corrente sera atualizada no registro da CAT.       "
	Local cString := "TNC"

	Private aCodFol   	:= {}
	Private aRoteiro  	:= {}
	Private Normal    	:= Descanso := 0.00
	Private nomeprog 	:= "MDTR830"
	Private tamanho  	:= "M"
	Private aReturn 	:= { STR0004, 1,STR0005, 1, 1, 1, "",1 } //"Zebrado"###"Administracao"
	Private titulo   	:= STR0006 //"Comunicacao de Acidente de Trabalho - CAT"
	Private ntipo		:= 0
	Private cPerg		:="MDT830    "
	Private nLastKey 	:= 0
	Private cAlias 		:= "SI3"
	Private cDescr 		:= "SI3->I3_DESC"
	Private cPROGRAMA 	:= "MDTR830"
	Private lFicha  	:= .T.
	Private lParEnd 	:= "C"
	Private cMascCP 	:= ""
	Private cEstado, cCity, cAddress, cBairro, cCep
	Private cabec1, cabec2
	Private lExist8301  := ExistBlock("MDTR8301")
	Private lMDTGPE     := Alltrim(GETMV("MV_MDTGPE")) == "S"

	cMascCP := AllTrim( X3Picture( "RA_NUMCP" ) )

	If Alltrim(GETMV("MV_MCONTAB")) == "CTB"
		cAlias := "CTT"
		cDescr := "CTT->CTT_DESC01"
	Endif

	If Alltrim(GETMV("MV_PAREND")) == "F"
		lParEnd := "F"
	Endif

	lTNC_PARTE := SuperGetMv("MV_NG2PCAT",.F.,"1") == "1"

	/*----------------------------------------------------------
	//PERGUNTAS PADRÃO											|
	|	MDT830    ¦01      ¦De  Acidente ?						|
	|	MDT830    ¦02      ¦Ate Acidente ?						|
	|	MDT830    ¦03      ¦Modelo do Relatorio ?				|
	|	MDT830    ¦04      ¦Preencher campos 57, 58 e 59 ?		|
	|	MDT830    ¦05      ¦Imp. Questionario Respon. ?			|
	|	MDT830    ¦06      ¦Numero de Vias ?					|
	|															|
	//PERGUNTAS PRESTADOR DE SERVIÇO							|
	|	MDT830PS  ¦01      ¦De Cliente ?						|
	|	MDT830PS  ¦02      ¦Loja								|
	|	MDT830PS  ¦03      ¦Até Cliente ?						|
	|	MDT830PS  ¦04      ¦Loja								|
	|	MDT830PS  ¦05      ¦De  Acidente ?						|
	|	MDT830PS  ¦06      ¦Ate Acidente ?						|
	|	MDT830PS  ¦07      ¦Modelo do Relatorio ?				|
	|	MDT830PS  ¦08      ¦Preencher campos 57, 58 e 59 ?		|
	|	MDT830PS  ¦09      ¦Imp. Questionario Respon. ?			|
	|	MDT830PS  ¦10      ¦Numero de Vias ?					|
	-------------------------------------------------------------*/

	cEstado  :=  IF(lParEnd=="C",SM0->M0_ESTCOB,SM0->M0_ESTENT)
	cCity    :=  IF(lParEnd=="C",SM0->M0_CIDCOB,SM0->M0_CIDENT)
	cAddress :=  IF(lParEnd=="C",SM0->M0_ENDCOB,SM0->M0_ENDENT)
	cBairro  :=  IF(lParEnd=="C",SM0->M0_BAIRCOB,SM0->M0_BAIRENT)
	cCep     :=  IF(lParEnd=="C",SM0->M0_CEPCOB,SM0->M0_CEPENT)

	If !Empty(cCity)
		cCity := AllTrim(cCity)
	EndIf

	If !Empty(cAddress)
		cAddress := AllTrim(cAddress)
	EndIf

	If !Empty(cBairro)
		cBairro := AllTrim(cBairro)
	EndIf

	// Verifica as perguntas selecionadas
	pergunte(cPerg,.F.)

	// Envia controle para a funcao SETPRINT
	wnrel:="MDTR830"
	wnrel:=SetPrint(cString,wnrel,cPerg,titulo,cDesc1,cDesc2,cDesc3,.F.,"")

	If nLastKey == 27
		Set Filter to

		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	SetDefault(aReturn,cString)

	If nLastKey == 27
		Set Filter to

		// Devolve variaveis armazenadas (NGRIGHTCLICK)
		NGRETURNPRM(aNGBEGINPRM)
		Return
	EndIf

	If Mv_par03 == 2  .Or. Mv_par03 == 3
		U_MDTR830PX()
	Else
		RptStatus({|lEnd| R830Imp(@lEnd,wnRel,titulo,tamanho)},titulo)
	EndIf

	// Devolve variaveis armazenadas (NGRIGHTCLICK)
	NGRETURNPRM(aNGBEGINPRM)

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} R830Imp
Chamada do Relatório

@author  Thiago Machado
@since   04/10/2000
@param   lEnd, Lógico, Indica se abortou opercao
@param   wnRel, Caractere, Arquivo de saida do relatorio
@param   titulo, Caractere, Titulo do relatorio
@param   tamanho, Caractere, Tamanho do relatorio

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function R830Imp(lEnd,wnRel,titulo,tamanho)

	Local nX
	Local cDiag		:= ""
	Local cCGCSEM	:= ""
	Local cDoenca	:= ""
	Local cIndLocal	:= ""

	// Contadores de linha e pagina
	Private li := 80 ,m_pag := 1

	// Verifica se deve comprimir ou nao
	nTipo  := IIF(aReturn[4]==1,15,18)

	dbSelectArea("TNC")
	dbSetOrder(1)
	DbSeek(xFilial("TNC")+mv_par01,.T.)

	SetRegua(LastRec())
	While !Eof() .And. TNC->TNC_FILIAL == xFIlial("TNC")  .And. TNC->TNC_ACIDEN <= mv_par02

		IncRegua()

		For nX := 1 To mv_par06

			dbSelectArea("TNC")
			dbSetOrder(1)
			DbSeek(xFilial("TNC")+TNC->TNC_ACIDEN)
			dbSelectArea("TM0")
			dbSetOrder(1)
			DbSeek(xFilial("TM0")+TNC->TNC_NUMFIC)
			somalinha()
			@Li,000 PSAY STR0008 //"PREVIDENCIA SOCIAL"
			@Li,088 PSAY STR0122 //"|1-Emitente:"
			IF TNC->TNC_EMITEN = "1"
				@Li,101 PSAY STR0010 //"EMPREGADOR"
			ELSEIF TNC->TNC_EMITEN = "2"
				@Li,101 PSAY STR0011 //"SINDICATO"
			ELSEIF TNC->TNC_EMITEN = "3"
				@Li,101 PSAY STR0012 //"MEDICO"
			ELSEIF TNC->TNC_EMITEN = "4"
				@Li,101 PSAY STR0013 //"SEGURADO"
			ELSEIF TNC->TNC_EMITEN = "5"
				@Li,101 PSAY STR0014 //"AUT. PUBLICA"
			ENDIF
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0123 //"INSTITUTO NACIONAL DO SEGURO SOCIAL"
			@Li,088 PSAY "|"
			@Li,089 PSAY replicate("-",40)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0124 //"COMUNICACAO DE ACIDENTE DO TRABALHO - CAT"
			@Li,088 PSAY STR0125 //"|2-Tipo de CAT:"
			IF TNC->TNC_TIPCAT = "1"
				@Li,105 psay  STR0015 //"INICIAL"
			ELSEIF TNC->TNC_TIPCAT = "2"
				@Li,105 psay  STR0016 //"REABERTURA"
			ELSEIF TNC->TNC_TIPCAT = "3"
				@Li,105 psay STR0126+DTOC(TNC->TNC_DTOBIT) //"COMUNICACAO DE OBITO EM :"
			ENDIF
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY replicate("-",129)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0127 //"| |E|3-Razao Social/Nome"
			@Li,129 psay "|"
			somalinha()
			@Li,000 PSAY "| |m|"+SM0->M0_NOMECOM
			@Li,129 psay "|"
			somalinha()
			@Li,000 PSAY "| |p|"
			@Li,005 PSAY replicate("-",124)
			@Li,129 psay "|"
			somalinha()
			@Li,000 psay STR0128 //"| |r|4-Tipo"
			@Li,027 psay STR0129 //"|5-CNAE"
			@Li,054 PSAY STR0130 //"|6-Endereco"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "| |e|"
			IF SM0->M0_TPINSC = 2
				@Li,006 PSAY SM0->M0_CGC PICTURE "@!R NN.NNN.NNN/NNNN-99"
			Else
				@Li,006 PSAY SM0->M0_CGC PICTURE "@!"
			Endif
			@Li,028 PSAY SM0->M0_CNAE PICTURE "@!"
			@Li,055 PSAY cAddress PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0131 //"| |s|Bairro"
			@Li,031 psay STR0132 //"|CEP"
			@Li,050 PSAY STR0133 //"|7-Municipio"
			@Li,072 PSAY STR0134 //"|8-UF"
			@Li,078 PSAY STR0135 //"|9-Telefone"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "| |a|"
			@Li,006 PSAY cBairro PICTURE "@!"
			@Li,032 PSAY cCep PICTURE "@!"
			@Li,051 PSAY cCity PICTURE "@!"
			@Li,073 PSAY cEstado PICTURE "@!"
			@Li,079 PSAY SM0->M0_TEL PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "| |"
			@Li,003 PSAY replicate("-",126)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0137 //"| |A|10-Nome"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |c|"
			@Li,006 PSAY TNC->TNC_NOMFIC PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0138 //"| |i|11-Nome da Mae"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |d|"

			dbselectarea("SRA")
			DBSETORDER(1)
			DBSEEK(TM0->TM0_FILFUN+TM0->TM0_MAT)

			@Li,006 psay SRA->RA_MAE PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0139 //"| |e|12-Data de nasc."
			@Li,028 psay STR0140 //"|13-Sexo"
			@Li,042 PSAY STR0141 //"|14-Estado Civil"
			@Li,059 PSAY STR0142 //"|15-CTPS Serie  Data em."
			@Li,085 PSAY STR0143 //"|16-UF"
			@Li,095 PSAY STR0144  //"|17-Remuneracao mensal"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |n|"
			@Li,006 psay SRA->RA_NASC PICTURE "99/99/9999"
			IF SRA->RA_SEXO = "M"
				@Li,029 PSAY STR0022 //"MASCULINO"
			ELSEIF SRA->RA_SEXO = "F"
				@Li,029 PSAY STR0023 //"FEMININO"
			ENDIF
			IF SRA->RA_ESTCIVI = "1"
				@Li,043 PSAY STR0145 //"SOLTEIRO"
			ELSEIF SRA->RA_ESTCIVI = "2"
				@Li,043 PSAY STR0146 //"CASADO"
			ELSEIF SRA->RA_ESTCIVI = "3"
				@Li,043 PSAY STR0147 //"VIUVO"
			ELSEIF SRA->RA_ESTCIVI = "4"
				@Li,043 PSAY STR0148 //"SEP. JUD."
			ELSEIF SRA->RA_ESTCIVI = "4"
				@Li,043 PSAY STR0149 //"IGNORADO"
			ENDIF
			@Li,060 PSAY SRA->RA_NUMCP PICTURE cMascCP
			@Li,069 PSAY SRA->RA_SERCP PICTURE "99999"
			If SRA->(FieldPos("RA_DTEMICP")) > 0
				@Li,076 PSAY SRA->RA_DTEMICP PICTURE "99/99/99"
			ElseIf FieldPos("RA_DTCPEXP") > 0
				@Li,076 PSAY SRA->RA_DTCPEXP PICTURE "99/99/99"
			Endif
			@Li,086 PSAY SRA->RA_UFCP PICTURE "@!"

			// Calculando o salario do funcionario
			nSalario := 0

			If nSalario == 0

				fSalario( @nSalario, 0, 0, 0, 'A' )

			Endif

			aCodFol  := {}

			@Li,096 PSAY nSalario PICTURE "@E 999,999,999.99"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0150 //"| |t|18-Carteira de Identidade"
			@Li,031 psay STR0151 //"|Data de Emissao"
			@Li,055 PSAY STR0152 //"|Orgao Exp."
			@Li,067 PSAY STR0153 //"|19-UF"
			@Li,074 PSAY STR0154 //"|20-PIS/PASEP"
			@Li,089 PSAY STR0155 //"|21-Endereco"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|E|a|"
			@Li,006 PSAY SRA->RA_RG PICTURE "@!"
			If SRA->(FieldPos("RA_RGDTEMI")) > 0
				@Li,032 PSAY SRA->RA_RGDTEMI PICTURE "99/99/99"
			ElseIf FieldPos("RA_DTRGEXP") > 0
				@Li,032 PSAY SRA->RA_DTRGEXP PICTURE "99/99/99"
			Endif
			If FieldPos("RA_RGORG") > 0
				@Li,056 PSAY SRA->RA_RGORG
			Endif
			@Li,075 PSAY SRA->RA_PIS PICTURE "@!"
			@Li,090 PSAY SRA->RA_ENDEREC PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0156 //"|m|d|Endereco (compl.)"
			@Li,028 psay STR0157 //"|Bairro"
			@Li,045 PSAY STR0132 //"|CEP"
			@Li,059 PSAY STR0158 //"|22-Municipio"
			@Li,080 PSAY STR0159 //"|23-UF"
			@Li,088 PSAY STR0160  //"|24-Telefone"
			@Li,105 PSAY STR0304  //"|25-Grau de Instrução"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|i|o|"
			@Li,006 PSAY SubSTR(SRA->RA_COMPLEM,1,15) PICTURE "@!"
			@Li,029 PSAY SubSTR(SRA->RA_BAIRRO,1,15) PICTURE "@!"
			@Li,046 PSAY SubSTR(SRA->RA_CEP,1,9) PICTURE "@R 99999-999"
			@Li,060 PSAY SubSTR(SRA->RA_MUNICIP,1,20) PICTURE "@! "
			@Li,081 PSAY SubSTR(SRA->RA_ESTADO,1,2) PICTURE "@!"
			@Li,087 PSAY SubSTR(SRA->RA_TELEFON,1,15) PICTURE "@!"
			@Li,106 PSAY SubSTR(SRA->RA_GRINRAI,1,2)
			@Li,129 PSAY "|"

			somalinha()
			@Li,000 psay "|t| |"
			@Li,006 psay STR0161 //"25-Nome da Ocupacao"
			@Li,028 PSAY STR0162 //"|26-CBO"
			@Li,040 PSAY STR0163 //"|27-Filiacao Previdencia Social"
			@Li,082 PSAY STR0164 //"|28-Aposentado?"
			@Li,100 PSAY STR0165  //"|29-Area"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|e| |"
			dbselectarea("SRJ")
			DBSETORDER(1)
			DBSEEK(XFILIAL("SRJ")+SRA->RA_CODFUNC)
			cCBO := SRJ->RJ_CBO
			If !Empty(SRJ->RJ_CODCBO)
				cCBO := SRJ->RJ_CODCBO
			Endif
			@Li,006 PSAY Substr(SRJ->RJ_DESC,1,21) PICTURE "@!"
			@Li,029 PSAY Substr(cCBO,1,10)
			IF TNC->TNC_TIPREV = "1"
				@Li,041 PSAY STR0018 //"Empregado"
			ELSEIF TNC->TNC_TIPREV = "2"
				@Li,041 PSAY STR0166 //"Trab. avulso"
			ELSEIF TNC->TNC_TIPREV = "3"
				@Li,041 PSAY STR0020 //"Seg. especial"
			ELSEIF TNC->TNC_TIPREV = "4"
				@Li,041 PSAY STR0167 //"Medico Resid."
			ENDIF
			IF TNC->TNC_APOSEN = "1"
				@Li,083 PSAY STR0109 //"SIM"
			ELSE
				@Li,083 PSAY STR0168 //"NAO"
			ENDIF
			IF TNC->TNC_AREA = "1"
				@Li,101 PSAY STR0032 //"URBANA"
			ELSE
				@Li,101 PSAY STR0033 //"RURAL"
			ENDIF
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|n|"
			@Li,003 PSAY replicate("-",126)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0169 //"|t|A|30-Data do Acidente"
			@Li,025 PSAY STR0170 //"|31-Hora do Acidente"
			@Li,046 PSAY STR0171 //"|32-Apos quantas horas de trabalho?"
			@Li,085 PSAY STR0172 //"|33-Tipo"
			@Li,98 PSAY STR0173        //"|34-Houve Afastamento?"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|e|c|"
			@Li,006 PSAY TNC->TNC_DTACID PICTURE "99/99/9999"
			@Li,026 PSAY TNC->TNC_HRACID PICTURE "99:99"
			@Li,052 PSAY TNC->TNC_HRTRAB PICTURE "99:99"
			IF TNC->TNC_INDACI == "1"
				@Li,086 PSAY SubSTR(STR0034, 10, 6)    //"TIPICO"
			ELSEIF TNC->TNC_INDACI == "2"
				@Li,086 PSAY SubSTR(STR0035, 13, 7) 	//"TRAJETO"
			ELSEIF TNC->TNC_INDACI == "3"
				@Li,086 PSAY SubSTR(STR0036, 1, 6)		//"DOENÇA"
			ELSEIF TNC->TNC_INDACI == "4"
				@Li,086 PSAY STR0037				 	//"INCIDENTE"
			ENDIF

			IF TNC->TNC_AFASTA = "1"
				@Li,99 PSAY STR0109  //"SIM"
			ELSE
				@Li,99 PSAY STR0168 //"NAO"
			endif
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0174 //"| |i|35-Ultimo dia"
			@Li,019 PSAY STR0175 //"|36-Local do Acidente"
			@Li,050 PSAY STR0176 //"|37-Especif. do local de trabalho"
			If(SM0->M0_TPINSC) == 1
				@Li,098 PSAY "|38-"+STR0038 //"|38-CEI"
			Else
				@Li,098 PSAY STR0177  //"|39-CGC/CNPJ"
			Endif
			@Li,119 PSAY STR0178  //"|39-UF"
			@Li,129 PSAY "|"
			somalinha()
			If(SM0->M0_TPINSC) == 1
				If lExist8301
					cCGCSEM := ExecBlock("MDTR8301",.F.,.F.)
				EndIf
			Endif
			If TNC->TNC_INDLOC == "1"
				cIndLocal := STR0179 //"ESTABELECIMENTO DA EMPRESA"
			ElseIf TNC->TNC_INDLOC == "2"
				cIndLocal := STR0180 //"ONDE PRESTA SERVICO"
			ElseIf TNC->TNC_INDLOC == "3"
				cIndLocal := STR0181 //"VIA PUBLICA"
			ElseIf TNC->TNC_INDLOC == "4"
				cIndLocal := STR0182 //"AREA RURAL"
			ElseIf TNC->TNC_INDLOC == "5"
				cIndLocal := STR0307 //"EMBARCACAO"
			ElseIf TNC->TNC_INDLOC == "6"
				cIndLocal := STR0306 //"EXTERIOR"
			ElseIf TNC->TNC_INDLOC == "9"
				cIndLocal := STR0308 // "OUTROS"
			Endif
			@Li,000 psay "| |d|"
			@Li,006 PSAY TNC->TNC_DTULTI PICTURE "99/99/9999"
			@Li,020 PSAY cIndLocal PICTURE "@!"
			@Li,051 PSAY SubStr(TNC->TNC_LOCAL,1,45) PICTURE "@!"
			If(SM0->M0_TPINSC) == 1 
				If lExist8301
					@Li,099 PSAY cCGCSEM
				EndIf
			Else
				@Li,099 PSAY TNC->TNC_CGCPRE PICTURE "@!R NN.NNN.NNN/NNNN-99"
			Endif
			@Li,120 PSAY TNC->TNC_ESTACI PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0183 //"| |e|40-Municipio do Acidente"
			@Li,030 PSAY STR0184 //"|41-Parte(s) do corpo atingida(s)"
			@Li,098 PSAY STR0185 //"|42-Agente Causador"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |n|"
			@Li,006 PSAY AllTrim(TNC->TNC_CIDACI) PICTURE "@!"

			If AliasInDic('TYE')//Se possui as novas tabela para o eSocial

				@Li,031 PSAY SubStr( U_fRetAgePar( 1, TNC->TNC_ACIDEN ), 1, 65)
				@Li,099 PSAY SubStr( U_fRetAgePar( 2, TNC->TNC_ACIDEN ), 1, 25)

			Else

				If lTNC_PARTE
					@Li,031 PSAY SUBSTR(TNC->TNC_PARTE,1,40)
				Else
					dbSelectArea("TOI")
					dbSetOrder(01)
					dbSeek(xFilial("TOI")+TNC->TNC_CODPAR)
					@Li,031 PSAY SUBSTR(TOI->TOI_DESPAR,1,40)
				Endif
				dbselectarea("TNH")
				DBSETORDER(1)
				DBSEEK(XFILIAL("TNH")+TNC->TNC_CODOBJ)
				@Li,099 PSAY SUBSTR(TNH->TNH_DESOBJ,1,20)
			EndIf

			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0186 //"| |t|43-Descricao da situacao geradora do acidente ou doenca"
			@Li,098 PSAY STR0187 //"|44-Houve registro policial?"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |e|"
			@Li,006 PSAY TNC->TNC_DESCR1 PICTURE "@!"
			IF TNC->TNC_POLICI = "1"
				@Li,099 PSAY STR0109  //"SIM"
			ELSE
				@Li,099 PSAY STR0168  //"NAO"
			ENDIF
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| | |"
			@Li,006 PSAY TNC->TNC_DESCR2 PICTURE "@!"
			@Li,098 PSAY STR0188      //"|45-Houve morte?"
			IF TNC->TNC_MORTE = "1"
				@Li,120 PSAY STR0109  //"SIM"
			ELSE
				@Li,120 PSAY STR0168  //"NAO"
			ENDIF
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |"
			@Li,003 PSAY replicate("-",126)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0189    //"| |T|46-Nome:"
			@Li,016 PSAY SubStr(TNC->TNC_TESTE1,1,40) PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0190 //"| |e|47-Endereco"
			@Li,046 PSAY STR0157 //"|Bairro"
			@Li,062 PSAY STR0132 //"|CEP"
			@Li,078 PSAY STR0191  //"|48-Municipio"
			@Li,095 PSAY STR0192   //"|49-UF"
			@Li,105 PSAY STR0193  //"|Telefone"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |s|"
			@Li,006 PSAY SubStr(TNC->TNC_ENDTE1,1,40) PICTURE "@!"
			@Li,047 PSAY SubStr(TNC->TNC_BAIRR1,1,15) PICTURE "@!"
			@Li,063 PSAY TNC->TNC_CEP1 PICTURE "@!"
			@Li,079 PSAY TNC->TNC_CIDAD1 PICTURE "@!"
			@Li,097 PSAY TNC->TNC_ESTAD1 PICTURE "@!"
			@Li,106 PSAY TNC->TNC_TELEF1 PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay STR0194       //"| |t|50-Nome:"
			@Li,016 PSAY SubStr(TNC->TNC_TESTE2,1,40) PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0195 //"| |m|51-Endereco"
			@Li,046 PSAY STR0157 //"|Bairro"
			@Li,062 PSAY STR0132 //"|CEP"
			@Li,078 PSAY STR0196  //"|52-Municipio"
			@Li,095 PSAY STR0197   //"|53-UF"
			@Li,105 PSAY STR0193  //"|Telefone"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "| |.|"
			@Li,006 PSAY SubStr(TNC->TNC_ENDTE2,1,40) PICTURE "@!"
			@Li,047 PSAY SubStr(TNC->TNC_BAIRR2,1,15) PICTURE "@!"
			@Li,063 PSAY TNC->TNC_CEP2 PICTURE "@!"
			@Li,079 PSAY TNC->TNC_CIDAD2 PICTURE "@!"
			@Li,096 PSAY TNC->TNC_ESTAD2 PICTURE "@!"
			@Li,106 PSAY TNC->TNC_TELEF2 PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 psay "|"
			@Li,001 PSAY replicate("-",128)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|"
			cLocal  := cCity + ", "
			nLocal  := len(cLocal)
			nEspaco := (32 - (nLocal + 8))/2
			If nEspaco >= 1
				@Li,022 Psay space(nEspaco) + cLocal
				nCol := 22 + nEspaco + nLocal
				@Li,nCol Psay If(!Empty(TNC->TNC_DTEMIS),TNC->TNC_DTEMIS,dDataBase) PICTURE "99/99/99"
			Else
				@Li,020 Psay cLocal
				nCol := 20 + nLocal
				@Li,nCol Psay If(!Empty(TNC->TNC_DTEMIS),TNC->TNC_DTEMIS,dDataBase) PICTURE "99/99/99"
			EndIf
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|                     ________________________________                  _____________________________________"
			@Li,129 psay "|"
			somalinha()
			@Li,000 psay "|"
			@Li,031 PSAY STR0198 //"Local e data"
			@Li,075 PSAY STR0199 //"Assinatura e carimbo do emitente"
			@Li,129 psay "|"
			somalinha()
			@Li,000 psay "|"
			@Li,001 PSAY replicate("-",128)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0200 //"|A|A|54-Unidade de atendimento medico"
			@Li,086 PSAY STR0201 //"|55-Data"
			@Li,098 PSAY STR0202 //"|56-Hora"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|t|t|"
			@Li,006 PSAY TNC->TNC_LOCATE PICTURE "@!"
			@Li,087 PSAY TNC->TNC_DTATEN PICTURE "99/99/9999"
			@Li,099 PSAY TNC->TNC_HRATEN PICTURE "99:99"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0203 //"|e|e|57-Houve Internacao?"
			@Li,027 PSAY STR0204 //"|58-Duracao provavel do tratamento"
			@Li,061 PSAY STR0205 //"|59-Devera afastar-se do trabalho?"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|s|n|"
			If mv_par04 == 2	 //SIM
				IF TNC->TNC_INTERN = "1"
					@Li,006 PSAY STR0109 //"SIM"
				ELSE
					@Li,006 PSAY STR0168  //"NAO"
				ENDIF
				@Li,028 PSAY TNC->TNC_QTAFAS
				@Li,033 PSAY STR0206 //" DIAS"
				IF TNC->TNC_AFASTA = "1"
					@Li,062 PSAY STR0109  //"SIM"
				ELSE
					@Li,062 PSAY STR0168  //"NAO"
				ENDIF
			EndIf
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0207 //"|t|d|60-Descricao e natureza da lesao"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|a|i|"
			If !Empty(TNC->TNC_DESLES)
				@Li,006 PSAY TNC->TNC_DESLES PICTURE "@!"
			ELse
				@Li,006 PSAY SubSTR(NGSEEK("TOJ",TNC->TNC_CODLES,1,"TOJ_NOMLES"),1,80) PICTURE "@!"
			Endif
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0208 //"|d|m|61-Diagnostico provavel"
			@Li,087 PSAY STR0217 //"|62-CID - 10"
			@Li,129 PSAY "|"
			somalinha()
			DbSelectArea( "TMR" )
			DbSetOrder( 1 )
			If MsSeek( xFilial( "TMR" ) + TNC->TNC_CID )
				cDoenca := TMR->TMR_DOENCA
			EndIf
			DBSELECTAREA("TMT")
			DBSETORDER(7)
			DBSEEK(XFILIAL("TMT")+TNC->TNC_ACIDEN)
			If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
				cDiag := SubStr(IIF(!Empty(MsMM(TMT->TMT_DIASYP,10)),MsMM(TMT->TMT_DIASYP,10),cDoenca),1,80)
			Else
				cDiag := SubStr(IIF(!Empty(TMT->TMT_DIAGNO),TMT->TMT_DIAGNO,cDoenca),1,80)
			EndIf
			@Li,000 PSAY "|o|e|"
			@Li,006 PSAY cDiag PICTURE "@!"
			@Li,088 PSAY Alltrim(TNC->TNC_CID)+" - "+SubStr(NGSEEK("TMR",TNC->TNC_CID,1,"TMR_DOENCA"),1,28) PICTURE "@!"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0209 //"| |n|63-Obs."
			@Li,015 PSAY TNC->TNC_OBSERV PICTURE "@!"
			@Li,129 psay "|"
			somalinha()
			@Li,000 PSAY "| |t|"
			@Li,129 psay "|"
			somalinha()
			@Li,000 PSAY "| |o|"
			@Li,129 psay "|"
			somalinha()
			@Li,000 PSAY "|"
			@Li,001 psay replicate("-",128)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|                     ________________________________       ________________________________________________"
			@Li,129 psay "|"
			somalinha()
			@Li,000 psay "|"

			@Li,031 PSAY STR0198 //"Local e data"
			@Li,066 PSAY STR0210 //"Assinatura e carimbo do medico com CRM"
			@Li,129 psay "|"
			somalinha()
			@Li,000 psay "|"
			@Li,001 PSAY replicate("-",128)
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0211 //"|I|64-Recebido em"
			@Li,018 PSAY STR0212 //"|65-Codigo da Unidade"
			@Li,040 PSAY STR0213 //"|66-Numero da CAT"
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|N|"
			@Li,041 PSAY TNC->TNC_CATINS PICTURE "@!" //Numero do CAT
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY STR0214 //"|S|68-Matricula do servidor"
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|S|"
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "| |                 __________________        ________________________"
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "| |"
			@Li,024 PSAY STR0215 //"Matricula"
			@Li,050 PSAY STR0216 //"Ass. do Servidor"
			@Li,085 PSAY "|"
			@Li,129 PSAY "|"
			somalinha()
			@Li,000 PSAY "|"
			@Li,001 PSAY replicate("-",128)
			@Li,129 PSAY "|"
			If Empty(TNC->TNC_DTEMIS)
				RECLOCK("TNC",.F.)
				TNC->TNC_DTEMIS := date()
				MSUNLOCK("TNC")
			Endif
			Dbselectarea("TNC")
			If TNC->TNC_INDACI == "2" .And. mv_par05 == 1
				U_QUEST830TXT()
			Endif
			li := 80

		Next nX

		dbselectarea("TNC")
		DBSKIP()

	END

	//Roda(nCntImpr,cRodaTxt,Tamanho)
	// Devolve a condicao original do arquivo principal
	RetIndex("TNC")

	Set Filter To

	Set device to Screen

	If aReturn[5] = 1
		Set Printer To
		dbCommitAll()
		OurSpool(wnrel)
	Endif
	MS_FLUSH()

	dbSelectArea("TMT")

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} somalinha
Incrementa Linha inicial

@author  Inacio Luiz Kolling
@since   01//06/1997
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
Static Function somalinha()

    Li ++
    If Li > 72
       Li := 0
    Endif

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR830PX
Segundo Modelo do CAT

@author  Denis Hyroshi de Souza
@since   07/11/2002
@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR830PX()

	Local oPrint
	Local i 	:= 1
	Local lin 	:= 0
	Private oFont16,oFont14,oFont12,oFont11,oFont10,oFont09,oFont08,oFont07,oFont07b,oFont06,oFont06b
	Private oFontYY,oFontXX
	oPrint := TMSPrinter():New( OemToAnsi(STR0006) )
	oPrint:SetPortrait() //retrato
	oPrint:Setup()
	oFont05	:= TFont():New("ARIAL",05,05,,.F.,,,,.F.,.F.)

	If mv_par03 == 2
		oFont08	:= TFont():New("TIMES NEW ROMAN",08,08,,.T.,,,,.T.,.F.)
		oFontXX := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
		oFontYY := TFont():New("COURIER NEW",09,09,,.T.,,,,.F.,.F.)
		oFont09	:= TFont():New("TIMES NEW ROMAN",09,09,,.F.,,,,.T.,.F.)
		oFont14	:= TFont():New("TIMES NEW ROMAN",14,14,,.T.,,,,.T.,.F.)
		oFont16	:= TFont():New("TIMES NEW ROMAN",16,16,,.T.,,,,.T.,.F.)
		U_MDTR830MOD2(oPrint,@i,@lin)
	Elseif mv_par03 == 3
	oFont07b := TFont():New("LUCIDA CONSOLE",07,07,,.F.,,,,.F.,.F.)
	oFont06b := TFont():New("LUCIDA CONSOLE",05,05,,.F.,,,,.F.,.F.)
		oFontXX := TFont():New("COURIER NEW",10,10,,.F.,,,,.F.,.F.)
		oFontYY := TFont():New("COURIER NEW",09,09,,.T.,,,,.F.,.F.)
		oFont05	:= TFont():New("TIMES NEW ROMAN",05,05,,.F.,,,,.F.,.F.)
		oFont06	:= TFont():New("ARIAL",06,06,,.F.,,,,.F.,.F.)
		oFont07	:= TFont():New("ARIAL",07,07,,.F.,,,,.F.,.F.)
		oFont08	:= TFont():New("ARIAL",08,08,,.F.,,,,.F.,.F.)
		oFont09	:= TFont():New("ARIAL",09,09,,.F.,,,,.F.,.F.)
		oFont10	:= TFont():New("ARIAL",10,10,,.F.,,,,.F.,.F.)
		oFont11	:= TFont():New("ARIAL",10,10,,.T.,,,,.F.,.F.)
		oFont12	:= TFont():New("ARIAL",12,12,,.T.,,,,.T.,.T.)
		U_MOD3MDTR830(oPrint,@i,@lin)
	Endif

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MOD3MDTR830

@author  Denis Hyroshi de Souza
@since   07/12/2002
@param   oPrint, Objeto, Objeto de impressão
@param   i, Numérico, COntador de vias impressas
@param   l, Numérico, Linha

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MOD3MDTR830(oPrint,i,l)

	Local nX

	Local lin := 100, strEmit := STR0043, strEmpr := STR0010, strViti := STR0218 //"EMITENTE"###"EMPREGADOR"###"ACIDENTADO"
	Local strAcid := STR0219, strTest := STR0220, strAten := STR0221 //"ACIDENTE OU DOENÇA"###"TESTEMUNHAS"###"ATENDIMEN."
	Local strAtes := STR0222, strLesa := STR0223, strDiag := STR0224 //"ATESTADO MÉDICO"###"LESÃO"###"DIAGNÓST."
	Local strInss := STR0225, cIndLocal := "" //"INSS"###""
	Local strNota01, strNota02, xx,LinhaCorrente
	Local cTipo := ""
	Local cCGCSEM := ""
	Local cDoenca := ""
	Local cEndeRec := ""

	strNota01 := STR0227 //"A inexatidão das declarações desta comunica- ção implicará nas sanções previstas nos arts. "
	strNota01 += STR0228 //"171 e 299 do Código Penal."
	strNota02 := STR0229 //"A comunicação de acidente do trabalho deverá ser feita até o 1º dia útil após o acidente, "
	strNota02 += STR0230 //"sob pena de multa."

	DbSelectArea("TNC")
	DbSetOrder(1)
	DbSeek(xFilial("TNC")+mv_par01,.T.)

	While !Eof()                                 .And.;
		TNC->TNC_FILIAL == xFIlial("TNC")        .And.;
		TNC->TNC_ACIDEN <= mv_par02

		For nX := 1 To mv_par06

			oPrint:StartPage()
			DbSelectArea("TNC")
			DbSetOrder(1)
			DbSeek(xFilial("TNC")+TNC->TNC_ACIDEN)
			DbSelectArea("TM0")
			DbSetOrder(1)
			DbSeek(xFilial("TM0")+TNC->TNC_NUMFIC)
			Dbselectarea("SRA")
			DbSetOrder(1)
			DbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT)
			Dbselectarea("TNH")
			DbSetOrder(1)
			DbSeek(xFilial("TNH")+TNC->TNC_CODOBJ)
			Dbselectarea("TMT")
			DbSetOrder(7)
			DbSeek(xFilial("TMT")+TNC->TNC_ACIDEN)
			Dbselectarea("TMK")
			DbSetOrder(1)
			DbSeek(xFilial("TMK")+TMT->TMT_CODUSU)
			Dbselectarea("TMR")
			DbSetOrder(1)
			DbSeek(xFilial("TMR")+TMT->TMT_CID)
			Dbselectarea(cAlias)
			DbSetOrder(1)
			DbSeek(xFilial(cAlias)+TNC->TNC_CC)
			DbSelectArea("SRJ")
			DBSetOrder(1)
			DbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
			cCBO := SRJ->RJ_CBO
			If !Empty(SRJ->RJ_CODCBO)
				cCBO := SRJ->RJ_CODCBO
			Endif
			Dbselectarea("SRA")

			cTipInsc := str(SM0->M0_TPINSC,1)
			cCGCCOM := alltrim(Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))
			If(SM0->M0_TPINSC) == 1
				If lExist8301
					cCGCSEM := ExecBlock("MDTR8301",.F.,.F.)
				EndIf
			Else
			cCGCSEM := SM0->M0_CGC
			Endif
			cEstCiv := space(1)
			IF SRA->RA_ESTCIVI = "C" ; cEstCiv := "2"   	//"CASADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "D" ; cEstCiv := "4" 	//"DIVORCIADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "M" ; cEstCiv := "5"   //"MARITAL"
			ELSEIF SRA->RA_ESTCIVI = "Q" ; cEstCiv := "5" 	//"DESQUITADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "S" ; cEstCiv := "1" 	//"SOLTEIRO(A)"
			ELSEIF SRA->RA_ESTCIVI = "V" ; cEstCiv := "3" 	//"VIUVO(A)"
			ENDIF

			oPrint:Box(lin,1000,200,2350)
			oPrint:Line(200,1000,300,1000)
			oPrint:Line(200,2350,300,2350)
			oPrint:Box(300,30,3000,2350)
			If File("logoprev.bmp")
				oPrint:sayBitMap(100,50,"logoprev.bmp",270,120)
				oPrint:Say(130,335,STR0235,oFont12)  //" PREVIDÊNCIA  SOCIAL "
				oPrint:Say(180,335,STR0123,oFont07)  //"INSTITUTO NACIONAL DO SEGURO SOCIAL"
			Else
				oPrint:Say(130,260,STR0235,oFont12)  //" PREVIDÊNCIA  SOCIAL "
				oPrint:Say(180,260,STR0123,oFont07)  //"INSTITUTO NACIONAL DO SEGURO SOCIAL"
			Endif
			oPrint:Say(240,30,STR0236,oFont11) //"COMUNICAÇÃO DE ACIDENTE DO TRABALHO - CAT"

			Linha := 890
			For xx := 1 to len(strEmit)//EMITENTE
				oPrint:Say(Linha,70,substr(strEmit,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 330
			For xx := 1 to len(strEmpr)//Empregador
				oPrint:Say(Linha,170,substr(strEmpr,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 670
			For xx := 1 to len(strViti)//Acidentado
				oPrint:Say(Linha,170,substr(strViti,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 1000
			For xx := 1 to len(strAcid)//Acidente ou Doenca
				oPrint:Say(Linha,170,substr(strAcid,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 1416
			For xx := 1 to len(strTest)//Testemunhas
				oPrint:Say(Linha,170,substr(strTest,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 1890
			For xx := 1 to len(strAtes)//Atestado Medico
				oPrint:Say(Linha,70,substr(strAtes,xx,1),oFont07b)
				linha += 20
			Next xx

			Linha := 1830
			For xx := 1 to len(strAten)//Atendimento
				oPrint:Say(Linha,170,substr(strAten,xx,1),oFont06b)
				linha += 20
			Next xx

			Linha := 2030
			For xx := 1 to len(strLesa)//Lesao
				oPrint:Say(Linha,170,substr(strLesa,xx,1),oFont06b)
				linha += 20
			Next xx

			Linha := 2135
			For xx := 1 to len(strDiag)//Diagnostico
				oPrint:Say(Linha,170,substr(strDiag,xx,1),oFont06b)
				linha += 20
			Next xx

			Linha := 2660
			For xx := 1 to len(strInss)//INSS
				oPrint:Say(Linha,70,substr(strInss,xx,1),oFont07b)
				linha += 20
			Next xx

			oPrint:Say(lin+10,1020,STR0237,oFont07) //"1 - Emitente"
			oPrint:Box(lin+2,1220,lin+45,1250)
			oPrint:Say(lin+60,1020,STR0238,oFont06)  //"1 - Empregador   2 - Sindicato   3 - Médico   4 - Segurado ou Dependente   5 - Autoridade Pública"
			oPrint:Say(lin+5,1225,TNC->TNC_EMITEN ,oFont10)
			oPrint:Say(lin+110,1020,STR0239,oFont07) //"2 - Tipo de CAT"
			oPrint:Box(lin+102,1270,lin+145,1300)
			oPrint:Say(lin+160,1020,STR0240+If(TNC->TNC_TIPCAT == "3",DtoC(TNC->TNC_DTOBIT),"___/___/___"),oFont07)  //"1 - Início   2 - Reabertura   3 - Comunicação de Óbito em "
			oPrint:Say(lin+105,1275,TNC->TNC_TIPCAT,oFont10)
			lin := 300

			// PRIMEIRA PARTE
			oPrint:Line( lin+1350 , 30 , lin+1350  , 2350 )
			oPrint:Line( lin+1100 , 130 , lin+1100 , 2350 )

			//EMPREGADOR
			oPrint:Line( lin     , 130 , lin+1350 , 130  )
			oPrint:Line( lin+85  , 230 , lin+85   , 2350 )
			oPrint:Line( lin+170 , 230 , lin+170  , 2350 )
			oPrint:Line( lin     , 230 , lin+1350 , 230  )

			//ACIDENTADO
			oPrint:Line( lin+250 , 130 , lin+250 , 2350 )
			oPrint:Line( lin+320 , 230 , lin+320 , 2350 )
			oPrint:Line( lin+390 , 230 , lin+390 , 2350 )
			oPrint:Line( lin+460 , 230 , lin+460 , 2350 )
			oPrint:Line( lin+530 , 230 , lin+530 , 2350 )
			oPrint:Line( lin+600 , 230 , lin+600 , 2350 )
			oPrint:Line( lin+675 , 130 , lin+675 , 2350 )

			oPrint:Line(lin+755,230,lin+755,2350)
			oPrint:Line(lin+835,230,lin+835,2350)
			oPrint:Line(lin+915,230,lin+915,2350)
			oPrint:Line(lin+1145,230,lin+1140,2350)
			oPrint:Line(lin+1225,230,lin+1225,2350)
			oPrint:Line(lin+1270,230,lin+1265,2350)
			//EMPREGADOR_________________________________________________________________________________________________
			oPrint:Say(lin+10,240,"3 - "+STR0241,oFont07) //"Razão Social / Nome"
			If Len(Alltrim(SM0->M0_NOMECOM)) > 30
				oPrint:Say(lin+45,240,Substr(SM0->M0_NOMECOM,1,40),oFont08)
			Else
				oPrint:Say(lin+45,240,SM0->M0_NOMECOM,oFont10)
			Endif
			If(SM0->M0_TPINSC) == 1
				If lExist8301
					cCGCSEM := ExecBlock("MDTR8301",.F.,.F.)
				EndIf
			Else
			cCGCSEM := SM0->M0_CGC
			Endif
			//4 - Tipo
			oPrint:Say(lin+90,250,"4 - "+STR0077,oFont07) //"Tipo"
			oPrint:Box(lin+90,343,lin+133,373)
			oPrint:Say(lin+90,385,STR0242,oFont07)  //"1 - CEI       2 - CNPJ      3 - CPF      4 - NT"
			oPrint:Say(lin+93,348,cTipInsc,oFont10)
			oPrint:Say(lin+130,250,If(cTipInsc == "2",cCGCCOM,cCGCSEM),oFont10)
			oPrint:Line(lin+85,1000,lin+170,1000)
			// 5 - CNAE
			oPrint:Say(lin+90,1010,"5 - "+STR0052,oFont07) //"CNAE"
			oPrint:Say(lin+120,1010,SM0->M0_CNAE,oFont10)
			oPrint:Line(lin+85,1300,lin+170,1300)
			// 6 - Endereço
			oPrint:Say(lin+90,1310,"6 - "+STR0243,oFont07) //"Endereço Rua/Av./Nº/Comp."
			oPrint:Say(lin+120,1310,Memoline(cAddress,50,1),oFont09)
			// Endereço Continuação
			oPrint:Say(lin+175,250,STR0243+STR0300,oFont07) //"Endereço Rua/Av./Nº/Comp." ## (continuação)
			oPrint:Say(lin+215,250,Memoline(cAddress,50,2),oFont09)
			oPrint:Line(lin+170,740,lin+250,740)
			// Bairo
			oPrint:Say(lin+175,760,STR0055,oFont07)		 //"Bairro"
			oPrint:Say(lin+215,760,cBairro,oFont07)
			oPrint:Line(lin+170,1100,lin+250,1100)
			// CEP
			oPrint:Say(lin+175,1110,STR0053,oFont07)     //"CEP"
			oPrint:Say(lin+215,1110,Transform(cCep,"@R 99999-999"),oFont10)
			oPrint:Line(lin+170,1350,lin+250,1350)
			// 7 - Municipio
			oPrint:Say(lin+175,1360,"7 - "+STR0057,oFont07) //"Município"
			oPrint:Say(lin+215,1360,SubStr(cCity,1,35),oFont07)
			oPrint:Line(lin+170,1900,lin+250,1900)
			// 8-UF
			oPrint:Say(lin+175,1910,"8 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+210,1910,Upper(cEstado),oFont10)
			oPrint:Line(lin+170,2000,lin+250,2000)
			// 9 - Telefone
			oPrint:Say(lin+175,2010,"9 - "+STR0058,oFont07)	 //"Telefone"
			oPrint:Say(lin+215,2010,substr(SM0->M0_TEL,1,15),oFont07)


			//ACIDENTADO_______________________________________________________________________________________________
			// 10 - PIS/PASEP/NIT
			oPrint:Say(lin+255,250,"10 - "+STR0252,oFont07) //"PIS/PASEP"
			oPrint:Say(lin+285,250,SRA->RA_PIS,oFont10)
			oPrint:Line(lin+250,800,lin+320,800)
			// 11 - Nome
			oPrint:Say(lin+255,810,"11 - "+STR0060,oFont07) //"Nome"
			oPrint:Say(lin+285,810,SRA->RA_NOME,oFont10)
			// 12 - Nome da Mãe
			oPrint:Say(lin+325,250,"12 - "+STR0062,oFont07) //"Nome da Mãe"
			oPrint:Say(lin+355,250,SRA->RA_MAE,oFont10)
			//  13 - Data de nasc.
			oPrint:Say(lin+395,250,"13 - "+STR0245,oFont07) //"Data Nasc."
			oPrint:Say(lin+425,250,Dtoc(SRA->RA_NASC),oFont10)
			oPrint:Line(lin+390,500,lin+460,500)
			// 14 - Sexo
			oPrint:Say(lin+395,510,"14 - "+STR0063,oFont07) //"Sexo"
			oPrint:Box(lin+395,680,lin+438,710)
			oPrint:Say(lin+398,685,If(SRA->RA_SEXO = "M","1","2"),oFont10)
			oPrint:Say(lin+435,510,STR0246,oFont05) 	 //"1 - Masc. 2 - Fem."
			oPrint:Line(lin+390,750,lin+460,750)
			// 15 - Estado Civil
			oPrint:Say(lin+395,760,"15 - "+STR0064,oFont07) //"Estado Civil"
			oPrint:Box(lin+395,1020,lin+438,1050)
			oPrint:Say(lin+398,1025,cEstCiv,oFont10)
			oPrint:Say(lin+425,760,"        "+STR0301,oFont05) //"1-Solteiro                3-Viúvo                 5-Outro"
			oPrint:Say(lin+440,760,"        "+STR0302,oFont05)//"2-Casado                 4-Sep.judic.            6-Ignorado"
			oPrint:Line(lin+390,1200,lin+460,1200)
			// 16 - CTPS
			oPrint:Say(lin+395,1210,"16 - "+STR0248,oFont07) //"CTPS  Série"
			oPrint:Say(lin+420,1210,Transform(SRA->RA_NUMCP,cMascCP)+" - "+SRA->RA_SERCP,oFont09)
			oPrint:Say(lin+395,1550,STR0249,oFont07) //"Data de Emissão"
			If SRA->(FieldPos("RA_DTEMICP")) > 0
				oPrint:Say(lin+420,1550,DTOC(SRA->RA_DTEMICP),oFont10)
			ElseIf FieldPos("RA_DTCPEXP") > 0
				oPrint:Say(lin+420,1550,DTOC(SRA->RA_DTCPEXP),oFont10)
			Endif
			oPrint:Line(lin+390,1750,lin+460,1750)
			// 17 - UF
			oPrint:Say(lin+395,1760,"17 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+420,1760,SRA->RA_UFCP,oFont10)
			oPrint:Line(lin+390,1950,lin+460,1950)
			// 18 - Remuneração Mensal
			oPrint:Say(lin+395,1960,"18 - "+STR0253,oFont07) //"Remuneração Mensal"
			//---------------------------------------------------------
			//| Calculando o salario do funcionario          	      |
			//---------------------------------------------------------
			nSalario := 0

			If nSalario == 0

				fSalario( @nSalario, 0, 0, 0, 'A' )

			Endif

			aCodFol  := {}
			oPrint:Say(lin+420,1960,"R$"+space(1)+AllTrim(Transform(nSalario,"@E 999,999,999.99")),oFont10)
			// 19 - Carteira de Identidade
			oPrint:Say(lin+465,250,"19 - "+STR0250,oFont07) //"Carteira de Identidade"
			oPrint:Say(lin+490,250,SRA->RA_RG,oFont10)
			oPrint:Line(lin+460,800,lin+530,800)
			// Data de Emissão
			oPrint:Say(lin+465,810,STR0249,oFont07) //"Data de Emissão"
			If SRA->(FieldPos("RA_RGDTEMI")) > 0
				oPrint:Say(lin+490,810,DtoC(SRA->RA_RGDTEMI),oFont10)
			ElseIf FieldPos("RA_DTRGEXP") > 0
				oPrint:Say(lin+490,810,DTOC(SRA->RA_DTRGEXP),oFont10)
			Endif
			oPrint:Line(lin+460,1100,lin+530,1100)
			// Orgão Exp.
			oPrint:Say(lin+465,1110,STR0251,oFont07) //"Orgão Exp."
			If FieldPos("RA_RGORG") > 0
				oPrint:Say(lin+490,1110,SRA->RA_RGORG,oFont10)
			ENdif
			oPrint:Line(lin+460,1500,lin+530,1500)
			// 20 - UF
			oPrint:Say(lin+465,1510,"20 - "+STR0244,oFont07) //"UF"
			If FieldPos("RA_RGUF") > 0
				oPrint:Say(lin+490,1510,SRA->RA_RGUF,oFont10)
			Endif
			oPrint:Line(lin+460,1650,lin+530,1650)
			// 21 - Endereço
			cEndeRec := SRA->RA_ENDEREC + "  " + SRA->RA_NUMENDE + "  " + SRA->RA_COMPLEM
			oPrint:Say(lin+465,1660,"21 - "+STR0243,oFont07) //"Endereço Rua/Av./Nº/Comp."
			oPrint:Say(lin+490,1660,MemoLine(cEndeRec,35,1),oFont09)
			// Endereço
			oPrint:Say(lin+535,250,STR0243,oFont07) //"Endereço Rua/Av./Nº/Comp."
			oPrint:Say(lin+565,250,MemoLine(cEndeRec,35,2),oFont09)
			oPrint:Line(lin+530,700,lin+600,700)
			// Bairro
			oPrint:Say(lin+535,710,STR0055,oFont07) //"Bairro"
			oPrint:Say(lin+565,710,SRA->RA_BAIRRO,oFont07)
			oPrint:Line(lin+530,1000,lin+600,1000)
			// CEP
			oPrint:Say(lin+535,1010,STR0053,oFont07) //"CEP"
			oPrint:Say(lin+560,1010,Transform(SRA->RA_CEP,"@R 99999-999"),oFont10)
			oPrint:Line(lin+530,1300,lin+600,1300)
			// 22 - Municipio
			oPrint:Say(lin+535,1310,"22 - "+STR0057,oFont07) //"Município"
			oPrint:Say(lin+565,1310,SRA->RA_MUNICIP,oFont07)
			oPrint:Line(lin+530,1700,lin+600,1700)
			// 23 - UF
			oPrint:Say(lin+535,1710,"23 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+560,1710,SRA->RA_ESTADO,oFont10)
			oPrint:Line(lin+530,1800,lin+600,1800)
			// 24 - Telefone
			oPrint:Say(lin+535,1810,"24 - "+STR0058,oFont07) //"Telefone"
			oPrint:Say(lin+565,1810,substr(SRA->RA_TELEFON,1,17),oFont07)
			oPrint:Line(lin+530,2000,lin+600,2000)
			// 25 - Grau de Instrução
			oPrint:Say(lin+535,2010,"25 - "+STR0303,oFont07) //"Grau de Instrução"
			oPrint:Box(lin+535,2280,lin+578,2330)
			oPrint:Say(lin+538,2285,SRA->RA_GRINRAI,oFont09)
			// 26 - Nome da Ocupação
			oPrint:Say(lin+605,250,"26 - "+STR0254,oFont07) //"Nome da Ocupação"
			oPrint:Say(lin+630,250,Substr(SRJ->RJ_DESC,1,26),oFont08)
			oPrint:Line(lin+600,700,lin+675,700)
			// 27 - CBO
			oPrint:Say(lin+605,710,"27 - "+STR0070,oFont07) //"CBO"
			oPrint:Say(lin+630,710,Substr(cCBO,1,10),oFont10)
			oPrint:Line(lin+600,900,lin+675,900)
			// 28 - Filiação a Previdência Social
			oPrint:Say(lin+605,910,"28 - "+STR0255,oFont07) //"Filiação à Previdência Social"
			oPrint:Box(lin+605,1300,lin+648,1330)
			oPrint:Say(lin+608,1305,If(TNC->TNC_TIPREV == "6","7",If(TNC->TNC_TIPREV == "7","8",TNC->TNC_TIPREV)),oFont10)
			oPrint:Say(lin+650,910,STR0256,oFont05) //"1-Empregado 2-Trab. Avulso 7-Seg. Especial 8-Médico Resid."
			oPrint:Line(lin+600,1400,lin+675,1400)
			// 29 - Aposentado
			oPrint:Say(lin+605,1410,"29 - "+STR0257,oFont07) //"Aposentado ?"
			oPrint:Box(lin+605,1650,lin+648,1680)
			oPrint:Say(lin+608,1655,TNC->TNC_APOSEN,oFont10)
			oPrint:Say(lin+650,1410,STR0258,oFont05)	 //"1 - Sim  2 - Não"
			oPrint:Line(lin+600,2000,lin+675,2000)
			// 30 - Área
			oPrint:Say(lin+610,2010,"30 - "+STR0072,oFont07) //"Área"
			oPrint:Box(lin+610,2200,lin+653,2230)
			oPrint:Say(lin+613,2205,TNC->TNC_AREA,oFont10)
			oPrint:Say(lin+650,2010,STR0259,oFont05) //"1 - Urbano  2 - Rural"

			//ACIDENTE OU DOENCA_______________________________________________________________________________________
			oPrint:Say(lin+685,250,"31 - "+STR0260,oFont07) //"Data Acidente"
			oPrint:Say(lin+720,250,Dtoc(TNC->TNC_DTACID),oFont10)
			oPrint:Line(lin+675,535,lin+835,535)
			oPrint:Say(lin+685,555,"32 - "+STR0261,oFont07) //"Hora Acidente"
			oPrint:Say(lin+720,555,Transform(TNC->TNC_HRACID,"99:99"),oFont10)
			oPrint:Line(lin+675,860,lin+835,860)
			oPrint:Say(lin+685,880,"33 - "+STR0262,oFont06) //"Após quantas horas de trab.?"
			oPrint:Say(lin+720,880,Transform(TNC->TNC_HRTRAB,"99:99"),oFont10)

			oPrint:Line(lin+675,1320,lin+755,1320)
			oPrint:Say(lin+685,1340,"34 - "+STR0077,oFont06) //"Tipo"
			oPrint:Box(lin+677,1620,lin+720,1650)
			oPrint:Say(lin+727,1340,STR0263,oFont05)  //"1 - Típico  2 - Doença  3 - Trajeto"
			If ( TNC->TNC_INDACI == "1" ) .Or. ( TNC->TNC_INDACI == "4" )
				cTipo := "1"
			ElseIf TNC->TNC_INDACI == "2"
				cTipo := "3"
			ElseIf TNC->TNC_INDACI == "3"
				cTipo := "2"
			Endif
			oPrint:Say(lin+680,1625,cTipo,oFont10)

			oPrint:Line(lin+675,1820,lin+755,1820)
			oPrint:Say(lin+685,1840,"35 - "+STR0264,oFont07) //"Houve afastamento?"
			oPrint:Box(lin+677,2150,lin+720,2180)
			oPrint:Say(lin+680,2155,TNC->TNC_AFASTA,oFont10)
			oPrint:Say(lin+727,1840,STR0258,oFont05) //"1 - Sim  2 - Não"

			If TNC->TNC_INDLOC == "1"
				cIndLocal := STR0226 //"ESTAB. EMPRESA"
			ElseIf TNC->TNC_INDLOC == "2"
				cIndLocal := STR0265 //"PRES. SERVIÇO"
			ElseIf TNC->TNC_INDLOC == "3"
				cIndLocal := STR0266 //"VIA PÚBLICA"
			ElseIf TNC->TNC_INDLOC == "4"
				cIndLocal := STR0267 //"ÁREA RURAL"
			ElseIf TNC->TNC_INDLOC == "5"
				cIndLocal := STR0305 //"EMBARCAÇÃO"
			ElseIf TNC->TNC_INDLOC == "6"
				cIndLocal := STR0306 //"EXTERIOR"
			ElseIf TNC->TNC_INDLOC == "9"
				cIndLocal := STR0308 // "OUTROS"
			Endif

			oPrint:Say(lin+765,250,"36 - "+STR0268,oFont07) //"Último dia trabalhado"
			oPrint:Say(lin+800,250,Dtoc(TNC->TNC_DTULTI),oFont10)

			oPrint:Say(lin+765,555,"37 - "+STR0269,oFont07) //"Local Acidente"
			oPrint:Say(lin+800,555,cIndLocal,oFont07)

			oPrint:Say(lin+765,880,"38 - "+STR0270,oFont07) //"Especificação do Local do Acidente"
			oPrint:Say(lin+800,880,Alltrim(SubStr(TNC->TNC_LOCAL,1,50)),oFont07)

			oPrint:Line(lin+755,1660,lin+835,1660)
			oPrint:Say(lin+765,1680,"39 - "+STR0271,oFont07) //"CGC/CNPJ"
			oPrint:Say(lin+800,1680,Transform(TNC->TNC_CGCPRE,"@!R NN.NNN.NNN/NNNN-99"),oFont08)

			oPrint:Line(lin+755,2210,lin+835,2210)
			oPrint:Say(lin+765,2230,"40 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+800,2230,TNC->TNC_ESTACI,oFont10)

			oPrint:Say(lin+845,250,"41 - "+STR0272,oFont06) //"Município do Acidente"
			oPrint:Say(lin+880,250,TNC->TNC_CIDACI,oFont07)

			oPrint:Line(lin+835,510,lin+915,510)
			oPrint:Say(lin+845,520,"42 - "+STR0273,oFont07) //"Parte(s) do Corpo Atingida(s)"

			If AliasInDic('TYE')//Se possui as novas tabela para o eSocial

				oPrint:Say(lin+880,520, SubStr( U_fRetAgePar( 1, TNC->TNC_ACIDEN ), 1, 80) ,oFont09)
				oPrint:Say(lin+880,1760, SubStr( U_fRetAgePar( 2, TNC->TNC_ACIDEN ), 1, 30) ,oFont09)

			Else
				If lTNC_PARTE
					oPrint:Say(lin+880,520,MemoLine(TNC->TNC_PARTE,90,1),oFont07)
				Else
					dbSelectArea("TOI")
					dbSetOrder(01)
					dbSeek(xFilial("TOI")+TNC->TNC_CODPAR)

					If Len( AllTrim(TOI->TOI_DESPAR) ) > 90
						oPrint:Say(lin+880,520,MemoLine(TOI->TOI_DESPAR,110,1),oFont05)
					Else
						oPrint:Say(lin+880,520,MemoLine(TOI->TOI_DESPAR,90,1),oFont07)
					Endif
				Endif
				oPrint:Say(lin+880,1760,TNH->TNH_DESOBJ,oFont07)
			EndIf

			oPrint:Line(lin+835,1740,lin+915,1740)
			oPrint:Say(lin+845,1760,"43 - "+STR0089,oFont07) //"Agente Causador"

			oPrint:Say(lin+925,250,"44 - "+STR0274,oFont07)	   //"Descrição da situação geradora do Acidente ou Doença"
			oPrint:Say(lin+970,250,substr(TNC->TNC_DESCR1,1,85),oFont08)
			oPrint:Say(lin+1035,250,substr(TNC->TNC_DESCR2,1,85),oFont08)
			oPrint:Line(lin+915,1830,lin+1100,1830)
			oPrint:Say(lin+925,1850,"45 - "+STR0275,oFont07)	   //"Houve registro policial?"
			oPrint:Box(lin+917,2290,lin+960,2320)
			oPrint:Say(lin+920,2295,TNC->TNC_POLICI,oFont10)
			oPrint:Say(lin+979,1850,STR0258,oFont05) //"1 - Sim  2 - Não"
			oPrint:Line(lin+1007,1830,lin+1007,2350)
			oPrint:Say(lin+1017,1850,"46 - "+STR0276,oFont07)	   //"Houve morte?"
			oPrint:Box(lin+1009,2150,lin+1052,2180)
			oPrint:Say(lin+1012,2155,TNC->TNC_MORTE,oFont10)
			oPrint:Say(lin+1072,1850,STR0258,oFont05)	 //"1 - Sim  2 - Não"


			//TESTEMUNHAS _______________________________________________________________________________________
			oPrint:Say(lin+1110,250,"47 - "+STR0060,oFont07)	   //"Nome"
			oPrint:Say(lin+1105,450,SubStr(TNC->TNC_TESTE1,1,40),oFont10)

			oPrint:Say(lin+1155,250,"48 - "+STR0243,oFont07) //"Endereço Rua/Av./Nº/Comp."
			oPrint:Say(lin+1190,250,SubStr(TNC->TNC_ENDTE1,1,40),oFont07)
			oPrint:Line(lin+1145,1000,lin+1225,1000)
			oPrint:Say(lin+1155,1020,STR0055,oFont07) //"Bairro"
			oPrint:Say(lin+1190,1020,SubStr(TNC->TNC_BAIRR1,1,15),oFont07)
			oPrint:Line(lin+1145,1300,lin+1225,1300)
			oPrint:Say(lin+1155,1320,STR0053,oFont07) //"CEP"
			oPrint:Say(lin+1190,1320,TNC->TNC_CEP1,oFont07)
			oPrint:Line(lin+1145,1500,lin+1225,1500)
			oPrint:Say(lin+1155,1520,"49 - "+STR0057,oFont07) //"Município"
			oPrint:Say(lin+1190,1520,TNC->TNC_CIDAD1,oFont07)
			oPrint:Line(lin+1145,1900,lin+1225,1900)
			oPrint:Say(lin+1155,1920,"50 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+1190,1920,TNC->TNC_ESTAD1,oFont10)
			oPrint:Line(lin+1145,2050,lin+1225,2050)
			oPrint:Say(lin+1155,2070,STR0058,oFont07) //"Telefone"
			oPrint:Say(lin+1190,2070,TNC->TNC_TELEF1,oFont10)


			oPrint:Say(lin+1235,250,"51 - "+STR0060,oFont07)	   //"Nome"
			oPrint:Say(lin+1230,450,SubStr(TNC->TNC_TESTE2,1,40),oFont10)

			oPrint:Say(lin+1280,250,"52 - "+STR0243,oFont07) //"Endereço Rua/Av./Nº/Comp."
			oPrint:Say(lin+1315,250,SubStr(TNC->TNC_ENDTE2,1,40),oFont07)
			oPrint:Line(lin+1270,1000,lin+1350,1000)
			oPrint:Say(lin+1280,1020,STR0055,oFont07) //"Bairro"
			oPrint:Say(lin+1315,1020,SubStr(TNC->TNC_BAIRR2,1,15),oFont07)
			oPrint:Line(lin+1270,1300,lin+1350,1300)
			oPrint:Say(lin+1280,1320,STR0053,oFont07) //"CEP"
			oPrint:Say(lin+1315,1320,TNC->TNC_CEP2,oFont07)
			oPrint:Line(lin+1270,1500,lin+1350,1500)
			oPrint:Say(lin+1280,1520,"53 - "+STR0057,oFont07) //"Município"
			oPrint:Say(lin+1315,1520,TNC->TNC_CIDAD2,oFont07)
			oPrint:Line(lin+1270,1900,lin+1350,1900)
			oPrint:Say(lin+1280,1920,"54 - "+STR0244,oFont07) //"UF"
			oPrint:Say(lin+1315,1920,TNC->TNC_ESTAD2,oFont10)
			oPrint:Line(lin+1270,2050,lin+1350,2050)
			oPrint:Say(lin+1280,2070,STR0058,oFont07) //"Telefone"
			oPrint:Say(lin+1315,2070,TNC->TNC_TELEF2,oFont10)


			// SEGUNDA PARTE
			lin := 1650
			oPrint:Line(lin+675,30,lin+675,2350)
			oPrint:Line(lin+155,30,lin+155,2350)
			oPrint:Line(lin+175,30,lin+175,2350)
			oPrint:Line(lin,1200,lin+155,1200)
			oPrint:Line(lin+175,130,lin+675,130)
			oPrint:Line(lin+175,230,lin+675,230)
			oPrint:Line(lin+275,230,lin+275,2350)
			oPrint:Line(lin+375,130,lin+375,2350)
			oPrint:Line(lin+475,130,lin+475,2350)
			oPrint:Line(lin+575,230,lin+575,2350)
			oPrint:Line(lin+830,30,lin+830,2350)
			oPrint:Line(lin+850,30,lin+850,2350)
			oPrint:Line(lin+1270,30,lin+1270,2350)
			oPrint:Line(lin+850,130,lin+1270,130)
			oPrint:Line(lin+850,1600,lin+1270,1600)
			oPrint:Line(lin+950,130,lin+950,1600)
			oPrint:Line(lin+1050,130,lin+1050,1600)
			oPrint:Line(lin+675,1200,lin+830,1200)

			//ATENDIMENTO_______________________________________________________________________________

			cLocal  := cCity + ", " + dtoc(If(!Empty(TNC->TNC_DTEMIS),TNC->TNC_DTEMIS,dDataBase))
			nLocal  := len(cLocal) * 18
			nEspaco := (650 - (nLocal))/2

			If nLocal > 0
				oPrint:Say(lin+70,nEspaco+350,cLocal,oFont10)
			Else
				oPrint:Say(lin+70,340,cLocal,oFont10)
			EndIf

			oPrint:Line(lin+117,350,lin+117,1000)
			oPrint:Say(lin+127,580,STR0198,oFont07) //"Local e Data"
			oPrint:Line(lin+117,1400,lin+117,2050)
			oPrint:Say(lin+127,1550,STR0199,oFont07)	 //"Assinatura e carimbo do Emitente"

			oPrint:Line(lin+792,350,lin+792,1000)
			oPrint:Say(lin+802,580,STR0198,oFont07)	 //"Local e Data"
			oPrint:Line(lin+792,1400,lin+792,2050)
			oPrint:Say(lin+802,1490,STR0277,oFont07)	 	 //"Assinatura e carimbo do Médico com CRM"

			oPrint:Say(lin+185,250,"55 - "+STR0278,oFont07) //"Unidade de Atendimento Médico"
			oPrint:Say(lin+230,250,substr(TNC->TNC_LOCATE,1,72),oFont09)
			oPrint:Line(lin+175,1700,lin+275,1700)
			oPrint:Say(lin+185,1720,"56 - "+STR0279,oFont07) //"Data"
			oPrint:Say(lin+230,1720,Dtoc(TNC->TNC_DTATEN),oFont10)
			oPrint:Line(lin+175,2050,lin+275,2050)
			oPrint:Say(lin+185,2070,"57 - "+STR0280,oFont07) //"Hora"
			oPrint:Say(lin+230,2070,Transform(TNC->TNC_HRATEN,"99:99"),oFont10)

			oPrint:Say(lin+285,250,"58 - "+STR0281,oFont07)	   //"Houve internação?"
			oPrint:Box(lin+277,590,lin+320,620)

			If mv_par04 == 2  ///sim
				oPrint:Say(lin+280,595,TNC->TNC_INTERN,oFont10)
			EndIf

			oPrint:Say(lin+340,250,STR0258,oFont07)		 //"1 - Sim  2 - Não"
			oPrint:Line(lin+275,750,lin+375,750)
			oPrint:Say(lin+285,770,"59 - "+STR0282,oFont07)	   //"Duração provável do tratam."
			oPrint:Box(lin+340,930,lin+370,990)

			If mv_par04 == 2 	//sim
				oPrint:Say(lin+343,935,Alltrim(Str(TNC->TNC_QTAFAS,3)),oFont07)
			EndIf

			oPrint:Say(lin+340,1005,STR0102,oFont07)	 //"Dia(s)"
			oPrint:Line(lin+275,1270,lin+375,1270)
			oPrint:Say(lin+285,1290,"60 - "+STR0283,oFont07)	   //"Deverá o acidentado afastar-se do trab. durante o trat.?"
			oPrint:Box(lin+277,1980,lin+320,2010)

			If mv_par04 == 2  //sim
				oPrint:Say(lin+280,1985,TNC->TNC_AFASTA,oFont10)
			EndIf

			oPrint:Say(lin+340,1290,STR0258,oFont07) //"1 - Sim  2 - Não"
			oPrint:Say(lin+385,250,"61 - "+STR0284,oFont07) //"Descrição e natureza da lesão"

			If !Empty(TNC->TNC_DESLES)
				oPrint:Say(lin+430,250,TNC->TNC_DESLES,oFont10)
			Else
				oPrint:Say(lin+430,250,SubSTR(NGSEEK("TOJ",TNC->TNC_CODLES,1,"TOJ_NOMLES"),1,80),oFont10)
			EndIf

			oPrint:Say(lin+485,250,"62 - "+STR0285,oFont07) //"Diagnóstico provável"
			dbSelectArea( "TMR" )
			dbSetOrder( 1 )

			If MsSeek( xFilial( "TMR" ) + TNC->TNC_CID )
				cDoenca := TMR->TMR_DOENCA
			EndIf

			dbSelectArea("TMT")
			dbSetOrder(7)
			dbSeek(XFILIAL("TMT")+TNC->TNC_ACIDEN)

			If NGCADICBASE( "TMT_DIASYP" , "A" , "TMT" , .F. )
				cDiag := SubStr(IIF(!Empty(MsMM(TMT->TMT_DIASYP,10)),MsMM(TMT->TMT_DIASYP,10),cDoenca),1,65)
			Else
				cDiag := SubStr(IIF(!Empty(TMT->TMT_DIAGNO),TMT->TMT_DIAGNO,cDoenca),1,65)
			EndIf

			oPrint:Say(lin+530,250,cDiag,oFont10)
			oPrint:Line(lin+475,1700,lin+575,1700)
			oPrint:Say(lin+485,1720,"63 - CID - 10",oFont07)
			oPrint:Say(lin+530,1720,Alltrim(TNC->TNC_CID)+" - "+SubStr(NGSEEK("TMR",TNC->TNC_CID,1,"TMR_DOENCA"),1,20),oFont10)

			oPrint:Say(lin+585,250,"64 - "+STR0105,oFont07) //"Observações"
			oPrint:Say(lin+630,250,TNC->TNC_OBSERV	,oFont10)

			oPrint:Say(lin+860,150,"65 - "+STR0286,oFont07) //"Recebida em"
			oPrint:Line(lin+850,650,lin+950,650)
			oPrint:Say(lin+860,670,"66 - "+STR0287,oFont07) //"Código da Unidade"
			oPrint:Line(lin+850,1070,lin+950,1070)
			oPrint:Say(lin+860,1090,"67 - "+STR0288,oFont07) //"Número do Acidente"
			oPrint:Say(lin+905,1090,TNC->TNC_CATINS,oFont10)

			oPrint:Say(lin+960,150,"69 - "+STR0289,oFont06)	   //"É reconhecido o direito do segurado à habilitação de benefício"
			oPrint:Say(Lin+985,150,"     "+STR0290,oFont06) //"acidentário?"
			oPrint:Box(lin+985,450,lin+1025,480)
			oPrint:Say(lin+990,1125,"",oFont10)
			oPrint:Say(lin+1015,150,STR0258,oFont07)		 //"1 - Sim  2 - Não"


			oPrint:Say(lin+1060,150,"68 - "+STR0291,oFont07)	   //"Matrícula do servidor"

			oPrint:Line(lin+1232,350,lin+1232,850)
			oPrint:Say(lin+1242,540,STR0292,oFont07)	 //"Matrícula"
			oPrint:Line(lin+1232,950,lin+1232,1450)
			oPrint:Say(lin+1242,1070,STR0293,oFont07)		 //"Assinatura do servidor"

			oPrint:Say(lin+860,1620,STR0294,oFont07)	   //"Notas:"

			nLinha := lin+860+30
			nLinhasMemo := MLCOUNT(strNota01,45)
			lPrint := .T.
			For LinhaCorrente := 1 to nLinhasMemo
				If lPrint
					oPrint:Say(nLinha,1620,"1.",oFont07)
					lPrint := .F.
				Endif
				oPrint:Say(nLinha,1660,(MemoLine(strNota01,45,LinhaCorrente)),oFont07)
				nLinha += 25
			Next LinhaCorrente

			nLinha += 5
			nLinhasMemo := MLCOUNT(strNota02,45)
			lPrint := .T.
			For LinhaCorrente := 1 to nLinhasMemo
				If lPrint
					oPrint:Say(nLinha,1620,"2.",oFont07)
					lPrint := .F.
				Endif
				oPrint:Say(nLinha,1660,(MemoLine(strNota02,45,LinhaCorrente)),oFont07)
				nLinha += 25
			Next LinhaCorrente

			oPrint:Say(lin+1285,120,STR0295,oFont11) //"A COMUNICAÇÃO DO ACIDENTE É OBRIGATÓRIA, MESMO NO CASO EM QUE NÃO HAJA AFASTAMENTO DO TRABALHO."

			If Empty(TNC->TNC_DTEMIS)
				RECLOCK("TNC",.F.)
				TNC->TNC_DTEMIS := date()
				MSUNLOCK("TNC")
			Endif

			I++
			oPrint:EndPage()
			Dbselectarea("TNC")
			If TNC->TNC_INDACI == "2" .And. mv_par05 == 1
				U_QUEST830(oPrint)
			Endif
			lin := 100

		Next nX

		DbSelectArea("TNC")
		DbSkip()
	EndDo

	oPrint:Preview()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR830MOD2

@author  Denis Hyroshi de Souza
@since   07/11/2002
@param   oPrint, Objeto, Objeto de impressão
@param   i, Numérico, COntador de vias impressas
@param   l, Numérico, Linha

@return  Nil, Sempre Nulo
/*/
//-------------------------------------------------------------------
User Function MDTR830MOD2(oPrint,i,l)

	Local nX
	Local cObserv
	Local nObsLen
	Local nY
	Local nXX
	Local nZ
	Local nPosicao
	Local nPosFim
	Local cCODUSU := ""
	Local cNOMUSU := ""
	Local cNUMENT := ""
	Local cCid3 := ""
	Local cCGCSEM := ""

	Local lin := 150, cEmitente := space(10), cTipoCat := space(10), cTipoFil := space(10)
	Local cSexo := space(5), cEstCiv := space(5), cApos := space(3), cArea := space(5)
	Local cTipAci := space(10), cAfastam := space(3), cPolicial := space(3), cObito := space(3)
	Local cCidtest := space(10), cIntern := space(3), cAfastm := space(3), cTipoinsc := space(10)
	Local cIndLocal := space(10)

	DbSelectArea("TNC")
	DbSetOrder(1)
	DbSeek(xFilial("TNC")+mv_par01,.T.)

	While !Eof()                                 .And.;
		TNC->TNC_FILIAL == xFIlial("TNC")        .And.;
		TNC->TNC_ACIDEN <= mv_par02

		For nX := 1 To mv_par06

			oPrint:StartPage()
			DbSelectArea("TNC")
			DbSetOrder(1)
			DbSeek(xFilial("TNC")+TNC->TNC_ACIDEN)
			DbSelectArea("TM0")
			DbSetOrder(1)
			DbSeek(xFilial("TM0")+TNC->TNC_NUMFIC)
			Dbselectarea("SRA")
			DbSetOrder(1)
			DbSeek(TM0->TM0_FILFUN+TM0->TM0_MAT)
			Dbselectarea("TNH")
			DbSetOrder(1)
			DbSeek(xFilial("TNH")+TNC->TNC_CODOBJ)

			cCid3 := Alltrim(TNC->TNC_CID)+" - "+SubStr(NGSEEK("TMR",TNC->TNC_CID,1,"TMR_DOENCA"),1,30)
			Dbselectarea("TMT")
			DbSetOrder(7)
			If DbSeek(xFilial("TMT")+TNC->TNC_ACIDEN)
				Dbselectarea("TMK")
				DbSetOrder(1)
				DbSeek(xFilial("TMK")+TMT->TMT_CODUSU)
				cCODUSU := TMK->TMK_CODUSU
				cNOMUSU := TMK->TMK_NOMUSU
				cNUMENT := TMK->TMK_NUMENT
			Else
				dbSelectArea("TNY")
				dbSetOrder(5)
				If dbSeek(xFilial("TNY")+TNC->TNC_ACIDEN)
					Dbselectarea("TNP")
					DbSetOrder(1)
					DbSeek(xFilial("TNP")+TNY->TNY_EMITEN)
					cCODUSU := TNP->TNP_EMITEN
					cNOMUSU := TNP->TNP_NOME
					cNUMENT := TNP->TNP_NUMENT
				Endif
			Endif

			Dbselectarea(cAlias)
			DbSetOrder(1)
			DbSeek(xFilial(cAlias)+TNC->TNC_CC)

			oPrint:Box(lin-20, 30, 250, 2350 )
			oPrint:Say(lin-10,670,STR0009,oFont14 ) //"Comunicação de Acidente de Trabalho"
			If Empty(TNC->TNC_CATINS)
				oPrint:Say(lin+35,670,STR0298,oFont12 ) //"Número da CAT: "
			Else
				oPrint:Say(lin+35,670,STR0298 + alltrim(Transform(TNC->TNC_CATINS,"@R 9999999999-9/99")),oFont12 ) //"Número da CAT: "
			Endif

			lin := 270

			IF TNC->TNC_EMITEN = "1" ; cEmitente := STR0010 //"EMPREGADOR"
			ELSEIF TNC->TNC_EMITEN = "2" ; cEmitente := STR0011 //"SINDICATO"
			ELSEIF TNC->TNC_EMITEN = "3" ;	cEmitente := STR0012 //"MEDICO"
			ELSEIF TNC->TNC_EMITEN = "4" ;	cEmitente := STR0013 //"SEGURADO"
			ELSEIF TNC->TNC_EMITEN = "5" ;	cEmitente := STR0014 //"AUT. PUBLICA"
			ENDIF

			IF TNC->TNC_TIPCAT = "1" ; cTipoCat := STR0015 //"INICIAL"
			ELSEIF TNC->TNC_TIPCAT = "2" ; cTipoCat := STR0016 //"REABERTURA"
			ELSEIF TNC->TNC_TIPCAT = "3" ; cTipoCat := STR0017  //"OBITO"
			ENDIF

			IF TNC->TNC_TIPREV = "1" ; cTipoFil := STR0018 //"EMPREGADO"
			ELSEIF TNC->TNC_TIPREV = "2" ; cTipoFil := STR0019 //"TRABALHADOR AVULSO"
			ELSEIF TNC->TNC_TIPREV = "6" ; cTipoFil := STR0020 //"SEG. ESPECIAL"
			ELSEIF TNC->TNC_TIPREV = "7" ; cTipoFil := STR0021 //"MÉDICO RESIDENCIAL"
			ENDIF

			IF SRA->RA_SEXO = "M" ; cSexo := STR0022 //"MASCULINO"
			ELSEIF SRA->RA_SEXO = "F" ; cSexo := STR0023 //"FEMININO"
			ENDIF

			IF SRA->RA_ESTCIVI = "C" ; cEstCiv := STR0024   //"CASADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "D" ; cEstCiv := STR0025 //"DIVORCIADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "M" ; cEstCiv := STR0026   //"MARITAL"
			ELSEIF SRA->RA_ESTCIVI = "Q" ; cEstCiv := STR0027 //"DESQUITADO(A)"
			ELSEIF SRA->RA_ESTCIVI = "S" ; cEstCiv := STR0028 //"SOLTEIRO(A)"
			ELSEIF SRA->RA_ESTCIVI = "V" ; cEstCiv := STR0029 //"VIUVO(A)"
			ENDIF

			IF TNC->TNC_APOSEN = "1" ; cApos := STR0030 //"SIM"
			ELSE  ; cApos := STR0031 //"NÃO"
			ENDIF

			IF TNC->TNC_AREA = "1" ; cArea := STR0032 //"URBANA"
			ELSE ; cArea := STR0033 //"RURAL"
			ENDIF

			IF TNC->TNC_INDACI == "1" ; cTipAci := STR0034 //"ACIDENTE TIPICO"
			ELSEIF TNC->TNC_INDACI == "2" ; cTipAci := STR0035 //"ACIDENTE DE TRAJETO"
			ELSEIF TNC->TNC_INDACI == "3" ; cTipAci := STR0036 //"DOENÇA DO TRABALHO"
			ELSEIF TNC->TNC_INDACI == "4" ; cTipAci := STR0037 //"INCIDENTE"
			ENDIF

			IF TNC->TNC_AFASTA = "1" ; cAfastam := STR0030  //"SIM"
			ELSE ; cAfastam := STR0031 //"NÃO"
			ENDIF

			IF TNC->TNC_POLICI = "1" ; cPolicial := STR0030  //"SIM"
			ELSE ; cPolicial := STR0031  //"NÃO"
			ENDIF

			IF TNC->TNC_MORTE = "1" ; cObito := STR0030  //"SIM"
			ELSE ; cObito := STR0031  //"NÃO"
			ENDIF

			IF !EMPTY(TNC->TNC_ESTAD1)
				cCidtest := Alltrim(TNC->TNC_CIDAD1)+" - "+TNC->TNC_ESTAD1
			ELSE
				cCidtest := TNC->TNC_CIDAD1
			ENDIF

			IF TNC->TNC_INTERN = "1"  ; cIntern := STR0030 //"SIM"
			ELSE ; cIntern :=  STR0031  //"NÃO"
			ENDIF

			IF TNC->TNC_AFASTA = "1"  ; cAfastm := STR0030  //"SIM"
			ELSE   ; cAfastm :=  STR0031  //"NÃO"
			ENDIF

			cCGCCOM := alltrim(Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"))

			If(SM0->M0_TPINSC) == 1
				If lExist8301
					cCGCSEM := ExecBlock("MDTR8301",.F.,.F.)
				EndIf
			Else
			cCGCSEM := SM0->M0_CGC
			Endif
			IF SM0->M0_TPINSC = 1  ; cTipoinsc := STR0038+" - "+cCGCSEM //"CEI"
			ELSEIF SM0->M0_TPINSC = 2  ; cTipoinsc := STR0039+" - "+cCGCCOM //"CNPJ"
			ELSEIF SM0->M0_TPINSC = 3  ; cTipoinsc := STR0040+" - "+cCGCSEM //"CPF"
			ELSEIF SM0->M0_TPINSC = 4  ; cTipoinsc := STR0041+" - "+cCGCSEM //"INCRA"
			ELSE ; cTipoinsc := cCGCSEM
			ENDIF

			If TNC->TNC_INDLOC == "1"
				cIndLocal := STR0179 //"ESTABELECIMENTO DA EMPRESA"
			ElseIf TNC->TNC_INDLOC == "2"
				cIndLocal := STR0296 //"ONDE PRESTA SERVIÇO"
			ElseIf TNC->TNC_INDLOC == "3"
				cIndLocal := STR0266 //"VIA PÚBLICA"
			ElseIf TNC->TNC_INDLOC == "4"
				cIndLocal := STR0267 //"ÁREA RURAL"
			ElseIf TNC->TNC_INDLOC == "5"
				cIndLocal := STR0305 //"EMBARCAÇÃO"
			ElseIf TNC->TNC_INDLOC == "6"
				cIndLocal := STR0306 //"EXTERIOR"
			ElseIf TNC->TNC_INDLOC == "9"
				cIndLocal := STR0308 // "OUTROS"
			Endif

			oPrint:Say(lin+10,30,STR0042,oFont14 )   //"Informações do Emitente"
			lin += 10
			oPrint:Box(lin+60,30,lin+210,2350)
			oPrint:Line(lin+110,30,lin+110,2350)
			oPrint:Line(lin+160,30,lin+160,2350)
			oPrint:Line(lin+60,1160,lin+210,1160)
			oPrint:Line(lin+60,330,lin+210,330)
			oPrint:Line(lin+60,1460,lin+210,1460)
			oPrint:Say(lin+70,40,STR0043,oFont08) //"Emitente"
			oPrint:Say(lin+70,340,cEmitente,oFont09)
			oPrint:Say(lin+70,1170,STR0044,oFont08)   //"Data Emissão"
			oPrint:Say(lin+70,1470,DtoC(If(!Empty(TNC->TNC_DTEMIS),TNC->TNC_DTEMIS,dDataBase)),oFont09)
			oPrint:Say(lin+120,40,STR0045,oFont08)  //"Tipo de CAT"
			oPrint:Say(lin+120,340,cTipoCat,oFont09)
			oPrint:Say(lin+120,1170,STR0046,oFont08) //"Comunicação Obito"
			oPrint:Say(lin+120,1470,DtoC(TNC->TNC_DTOBIT),oFont09)
			oPrint:Say(lin+170,40,STR0047,oFont08)           //"Filiação"
			oPrint:Say(lin+170,340,cTipoFil,oFont09)
			oPrint:Say(lin+170,1170,STR0048,oFont08)  //"E-mail"
			oPrint:Say(lin+170,1470,"",oFont09)
			lin += 230

			oPrint:Say(lin+10,30,STR0049,oFont14 ) //"Informações do Empregador"
			lin += 10
			oPrint:Box(lin+60,30,lin+310,2350)
			oPrint:Line(lin+110,30,lin+110,2350)
			oPrint:Line(lin+160,30,lin+160,2350)
			oPrint:Line(lin+210,30,lin+210,2350)
			oPrint:Line(lin+260,30,lin+260,2350)
			oPrint:Line(lin+110,1160,lin+310,1160)
			oPrint:Line(lin+60,330,lin+310,330)
			oPrint:Line(lin+110,1460,lin+310,1460)
			oPrint:Say(lin+70,40,STR0050,oFont08) //"Razão Social/Nome"
			oPrint:Say(lin+70,340,Upper(Substr(SM0->M0_NOMECOM,1,60)),oFont09)
			oPrint:Say(lin+120,40,STR0051,oFont08) //"Tipo/Num. Documento"
			oPrint:Say(lin+120,340,cTipoinsc,oFont09)
			oPrint:Say(lin+120,1170,STR0052,oFont08)  //"CNAE"
			oPrint:Say(lin+120,1470,SM0->M0_CNAE,oFont09)
			oPrint:Say(lin+170,40,STR0053,oFont08)          //"CEP"
			oPrint:Say(lin+170,340,Transform(cCep,"@R 99999-999"),oFont09)
			oPrint:Say(lin+170,1170,STR0054,oFont08)  //"Endereço"
			oPrint:Say(lin+170,1470,Upper(Substr(cAddress,1,35)),oFont09)
			oPrint:Say(lin+220,40,STR0055,oFont08)   //"Bairro"
			oPrint:Say(lin+220,340,Upper(cBairro),oFont09)
			oPrint:Say(lin+220,1170,STR0056,oFont08)  //"Estado"
			oPrint:Say(lin+220,1470,Upper(cEstado),oFont09)
			oPrint:Say(lin+270,40,STR0057,oFont08)   //"Município"
			oPrint:Say(lin+270,340,Upper(cCity),oFont09)
			oPrint:Say(lin+270,1170,STR0058,oFont08)                      //"Telefone"
			oPrint:Say(lin+270,1470,SM0->M0_TEL,oFont09)
			lin += 330

			oPrint:Say(lin+10,30,STR0059,oFont14 ) //"Informações do Acidentado"
			lin += 10
			oPrint:Box(lin+60,30,lin+560,2350)
			oPrint:Line(lin+110,30,lin+110,2350)
			oPrint:Line(lin+160,30,lin+160,2350)
			oPrint:Line(lin+210,30,lin+210,2350)
			oPrint:Line(lin+260,30,lin+260,2350)
			oPrint:Line(lin+310,30,lin+310,2350)
			oPrint:Line(lin+360,30,lin+360,2350)
			oPrint:Line(lin+410,30,lin+410,2350)
			oPrint:Line(lin+460,30,lin+460,2350)
			oPrint:Line(lin+510,30,lin+510,2350)
			oPrint:Line(lin+60,330,lin+560,330)
			oPrint:Line(lin+60,1160,lin+160,1160)
			oPrint:Line(lin+60,1460,lin+160,1460)
			oPrint:Line(lin+210,1160,lin+560,1160)
			oPrint:Line(lin+210,1460,lin+560,1460)
			oPrint:Say(lin+70,40,STR0060,oFont08)         //"Nome"
			oPrint:Say(lin+70,340,Substr(SRA->RA_NOME,1,35),oFont09)
			oPrint:Say(lin+70,1170,STR0061,oFont08)	 //"Data de Nascimento"
			oPrint:Say(lin+70,1470,Dtoc(SRA->RA_NASC),oFont09)
			oPrint:Say(lin+120,40,STR0062,oFont08)  //"Nome da Mãe"
			oPrint:Say(lin+120,340,Substr(SRA->RA_MAE,1,35),oFont09)
			oPrint:Say(lin+120,1170,STR0063,oFont08)      //"Sexo"
			oPrint:Say(lin+120,1470,cSexo,oFont09)
			oPrint:Say(lin+170,40,STR0299,oFont08) //"Grau de Instrução"
			oPrint:Say(lin+170,340,SRA->RA_GRINRAI + " - " + NGSeek( "SX5" , "26" + SRA->RA_GRINRAI , 1 , "X5Descri()" ),oFont09)
			oPrint:Say(lin+220,40,STR0064,oFont08)  //"Estado Civil"
			oPrint:Say(lin+220,340,cEstCiv,oFont09)
			oPrint:Say(lin+220,1170,STR0065,oFont08)  //"Remuneração"

			//Calculando o salario do funcionario
			nSalario := 0

			If nSalario == 0

				fSalario( @nSalario, 0, 0, 0, 'A' )

			Endif

			aCodFol  := {}

			oPrint:Say(lin+220,1470,STR0066+space(1)+AllTrim(Transform(nSalario,"@E 999,999,999.99")),oFont09) //"R$"
			oPrint:Say(lin+270,40,STR0067,oFont08)  //"CTPS"
			oPrint:Say(lin+270,340,Transform(SRA->RA_NUMCP,cMascCP)+" - "+SRA->RA_SERCP,oFont09)
			oPrint:Say(lin+270,1170,STR0068,oFont08)  //"Identidade"
			oPrint:Say(lin+270,1470,SRA->RA_RG,oFont09)
			oPrint:Say(lin+320,40,STR0069,oFont08)  //"PIS/PASEP/NIT"
			oPrint:Say(lin+320,340,SRA->RA_PIS,oFont09)
			oPrint:Say(lin+320,1170,STR0054,oFont08)  //"Endereço"
			oPrint:Say(lin+320,1470,Substr(SRA->RA_ENDEREC,1,35),oFont09)
			oPrint:Say(lin+370,40,STR0055,oFont08)  //"Bairro"
			oPrint:Say(lin+370,340,SRA->RA_BAIRRO,oFont09)
			oPrint:Say(lin+370,1170,STR0053,oFont08)  //"CEP"
			oPrint:Say(lin+370,1470,Transform(SRA->RA_CEP,"@R 99999-999"),oFont09)
			oPrint:Say(lin+420,40,STR0056,oFont08)  //"Estado"
			oPrint:Say(lin+420,340,SRA->RA_ESTADO,oFont09)
			oPrint:Say(lin+420,1170,STR0057,oFont08)  //"Município"
			oPrint:Say(lin+420,1470,SRA->RA_MUNICIP,oFont09)
			oPrint:Say(lin+470,40,STR0058,oFont08)  //"Telefone"
			oPrint:Say(lin+470,340,SRA->RA_TELEFON,oFont09)
			oPrint:Say(lin+470,1170,STR0070,oFont08)       //"CBO"
			DbSelectArea("SRJ")
			DBSetOrder(1)
			DbSeek(xFilial("SRJ")+SRA->RA_CODFUNC)
			cCBO := SRJ->RJ_CBO
			If !Empty(SRJ->RJ_CODCBO)
				cCBO := SRJ->RJ_CODCBO
			Endif
			oPrint:Say(lin+470,1470,cCBO,oFont09)
			oPrint:Say(lin+520,40,STR0071,oFont08)  //"Aposentado"
			oPrint:Say(lin+520,340,cApos,oFont09)
			oPrint:Say(lin+520,1170,STR0072,oFont08) 	 //"Área"
			oPrint:Say(lin+520,1470,cArea,oFont09)
			lin += 590

			oPrint:Say(lin+10,30,STR0073,oFont14 ) //"Informações do Acidente"
			lin += 10
			oPrint:Box(lin+60,30,lin+860,2350)
			oPrint:Line(lin+110,30,lin+110,2350)
			oPrint:Line(lin+160,30,lin+160,2350)
			oPrint:Line(lin+210,30,lin+210,2350)
			oPrint:Line(lin+260,30,lin+260,2350)
			oPrint:Line(lin+310,30,lin+310,2350)
			oPrint:Line(lin+410,30,lin+410,2350)
			oPrint:Line(lin+460,30,lin+460,2350)
			oPrint:Line(lin+510,30,lin+510,2350)
			oPrint:Line(lin+610,30,lin+610,2350)
			oPrint:Line(lin+660,30,lin+660,2350)
			oPrint:Line(lin+760,30,lin+760,2350)
			oPrint:Line(lin+810,30,lin+810,2350)
			oPrint:Line(lin+60,1160,lin+410,1160)
			oPrint:Line(lin+610,1160,lin+860,1160)
			oPrint:Line(lin+60,330,lin+860,330)
			oPrint:Line(lin+60,1460,lin+410,1460)
			oPrint:Line(lin+610,1460,lin+860,1460)
			oPrint:Say(lin+70,40,STR0074,oFont08) //"Data do Acidente"
			oPrint:Say(lin+70,340,Dtoc(TNC->TNC_DTACID),oFont09)
			oPrint:Say(lin+70,1170,STR0075,oFont08)	 //"Hora do Acidente"
			oPrint:Say(lin+70,1470,Transform(TNC->TNC_HRACID,"99:99"),oFont09)
			oPrint:Say(lin+120,40,STR0076,oFont08)  //"Horas Trabalhadas"
			oPrint:Say(lin+120,340,Transform(TNC->TNC_HRTRAB,"99:99"),oFont09)
			oPrint:Say(lin+120,1170,STR0077,oFont08)  //"Tipo"
			oPrint:Say(lin+120,1470,cTipAci,oFont09)
			oPrint:Say(lin+170,40,STR0078,oFont08)  //"Afastamento"
			oPrint:Say(lin+170,340,cAfastam,oFont09)
			oPrint:Say(lin+170,1170,STR0079,oFont08)  //"Registro Policial"
			oPrint:Say(lin+170,1470,cPolicial,oFont09)
			oPrint:Say(lin+220,40,STR0080,oFont08)  //"Local do Acidente"
			oPrint:Say(lin+220,340,cIndLocal,oFont09)
			oPrint:Say(lin+220,1170,STR0081,oFont08)  //"Especificação Local"
			oPrint:Say(lin+220,1470,Substr(TNC->TNC_LOCAL,1,45),oFont09)
			oPrint:Say(lin+270,40,STR0082,oFont08)  //"CGC da Prestadora"
			oPrint:Say(lin+270,340,Transform(TNC->TNC_CGCPRE,"@!R NN.NNN.NNN/NNNN-99"),oFont09)
			oPrint:Say(lin+270,1170,STR0083,oFont08)  //"UF do Acidente"
			oPrint:Say(lin+270,1470,Upper(TNC->TNC_ESTACI),oFont09)
			oPrint:Say(lin+320,40,STR0084,oFont08)  //"Município do"
			oPrint:Say(lin+340,340,Upper(TNC->TNC_CIDACI),oFont09)
			oPrint:Say(lin+320,1170,STR0085,oFont08)  //"Último dia"
			oPrint:Say(lin+340,1470,Dtoc(TNC->TNC_DTULTI),oFont09)
			oPrint:Say(lin+370,40,STR0086,oFont08)  //"Acidente"
			oPrint:Say(lin+370,1170,STR0087,oFont08)  //"Trabalhado/Dt Óbito"

			oPrint:Say(lin+420,40,STR0088,oFont08)  //"Parte do Corpo"
			oPrint:Say(lin+470,40,STR0089,oFont08)  //"Agente Causador"

			If AliasInDic('TYE')//Se possui as novas tabela para o eSocial

				oPrint:Say(lin+420,340, SubStr( U_fRetAgePar( 1, TNC->TNC_ACIDEN ), 1, 135) ,oFont09)
				oPrint:Say(lin+470,340, SubStr( U_fRetAgePar( 2, TNC->TNC_ACIDEN ), 1, 135) ,oFont09)

			Else
				If lTNC_PARTE
					oPrint:Say(lin+420,340,TNC->TNC_PARTE,oFont09)
				Else
					dbSelectArea("TOI")
					dbSetOrder(01)
					dbSeek(xFilial("TOI")+TNC->TNC_CODPAR)
					oPrint:Say(lin+420,340,MemoLine(TOI->TOI_DESPAR,110,1),oFont09)
				Endif
				oPrint:Say(lin+470,340,TNH->TNH_DESOBJ,oFont09)
			EndIf

			oPrint:Say(lin+520,40,STR0090,oFont08) 	 //"Situação Geradora"
			oPrint:Say(lin+520,340,AllTrim(TNC->TNC_DESCR1),oFont09)
			oPrint:Say(lin+570,340,AllTrim(TNC->TNC_DESCR2),oFont09)
			oPrint:Say(lin+620,40,STR0091,oFont08)  //"Morte"
			oPrint:Say(lin+620,340,cObito,oFont09)
			oPrint:Say(lin+620,1170,STR0092,oFont08)  //"Data Óbito"
			oPrint:Say(lin+620,1470,DtoC(TNC->TNC_DTOBIT),oFont09)
			oPrint:Say(lin+670,40,STR0093,oFont08)   //"Descrição do"
			oPrint:Say(lin+670,340,(MemoLine(TNC->TNC_DESACI,35,1)),oFont09)
			oPrint:Say(lin+720,340,(MemoLine(TNC->TNC_DESACI,35,2)),oFont09)
			oPrint:Say(lin+690,1170,STR0094,oFont08)  //"Nome Testemunha"
			oPrint:Say(lin+690,1470,SubStr(TNC->TNC_TESTE1,1,40),oFont09)
			oPrint:Say(lin+720,40,STR0086,oFont08)  //"Acidente"
			oPrint:Say(lin+770,40,STR0054,oFont08)  //"Endereço"
			oPrint:Say(lin+770,340,Substr(TNC->TNC_ENDTE1,1,35),oFont09)
			oPrint:Say(lin+770,1170,STR0053,oFont08)  //"CEP"
			oPrint:Say(lin+770,1470,Transform(TNC->TNC_CEP1,"@R 99999-999"),oFont09)
			oPrint:Say(lin+820,40,STR0095,oFont08)  //"Município/UF"
			oPrint:Say(lin+820,340,cCidtest,oFont09)
			oPrint:Say(lin+820,1170,STR0058,oFont08)  //"Telefone"
			oPrint:Say(lin+820,1470,TNC->TNC_TELEF1,oFont09)
			lin += 880


			oPrint:Say(lin+10,30,STR0096,oFont14 ) //"Informações do Atestado Médico"
			lin += 10
			nPosicao := lin
			cObserv := Upper(AllTrim(TNC->TNC_OBSERV))
			nObsLen := Len(cObserv)
			If nObsLen <= 40
			oPrint:Box(lin+60,30,lin+360,2350)
				oPrint:Line(lin+260,1160,lin+360,1160)
				oPrint:Line(lin+60,330,lin+360,330)
				oPrint:Line(lin+260,1460,lin+360,1460)
			Else
				While nObsLen > 40
					nPosFim := lin+320
					lin += 50
					nObsLen -= 40
				End
				If nObsLen > 0
					nPosFim := lin+320
				EndIf
				nPosFim += 50
				oPrint:Box(nPosicao+60,30,nPosFim,2350)
				oPrint:Line(nPosicao+260,1160,nPosFim,1160)
				oPrint:Line(nPosicao+60,330,nPosFim,330)
				oPrint:Line(nPosicao+260,1460,nPosFim,1460)
			Endif
			lin := nPosicao
			oPrint:Line(lin+110,30,lin+110,2350)
			oPrint:Line(lin+160,30,lin+160,2350)
			oPrint:Line(lin+210,30,lin+210,2350)
			oPrint:Line(lin+260,30,lin+260,2350)
			oPrint:Line(lin+310,30,lin+310,2350)
			oPrint:Line(lin+60,1160,lin+210,1160)
			oPrint:Line(lin+60,1460,lin+210,1460)
			oPrint:Say(lin+70,40,STR0097,oFont08)   //"Unidade"
			oPrint:Say(lin+70,340,Substr(TNC->TNC_LOCATE,1,35),oFont09)
			oPrint:Say(lin+70,1170,STR0098,oFont08)	 //"Data Atendimento"
			oPrint:Say(lin+70,1470,Dtoc(TNC->TNC_DTATEN),oFont09)
			oPrint:Say(lin+120,40,STR0099,oFont08)               //"Hora Atendimento"
			oPrint:Say(lin+120,340,Transform(TNC->TNC_HRATEN,"99:99"),oFont09)

			oPrint:Say(lin+120,1170,STR0100,oFont08)              //"Internação"
			if mv_par04 == 2
				oPrint:Say(lin+120,1470,cIntern,oFont09)
			endif

			oPrint:Say(lin+170,40,STR0101,oFont08)        //"Duração Tratamento"
			if mv_par04 == 2
				oPrint:Say(lin+170,340,Alltrim(Str(TNC->TNC_QTAFAS,3))+" "+STR0102,oFont09)	 //"DIA(S)"
			endif

			oPrint:Say(lin+170,1170,STR0078,oFont08)             //"Afastamento"
			if mv_par04 == 2
				oPrint:Say(lin+170,1470,cAfastm,oFont09)
			endif

			oPrint:Say(lin+220,40,STR0103,oFont08)                //"Natureza Lesão"
			If !Empty(TNC->TNC_DESLES)
				oPrint:Say(lin+220,340,Upper(TNC->TNC_DESLES),oFont09)
			Else
				oPrint:Say(lin+220,340,Upper(SubSTR(NGSEEK("TOJ",TNC->TNC_CODLES,1,"TOJ_NOMLES"),1,80)),oFont09)
			Endif
			oPrint:Say(lin+270,40,STR0104+" - 10",oFont08)                       //"CID"
			oPrint:Say(lin+270,340,cCid3,oFont09)
			oPrint:Say(lin+270,1170,STR0297,oFont08) //"Médico"
			oPrint:Say(lin+270,1470,Alltrim(cCODUSU)+" - "+Substr(cNOMUSU,1,30),oFont09)
			********************************************
			nObsLen := Len(cObserv)
			If nObsLen <= 40
				oPrint:Say(lin+320,40,STR0105,oFont08)               //"Observações"
				oPrint:Say(lin+320,340,cObserv,oFont09)
				oPrint:Say(lin+320,1170,STR0106,oFont08)                     //"CRM"
				oPrint:Say(lin+320,1470,cNUMENT,oFont09)
				lin += 380
			Else
				oPrint:Say(lin+320,40,STR0105,oFont08)               //"Observações"
				oPrint:Say(lin+320,1170,STR0106,oFont08)                     //"CRM"
				oPrint:Say(lin+320,1470,cNUMENT,oFont09)


				nY := 0
				nXX := 1
				While nObsLen > 40
					nY ++
					nZ := 40 * nY
					nPosFim := lin+320
					oPrint:Say(nPosFim,340,SubSTR(cObserv,nXX,40),oFont09)
					lin += 50
					nXX := nZ + 1
					nObsLen -= 40
				End
				If nObsLen > 0
					nPosFim := lin+320
					oPrint:Say(nPosFim,340,SubSTR(cObserv,nXX,nObsLen),oFont09)
					nY ++
				EndIf

				lin += 380

			Endif
			********************************************
			oPrint:Say(lin+60,900,"________________________________________________________",oFont08)
			oPrint:Say(lin+90,1020,STR0277,oFont08) //"Assinatura e carimbo do Médico com CRM"

			If Empty(TNC->TNC_DTEMIS)
				RECLOCK("TNC",.F.)
				TNC->TNC_DTEMIS := date()
				MSUNLOCK("TNC")
			Endif

			I++
			oPrint:EndPage()
			Dbselectarea("TNC")
			If TNC->TNC_INDACI == "2" .And. mv_par05 == 1
				U_QUEST830(oPrint)
			Endif
			lin := 150
		Next nX

		DbSelectArea("TNC")
		DbSkip()
	EndDo

	oPrint:Preview()

Return Nil

//-------------------------------------------------------------------
/*/{Protheus.doc} QUEST830
Imprime o questinario de responsabilidade do empregador

@author  Denis Hyroshi de Souza
@since   29/04/2003
@param   oPrint, Objeto, Objeto de impressão

@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function QUEST830(oPrint)

	Local aArea := TNC->(GetArea())
	Local lin := 150
	Local cLOCACT,cHORSAI,cTRAJET,cMEIO,cLOCACI,cDISTAC,cMUDANC,cMOTIVO,cADMITE,cCONFIN,cHRRPAD,cHRRDIA

	store space(1) to cLOCACT,cHORSAI,cTRAJET,cMEIO,cLOCACI,cMUDANC,cMOTIVO,cADMITE,cCONFIN,cHRRPAD,cHRRDIA
	store 0 to cDISTAC
	Dbselectarea("TNC")
	cLOCACT := TNC->TNC_LOCACT
	cHORSAI := TNC->TNC_HORSAI
	cTRAJET := TNC->TNC_TRAJET
	cMEIO   := TNC->TNC_MEIO
	cLOCACI := TNC->TNC_LOCACI
	cDISTAC := TNC->TNC_DISTAC
	cMUDANC := TNC->TNC_MUDANC
	cMOTIVO := TNC->TNC_MOTIVO
	cADMITE := TNC->TNC_ADMITE
	cCONFIN := TNC->TNC_CONFIN
	cHRRPAD := TNC->TNC_HRRPAD
	cHRRDIA := TNC->TNC_HRRDIA

	//***************
	//***************  Pagina 1
	//***************
	oPrint:StartPage()
	oPrint:Say(lin,400,"RSPS - COORDENAÇÃO REGIONAL DE ACIDENTES DE TRABALHO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"QUALIFICAÇÃO DE ACIDENTE DE TRAJETO NOS TERMOS DAS ALÍNEAS 'd' E 'e' INCISO E",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"PARAGRÁFOS 4º E 5º DO ARTIGO 3º DO REGULAMENTO APROVADO PELO DECRETO Nº 790 DE 24",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"DE DEZEMBRO DE 1976.",oFontXX)

	lin := 450
	oPrint:Say(lin,550,"QUESTIONÁRIO DE RESPONSABILIDADE DO EMPREGADOR",oFontXX)

	lin := 550
	oPrint:Say(lin,150,"I - QUALIFICAÇÃO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"EMPREGADOR:",oFontXX)
	oPrint:Say(lin,430,ALLTRIM(SM0->M0_NOMECOM),oFontYY)
	lin += 50
	oPrint:Say(lin,150,"C.G.C. OU MATRÍCULA NO IAPAS:",oFontXX)
	oPrint:Say(lin,900,Transform(SM0->M0_CGC,"@!R NN.NNN.NNN/NNNN-99"),oFontYY)
	lin += 50
	oPrint:Say(lin,150,"ESTABELECIDA NA:",oFontXX)
	oPrint:Say(lin,580,cAddress+" - "+cBairro+" - "+cCity,oFontYY)
	lin += 50
	oPrint:Say(lin,150,"ACIDENTADO:",oFontXX)
	oPrint:Say(lin,450,ALLTRIM(SRA->RA_NOME),oFontYY)
	lin += 50
	oPrint:Say(lin,150,"RESIDENTE:",oFontXX)
	oPrint:Say(lin,450,ALLTRIM(SRA->RA_ENDEREC),oFontYY)
	lin += 50
	oPrint:Say(lin,150,"LOCAL DE TRABALHO:",oFontXX)
	oPrint:Say(lin,630,cAddress,oFontYY)
	lin += 100

	oPrint:Say(lin,150,"II - DESCRIÇÃO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"O ACIDENTE OCORREU NO PERCURSO:",oFontXX)
	lin += 50

	cMarca := If(cLOCACT=="1"," X ",space(3))
	oPrint:Say(lin,150,SPACE(5)+"a) DA RESIDÊNCIA PARA O TRABALHO"+" ("+cMarca+")",oFontXX)
	lin += 50
	cMarca := If(cLOCACT=="2"," X ",space(3))
	oPrint:Say(lin,150,SPACE(5)+"b) DO TRABALHO PARA A RESIDÊNCIA"+" ("+cMarca+")",oFontXX)
	lin += 50
	cMarca := If(cLOCACT=="3"," X ",space(3))
	oPrint:Say(lin,150,SPACE(5)+"c) DE IDA PARA O LOCAL DE REFEIÇÃO EM INTERVALO DE TRABALHO"+" ("+cMarca+")",oFontXX)
	lin += 50
	cMarca := If(cLOCACT=="4"," X ",space(3))
	oPrint:Say(lin,150,SPACE(5)+"d) DE VOLTA DO LOCAL DE REFEIÇÃO EM INTERVALO DE TRABALHO"+" ("+cMarca+")",oFontXX)
	lin += 50

	oPrint:Say(lin,150,"DATA DA OCORRÊNCIA:",oFontXX)
	oPrint:Say(lin,600,Dtoc(TNC->TNC_DTACID),oFontYY)
	oPrint:Say(lin,1000,"HORA:",oFontXX)
	oPrint:Say(lin,1180,Transform(TNC->TNC_HRACID,"99:99"),oFontYY)
	lin += 50

	oPrint:Say(lin,150,"HORÁRIO DE SAÍDA DO LOCAL ACIMA ASSINALADO:",oFontXX)
	oPrint:Say(lin,1120,Transform(cHORSAI,"99:99"),oFontYY)
	lin += 50

	oPrint:Say(lin,150,"HORÁRIO DE TRABALHO QUE O SEGURADO CUMPRIU OU DEVERIA TER CUMPRIDO NO DIA",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"DO ACIDENTE:",oFontXX)
	oPrint:Say(lin,500,cHRRDIA,oFontYY)
	lin += 50

	oPrint:Say(lin,150,"TRAJETO USUAL DO EMPREGADO:",oFontXX)
	oPrint:Say(lin,800,Memoline(cTRAJET,40,1),oFontYY)
	lin += 50
	oPrint:Say(lin,150,Memoline(cTRAJET,40,2),oFontYY)
	lin += 50

	oPrint:Say(lin,150,"MEIO DE LOCOMOÇÃO UTILIZADO PELO SEGURADO QUANDO DO ACIDENTE:",oFontXX)
	oPrint:Say(lin,1550,Alltrim(cMEIO),oFontYY)
	lin += 50

	oPrint:Say(lin,150,"LOCAL EM QUE OCORREU O ACIDENTE:",oFontXX)
	oPrint:Say(lin,920,Alltrim(cLOCACI),oFontYY)
	lin += 50

	oPrint:Say(lin,150,"DISTÂNCIA APROXIMADA ENTRE O LOCAL DE SAÍDA DO SEGURADO E O ACIDENTE:",oFontXX)
	oPrint:Say(lin,1800,Alltrim(Str(cDISTAC,5))+" m",oFontYY)
	lin += 50

	cSim := If(cMUDANC=="1","X",Space(1))
	cNao := If(cMUDANC=="2","X",Space(1))
	oPrint:Say(lin,150,"HOUVE ALTERAÇÃO OU MUDANÇA DE TRAJETO?      SIM( "+cSim+" ) NÃO( "+cNao+" )",oFontXX)
	lin += 50

	oPrint:Say(lin,150,"POR QUÊ?",oFontXX)
	lin += 50
	oPrint:Say(lin,150,cMOTIVO,oFontYY)

	lin += 50
	oPrint:Say(lin,150,"A AUTORIDADE POLICIAL TOMOU CONHECIMENTO DA OCORRÊNCIA:",oFontXX)
	oPrint:Say(lin,1400,If(TNC->TNC_POLICI=="1","SIM","NAO"),oFontYY)

	lin += 50
	oPrint:Say(lin,150,"(EM CASO DE RESPOSTA AFIRMATIVA JUNTAR CERTIDÃO DO REGISTRO DA OCORRÊNCIA).",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"ADMITE O EMPREGADOR O ENQUADRAMENTO DO ACIDENTE NOS DISPOSITIVOS LEGAIS TRANSCRITOS",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"NO VERSO?",oFontXX)
	oPrint:Say(lin,450,If(cADMITE=="1","SIM","NAO"),oFontYY)
	lin += 100

	oPrint:Say(lin,150,"III - OUTRAS CONSIDERAÇÕES",oFontXX)
	lin += 50
	oPrint:Say(lin,150,Substr(cCONFIN,1,80),oFontYY)
	lin += 150

	oPrint:Say(lin,150,"IV - HORÁRIO DE TRABALHO DO SEGURADO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,cHRRPAD,oFontYY)
	lin += 150


	oPrint:Say(lin,150,"NOTA: A INEXATIDÃO DAS DECLARAÇÕES CONSTANTES DESTE DOCUMENTO CONSTITUI CRIME",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"PREVISTO NOS ARTIGOS 171 E 299 DO CÓDIGO PENAL.",oFontXX)
	lin += 150

	oPrint:Say(lin,1300,"LOCALIDADE:",oFontXX)
	oPrint:Say(lin,1570,cCity+", "+DTOC(Date()),oFontYY)
	lin += 300

	oPrint:Line(lin-10,1380,lin-10,2150)
	oPrint:Say(lin,1400,"ASSINATURA E CARIMBO DO EMPREGADOR",oFontXX)
	lin += 50

	oPrint:EndPage()
	//***************
	//***************  Pagina 2
	//***************
	lin := 150

	oPrint:StartPage()
	oPrint:Say(lin,300,"REGULAMENTO APROVADO PELO DECRETO Nº 79037 DE 24 DE DEZEMBRO DE 1970",oFontXX)
	lin += 100
	oPrint:Say(lin,150,"ARTIGO 3º - SÃO TAMBÉM CONSIDERADOS COMO ACIDENTE DE TRABALHO:",oFontXX)
	lin += 50
	oPrint:Say(lin,250,"II - O ACIDENTE SOFRIDO PELO EMPREGADO AINDA QUE FORA DO LOCAL DE TRABALHO:",oFontXX)
	lin += 50
	oPrint:Say(lin,250,"d) NO PERCURSO DA RESIDÊNCIA PARA O TRABALHO OU DESTA PARA AQUELA;",oFontXX)
	lin += 50
	oPrint:Say(lin,250,"e) NO PERCURSO DE IDA OU VOLTA PARA O LOCAL DA REFEIÇÃO OU INTERVALO DE TRABALHO.",oFontXX)
	lin += 50
	oPrint:Say(lin,250,"4º - O DISPOSTO NO ÍTEM II, LETRAS 'd' E 'e', NÃO SE APLICAM AO ACIDENTE SOFRIDO PELO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"SEGURADO QUE POR INTERESSE PESSOAL TIVER INTERROMPIDO OU ALTERADO O PERCURSO.",oFontXX)
	lin += 50
	oPrint:Say(lin,250,"5º - ENTENDE-SE COMO PERCURSO O TRAJETO USUAL DA RESIDÊNCIA OU DO LOCAL DE REFEIÇÃO",oFontXX)
	lin += 50
	oPrint:Say(lin,150,"PARA O TRABALHO, OU DESTE PARA AQUELES.",oFontXX)
	lin += 150//LIN == 800

	oPrint:box(lin,150,2700,2200)
	oPrint:line(lin+120,150,lin+120,2200)
	oPrint:Say(lin+10,160,"CROQUI DESCRITO DO LOCAL DO ACIDENTE RELACIONADO COM O LOCAL DE TRABALHO-RESIDÊNCIA",oFontXX)
	oPrint:Say(lin+60,160,"OU TRABALHO-LOCAL DE REFEIÇÃO OU VICE-VERSA.",oFontXX)

	oPrint:EndPage()

	RestArea(aArea)

Return .T.

//-------------------------------------------------------------------
/*/{Protheus.doc} QUEST830TXT
Imprime o questinario de responsabilidade do empregador

@author  Denis Hyroshi de Souza
@since   29/04/2003
@return  Lógico, Sempre Verdadeiro
/*/
//-------------------------------------------------------------------
User Function QUEST830TXT()

	Local aArea := TNC->(GetArea()),xx
	Local cLOCACT,cHORSAI,cTRAJET,cMEIO,cLOCACI,cDISTAC,cMUDANC,cMOTIVO,cADMITE,cCONFIN,cHRRPAD,cHRRDIA
	store space(1) to cLOCACT,cHORSAI,cTRAJET,cMEIO,cLOCACI,cMUDANC,cMOTIVO,cADMITE,cCONFIN,cHRRPAD,cHRRDIA
	store 0 to cDISTAC

	Dbselectarea("TNC")
	cLOCACT := TNC->TNC_LOCACT
	cHORSAI := TNC->TNC_HORSAI
	cTRAJET := TNC->TNC_TRAJET
	cMEIO   := TNC->TNC_MEIO
	cLOCACI := TNC->TNC_LOCACI
	cDISTAC := TNC->TNC_DISTAC
	cMUDANC := TNC->TNC_MUDANC
	cMOTIVO := TNC->TNC_MOTIVO
	cADMITE := TNC->TNC_ADMITE
	cCONFIN := TNC->TNC_CONFIN
	cHRRPAD := TNC->TNC_HRRPAD
	cHRRDIA := TNC->TNC_HRRDIA

	//***************
	//***************  Pagina 1
	//***************
	li := 80
	Somalinha()
	@Li,035 PSay "RSPS - COORDENAÇÃO REGIONAL DE ACIDENTES DE TRABALHO"
	Somalinha()
		//          1         2         3         4         5         6         7         8         9         0         1         2         3
		//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	@Li,005 PSay "QUALIFICAÇÃO DE ACIDENTE DE TRAJETO NOS TERMOS DAS ALÍNEAS 'd' E 'e' INCISO E PARAGRÁFOS 4º E 5º DO ARTIGO 3º DO"
	Somalinha()
	@Li,005 PSay "REGULAMENTO APROVADO PELO DECRETO Nº 790 DE 24 DE DEZEMBRO DE 1976."
	Somalinha()
	Somalinha()
	@Li,040 PSay "QUESTIONÁRIO DE RESPONSABILIDADE DO EMPREGADOR"
	Somalinha()
	Somalinha()
	@Li,005 PSay "I - QUALIFICAÇÃO"
	Somalinha()
	@Li,005 PSay "Empregador:"
	@Li,018 PSay ALLTRIM(SM0->M0_NOMECOM)
	Somalinha()
	@Li,005 PSay "C.G.C. ou Matricula no IAPAS:"
	@Li,036 PSay SM0->M0_CGC Picture "@!R NN.NNN.NNN/NNNN-99"
	Somalinha()
	@Li,005 PSay "Estabelecias na:"
	@Li,023 PSay cAddress+" - "+cBairro+" - "+cCity
	Somalinha()
	@Li,005 PSay "Acidentado:"
	@Li,018 PSay ALLTRIM(SRA->RA_NOME)
	Somalinha()
	@Li,005 PSay "Residente:"
	@Li,017 PSay ALLTRIM(SRA->RA_ENDEREC)
	Somalinha()
	@Li,005 PSay "Local de Trabalho:"
	@Li,025 PSay cAddress
	Somalinha()
	Somalinha()
	@Li,005 PSay "II - DESCRIÇÃO"
	Somalinha()
	@Li,005 PSay "O Acidente ocorreu no percurso:"
	Somalinha()

	cMarca := If(cLOCACT=="1"," X ",space(3))
	@Li,010 PSay "a) Da Residencia para o Trabalho"+" ("+cMarca+")"
	Somalinha()
	cMarca := If(cLOCACT=="2"," X ",space(3))
	@Li,010 PSay "b) Do Trabalho para a Residencia"+" ("+cMarca+")"
	Somalinha()
	cMarca := If(cLOCACT=="3"," X ",space(3))
	@Li,010 PSay "c) De ida para o local de refeicao em intervalo de trabalho"+" ("+cMarca+")"
	Somalinha()
	cMarca := If(cLOCACT=="4"," X ",space(3))
	@Li,010 PSay "d) De volta do local de refeicao em intervalo de trabalho"+" ("+cMarca+")"
	Somalinha()

	@Li,005 PSay "Data da Ocorrencia:"
	@Li,026 PSay TNC->TNC_DTACID Picture "99/99/99"
	@Li,040 PSay "Hora:"
	@Li,047 PSay TNC->TNC_HRACID Picture "99:99"
	Somalinha()

	@Li,005 PSay "Horario de Saida do Local acima assinalado:"
	@Li,050 PSay cHORSAI Picture "99:99"
	Somalinha()
	@Li,005 PSay "Horario de Trabalho que o segurado cumpriu ou deveria ter cumprido no dia do acidente:"
	@Li,094 PSay cHRRDIA
	Somalinha()
	@Li,005 PSay "Trajeto Usual do Empregado:"
	@Li,033 PSay Substr(cTRAJET,1,80)
	Somalinha()
	@Li,005 PSay "Meio de Locomocao utilizado pelo segurado quando do acidente:"+Space(2)+Alltrim(cMEIO)
	Somalinha()

	@Li,005 PSay "Local em que ocorreu o acidente:"
	@Li,038 PSay Alltrim(cLOCACI)
	Somalinha()
	@Li,005 PSay "Distancia aproximada entre o local de saida do segurado e o acidente:  "+Alltrim(Str(cDISTAC,5))+" m"
	Somalinha()

	cSim := If(cMUDANC=="1","X",Space(1))
	cNao := If(cMUDANC=="2","X",Space(1))
	@Li,005 PSay "Houve alteracao ou mudanca de trajeto?  SIM( "+cSim+" ) NAO( "+cNao+" )"
	Somalinha()
	@Li,005 PSay "Por que?"
	Somalinha()
	@Li,005 PSay cMOTIVO
	Somalinha()
	@Li,005 PSay "A Autoridade policial tomou conhecimento da ocorrencia:"
	@Li,062 PSay If(TNC->TNC_POLICI=="1","SIM","NAO")
	Somalinha()
	@Li,005 PSay "(Em caso de resposta afirmativa juntar Certidao do Registro da Ocorrencia)."
	Somalinha()
	@Li,005 PSay "Admite o empregador o enquadramento do acidente nos dispositivos legais transcritos no verso?"
	@Li,100 PSay If(cADMITE=="1","SIM","NAO")
	Somalinha()
	Somalinha()

	@Li,005 PSay "III - OUTRAS CONSIDERAÇÕES"
	Somalinha()
	@Li,005 PSay cCONFIN
	Somalinha()
	Somalinha()
	@Li,005 PSay "IV - HORÁRIO DE TRABALHO DO SEGURADO"
	Somalinha()
	@Li,005 PSay cHRRPAD
	Somalinha()
	Somalinha()
		//          1         2         3         4         5         6         7         8         9         0         1         2         3
		//0123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012345678901234567890123456789012
	@Li,005 PSay "NOTA: A INEXATIDÃO DAS DECLARAÇÕES CONSTANTES DESTE DOCUMENTO CONSTITUI CRIME PREVISTO NOS ARTIGOS 171 E 299"
	Somalinha()
	@Li,005 PSay "DO CÓDIGO PENAL."
	Somalinha()
	Somalinha()

	@Li,068 PSay "Localidade:"
	@Li,081 PSay cCity+", "+DTOC(Date())
	Somalinha()
	Somalinha()
	Somalinha()
	Somalinha()

	@Li,074 PSay Replicate("_",36)
	Somalinha()
	@Li,075 PSay "Assinatura e carimbo do empregador"
	Somalinha()

	li := 80
	//***************
	//***************  Pagina 2
	//***************
	Somalinha()
	Somalinha()
	@Li,025 PSay "REGULAMENTO APROVADO PELO DECRETO Nº 79037 DE 24 DE DEZEMBRO DE 1970"
	Somalinha()
	Somalinha()
	@Li,005 PSay "ARTIGO 3º - SÃO TAMBÉM CONSIDERADOS COMO ACIDENTE DE TRABALHO:"
	Somalinha()
	@Li,010 PSay "II - O ACIDENTE SOFRIDO PELO EMPREGADO AINDA QUE FORA DO LOCAL DE TRABALHO:"
	Somalinha()
	@Li,010 PSay "d) NO PERCURSO DA RESIDÊNCIA PARA O TRABALHO OU DESTA PARA AQUELA;"
	Somalinha()
	@Li,010 PSay "e) NO PERCURSO DE IDA OU VOLTA PARA O LOCAL DA REFEIÇÃO OU INTERVALO DE TRABALHO."
	Somalinha()

	@Li,010 PSay "4º - O DISPOSTO NO ÍTEM II, LETRAS 'd' E 'e', NÃO SE APLICAM AO ACIDENTE SOFRIDO PELO SEGURADO QUE POR"
	Somalinha()
	@Li,005 PSay "INTERESSE PESSOAL TIVER INTERROMPIDO OU ALTERADO O PERCURSO."
	Somalinha()
	@Li,010 PSay "5º - ENTENDE-SE COMO PERCURSO O TRAJETO USUAL DA RESIDÊNCIA OU DO LOCAL DE REFEIÇÃO PARA O TRABALHO, OU DESTE"
	Somalinha()
	@Li,005 PSay "PARA AQUELES."
	Somalinha()
	Somalinha()
	Somalinha()
	@Li,006 PSay Replicate("_",114)
	Somalinha()
	@Li,005 PSay "|"
	@Li,006 PSay "CROQUI DESCRITO DO LOCAL DO ACIDENTE RELACIONADO COM O LOCAL DE TRABALHO-RESIDÊNCIA OU TRABALHO-LOCAL DE REFEIÇÃO"
	@Li,120 PSay "|"
	Somalinha()
	@Li,005 PSay "|"
	@Li,006 PSay "OU VICE-VERSA."
	@Li,120 PSay "|"
	Somalinha()
	@Li,005 PSay "|"
	@Li,006 PSay Replicate("_",114)
	@Li,120 PSay "|"
	For xx := 1 to 35
		Somalinha()
		@Li,005 PSay "|"
		@Li,120 PSay "|"
	Next xx
	Somalinha()
	@Li,005 PSay "|"
	@Li,006 PSay Replicate("_",114)
	@Li,120 PSay "|"

	RestArea(aArea)

Return .T.
/*
100u.r. -> 1,5cm
1cm     -> 66,5u.r.
1c      -> 27,5u.r.

font08
8c -> 1cm
8c -> 66,5 u.r.
1c -> 8,3 u.r.
*/

//-------------------------------------------------------------------
/*/{Protheus.doc} fRetAgePar
Retorna as descrições das partes do corpo atingidas e dos agentes
causadores do acidente.

@author  Julia Kondlatsch
@since   18/05/2018
@sample  U_fRetAgePar(1, TNC->TNC_ACIDEN)

@param   nCampo, Numérico, Campo a ser retornado (1) Parte do corpo,
(2) Agente Causador
@param   cAciden, Caractere, Código do acidente

@return  cDescri, Caractere, Descrição do campo passado como parâmetro
/*/
//-------------------------------------------------------------------
User Function fRetAgePar( nCampo, cAciden )

	Local cDescri   := ''
	Local lCpo1     := nCampo == 1
	Local cTabCod   := IIf( lCpo1, 'TYF'/*Parte do corpo atingida*/, 'TYE'/*Agente Causador*/ )//Tabela com o código
	Local cTabDes   := IIf( lCpo1, 'TOI', 'TNH' )//Tabela com a a descrição
	Local lPrimeiro := .T.

	dbSelectArea( cTabCod )
	dbSetOrder( 01 )//TYF_FILIAL+TYF_ACIDEN+TYE_CODPAR / TYE_FILIAL+TYE_ACIDEN+TYE_CAUSA
	If dbSeek( xFilial( cTabCod )+cAciden )
		While &(cTabCod)->( !EoF() ) .And. ;
			&( PrefixoCpo(cTabCod)+'_FILIAL' ) == xFilial( cTabCod ) .And.;
		 	&( PrefixoCpo(cTabCod)+'_ACIDEN' ) == cAciden

			If !lPrimeiro
				cDescri += '; '
			Else
				lPrimeiro := .F.
			EndIf

			cDescri += AllTrim( NgSeek( cTabDes , ;
										IIf( lCpo1, TYF->TYF_CODPAR, TYE->TYE_CAUSA ), ;
										1, ;
										IIf( lCpo1, 'TOI_DESPAR', 'TNH_DESOBJ' ) ) )

			&(cTabCod)->( DbSkip() )

		EndDo
	EndIf

Return cDescri
