/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "TOPCONN.CH"
#INCLUDE "XMLXFUN.CH"
#INCLUDE "TECR900.CH"



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณTECR900  บAutor  ณTOTVS		         บ Data ณ  05/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina principal para gera็ใo dos arquivos GESP Xml	      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                	                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function TECR900()

Local aArea 		:= GetArea()
Local cDirArq 		:= SuperGetMV("MV_TECXML",,"c:\XML Gesp")
Local cDirDia		:= "" 
Local cArqPessoa	:= "Pessoas.xml"
Local cArqPS		:= "PostosDeServicos.xml"
Local cArqArmas		:= "Armas.xml"
Local lContinua		:= .T.


//Verifica se o nome do arquivo foi preenchido
If !Empty(cDirArq)

	//Verifica se o diret๓rio informado no parโmetro MV_TECXML  existe.
	If VldDirPar(cDirArq)
		
		//Variavel recebe o diret๓rio com a data 
		cDirDia := cDirArq+"\"+GetDDirDia()   
		
		//Verifica se existe o diret๓rio com data existe. Senใo existir serแ criado.
		If CriaDirDia(cDirDia)

			//Verifica se o arquivo existe o arquivo pessoa.xml. Se existir serแ excluido para a cria็ใo do novo
			If File(cDirDia+"\"+cArqPessoa)
				lContinua := ExclArq(cDirDia+"\"+cArqPessoa)
			EndIf


			//Verifica se o arquivo existe o arquivo pessoa.xml. Se existir serแ excluido para a cria็ใo do novo
			If File(cDirDia+"\"+cArqPS)
				lContinua := ExclArq(cDirDia+"\"+cArqPS)
			EndIf

			//Verifica se o arquivo existe o arquivo pessoa.xml. Se existir serแ excluido para a cria็ใo do novo
			If File(cDirDia+"\"+cArqArmas)
				lContinua := ExclArq(cDirDia+"\"+cArqArmas)
			EndIf

			
			If lContinua  

				//Chama a rotina para gravar o arquivo pessoa.xml
				LjMsgRun(STR0005+cArqPessoa,STR0008,{||GXMLPessoa(cDirDia+"\"+cArqPessoa)})//"Gerando arquivo: "			
				
				//Chama a rotina para gravar o arquivo postosdeservico.xml
				LjMsgRun(STR0005+cArqPS,STR0008,{||GXMLPS(cDirDia+"\"+cArqPS)})//"Gerando arquivo: "			

				//Chama a rotina para gravar o arquivo Armas.xml
				LjMsgRun(STR0005+cArqArmas,STR0008,{||GXMLArmas(cDirDia+"\"+cArqArmas)})//"Gerando arquivo: "							
                
				Aviso(STR0006,STR0007,{STR0009},2) //Processamento##Finaliza็ใo do processamento##OK
			Endif
		EndIf
	EndIf
		
Else
	HELP(" ",1,"PARAMVAZIO",,STR0001,4,2)
Endif



Restarea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGXMLPessoa  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para gravar os dados do arquivo 			  บฑฑ
ฑฑบ          ณpessoa.xml				           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GXMLPessoa(cArq)

Local aArea 	:= Getarea()
Local cTextoAux	:= ""
Local cArqTmp	:= GetNextAlias()

Default cArq := ""        

BeginSql Alias cArqTmp
	
	SELECT RA_FILIAL, RA_CIC, RA_NOME, RA_ENDEREC, RA_BAIRRO, RA_CEP, RA_ESTADO, RA_MUNICIP, RA_DDDFONE,
	RA_TELEFON, RA_PIS, RA_ADMISSA, RA_RG, RA_COMPLRG, RA_NASC, RA_NACIONA, RA_NATURAL, RA_SEXO, AA1_VINCUL, AA1_EXTVIG
	FROM %Table:SRA% SRA
	
	INNER JOIN %Table:AA1% AA1
	ON AA1.AA1_FILIAL = %xfilial:AA1%
	AND AA1.AA1_CDFUNC = SRA.RA_MAT
	AND AA1.%NotDel%
	
	WHERE SRA.RA_FILIAL = %xfilial:SRA%
	AND SRA.%NotDel%
	AND RA_SITFOLH NOT IN(%Exp:"D"%,%Exp:"T"%)
	
EndSql

//Tag para evitar problemas com caracter acentuados
cTextoAux	:= '<?xml version="1.0" encoding="iso-8859-1"?>'+CRLF
cTextoAux	+= '<pessoa-array>'+CRLF

//Chama a rotina para gravar os dados no arquivo
GravaTxt( cArq, cTextoAux)

While (cArqTmp)->(!Eof())
	cTextoAux := ""
	 
	cTextoAux += '	<pessoa>'
	cTextoAux += '		<vinculoEmpregaticio>'+Alltrim((cArqTmp)->AA1_VINCUL)+'</vinculoEmpregaticio>'+CRLF
	cTextoAux += '		<cpf>'+Alltrim(GetTxt((cArqTmp)->RA_CIC))+'</cpf>'+CRLF
	cTextoAux += '		<nome>'+Alltrim((cArqTmp)->RA_NOME)+'</nome>'+CRLF
	cTextoAux += '		<cnpj>'+Alltrim(GetTxt((cArqTmp)->RA_CIC))+'</cnpj>'+CRLF//Alterar
	cTextoAux += '		<endereco>'+Alltrim(GetTxt((cArqTmp)->RA_ENDEREC))+'</endereco>'+CRLF
	cTextoAux += '		<bairro>'+Alltrim((cArqTmp)->RA_BAIRRO)+'</bairro>'+CRLF
	cTextoAux += '		<cep>'+Alltrim(GetTxt((cArqTmp)->RA_CEP))+'</cep>'+CRLF
	cTextoAux += '		<estado>'+Alltrim((cArqTmp)->RA_ESTADO)+'</estado>'+CRLF
	cTextoAux += '		<cidade>'+Alltrim((cArqTmp)->RA_MUNICIP)+'</cidade>'+CRLF
	cTextoAux += '		<telefone>'+Alltrim((cArqTmp)->(RA_DDDFONE + RA_TELEFON))+'</telefone>'+CRLF
	cTextoAux += '		<pis>'+Alltrim(GetTxt((cArqTmp)->RA_PIS))+'</pis>'+CRLF
	cTextoAux += '		<dataAdmissao>'+GetTxt(DTOC(STOD((cArqTmp)->RA_ADMISSA)))+'</dataAdmissao>'+CRLF
    
	If Alltrim((cArqTmp)->AA1_EXTVIG) == "1"
		cTextoAux += '		<extensao>TV</extensao>'+CRLF
	Elseif Alltrim((cArqTmp)->AA1_EXTVIG) == "2"
		cTextoAux += '		<extensao>SPP</extensao>'+CRLF
	ElseIf Alltrim((cArqTmp)->AA1_EXTVIG) == "3"
		cTextoAux += '		<extensao>TV;SPP</extensao>'+CRLF
	ElseIf Alltrim((cArqTmp)->AA1_EXTVIG) == "4"
		cTextoAux += '		<extensao>SPP;TV</extensao>'+CRLF
	Else
		cTextoAux += '		<extensao></extensao>'+CRLF
	EndIf


	cTextoAux += '		<sexo>'+Alltrim((cArqTmp)->RA_SEXO)+'</sexo>'+CRLF
	cTextoAux += '		<rg>'+Alltrim(GetTxt((cArqTmp)->RA_RG))+'</rg>'+CRLF
	cTextoAux += '		<orgaoExpedidor>'+(cArqTmp)->RA_COMPLRG+'</orgaoExpedidor>'+CRLF
	cTextoAux += '		<dataNascimento>'+GetTxt(DTOC(STOD((cArqTmp)->RA_NASC)))+'</dataNascimento>'+CRLF
	cTextoAux += '		<paisNascimento>'+Alltrim((cArqTmp)->RA_NACIONA)+'</paisNascimento>'+CRLF
	cTextoAux += '		<estadoNascimento>'+Alltrim((cArqTmp)->RA_NATURAL)+'</estadoNascimento>'+CRLF
	cTextoAux += '		<cidadeNascimento>'+Alltrim(GetCdNasc((cArqTmp)->RA_NATURAL))+'</cidadeNascimento>'+CRLF
	cTextoAux += '	</pessoa>'+CRLF
    
	//Grava os dados no final do arquivo
	GravaTxt( cArq, cTextoAux)

	(cArqTmp)->(DbSkip())
EndDo                    
cTextoAux	:= '</pessoa-array>'
GravaTxt( cArq, cTextoAux)

(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGXMLPS  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para gravar os dados do arquivo'			  บฑฑ
ฑฑบ          ณpostosdeservicos.xml		           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GXMLPS(cArq)

Local aArea 	:= Getarea()
Local cTextoAux	:= ""
Local cArqTmp	:= GetNextAlias()
Local aArmPost	:= {}
Local aVigPost 	:= {}
Local nX		:= 0

Default cArq := ""        

BeginSql Alias cArqTmp
	
	SELECT A1_CGC, ABS_CODIGO, ABS_LOJA, ABS_LOCAL, ABS_DESCRI, ABS_END, ABS_BAIRRO, ABS_CEP, ABS_ESTADO, ABS_MUNIC, ABS_CONTAT, U5_FCOM2
	FROM %Table:ABS% ABSP
	
	INNER JOIN %Table:SA1% SA1
	ON SA1.A1_FILIAL = %xfilial:SA1%
	AND SA1.A1_COD = ABSP.ABS_CODIGO
	AND SA1.A1_LOJA = ABSP.ABS_LOJA
	AND SA1.%NotDel%
	
	INNER JOIN %Table:SU5% U5
	ON U5.U5_FILIAL = %xfilial:SU5%
	AND U5.U5_CODCONT = ABSP.ABS_CONTAT
	AND U5.%NotDel%
/*	
	INNER JOIN %Table:AAH% AAH
	ON AAH.AAH_FILIAL = %xfilial:AAH%
	AND AAH.AAH_CODCLI = ABSP.ABS_CODIGO
	AND AAH.AAH_LOJA = 	ABSP.ABS_LOJA
	AND AAH.AAH_STATUS = %Exp:"1"%
	AND AAH.%NotDel%
	*/
	WHERE ABSP.ABS_FILIAL = %xfilial:ABS%
	AND ABSP.%NotDel%
EndSql


//Tag para evitar problemas com caracter acentuados
cTextoAux	:= '<?xml version="1.0" encoding="iso-8859-1"?>'+CRLF
cTextoAux	+= '<postoservico-array>'+CRLF
 
//Chama a rotina para gravar os dados no arquivo
GravaTxt( cArq, cTextoAux)

While (cArqTmp)->(!Eof())
	cTextoAux := ""
	cTextoAux	+= '	<postoservico>'
	cTextoAux	+= '		<cnpjContratante>'+Alltrim(GetTxt((cArqTmp)->A1_CGC))+'</cnpjContratante> '+CRLF	 
	cTextoAux	+= '		<identificador>'+Alltrim((cArqTmp)->ABS_DESCRI)+'</identificador> '+CRLF	 
	cTextoAux	+= '		<cnpjPosto>'+Alltrim(GetTxt((cArqTmp)->A1_CGC))+'</cnpjPosto> '+CRLF	 
	cTextoAux	+= '		<qtdPostosArmados>'+Alltrim(GetQtdPArm((cArqTmp)->ABS_LOCAL))+'</qtdPostosArmados> '+CRLF	 
	cTextoAux	+= '		<qtdPostos>'+GetQtPCli((cArqTmp)->ABS_CODIGO, (cArqTmp)->ABS_LOJA)+'</qtdPostos> '+CRLF	 	
	cTextoAux	+= '		<endereco>'+Alltrim((cArqTmp)->ABS_END)+'</endereco> '+CRLF	 		
	cTextoAux	+= '		<bairro>'+Alltrim((cArqTmp)->ABS_BAIRRO)+'</bairro> '+CRLF
	cTextoAux	+= '		<cep>'+Alltrim(GetTxt((cArqTmp)->ABS_CEP))+'</cep> '+CRLF
	cTextoAux	+= '		<estado>'+Alltrim((cArqTmp)->ABS_ESTADO)+'</estado> '+CRLF	
	cTextoAux	+= '		<cidade>'+Alltrim((cArqTmp)->ABS_MUNIC)+'</cidade> '+CRLF	
	cTextoAux	+= '		<telefone>'+Alltrim((cArqTmp)->U5_FCOM2)+'</telefone> '+CRLF				
	//cTextoAux	+= '		<telefone>'+Alltrim(IIF(!EMPTY(M->ABS_CONTAT),ALLTRIM( POSICIONE("SU5",1,XFILIAL("SU5")+M->ABS_CONTAT,"U5_FCOM2") ) ,""))+'</telefone> '+CRLF			

	aArmPost	:= {}	
	aArmPost	:= GetArmas((cArqTmp)->ABS_LOCAL)//Rotina utilizada para retornar o registro (SINARM) das armas por posto de servi็o
	If Len(aArmPost) > 0
		cTextoAux	+= '		<armas>'+CRLF

		For nX := 1 To Len(aArmPost)
			cTextoAux	+= '			<arma>'+CRLF	
			cTextoAux	+= '				<cadastroSinarm>'+Alltrim(aArmPost[nX])+'</cadastroSinarm>'+CRLF	
			cTextoAux	+= '			</arma>'+CRLF	
		Next

		cTextoAux	+= '		</armas>'+CRLF	
 	EndIf   
 
	aVigPost := {}
	aVigPost := GetVigPost((cArqTmp)->ABS_LOCAL)//Rotina utilizada para retornar o CPF dos vigilantes por posto
	
	If Len(aVigPost) > 0
		cTextoAux	+= '		<vigilantes>'+CRLF

		For nX := 1 To Len(aVigPost)
			cTextoAux	+= '			<vigilante>'+CRLF	
			cTextoAux	+= '				<cpfVigilante>'+Alltrim(aVigPost[nX])+'</cpfVigilante>'+CRLF	
			cTextoAux	+= '			</vigilante>'+CRLF		
		Next

		cTextoAux	+= '		</vigilantes>'+CRLF	
	EndIf

	cTextoAux	+= '	</postoservico>'+CRLF	 	
	GravaTxt( cArq, cTextoAux)

	(cArqTmp)->(DbSkip())
EndDo      
              
cTextoAux	:= '</postoservico-array>'
GravaTxt( cArq, cTextoAux)

(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGXMLArmas  บAutor  ณTOTVS			     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRotina utilizada para gravar o arquivo Armas.xml			  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GXMLArmas(cArq)

Local aArea 	:= Getarea()
Local cTextoAux	:= ""
Local cArqTmp	:= GetNextAlias()

Default cArq := ""        

BeginSql Alias cArqTmp

	SELECT TE0_SINARM, TE0_NUMREG FROM %Table:TE0% TE0
	WHERE TE0_FILIAL = %xfilial:TE0%
	AND TE0.%NotDel%
	
EndSql



//Tag para evitar problemas com caracter acentuados
cTextoAux	:= '<?xml version="1.0" encoding="iso-8859-1"?>'+CRLF
cTextoAux	+= '<arma-array>'+CRLF
 
//Chama a rotina para gravar os dados no arquivo
GravaTxt( cArq, cTextoAux)

While (cArqTmp)->(!Eof())
	cTextoAux := ""
	cTextoAux	+= '	<arma>'+CRLF	 
	cTextoAux	+= '		<cadastroSinarm>'+Alltrim((cArqTmp)->TE0_SINARM)+'</cadastroSinarm>'+CRLF	 
	cTextoAux	+= '		<numeroArma>'+Alltrim((cArqTmp)->TE0_NUMREG)+'</numeroArma>'+CRLF	 
	cTextoAux	+= '	</arma>'+CRLF	 	
	GravaTxt( cArq, cTextoAux)

	(cArqTmp)->(DbSkip())
EndDo      
              
cTextoAux	:= '</arma-array>'
GravaTxt( cArq, cTextoAux)

(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetQtdPArm  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a quantidade de postos armados					  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetQtdPArm(cCodPosto)

Local aArea 	:= Getarea()
Local cArqTmp	:= GetNextAlias()
Local cRet		:= "0"      

Default cCodPosto := ""

BeginSql Alias cArqTmp
	
	SELECT	COUNT(*) QTDPOSTARM FROM %Table:TFG% TFG
	
	INNER JOIN %Table:SB5% SB5
	ON SB5.B5_FILIAL = %xfilial:SB5%
	AND SB5.%NotDel%
	AND SB5.B5_COD = TFG.TFG_PRODUT
	AND SB5.B5_TPISERV = %Exp:"1"%
	
	WHERE TFG.TFG_FILIAL = %xfilial:TFG%
	AND TFG.%NotDel%
	AND TFG.TFG_LOCAL = %Exp:cCodPosto%
	
EndSql



If (cArqTmp)->(!Eof())
	cRet :=	Alltrim(Str((cArqTmp)->QTDPOSTARM))
EndIf


(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetQtPCli	  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a quantidade de postos por cliente				  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetQtPCli(cCliente, cLoja)

Local aArea 	:= Getarea()
Local cArqTmp	:= GetNextAlias()
Local cRet		:= "0"      

Default cCliente	:= "" 
Default cLoja		:= ""

BeginSql Alias cArqTmp
	
	SELECT COUNT(*) QTDPOSTCLI  FROM %Table:ABS% ABS

	INNER JOIN %Table:AAH% AAH
	ON AAH.AAH_FILIAL = %xfilial:AAH%
	AND AAH.AAH_CODCLI = ABS.ABS_CODIGO
	AND AAH.AAH_LOJA = 	ABS.ABS_LOJA
	AND AAH.AAH_STATUS = %Exp:"1"%      
	AND AAH.%NotDel%
	
	INNER JOIN %Table:ABB% ABB
	ON  ABB.ABB_FILIAL = %xfilial:ABB%
	AND ABB.ABB_LOCAL = ABS.ABS_LOCAL
	AND ABB.%NotDel%

	WHERE ABS.ABS_FILIAL = %xfilial:ABS%
	AND ABS.%NotDel%
	AND ABS.ABS_CODIGO = %Exp:cCliente%
		
EndSql


If (cArqTmp)->(!Eof())
	cRet :=	Alltrim(Str((cArqTmp)->QTDPOSTCLI))
EndIf


(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetArmas  บAutor  ณTOTVS			     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o c๓digo SINARM das armas para cada posto			  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetArmas(cPostServ)
Local aArea 	:= Getarea()
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}

Default cPostServ	:= "" 
	
BeginSql Alias cArqTmp
	
	SELECT TFG_LOCAL, TE0_SINARM FROM %Table:TFG% TFG
	
	INNER JOIN %Table:TE0% TE0
	ON TE0.TE0_FILIAL = %xfilial:TE0%
	AND TE0.%NotDel%
	AND TE0.TE0_POSTAL = TFG.TFG_LOCAL
	
	WHERE TFG_FILIAL = %xfilial:TFG%
	AND TFG.%NotDel%
	AND TFG.TFG_LOCAL = %Exp:cPostServ%
	
EndSql


While (cArqTmp)->(!Eof())
	
	Aadd(aRet, (cArqTmp)->TE0_SINARM)
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return aRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetVigPost บAutor  ณTOTVS			     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o CPF dos vigilantes por posto					  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetVigPost(cPostServ)
Local aArea 	:= Getarea()
Local cArqTmp	:= GetNextAlias()
Local aRet		:= {}

Default cPostServ	:= "" 
	
BeginSql Alias cArqTmp
	
	SELECT ABB_LOCAL, AA1_CDFUNC, RA_CIC FROM %Table:ABB% ABBP

	INNER JOIN  %Table:AA1% AA1
	ON AA1.AA1_FILIAL = ABBP.ABB_FILIAL
	AND	AA1.AA1_CODTEC = ABBP.ABB_CODTEC 
	AND AA1.%NotDel%

	INNER JOIN %Table:SRA% SRA 
	ON SRA.RA_FILIAL = %xfilial:SRA%
	AND SRA.RA_MAT = AA1.AA1_CDFUNC
	AND SRA.%NotDel%

	WHERE ABBP.ABB_FILIAL = %xfilial:ABB% 
	AND ABBP.ABB_LOCAL = %Exp:cPostServ%
	AND ABBP.ABB_DTINI BETWEEN %Exp:DTOS(MsDate())%  AND %Exp:DTOS(MsDate())%
	AND ABBP.ABB_DTFIM BETWEEN %Exp:DTOS(MsDate())%  AND %Exp:DTOS(MsDate())%
	AND ABBP.ABB_ATIVO = %Exp:"1"% 
	AND ABBP.%NotDel%
	GROUP BY ABB_LOCAL, AA1_CDFUNC, RA_CIC
	
EndSql


While (cArqTmp)->(!Eof())
	
	Aadd(aRet, (cArqTmp)->RA_CIC )
	
	(cArqTmp)->(DbSkip())
EndDo


(cArqTmp)->(DbCloseArea())

Restarea(aArea)
Return aRet




/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณVldDirPar  บAutor  ณTOTVS			     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se existe diretorio informado no parametro		  บฑฑ
ฑฑบ          ณMV_TECXML							           				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function VldDirPar(cDir)
Local aArea 	:= GetArea()
Local lRet		:= .T.

Default cDir 	:= ""

If !ExistDir(cDir)
	lRet := .F.
	HELP(" ",1,"VALIDDIRETORIO",,STR0002+cDir,4,2)  //Diret๓rio nใo encontrado: 
EndIf

RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณCriaDirDia  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria o dirt๓rio diแrio para grava็ใo do arquivo Pessoal.xml บฑฑ
ฑฑบ          ณ           				  								  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CriaDirDia(cDir) 

Local aArea 	:= GetArea()
Local lRet		:= .T.

Default cDir 	:= ""

If !ExistDir(cDir)
	If MakeDir( cDir ) < 0
		lRet := .F.
		HELP(" ",1,"CRIADIR",,STR0003,4,2)  //Erro ao tentar criar diret๓rio
		
		Return lRet
	Else
		lRet := .T.
	EndIf
EndIf

RestArea(aArea)
Return lRet   



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetCdNasc	  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ		  บฑฑ
ฑฑบ          ณ							           				  		  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetCdNasc(cEst)

Local aRet	:= {}
Local cRet	:= ""

Default cEst := ""

aRet := FWGetSX5("12",cEst)
If Len(aRet) > 0
	cRet := Alltrim(aRet[1,4])
EndIf

Return cRet


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetTxt	  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o texto sem caracteres como (. e /)				  บฑฑ
ฑฑบ          ณ       				  									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetTxt(cText)

Local cRetNDir	:= ""     

Default cText := ""

cRetNDir := STRTRAN(cText, ".", "")
cRetNDir := STRTRAN(cRetNDir, "/", "")
cRetNDir := STRTRAN(cRetNDir, "\", "")
cRetNDir := STRTRAN(cRetNDir, "-", "")

Return cRetNDir



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGetDDirDia  บAutor  ณTOTVS		     บ Data ณ  05/04/2014 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna a descri็ใo do diret๓rio de acrodo com a data		  บฑฑ
ฑฑบ          ณExemplo do nome do diret๓rio: 05042014       				  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                              	          บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GetDDirDia()

Local cRetNDir	:= ""

cRetNDir := DTOC(MsDate())
cRetNDir := STRTRAN(cRetNDir, "/", "")

Return cRetNDir
               

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณExclArq	บ Autor ณ TOTVS		     บ Data ณ  05/04/14   	  บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Exclui arquivos se o mesmo existir						  บฑฑ
ฑฑบ          ณ                      									  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณAP 		                                                  บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function ExclArq(cArq)

Local aArea		:= GetArea()
Local nRetExc   := 0
Local lRet		:= .T.

Default cArq	:= ""

If !Empty(cArq)
	
	nRetExc := FERASE(cArq)
	If nRetExc !=  0
		HELP(" ",1,"EXCARQ",,STR0004+cArq,4,2)//Erro ao excluir arquivo: 
		lRet := .F.
	EndIf
EndIf


RestArea(aArea)
Return lRet



/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGravaTxt  บAutor  ณTOTVS		         บ Data ณ  05/04/14   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCria arquivo e grava arquivo XML                            บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                	                                      บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GravaTxt( cArq, cTexto )

Local nHandle := 0


If !File( cArq )
	nHandle := FCreate( cArq )
	FClose( nHandle )
Endif

If File( cArq )
	nHandle := FOpen( cArq, 2 )
	FSeek( nHandle, 0, 2 )	// Posiciona no final do arquivo
	FWrite( nHandle, cTexto + Chr(13) + Chr(10), Len(cTexto)+2 )
	FClose( nHandle)
Endif
Return   
