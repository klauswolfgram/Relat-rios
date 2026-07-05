/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "finr013.ch"
#INCLUDE "SIGAWIN.CH"   
/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณFINR013   บ Autor ณPaulo Augusto       บ Data ณ  20/08/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescricao ณ Programa para imprimir os comprovantes de entrega do talao บฑฑ
ฑฑบ          ณ de recibo para o Cobrador                                  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ                                                            บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

User Function FINR013()


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Declaracao de Variaveis                                             ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
Local cDesc1         := STR0001 //"Este programa tem como objetivo"
Local cDesc2         := STR0002 //"imprimir o comprovante de entrega"
Local cDesc3         := STR0003 //"do talao de Recibo para o cobrador "
Local titulo       	:= STR0004 //"Comprovante de Entrega de Recibo"
Local aOrd 				:= {} 
Local cPerg				:="FIR013"
Private tamanho    	:= "P"
Private nomeprog   	:= "FINR013"
Private nTipo   		:= 18
Private aReturn  		:= { STR0005, 1,STR0006, 2, 2, 1, "", 1}   //"Zebrado"###"Administracao"
Private nLastKey   	:= 0
Private wnrel      	:= "FINR013" // Coloque aqui o nome do arquivo usado para impressao em disco
Private cString 		:= "SEY"

dbSelectArea("SEY")
dbSetOrder(1)

pergunte( cperg , .f. )

//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Monta a interface padrao com o usuario...                           ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

wnrel := SetPrint(cString,NomeProg,cPerg,@titulo,cDesc1,cDesc2,cDesc3,.T.,aOrd,.T.,Tamanho,,.T.)

If nLastKey == 27
	Return
Endif

SetDefault(aReturn,cString)

If nLastKey == 27
   Return
Endif

nTipo := If(aReturn[4]==1,15,18)

RptStatus({|| f013Imp()},Titulo)
Return

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuno    ณf013Imp   บ Autor ณ Paulo Augusto      บ Data ณ  20/08/02   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDescrio ณ Funcao de impressao do relatorio                           บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ FINR013                                                    บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function f013Imp()  
Local cRetCob  := RTrim(RetTitle("AQ_CGC"))  //Retorna o titulo do campo

nLin:=10
dbSelectArea("SEY")
dbSetOrder(4)
DbSeek(xfilial("SEY") + mv_par03 + mv_par02+mv_par01) 

If found()                  
	SAQ->(DbSetOrder(1))
	SAQ->(DbSeek(xFilial("SAQ")+ SEY->EY_COBRAD))
	cNome		:=	SAQ->AQ_NOME 
	cEnd		:=	SAQ->AQ_END
	cCGC		:=	SAQ->AQ_CGC
	nTotRec	:= Val(SEy->EY_RECFin) - Val(SEy->EY_RECINI) + 1
	
	@nLin,25 PSAY STR0007 //"COMPROVANTE DE ENTREGA DE RECIBO "
 	nLin := nLin + 10 
	@nLin,06 PSAY STR0008 + subs(cNome,1,40) +  STR0009 + "  " + SEY->EY_COBRAD      //"     Eu "###" com codigo no. "
	nLin := nLin + 1
	@nLin,06 PSAY	STR0010 + cEnd          + STR0011    //"estabelecido(a) no endereco : "###" e "
	nLin := nLin + 1
	@nLin,06 PSAY	cRetCob + "   " + Transform(cCGC,PesqPict("SAQ","AQ_CGC"))+ STR0012 + SM0->M0_NOMECOM    //". Recebi da Empresa "
	nLin := nLin + 1 
	@nLin,06 PSAY 	STR0010+ SM0->M0_ENDENT + STR0011+ cRetCob + "  "     //"estabelecido(a) no endereco : "###" e "
	nLin := nLin + 1	
	@nLin,06 PSAY  Transform(SM0->M0_CGC,PesqPict("SAQ","AQ_CGC")) +  STR0013 + dtoc(SEY->EY_DATA)+ STR0014 +Alltrim(SEY->EY_SERIE)+IIf(Empty(SEY->EY_SERIE),"   "," - ")+SEY->EY_TALAO + STR0015  //" no dia "###" o talao de recibo  numero "###" contendo"
	nLin := nLin + 1	
	@nLin,06 PSAY  STR0016+Alltrim(SEY->EY_SERIE)+IIf(Empty(SEY->EY_SERIE),"   "," - ")+SEY->EY_RECINI+STR0017+Alltrim(SEY->EY_SERIE)+IIf(Empty(SEY->EY_SERIE),"   "," - ")+SEY->EY_RECFIN+STR0018+alltrim(str(nTotRec)) //"do recibo : "###" ate o recibo "###" no total de "
	nLin := nLin + 1	
	@nLin,06 PSAY  "( " + extenso(nTotRec,.t. ) + " )" 	+ STR0019 + Iif (SEY->EY_TIPOREC="1", STR0020,STR0021) //"recibos do tipo "###" Oficial"###"Provisorios"
	nLin := nLin + 6
	@nLin,06 PSAY STR0022 //"De acordo"
	
	nLin := nLin + 8      
	
	@nLin,06 PSAY "____________________    ____________________    ____________________"
	nLin := nLin + 2        
	@nLin,06 PSAY STR0023 //"      RECEBEU                 ENTREGOU               AUTORIZOU   "
		
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
