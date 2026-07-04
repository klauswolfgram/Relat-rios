/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prแtica e de fแcil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.ch"        
#INCLUDE "GPER801.ch"                    
                                    
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออออออปฑฑ
ฑฑบPrograma  ณGPER801   บAutor  ณErika Kanamori      บ Data ณ  08/22/08       บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออออออนฑฑ
ฑฑบDesc.     ณGera arquivos txt para Argentina.                               บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑณ Uso      ณ Generico                                                       บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบ          ณ    ATUALIZACOES SOFRIDAS DESDE A CONSTRU€AO INICIAL.           บฑฑ
ฑฑฬอออออออออออออุอออออออออุอออออออออุอออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบProgramador  ณ Data    ณFNC/PLANOณ  Motivo da Alteracao                    บฑฑ
ฑฑฬอออออออออออออุอออออออออุอออออออออุอออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบAlceu Pereiraณ17/02/09 ณ00029752009ณAlteracao do Lay-out do arquivo -      บฑฑ
ฑฑบ				ณ		  ณ			  ณAjuste nos seguintes campos: 		  บฑฑ
ฑฑบ				ณ		  ณ			  ณConjuge, Filho, Remuneracao Total,     บฑฑ
ฑฑบ				ณ		  ณ			  ณRemunerac Imponible 1 e 2, Regimen e   บฑฑ
ฑฑบ				ณ		  ณ			  ณdias trabalhados.                      บฑฑ
ฑฑบAlceu Pereiraณ20/02/09 ณ00044952009ณCorrecao da Funcao Remuneimp.	      บฑฑ 
ฑฑบAlceu Pereiraณ11/05/09 ณ008700/2009ณAlteracao do Lay-out do arquivo.       บฑฑ 
ฑฑบ				ณ		  ณ			  ณacrescentado mais 3 campos de acordo   บฑฑ 
ฑฑบ				ณ		  ณ			  ณcom a legislacao,Versao 32 do SIJP.    บฑฑ 
ฑฑบ				ณ	      ณ		      ณO SIJP passou a ser chamado de SICOSS  บฑฑ 
ฑฑบ				ณ	      ณ		      ณalteracao na geracao do arquivo, sen-  บฑฑ 
ฑฑบ				ณ	      ณ		      ณdo possivel gerar para mais de um      บฑฑ 
ฑฑบ				ณ	      ณ		      ณprocesso.Alterada a pergunta Processo  บฑฑ
ฑฑบ				ณ		  ณ			  ณAjuste na funcao Dias_trab.Alterada a  บฑฑ
ฑฑบ				ณ		  ณ		      ณbarra de processamento. Alterada a     บฑฑ
ฑฑบ				ณ		  ณ 		  ณtabela de s008 para s026 para limitar  บฑฑ
ฑฑบ				ณ		  ณ			  ณvalor (nMOPRE para nHabMinGar).	      บฑฑ
ฑฑบAlceu Pereiraณ11/09/09 ณ008700/2009ณAlteracao na Situacao de Revista. 	  บฑฑ
ฑฑบ				ณ		  ณ			  ณFeitos ajustes nos topes na funcao     บฑฑ
ฑฑบ				ณ		  ณ     	  ณRemuneimp. Sobre o TOPE                บฑฑ
ฑฑบAlceu Pereiraณ06/10/09 ณ00241312009ณAlteracao da Rotina Remuneimp. 	      บฑฑ
ฑฑบAlceu Pereiraณ16/10/09 ณ00258412009ณAjuste da Funcao Remuneimp.            บฑฑ
ฑฑบAlceu Pereiraณ23/11/09 ณ00278012009ณReescrita a Fun็ใo de Remuneracoes,    บฑฑ
ฑฑบ				ณ		  ณ			  ณTratamento para Situacao de Revista,   บฑฑ
ฑฑบ				ณ		  ณ			  ณcodigo da empresa, aportes - importes  บฑฑ
ฑฑบ				ณ		  ณ			  ณzona desfavorแvel,dias trabalhados,    บฑฑ
ฑฑบ				ณ		  ณ			  ณadicionais e premios, lay-out.	      บฑฑ
ฑฑบFrancisco Jr ณ08/01/10 ณ00004222010ณCompatibilizado Versao Corporativa     บฑฑ 
ฑฑบ             ณ         ณ           ณRetirado rotina de AjustaSX.           บฑฑ 
ฑฑบAdemar Jr.   ณ04/02/10 ณ           ณImplementado novas funcionalidades     บฑฑ
ฑฑบ             ณ         ณ           ณdo Sicoss - Version 33                 บฑฑ
ฑฑบAdemar Jr.   ณ09/02/10 ณ           ณ-Reescrita a funcao SituaRev() afim    บฑฑ
ฑฑบ             ณ         ณ           ณde melhorar a performace.              บฑฑ
ฑฑบ             ณ         ณ           ณ-Ajuste na funcao RemuneImp() afim de  บฑฑ
ฑฑบ             ณ         ณ           ณconsiderar verbas de SAC da Rescisao.  บฑฑ
ฑฑบTiago Malta  ณ04/03/10 ณ00042352010ณAlterado o uso do campo RA_TIPOCON     บฑฑ
ฑฑบ             ณ         ณ           ณ para RA_MODALID no Sicoss             บฑฑ
ฑฑบTiago Malta  ณ29/03/10 ณ00033902010ณHabilitado o AjustaGP801A para P11.    บฑฑ
ฑฑบAdemar Jr.   ณ29/04/10 ณ00056702010ณ-Ajuste para apresentar a Sit.Revista  บฑฑ
ฑฑบ             ณ         ณ           ณcomo "01" para Funcionarios Ativos.    บฑฑ
ฑฑบ             ณ         ณ           ณ-Habilitado a funcao de ajuste de SX1  บฑฑ
ฑฑบAdemar Jr.   ณ03/05/10 ณ00095942010ณ-Tratamento da Red.Patronal no Sicoss  บฑฑ
ฑฑบ             ณ         ณ           ณonde sempre deve enviar as  Bases sem  บฑฑ
ฑฑบ             ณ         ณ           ณaplicar a Reducao.                     บฑฑ
ฑฑบ             ณ         ณ           ณ-Desabilitado a funcao de ajuste das   บฑฑ
ฑฑบ             ณ         ณ           ณPerguntas (SX1) pois este ajuste foi   บฑฑ
ฑฑบ             ณ         ณ           ณimplementado no fonte RhUpdGpe.        บฑฑ
ฑฑบAlceu Pereiraณ23/03/11 ณ007016/2011ณAjuste p/ validar paramertro mv_par03  บฑฑ
ฑฑบ             ณ         ณ           ณ                                       บฑฑ
ฑฑบAlceu Pereiraณ04/02/11 ณ002168/2011ณAjuste para considerar o afastamento   บฑฑ
ฑฑบ             ณ         ณ           ณque nao tenha sido lan็ado para o      บฑฑ
ฑฑบ             ณ         ณ           ณprimeiro dia do m๊s, colocando o statusบฑฑ 
ฑฑบ             ณ         ณ           ณde ativo at้ o dia do afastamento.     บฑฑ
ฑฑบ             ณ         ณ           ณCorre็ใo para que a ๚ltima situa็ใo    บฑฑ
ฑฑบ             ณ         ณ           ณseja gravada no campo Codigo Situa็ใo. บฑฑ
ฑฑบ             ณ         ณ           ณCaso o funcionแrio tenha mais de 3 afasบฑฑ
ฑฑบ             ณ         ณ           ณtamentos no m๊s considerar o primeiro oบฑฑ 
ฑฑบ             ณ         ณ           ณsegundo e o ๚ltimo, tratamento para queบฑฑ 
ฑฑบ             ณ         ณ           ณcaso o ๚ltimo afastamento termine antesบฑฑ 
ฑฑบ             ณ         ณ           ณdo final m๊s seja lan็ado o c๓digo de  บฑฑ 
ฑฑบ             ณ         ณ           ณativo para a ๚ltima situa็ใo do funcio-บฑฑ
ฑฑบ             ณ         ณ           ณnแrio, tratamento para que caso a data บฑฑ 
ฑฑบ             ณ         ณ           ณfinal do afastamento seja maior que o  บฑฑ 
ฑฑบ             ณ         ณ           ณ๚ltimo dia do m๊s seja considerado o   บฑฑ 
ฑฑบ             ณ         ณ           ณ๚ltimo dia do m๊s.                     บฑฑ
ฑฑบAlceu Pereiraณ18/02/11 ณ           ณAjuste para considerar o afastamento   บฑฑ
ฑฑบ             ณ         ณ           ณcaso o mesmo nใo tenha data de retorno บฑฑ
ฑฑบ             ณ         ณ           ณcadastrado.                            บฑฑ
ฑฑบAlceu Pereiraณ30/03/11 ณ           ณAjuste para o calculo de dias trabalha-บฑฑ
ฑฑบ             ณ         ณ           ณdos.Funcionarios demitidos no m๊s de   บฑฑ
ฑฑบ             ณ         ณ           ณgeracao devem entrar no Sicoss.Alteradaบฑฑ
ฑฑบ             ณ         ณ           ณa Situacao de revista para func. que   บฑฑ
ฑฑบ             ณ         ณ           ณforam demitidos.                       บฑฑ
ฑฑบTiago Malta  ณ19/08/11 ณ00209632011ณRetirado a fun็ใo que cria as perguntasบฑฑ
ฑฑบ             ณ         ณ           ณe alterado a fun็ใo estatica Remuneimp บฑฑ
ฑฑบ             ณ         ณ           ณpara fun็ใo.                           บฑฑ 
ฑฑบGlaucia M.   ณ24/01/12 ณARG11.6_RH ณAjuste SICOSS, para atender espeficac  บฑฑ
ฑฑบ             ณ         ณREQ006     ณHub-Mexico.                            บฑฑ
ฑฑบGlaucia M.   ณ05/03/12 ณARG11.6_RH ณAjuste SICOSS/SICORE, para atender     บฑฑ
ฑฑบ             ณ         ณREQ006     ณespeficac Hub-Mexico.                  บฑฑ
ฑฑบGlaucia M.   ณ06/03/12 ณARG11.6_RH ณNova especificacao SICORE, para atenderบฑฑ
ฑฑบ             ณ         ณREQ007     ณespeficac Hub-Mexico.                  บฑฑ
ฑฑบGlaucia M.   ณ07/03/12 ณARG11.6_RH ณNova especificacao SICORE/SICOSS	      บฑฑ
ฑฑบ             ณ         ณREQ007     ณexclusao nos calculos de roteiros com  บฑฑ
ฑฑบ             ณ         ณ		      ณRY_TIPO = '4'. Altera็ใo picture       บฑฑ
ฑฑบ             ณ         ณ		      ณretorno FPERCASS. Melhoria na carga dasบฑฑ
ฑฑบ             ณ         ณ		      ณS017 e S022. Melhoria no parametro 	  บฑฑ
ฑฑบ             ณ         ณ		      ณFilial De - Ate.						  บฑฑ
ฑฑบGlaucia M.   ณ04/04/12 ณARG11.6_RH ณRetirada Carga MiSimplificacion		  บฑฑ
ฑฑบ             ณ         ณREQ007     ณAlteracao item 050 - SICOSS - S017     บฑฑ
ฑฑบGlaucia M.   ณ12/05/12 ณ010953/2012ณCarga da tabela S030(somente os codigosบฑฑ
ฑฑบ             ณ         ณTEXFUA     ณprincipais).							  บฑฑ
ฑฑบGlaucia M.   ณ21/01/13 ณ001371/2013ณNใo realizar filtros de funcionแrios deบฑฑ
ฑฑบ             ณ         ณTGMKD6     ณmitidos, se existe incidencia SRD/SRC  บฑฑ
ฑฑบ             ณ         ณ           ณconforme layout apresentar no arquivo. บฑฑ
ฑฑบGlaucia M.   ณ05/02/13 ณ002884/2013ณNova carga da tabela S017  via rotina  บฑฑ
ฑฑบ             ณ         ณTGILKW     ณCarTab801. O uso desta carga esta asso-บฑฑ
ฑฑบ             ณ         ณ           ณciado a nova carga de formulas deste   บฑฑ
ฑฑบ             ณ         ณ           ณdeste chamado.                         บฑฑ
ฑฑบLaura Medina ณ27/02/15 ณTRAJQS     ณDe acuerdo a la RG 3216/2014 "Su Decla-บฑฑ
ฑฑบ             ณ         ณ           ณracion", se agrego la 3ra opcion para  บฑฑ
ฑฑบ             ณ         ณ           ณel tipo de Archivo, siendo una varianteบฑฑ
ฑฑบ             ณ         ณ           ณde la opcion 1-SICOSS (usando S037)    บฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿      
*/     
User Function GPER801A    

Local aArea		:= GetArea()
Local bProc 	:= {|oSelf| GPE801Gera(oSelf)}  

oProcess 		:= tNewProcess():New( "GPER801" , OemToAnsi(STR0001) , bProc ,OemToAnsi(STR0003) , "GP801A",,,,,.T.,.T.  ) 

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao     GPE801GeraบAutor  ณErika Kanamori      บ Data ณ  05/09/2008 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Carrega parametros e cria arquivo texto escolhido pelo     บฑฑ
ฑฑบ          ณ usuario.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GPE801Gera(oProcess)


Local aArea			:= GetArea()

Private cCadastro 	:= OemToAnsi(STR0001) //"Ajuste de Parametros"
Private aVerbas 	:= {}
Private aRoteiros	:= {}
Private cProcessos	:= ""  
Private cProcFunc	:= "" 
Private cPer        := ""
Private nTipoRel	:= 0
Private cProcRange  := ""  
Private cProcAux	:= ""	
Private cArq		:=""    
Private cCond1	    := "01"
Private cCond2	    := "01"
Private cCond3	    := "01"
Private aCampos		:= {}
Private aPerTodosC 		:= {}

//--Seta e Carrega os Mnemonicos.
SetMnemonicos(NIL,NIL,.T.)

//--Carrega as perguntas.
Pergunte("GP801A",.F.)

nTipoRel  		:= Iif(mv_par01=="2","6",mv_par01)         //  Tipo de Relatorio?             
cProcFunc 		:= mv_par02 								//  Processo?	
cPeriodo  		:= mv_par03 								//  Data competencia - deve ser do tipo "DATA"
cFilialDe 		:= mv_par04 								//  Filial De?  
cFilialAte		:= mv_par05			   						//  Filial Ate? 
cMatDe	  		:= mv_par06									//  Matricula De?  
cMatAte   		:= mv_par07									//  Matricula Ate? 
cArq			:= mv_par08									//  Arquivo de Saida?

If  nTipoRel == '3' 
	cArq := Substr(cArq,1,Rat("\",cArq))+"SU"+AnoMes(cPeriodo)+Substr(cArq,Rat("\",cArq)+1)
Endif

Private nHdl:= fCreate(cArq)


If ValType(mv_par03)  != 'D'      
	MsgAlert(STR0005)
	Return .F.
Endif
                                        
If nHdl == -1
    MsgAlert(STR0004+cArq+STR0005,STR0006) //"O arquivo de nome "###" nao pode ser executado! Verifique os parametros."###"Atencao!"
    Return .F.
Endif            

//Array aRoteiros para excluir dos calculos os roteiros do tipo "4" (SRY->RY_TIPO=4)
DbSelectArea("SRY")
DbSetOrder(1)  
dbSeek(xFilial("SRY"))
While !Eof("SRY") .And. SRY->RY_FILIAL == xFilial("SRY") 
	if SRY->RY_TIPO <> ("4")
		Aadd(aRoteiros,{SRY->RY_CALCULO, RY_TIPO,0}) 
	Endif
	dbSkip()	
EndDo
	
If (len(aRoteiros) <= 0) 
	alert(OemtoAnsi(STR0030))				 							//"Nใo existem procedimentos para os parโmetros informados."   
	Return .F.
EndIf


If nTipoRel == '6'

	//O Filtro a seguir reune somente as verbas necessแrias para calculo do SICORE
	//346        Retenido esta Liquidaci๓n
	//347        Devoluci๓n esta liquidaci๓n
	//348        Retenido A๑o Anterior
	//349        Devoluci๓n A๑o Anterior
	
	DbSelectArea("SRV")
	DbSetOrder(1)  
	dbSeek(xFilial("SRV"))
	While !Eof("SRV") .And. SRV->RV_FILIAL == xFilial("SRV") 
		if SRV->RV_CODIGRR $ ('346|347|348|349')
			Aadd(aVerbas,{SRV->RV_COD,0}) 
		Endif
		dbSkip()	
	EndDo
		
	If (len(aVerbas) <= 0) 
		alert(OemtoAnsi(STR0021))				 							//"Nใo existem Verbas ou Processos para os parโmetros informados."
		Return .F.
	EndIf

Endif

GPE801Proc(oProcess)

RestArea(aArea)
Return .T.

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    |GPE801ProcบAutor  ณErika Kanamori      บ Data ณ  05/09/2008 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao de geraco do arquivo                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GPE801Proc(oProcess)

Local aArea			:= GetArea()
Local cForm0, cForm0OK, cFormE, cFormEOK, cFormL, cFormLOK, lCond
Local nTamLin, cLin, cCpo, nPoint, nX, nI, nJ, nZ 
Local cLectura 		:= SPACE(1) 
Local cFilialAnt 	:= SPACE(FWGETTAMFILIAL)   
Local aPos			:= {,,,,,,,}
Local aRCCE			:= {}
Local aRCCS			:= {} 
Local nAux			:= 0
Local nCount		:= 0
Local nPos			:= 1   
Local lBloqRes      := .F.
Local i             := 1
Local K				:= 0
Local X 			:= 0
Local nTam
Local lAllProc
Local cSvProcesso	:= ""   
Local aProcessos	:={}
Local nTamProc 		:= GetSx3Cache("RC_PROCES", "X3_TAMANHO")     
Local nEmpDe 		:= 0
Local nEmpAte		:= 0

Private cMes, cAno
Private cObra 
Private xQtdParC  
Private xQtdParF   
Private nMaxEM 		:= 0
Private nTotReten	:= 0	//Variแvel usada diretamente no layout SICORE
Private nTotDevol	:= 0 	//Variแvel usada diretamente no layout SICORE
Private nDiasTra
Private lRetencion	:= .T. //usado no controle SICORE
Private aPerFec 	:= {} 
Private aPerAbe		:= {}
Private aPerTodos	:= {}
Private aVerbasFunc	:= {} //Para uso nova funcao em modelo2
Private nHabMinGar  := 0

Private cSit1	 
Private cDiaSit1
Private cSit2	 
Private cDiaSit2
Private cSit3	 
Private cDiaSit3
Private cValN		:= "     0,00"
Private nCodEmp		:= 0
Private cConvenc    := "" 
Private aDatasSR8   := {}
Private dDtIngresso := Ctod("  /  /  ")
Private dDtDespido  := Ctod("  /  /  ")
Private dDtUltAfas  := Ctod("  /  /  ")
Private aRCMData	:= {}			//	Dados da tabela RCM
Private aRCMFields	:= {}			//  Estrutura da tabela RCM - direto do arquivo DBF
//Posicao dos campos da tabela RCM
Private nPosRCMFil	:= 0
Private nPosRCMPd	:= 0
Private nPosRCMTip	:= 0
Private nPosRCMSic  := 0
Private aQtdAus		:= {} //array contem a quantidade de dias para desconto do total de dias trabalhados Sicoss campo 041
           

/*
ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
ณ Desmenbrar Processo e Roteiro de Calculo                     ณ
ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู*/
cSvProcesso := cProcFunc
cProcFunc 	:= "("
nTam := Len(Alltrim(cSvProcesso))
For X := 1 to nTam Step nTamProc
	cProcFunc += "'" + Substr(cSvProcesso, X, nTamProc) + "',"
Next X
cProcFunc := Substr( cProcFunc, 1, Len(cProcFunc)-1) + ")"

cMes := StrZero(Month(mv_par03),2)
cAno := StrZero(Year(mv_par03),4)

cPer := cMes + cAno

fLoadRCM(aRCMData,aRCMFields) //Carrega RCM - Tipos de Aus๊ncia

fRetPerComp( 	cMes		  	,;		// Obrigatorio - Mes para localizar as informacoes
				cAno		  	,;		// Obrigatorio - Ano para localizar as informacoes
				xFilial("RCH")	,;		 // Opcional - Filial a Pesquisar
						  		,;		// Opcional - Filtro por Processo
			              		,;		// Opcional - Filtro por Roteiro
				@aPerAbe	  	,;		// Por Referencia - Array com os periodos Abertos
				@aPerFec, 		;		// Por Referencia - Array com os periodos Fechados
				@aPerTodos    	;		// Por Referencia - Array com os periodos Abertos e Fechados em Ordem Crescente
			 )
			 
	If nTipoRel == '6'
		U_ObtPeriodos()
	EndIf
	
If (len(aPerTodos) <= 0)
	Alert(OemToAnsi(STR0020))			//"Nใo existem perํodos vแlidos para a data informada."
	fClose(nHdl)
	return 
Endif
	
Do Case
	Case nTipoRel == "1"
		cNomeArq:= "S017"  
	Case nTipoRel == "3"
		cNomeArq:= "S037" 
	/*
	Case nTipoRel == "2"
		cNomeArq:= "S018"
	Case nTipoRel == "3"
		cNomeArq:= "S019"
	Case nTipoRel == "4"
		cNomeArq:= "S020"
	Case nTipoRel == "5"
		cNomeArq:= "S021"
	*/
	Case nTipoRel == "6"
		cNomeArq:= "S022"
EndCase

//monta os ARRAYS de posicoes. Posicao de inicio e tamanho.  
nPoint := 1//Ponteiro contador para selecionar a posicao de inicio de cada campo corretamente. 
DbSelectArea("RCB")     
DbSetOrder(1)  
cFilRCB:=xFilial("RCB")      
If RCB->(DbSeek(cFilRCB + cNomeArq))
	While cFilRCB == RCB_FILIAL .and. RCB_CODIGO == cNomeArq
		cCpo:= Alltrim(RCB_CAMPOS)
		Do Case
			Case cCpo == "LECTURA"  
				aPos[1]:={nPoint, RCB_TAMAN}
			Case cCpo == "FORMULA"
				aPos[2]:={nPoint, RCB_TAMAN}
			Case cCpo == "CONDICION"
				aPos[3]:={nPoint, RCB_TAMAN}
			Case cCpo == "INICIO"
				aPos[4]:={nPoint, RCB_TAMAN}
			Case cCpo == "LONGITUDE"
				aPos[5]:={nPoint, RCB_TAMAN}
			Case cCpo == "ALIAS"
				aPos[6]:={nPoint, RCB_TAMAN}
			Case cCpo == "ORDEN"
				aPos[7]:={nPoint, RCB_TAMAN}
			Case cCpo == "LLAVE"
				aPos[8]:={nPoint, RCB_TAMAN}
		EndCase
		nPoint += RCB_TAMAN
		DbSkip()
	Enddo        
Else
	IF  cNomeArq=='S037'     
		Alert(OemToAnsi(replace(STR0032,"S036","S037")))			//"No existe la tabla S037 - Arch. de texto Su Declaracion, verifique!"
		return  
	Endif
Endif


//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณGuarda as posicoes inicio e tamanho, dentro das vaiaves com os respectivos conteudos.ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cFilRCC:=xFilial("RCC")
DbSelectArea("RCC")
DbSetOrder(1)      
DbSeek(xFilial()+cNomeArq)
Do While cFilRCC == RCC_FILIAL .and. RCC_CODIGO == cNomeArq
	cLectura	:= Alltrim(SubStr(RCC_CONTEU, aPos[1,1], aPos[1,2]))
	cFormula	:= Alltrim(SubStr(RCC_CONTEU, aPos[2,1], aPos[2,2]))
	cCondicion	:= Alltrim(SubStr(RCC_CONTEU, aPos[3,1], aPos[3,2]))
	nInicio		:= Val(Alltrim(SubStr(RCC_CONTEU, apos[4,1], aPos[4,2])))
	nLongitude	:= Val(Alltrim(SubStr(RCC_CONTEU, aPos[5,1], aPos[5,2])))
	cAlias		:= Alltrim(SubStr(RCC_CONTEU, aPos[6,1], aPos[6,2]))
	nOrdem		:= Val(Alltrim(SubStr(RCC_CONTEU, aPos[7,1], aPos[7,2])))
	cChave		:= Alltrim(SubStr(RCC_CONTEU, aPos[8,1], aPos[8,2]))
	If cLectura == "S"
		AAdd(aRCCS,{cLectura,cFormula,cCondicion,nInicio,nLongitude,cAlias,nOrdem,cChave})
	ElseIf cLectura == "E"
		AAdd(aRCCE,{cLectura,cFormula,cCondicion,nInicio,nLongitude,cAlias,nOrdem,cChave})
	EndIf
	DbSkip()	
EndDo    

aEmpresas	:= FwAllFilial(,,,.F.)	// sele็ใo de todas filiais de todas empresas
nEmpDe		:= iif(aScan(aEmpresas,cFilialDe)==0,1,aScan(aEmpresas,cFilialDe))  
cFilialDe	:= aEmpresas[nEmpDe]

If nTipoRel $ "1|2|3|4|6"	 

	For k:=nEmpDe to len(aEmpresas)
	    If (aEmpresas[k]>cFilialAte)
	    	Exit
	    EndIf

			
		
			aSM0 := {}
			For nI:=1 To Len(aRCCS)
				lCond := If(Empty(aRCCS[nI][3]),.T.,&(aRCCS[nI][3]))
				//Verificar se tem que fazer pesquisa em algum arquivo
				If lCond .And. !Empty(aRCCS[nI][6])
					DbSelectArea(aRCCS[nI][6])
					DbSetOrder(aRCCS[nI][7])
					lCond	:=	MsSeek(&(aRCCS[nI][8]))
				Endif    
				
				If lCond//Verifica se existe uma condi็ใo valida
					cForm0 := &(aRCCS[nI][2])//Verifica o retorno da formula e converte para string caso seja numerico ou data.
					If Type("cForm0") == "N"
						cForm0OK := Str(Form0)  
					Elseif Type("cForm0") == "D"
						cForm0OK := DtoC(Form0)
					Else
						cForm0OK := cForm0
					EndIf  
				Else
					cForm0OK := " "//Se nใo existir uma condi็ใo valida, retorna vazio.
				EndIf 
				
				If aRCCS[nI,5] > 0            
					AAdd(aSM0,{aRCCS[nI,4],PADR(cForm0OK,aRCCS[nI,5])}) //Ajusta o tam. do result.(Longitude)
				Endif
			Next		
			
			//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
			//ณPosiciona o cadastro de funcionarios para iniciar o processamento ...                ณ
			//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
			DbSelectArea("SRA")
	        If  mv_par01 <> "1" .And. mv_par01 <> "3"   
				DbSetOrder(1)	//RA_FILIAL+RA_MAT
				cIndSRA := "RA_FILIAL,RA_MAT"
	        Else
				DbSetOrder(15)	//RA_FILIAL+RA_MAT+RA_PROCES
				cIndSRA := "RA_FILIAL,RA_MAT,RA_PROCES"
			Endif
	        
	       	cSRAAlias := "QSRA"
	        
	        cQuery := "SELECT R_E_C_N_O_ AS SRARECNO FROM "+RetSqlName("SRA")+" RA "
			cQuery += "WHERE RA_FILIAL = '"+aEmpresas[k]+"' "
			cQuery += " AND RA_MAT BETWEEN '"+cMatDe+"' AND '"+cMatAte+"' " 
			cQuery += " AND RA_PROCES IN "+cProcFunc//+" "   
			cQuery += " AND RA_CATFUNC NOT IN ('E','G') "
			If TcSrvType() == "AS/400"
				cQuery += " AND @DELETED@ = ' ' "                     
			Else
				cQuery += " AND D_E_L_E_T_ = ' ' "
			Endif 
			cQuery += " ORDER BY "+cIndSRA
			
			cQuery := ChangeQuery(cQuery)      
			
			If select(cSRAAlias) > 0
				(cSRAAlias)->(dbCloseArea())
			EndIf
			
			dbUseArea(.T.,"TOPCONN",TcGenQry(, ,cQuery),cSRAAlias,.T.,.T.)
			
			(cSRAAlias)->(dbGoTop())
			
			oProcess:SetRegua1((cSRAAlias)->(RecCount()))
			
			While !(cSRAAlias)->(EOF())
				
				SRA->(dbGoto( (cSRAAlias)->SRARECNO ))
				oProcess:IncRegua1(STR0007 + space(1) + SRA->RA_MAT)
				aRegistro := {}	  //Limpa o vetor a cada novo funcionario.
				aQtdAus   := {}   //Limpa o array que cont้m a quantidade de dias a serem descontados dos dias trabalhados
				
				cProcesso  	:= SRA->RA_PROCES      
				lBloqRes    := ( SRA->RA_BLQRES == "S" )
				dDtDespido  := SRA->RA_DEMISSA
				dDtIngresso	:= SRA->RA_ADMISSA  
				dDtUltAfas  := Ctod("  /  /  ")					          

				If nTipoRel <> '6'
					//Retorna as verbas do funcionario, de acordo com os periodos selecionados
					aVerbasFunc	:= RetornaVerbasFunc(	SRA->RA_FILIAL			,; 	// Filial do funcionario corrente
												SRA->RA_MAT	  					,,; 	// Matricula do funcionario corrente												NIL),; 	// 
												""	  					        ,; 	// Retorna todos os Roteiro 
												NIL			  					,; 	// Array com as verbas que deverใo ser listadas. Se NIL retorna todas as verbas.
												aPerAbe		  					,; 	// Array com os Periodos e Numero de pagamento abertos
												aPerFec		 	 				,;  // Array com os Periodos e Numero de pagamento fechados
												NIL 							)  //Pago 
		
				Else 
 					//SICORE - Retorna as verbas do funcionario, de acordo com os periodos selecionados, Roteiro e Verbas com RV_CODIGRR IN '388','393'
					aVerbasFunc	:= RetornaVerbasFunc(	SRA->RA_FILIAL			,; 	// Filial do funcionario corrente
												SRA->RA_MAT			  			,,; 	// Matricula do funcionario corrente												NIL),; 	// 
												NIL						        ,; 	// Retorna todos os Roteiro 
												aVerbas 	  					,; 	// Array com as verbas que deverใo ser listadas. Se NIL retorna todas as verbas.
												aPerAbe		  					,; 	// Array com os Periodos e Numero de pagamento abertos
												aPerFec		 	 				,;  // Array com os Periodos e Numero de pagamento fechados
												NIL								)  //Pago 
				Endif
				
				If Len(aVerbasFunc) == 0 
					(cSRAAlias)->(DbSkip())  
			 		Loop             
		        Endif  
				
			    If nTipoRel <> "6"  
			   		If AnoMes(SRA->RA_DEMISSA) < AnoMes(cPeriodo) 
	 				    If !Empty(SRA->RA_DEMISSA) 
	 						(cSRAAlias)->(DbSkip())  
				 	   		Loop 
				 	   	Endif	
					EndIf
			    Endif
				
				If Val(U_GRAUPAR("C",.T.)) == 0   				 
					 xQtdParC := "0" 
				Else
					xQtdParC := U_GRAUPAR("C",.T.)			 	 
				Endif
				 
				If Val(U_GRAUPAR("F",.T.)	) == 0
					xQtdParF :=	 "00"		
				Else
					xQtdParF :=	U_GRAUPAR("F",.T.)			
				Endif
				
							
				aDatasSR8 := {}
				cSit1 := Space(02)
				cSit2 := Space(02)
				cSit3 := Space(02)
				
				cDiaSit1 := Space(02)
				cDiaSit2 := Space(02)
				cDiaSit3 := Space(02)
				
				If nTipoRel <> "6" 							
					
					For nJ:=1 To Len(aRCCE)					//Le o vetor aRCCE(Empregados) e alimenta o vetor aRegistro.
						lCond := If(Empty(aRCCE[nJ][3]),.T.,&(aRCCE[nJ][3]))
						//Verificar se tem que fazer pesquisa em algum arquivo
						If lCond .And. !Empty(aRCCE[nJ][6])
							DbSelectArea(aRCCE[nJ][6])
							DbSetOrder(aRCCE[nJ][7])
							lCond	:=	MsSeek(&(aRCCE[nJ][8]) )
						Endif
			
						If lCond							//Verifica se existe uma condicao valida
							cFormE := &(aRCCE[nJ][2])		//Variavel que recebe o conteudo desse vetor calculado.
						   	If Type("cFormE") == "N"
								cFormEOK := Str(cFormE)
							Else
								cFormEOK := cFormE
							EndIf
						Else                          
							cFormEOK := " "//Se nใo existir uma condi็ใo valida, retorna vazio.
						EndIf
						If aRCCE[nJ,5] > 0
							AAdd(aRegistro,{aRCCE[nJ,4],PADR(cFormEOK,aRCCE[nJ,5])})
						Endif
					Next
					For nX:=1 To Len(aSM0) 					//Adicona o vetor de empresas aSM0{} ao vetor aRegistro{}.
						AAdd(aRegistro,aSM0[nX])
					Next nX
					aSort(aRegistro,,,{|aReg1,aReg2| aReg1[1] < aReg2[1]})//Ordena vetor.
					GPE801TXT()								//Funcao que grava o registro por funcionario.
					
				Else
					Retencion()    
				   
					If nTotReten > 0 .Or. ntotDevol > 0
						For nJ:=1 To Len(aRCCE)//Le o vetor aRCCE(Empregados) e alimenta o vetor aRegistro.
							lCond := If(Empty(aRCCE[nJ][3]),.T.,&(aRCCE[nJ][3]))
							//Verificar se tem que fazer pesquisa em algum arquivo                                   
							If lCond .And. !Empty(aRCCE[nJ][6])
								DbSelectArea(aRCCE[nJ][6])
								DbSetOrder(aRCCE[nJ][7])
								lCond	:=	MsSeek(&(aRCCE[nJ][8]) )
							Endif
				
							If lCond						//Verifica se existe uma condi็ใo valida
								cFormE := &(aRCCE[nJ][2])	//Variavel que recebe o conteudo desse vetor calculado.
								If Type("cFormE") == "N"
									cFormEOK := Str(cFormE)
								Else
									cFormEOK := cFormE
								EndIf
							Else                          
								cFormEOK := " "				//Se nใo existir uma condi็ใo valida, retorna vazio.
							EndIf
							If aRCCE[nJ,5] > 0
								AAdd(aRegistro,{aRCCE[nJ,4],PADR(cFormEOK,aRCCE[nJ,5])})
							Endif
						Next nJ
						For nX:=1 To Len(aSM0) 				//Adicona o vetor de empresas aSM0{} ao vetro aRegistro{}.
							AAdd(aRegistro,aSM0[nX])
						Next nX

						aSort(aRegistro,,,{|aReg1,aReg2| aReg1[1] < aReg2[1]})//Ordena vetor.
						GPE801TXT()							//Funcao que grava o registro por funcionario.
					Endif	
						
				Endif
				cCond1	    := ""
				cCond2	    := ""
				cCond3	    := ""
				(cSRAAlias)->(DbSkip())
			EndDo
	Next k
	
Elseif nTipoRel == "5"    									//se Mi simplificacion V. Famil, gera a partir de SRB (dependentes)
	DbSelectArea('SRB')
	DbSetOrder(1)
	DbSeek(cFilialDe+cMatDe,.T.)
	While !SRB->(Eof())
		If SRB->RB_FILIAL > cFilialAte .Or. SRB->RB_MAT > cMatAte
			Exit
		EndIf
		
		If SRB->RB_GRAUPAR == "O"
			SRB->(DbSkip())  
			Loop
		Endif    

		aSM0 := {}
		For nI:=1 To Len(aRCCS)
			lCond := If(Empty(aRCCS[nI][3]),.T.,&(aRCCS[nI][3]))
			//Verificar se tem que fazer pesquisa em algum arquivo
			If lCond .And. !Empty(aRCCS[nI][6])
				DbSelectArea(aRCCS[nI][6])
				DbSetOrder(aRCCS[nI][7])
				lCond	:=	MsSeek(&(aRCCS[nI][8]))
			Endif
			If lCond//Verifica se existe uma condi็ใo valida
				cForm0 := &(aRCCS[nI][2])//Verifica o retorno da formula e converte para string caso seja numerico.
				If Type("cForm0") == "N"
					cForm0OK := Str(Form0)
				Else
					cForm0OK := cForm0
				EndIf
			Else
				cForm0OK := " "//Se nใo existir uma condi็ใo valida, retorna vazio.
			EndIf
			If aRCCS[nI,5] > 0
				AAdd(aSM0,{aRCCS[nI,4],PADR(cForm0OK,aRCCS[nI,5])}) //Ajusta o tam. do result.(Longitude)
			Endif
		Next nI
	
		While !SRB->(Eof())
			//# Alterado pra melhorar performce
			If SRB->RB_FILIAL > cFilialAte .Or. SRB->RB_MAT > cMatAte
				Exit
			EndIf
			
			If SRB->RB_GRAUPAR == "O"
	  	    	SRB->(DbSkip())   
		    	Loop                          
	  		Endif    
		    DbSelectArea("SRA")
		    DbSetOrder(1)
		    DbSeek(SRB->RB_FILIAL + SRB->RB_MAT)
			If !Empty(SRA->RA_DEMISSA) .And. AnoMes(SRA->RA_DEMISSA) <= AnoMes(cPeriodo)
				SRB->(DbSkip())  
				Loop
			Endif    
			        
	  		aRegistro := {}//Limpa o vetor a cada novo funcionario.  
	
			While !Eof() .AND. SRA->RA_FILIAL+SRA->RA_MAT == SRB->RB_FILIAL+SRB->RB_MAT
	  			If SRB->RB_GRAUPAR == "O"
	  	  			SRB->(DbSkip())  
		    		Loop
	       		Endif    
	          
			    For nJ:=1 To Len(aRCCE)//Le o vetor aRCCE(Empregados) e alimenta o vetor aRegistro.
					lCond := If(Empty(aRCCE[nJ][3]),.T.,&(aRCCE[nJ][3]))
					//Verificar se tem que fazer pesquisa em algum arquivo
				 	If lCond .And. !Empty(aRCCE[nJ][6])
				  		dbSelectArea(aRCCE[nJ][6])
					 	DbSetOrder(aRCCE[nJ][7])
					 	lCond	:=	MsSeek(&(aRCCE[nJ][8]) )
				 	Endif
	
				  	If lCond//Verifica se existe uma condi็ใo valida
						cFormE := &(aRCCE[nJ][2])//Varial que recebe o conteudo desse vetor calculado.
						If Type("cFormE") == "N"
							cFormEOK := Str(cFormE)
						Else
							cFormEOK := cFormE
						EndIf
				  	Else                          
						cFormEOK := " "//Se nใo existir uma condi็ใo valida, retorna vazio.
				  	EndIf
				  	If aRCCE[nJ,5] > 0
						AAdd(aRegistro,{aRCCE[nJ,4],PADR(cFormEOK,aRCCE[nJ,5])})
				  	Endif
			    Next nJ
			    
			    For nX:=1 To Len(aSM0) //Adicona o vetor de empresas aSM0{} ao vetro aRegistro{}.
					AAdd(aRegistro,aSM0[nX])
			    Next nX
			    	
			    aSort(aRegistro,,,{|aReg1,aReg2| aReg1[1] < aReg2[1]})//Ordena vetor.
				GPE801TXT()//Funcao que grava o registro por funcionario.
	      		DbSkip()
	        EndDo 
	    	dbselectarea("SRB")    	 
			SRB->(DbSkip())
		EndDo
		
	EndDo
	
Endif

fClose(nHdl)//Fechamento do objeto Dialog
RestArea(aArea)

Return
 
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPE801TXT บAutor  ณRafael P. Rizzatto  บ Data ณ  19/04/2004 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Funcao que grava todo arquivo de texto com o conteudo      บฑฑ
ฑฑบ          ณ dos arrays.                                                บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function GPE801TXT()
Local nX, cLin
    cLin := ""
	For nX :=1 To Len(aRegistro)
		cLin += aRegistro[nX,2] 	   
	Next nX
	cLin += CRLF
   
    If fWrite(nHdl,cLin,Len(cLin)) != Len(cLin) 		//Testa por erros durante a gravacao da linha montada.
        If !MsgAlert(STR0008,STR0006) 					//"Ocorreu um erro na gravacao do arquivo. Continua?"###"Atencao!"
        Endif
    Endif

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER801   บAutor  ณErika Kanamori      บ Data ณ  08/26/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega janela de opcoes dos arquivos a serem gerados.      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fTipoRot( )

Local aArea		:= GetArea()
Local cTitulo	:= STR0016  //"tipo de relatorio"
Local cString	:= ""                 
Local MvParDef	:= ""
Local MvRetor	:= ""
Local nFor		:= 0
Local MvPar            
Local lExiste   := .F.
Private aSit	:= {}      
                                                                                            
cAlias := Alias() 					// Salva Alias Anterior   
          
If Upper(Alltrim(ReadVar() )) == "MV_PAR01"                        
	MvPar:=&(Alltrim(ReadVar()))	// Carrega o conteudo da variavel
	mvRet:=Alltrim(ReadVar())		// carrega o nome da variavel
Endif

CursorWait()  
	         		
//MvParDef:= "123456"  
MvParDef:= "123"  

aAdd(aSit, OemtoAnsi(STR0028))									//"SICOSS"
//aAdd(aSit, OemtoAnsi(STR0023)+" - "+OemtoAnsi(STR0024))		//"miSimplificaci๓n ### Relaciones Laborales"
//aAdd(aSit, OemtoAnsi(STR0023)+" - "+OemtoAnsi(STR0025))		//"miSimplificaci๓n ### Datos complementarios"
//aAdd(aSit, OemtoAnsi(STR0023)+" - "+OemtoAnsi(STR0026))		//"miSimplificaci๓n ### C.B.U."
//aAdd(aSit, OemtoAnsi(STR0023)+" - "+OemtoAnsi(STR0027))		//"miSimplificaci๓n ### Vํnculos Familiares"    
aAdd(aSit, OemtoAnsi(STR0029))									//"SICORE"
aAdd(aSit, OemtoAnsi(STR0031))									//"Su Declaracion"


CursorArrow()

IF f_Opcoes(@MvPar,cTitulo,aSit,MvParDef,,,.F.,1,1)
	CursorWait()
	For nFor := 1 To Len( MvPar )
	   	IF ( SubStr( mVpar , nFor , 1 ) # "*" )   
			mvRetor += SubStr( mVpar , nFor , 1 )
	  	Endif
   	Next nFor
	&MvRet := Alltrim(Mvretor)  //carrega o resultado da fopcoes
	CursorArrow()	
EndIF	                                                   

dbSelectArea(cAlias) // Retorna Alias
RestArea(aArea)

Return(.T.)
	
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณU_fDir()    บAutor  ณErika Kanamori      บ Data ณ  08/27/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณApresenta janela para usuario escolher diretorio/arquivo a  บฑฑ
ฑฑบ          ณser gerado.                                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
User Function fDir()

Local mvRet		:= Alltrim(ReadVar())
Local cType 	:= ""
Local cArq		:= ""
Local aDir		:= {}
Local nDir		:= 0

cType:= STR0015 //"Arquivos Texto (*.TXT) |*.txt|"
//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
//ณ Comando para selecionar um arquivo.                          ณ
//ณ Parametro: GETF_LOCALFLOPPY - Inclui o floppy drive local.   ณ
//ณ            GETF_LOCALHARD - Inclui o Harddisk local.         ณ
//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู
cArq 	:= cGetFile(cType, STR0017, 0,,.T.,GETF_LOCALHARD+GETF_LOCALFLOPPY)  // "Selecione arquivo "
aDir	:= { { cArq } }


&mvRet := cArq

Return (.T.)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณGrauPar   บAutor  ณRafael P. Rizzatto  บFecha ณ 19/04/2004         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se ha dependentes de determinado grau de parentesco.      บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณENTRADA:                                                           บฑฑ
ฑฑบ          ณ cTipo(caracter) = Grau do Parentesco                              บฑฑ
ฑฑบ          ณ  C = Conjuge                                                      บฑฑ
ฑฑบ          ณ  F = Filho                                                        บฑฑ
ฑฑบ          ณ                                                                   บฑฑ
ฑฑบ          ณ lQtd(logico) = Indica se a funco deve retornar o numero de        บฑฑ
ฑฑบ          ณ dependentes ou apenas verificar a existencia.                     บฑฑ
ฑฑบ          ณ .T. = Conta o numero de dependentes                               บฑฑ
ฑฑบ          ณ .F. = Verificar se ha existencia                                  บฑฑ
ฑฑบ          ณ                                                                   บฑฑ
ฑฑบ          ณRETORNO:                                                           บฑฑ
ฑฑบ          ณ Se lQtd == .T., retorna a quantidade de dependentes (numerico)    บฑฑ
ฑฑบ          ณ ou                                                                บฑฑ
ฑฑบ          ณ Se lQtd == .F., retorna se possui (.T.) ou nao possui (.F.)       บฑฑ
ฑฑบ          ณ dependentes (logico)          								     บฑฑ
ฑฑบ          ณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               		 บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
User Function GrauPar(cTipo,lQtd)

Local nQtd  :=0
Local xQtd  := If(lQtd,"00","0" )
Local aArea := GetArea()

DbSelectArea("SRB")
DbSetOrder(1)
DbSeek(SRA->RA_FILIAL + SRA->RA_MAT)
While !Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT == SRB->RB_FILIAL+SRB->RB_MAT
	If SRB->RB_GRAUPAR == cTipo
		nQtd++       
	EndIf 
	SRB->(DbSkip())	                   
EndDo

If cTipo =="F" 
 xQtd := If(nQtd > 0,StrZero(nQtd,2),"00")
Else            
 xQtd := If(nQtd > 0,StrZero(nQtd,1),"0")
EndIf   

RestArea(aArea)	 
	
Return xQtd

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบFuncao    ณSituacion บAutor  ณAlceu Pereira 		 บ Data ณ  21/12/2009 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณRetorna o ultimo codigo da situacao do funcionario          บฑฑ
ฑฑบ          ณdentro do mes. 											  บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Argentina - Sicoss                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Situacion()

Local cCond   	:= ""

cCond1	:= SituaRev("1","S")
If cCond1 <> "06" //So ira pesquisar as outras condicoes caso a primeira condicao nao seja 06
    			  //essa condicao (06) serve para demissao ou outro afastamento que nao esteja
				  //na lista de afastamentos conforme documentacao do Siccos.		

	cCond2	:= SituaRev("2","S")
	cCond3	:= SituaRev("3","S")   
	
	If !Empty(cCond3) .And. Alltrim(cCond3)!='00'
		cCond := cCond3
	ElseIf Empty(cCond) .And. !Empty(cCond2) .And. Alltrim(cCond2)!='00'
		cCond := cCond2                            
	ElseIF Empty(cCond) .And. !Empty(cCond1) .And. Alltrim(cCond1)!='00'
		cCond := cCond1
	Else
		cCond := "01"	
	Endif
Endif

If !Empty(SRA->RA_DEMISSA) .And. AnoMes(SRA->RA_DEMISSA) <= (cAno+cMes)
	cCond := "01"
Endif  

If  Empty(cCond) .And. SRA->(FieldPos("RA_SITREV")) > 0   
	cCond := IIF(!Empty(SRA->RA_SITREV),SRA->RA_SITREV,"  ")
Endif
              
Return cCond	
      
     
// FUNCOES MY SIMPLIFICACION  
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณMovfunc   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica o tipo de movimentaco de funcionario.                     บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
                
Static Function MovFunc()

Local cMov := ""
Local aArea := GetArea()

If SRA->RA_SITFOLH == " " .AND. MesAno(SRA->RA_ADMISSA) == MesAno(dDatabase)
   cMov := "AT"
ElseIf SRA->RA_SITFOLH == " " .AND. MesAno(SRA->RA_ADMISSA)<> MesAno(dDatabase)   
   cMov := "MR"
ElseIf SRA->RA_SITFOLH == "D"
   cMov := "BT"
Endif   
   
RestArea(aArea)

Return (cMov)  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหออออฯออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณDataIni   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a data de admissao de acordo com o layout.                	 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function DataIni()  

Local aArea := GetArea()
Local M_Data:= ""

M_Data:= Substr(DTOS(SRA->RA_ADMISSA),1,4)+"/"+Substr(DTOS(SRA->RA_ADMISSA),5,2)+"/"+Substr(DTOS(SRA->RA_ADMISSA),7,2)
RestArea(aArea)

Return(M_data) 

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณDatanas   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a data de Nascimento de acordo com o layout.                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function DataNas()

Local aArea := GetArea()
Local M_DaNa:= ""

M_DaNa:= substr(DTOS(SRA->RA_NASC),1,4)+"/"+substr(DTOS(SRA->RA_NASC),5,2)+"/"+substr(DTOS(SRA->RA_NASC),7,2)

RestArea(aArea)

Return(M_DaNa)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณDatadoc   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a data de documentos de acordo com o layout.                 บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function DataDoc()


Local aArea := GetArea()
Local M_DaNa:= ""  

If SRB->RB_GRAUPAR == "C"
   M_DaNa:= substr(DTOS(SRB->RB_DTCASAM),1,4)+"/"+substr(DTOS(SRB->RB_DTCASAM),5,2)+"/"+substr(DTOS(SRB->RB_DTCASAM),7,2)
else
   m_DANA:= substr(DTOS(SRB->RB_DTNASC),1,4)+"/"+substr(DTOS(SRB->RB_DTNASC),5,2)+"/"+substr(DTOS(SRB->RB_DTNASC),7,2)
endif

RestArea(aArea)

return(M_DaNa) 


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณDatafin   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณMonta a data de demissao de acordo com o layout.                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function DataFin()   

Local aArea := GetArea()
LOCAL M_Demi:= ""

IF !Empty(SRA->RA_DEMISSA)    
  M_Demi:= substr(DTOS(SRA->RA_DEMISSA),1,4)+"/"+substr(DTOS(SRA->RA_DEMISSA),5,2)+"/"+substr(DTOS(SRA->RA_DEMISSA),7,2)
ELSE
  M_Demi:=SPACE(10)
ENDIF
RestArea(aArea)
  
return(M_Demi)           


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณBaja      บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณVerifica se o funcionario esta demitido e ajusta o tipo de baixa.  บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/                       
Static Function Baja()


Local aArea := GetArea()
Local m_Bajas := ""

If SRA->RA_SITFOLH == " "
	m_Bajas := "  "
Elseif SRA->RA_SITFOLH == "D"
     m_Bajas := "02"
Endif
                      
RestArea(aArea)

RETURN(M_Bajas)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณModalid   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function Modalid()

Local aArea := GetArea()
Local M_Mod := ""

IF SRA->RA_CATFUNC $ "M|A|E"
     M_Mod := "1"         
Elseif SRA->RA_CATFUNC == "H"
     M_Mod := "2"
Endif                       
IF MesAno(SRA->RA_ADMISSA) < MesAno(dDatabase)
  M_Mod := " "
ENDIF  

RestArea(aArea)

Return(M_Mod)     
  

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณProvinc   บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณ Busca Sigla dos estados                                           บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/         
Static Function Provinc()

Local aArea := GetArea()
lOCAL M_Prov:= ""

DO CASE 
   CASE SRA->RA_ESTADO == "CF"
     M_Prov := "00"
   CASE SRA->RA_ESTADO == "BA"
     M_Prov := "01"
   CASE SRA->RA_ESTADO == "CA"
     M_Prov := "02"    
   CASE SRA->RA_ESTADO == "CO"
     M_Prov := "03"
   CASE SRA->RA_ESTADO == "CR"
     M_Prov := "04"
   CASE SRA->RA_ESTADO == "ER"
     M_Prov := "05"
   CASE SRA->RA_ESTADO == "JU"
     M_Prov := "06"    
   CASE SRA->RA_ESTADO == "ME"
     M_Prov := "07"
   CASE SRA->RA_ESTADO == "LR"
     M_Prov := "08"
   CASE SRA->RA_ESTADO == "SA"
     M_Prov := "09"
   CASE SRA->RA_ESTADO == "SJ"
     M_Prov := "10"    
   CASE SRA->RA_ESTADO == "SL"
     M_Prov := "11"
   CASE SRA->RA_ESTADO == "SF"
     M_Prov := "12"
   CASE SRA->RA_ESTADO == "SE"
     M_Prov := "13"
   CASE SRA->RA_ESTADO == "TU"
     M_Prov := "14"    
   CASE SRA->RA_ESTADO == "CH"
     M_Prov := "16"
   CASE SRA->RA_ESTADO == "CB"
     M_Prov := "17"
   CASE SRA->RA_ESTADO == "FO"
     M_Prov := "18"
   CASE SRA->RA_ESTADO == "MI"
     M_Prov := "19"    
   CASE SRA->RA_ESTADO == "NE"
     M_Prov := "20"
   CASE SRA->RA_ESTADO == "LP"
     M_Prov := "21"
   CASE SRA->RA_ESTADO == "RN"
     M_Prov := "22"
   CASE SRA->RA_ESTADO == "SC"
     M_Prov := "23"    
   CASE SRA->RA_ESTADO == "TF"
     M_Prov := "24"
ENDCASE        

RestArea(aArea)

Return(M_Prov)


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณSala      บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณBusca Salario do funcionario                                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
                
Static Function Sala()

Local cMov:= ""
Local aArea := GetArea()

If SRA->RA_SITFOLH == " " .AND. MesAno(SRA->RA_ADMISSA) == MesAno(dDatabase)
   CMov := TRANSFORM(SRA->RA_SALARIO,"@E 999999999999.99")            
Endif
   
RestArea(aArea)

Return cMov

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma ณEven_Par  บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007          บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.    ณVerifica existencia de dependentes para o grau de parentesco.       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
                
Static Function Even_Par()

Local cMov := ""
Local aArea := GetArea()

If SRB->RB_GRAUPAR == "C" 
   cMov := "03"
ElseIf SRB->RB_GRAUPAR == "F"
   cMov := "01"
ElseIf SRB->RB_GRAUPAR =="O"
   cMov := "39"
Endif   
   
RestArea(aArea)

Return cMov      

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัออออออออออออออออออออปฑฑ
ฑฑบPrograma  ณaCta      บAutor  ณLuis A. Trombini    บFecha ณ 18/04/2007         บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯออออออออออออออออออออนฑฑ
ฑฑบDesc.     ณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametrosณ                                                                   บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                                      บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/            
                
Static Function aCta()

Local cMov := ""
Local aArea := GetArea()

cMov:= StrZero(Val(SRB->RB_NUMFOLH),7) 
  
RestArea(aArea)

Return cMov     




//SICORE     
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma ณVer_comprobบAutor  ณMicrosiga           บ Data ณ  08/26/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna codigo do comprovante caso exista retencao         บฑฑ
ฑฑบ          ณ retorna o codigo 07 caso contrario o codigo 08             บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static function Ver_comprob()
Local aArea := GetArea() 

If lRetencion
	M_Comp:= "07"
Else
	M_Comp:= "08"
Endif

RestArea(aArea)	

Return(m_Comp)    

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER801   บAutor  ณMicrosiga           บ Data ณ  09/05/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna a data de emisao do comprovante.                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ Geracao de arquivo magnetico                               บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function ver_data()
Local aArea			:= GetArea()

Set Century On

mData:= dDataBase

If Len(aPerTodos) > 0        
	mData :=  (aPerTodos[Len(aPerTodos)][9])
Endif
RestArea(aArea)

Return(mData)
              
/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetencion บAutor  ณMicrosiga           บ Data ณ  08/26/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Totaliza as Retencoes e Devolucoes.                        บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function Retencion()

Local aArea  	:= GetArea()
Local nX	 	:= 0 
Local nImporte	:= 0 //Soma das verbas em SRC e SRD com RV_CODIGRR IN ('346','347','348','349')
Local nRetorno	:= 0

/* 
RV_CODIGRR =
346        Retenido esta Liquidaci๓n
347        Devoluci๓n esta liquidaci๓n
348        Retenido A๑o Anterior
349        Devoluci๓n A๑o Anterior
*/
      
If (len(aVerbasFunc)>0) 
	For nX := 1 to Len(aVerbasFunc)
		nRetorno	:= aScan(aRoteiros,{|x|x[1]==aVerbasFunc[nX,11]})
		If 	(aVerbasFunc[nx,18] $  "346|347|348|349") .and. nRetorno > 0
			nImporte +=  aVerbasFunc[nx,7]
		Endif
	Next nX                                      


	lRetencion  := .T.    

	//ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	//ณRetencoes e Devolucoes    				ณ
	//ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู

	If (nImporte >= 0) 			//si es positivo es retenci๓n
		nTotReten := nImporte
		nTotDevol := 0 
		lRetencion := .T.  
	Else 						//si es negativo es retenci๓n
		nTotDevol := ABS(nImporte)
		nTotReten := 0
		lRetencion := .F.
	Endif

EndIf

RestArea(aArea)
	                                                 
Return(nil)             

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER801   บAutor  ณErika Kanamori      บ Data ณ  08/22/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณGera tabelas necessarias para geracao de arquivos txt SIJP, บฑฑ
ฑฑบ          ณMi Simplificacion e SICORE.                                 บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function GPER801B() 

Local aArea			:= GetArea()

Private lImpMnemo		:= .F.

Begin Sequence         
	
		IF ( lImpMnemo := MsgNoYes(	OemToAnsi(	STR0012 + ;	//"O Sistema ira Atualizar a Tabela RCC para geracao de arquivos de texto."
											CRLF	+ ;
											STR0013 + ;	//"Faca um Backup (RCC) antes de Iniciar o Processo de Atualizacao."
											CRLF	+ ;
											CRLF	+ ;
											STR0014   ;	//"Confirma a Atualizacao da Tabela?"
					   					 ),;
				 				OemToAnsi( STR0009 ) ;	//"Ateno"
							);
		)
        
		MsAguarde( { || CarTab801() } )

	EndIf
	
	
End Sequence           


RestArea(aArea)

Return( NIL )


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออออหอออออัออออออออออออออออออออหออออออัออออออออออออออออปฑฑ
ฑฑบPrograma  ณCarTab801   บAutorณErika Kanamori      บ Data ณ  05/09/2008    บฑฑ
ฑฑฬออออออออออุออออออออออออสอออออฯออออออออออออออออออออสออออออฯออออออออออออออออนฑฑ
ฑฑบDesc.     ณ Carrega lay-out dos arquivos magneticos                       บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7                                                           บฑฑ
ฑฑฬอออออออออออออุออออออออุอออออออออออุอออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบProgramador  ณ Data   ณ    FNC    ณ  Motivo da Alteracao                  บฑฑ
ฑฑฬอออออออออออออุออออออออุอออออออออออุอออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบL.TROMBINI   ณ09/11/10ณ           ณAlteracao do Lay-out do arquivo -      บฑฑ
ฑฑบ				ณ		 ณ			 ณpara a versao 3.4 release 1            บฑฑ
ฑฑฬอออออออออออออุออออออออุอออออออออออุอออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function CarTab801()   

Local aArea			:= GetArea()
Local aTabRCC	:= {}
Local nI		:=	0   
Private cFilRCC  := xFilial("RCC")
                                       
DbSelectArea("RCC")  
DbSetOrder(1)  
                                                            
gper801del()        //se tabelas jah existem, apaga.
   

//Carrega informacoes da tabela S017 - SICOSS
cNomeArq := "S017"   

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','CUIL                               E  1 11SRA->RA_CIC                                                                                    0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','APELLIDO Y NOMBRE                  E 12 30SRA->RA_NOME                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CONYUGE                            E 42  1xQtdParC                                                                                       0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','CANTIDAD DE HIJOS                  E 43  2xQtdParF                                                                                       0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','CODIGO DE SITUACION                E 45  2SITUACION()                                                                                    0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','CODIGO DE CONDICION                E 47  2SRA->RA_COND                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','CODIGO DE ACTIVIDAD                E 49  3SRA->RA_ATIV                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','CODIGO DE ZONA                     E 52  2SRA->RA_ZONA                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','PORCENTAJE DE APORTE ADICIONAL SS  E 54  5FPERCASS()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','CODIGO DE MODALID. DE CONTRATA     E 59  3SRA->RA_MODALID                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','CODIGO DE OBRA SOCIAL              E 62  6SRA->RA_CFGOSOC                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','CANTIDAD DE ADHERENTES             E 68  2IIf(!Empty(SRA->RA_DPASSME),SRA->RA_DPASSME,"00")                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','REMUNERACION TOTAL                 E 70 11TRANSFORM(TSICOSS("V","800"),"@E 99999999.99")                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','REMUNERACION IMPONIBLE 1           E 81 10TRANSFORM(TSICOSS("V","801"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','ASIGNACIONES FAMILIARES PAGADAS    E 91  90                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','IMPORTE APORTE VOLUNTARIO          E100  9TRANSFORM(TSICOSS("V","8B6"),"@E 999999.99")                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','IMPORTE ADICIONAL OS               E109  9TRANSFORM(TSICOSS("V","821"),"@E 999999.99")                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','IMPORTE EXCEDENTES APORTES SS      E118  90                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','IMPORTE EXCEDENTES APORTES OS      E127  90                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','PROVINCIA LOCALIDAD                E136 50SUBSTR(FDESC("SX5","12"+SRA->RA_ESTADO,"X5DESCRI()"),1,12)                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','REMUNERACION IMPONIBLE 2           E186 10TRANSFORM(TSICOSS("V","802"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','REMUNERACION IMPONIBLE 3           E196 10TRANSFORM(TSICOSS("V","803"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','REMUNERACION IMPONIBLE 4           E206 10TRANSFORM(TSICOSS("V","804"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','CODIGO DE SINIESTRADO              E216  2SRA->RA_SINIEST                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','MARCA CORRESPONDE REDUCCION        E218  10                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','026','CAPITAL DE RECOMPOSICION DE LTR    E219  90                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','027','TIPO DE EMPRESA                    E228  11                                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','028','APORTE ADICIONAL DE OBRA SOCIAL    E229  9TRANSFORM(TSICOSS("V","8C1"),"@E 999999.99")                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','029','REGIMEN                            E238  1"1"                                                                                            0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','030','SITUACION DE REVISTA 1             E239  2SituaRev("1","S")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','031','DIA INICIO SITUACION DE REVISTA 1  E241  2SituaRev("1","D")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','032','SITUACION DE REVISTA 2             E243  2SituaRev("2","S")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','033','DIA INICIO SITUACION REVISTA 2     E245  2SituaRev("2","D")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','034','SITUACION REVISTA 3                E247  2SituaRev("3","S")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','035','DIA INICIO SITUACION DE REVISTA 3  E249  2SituaRev("3","D")                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','036','SUELDO+ADICIONALES                 E251 10TRANSFORM(TSICOSS("V","8D2"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','037','SAC                                E261 10TRANSFORM(TSICOSS("V","8D1"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','038','HORAS EXTRA                        E271 10TRANSFORM(TSICOSS("V","8D0"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','039','ZONA DESFAVORABLE                  E281 10TRANSFORM(TSICOSS("V","8D4"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','040','VACACIONES                         E291 10TRANSFORM(TSICOSS("V","8D3"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','041','CANTIDAD DE DIAS TRABAJADOS        E301  9TRANSFORM(TSICOSS("H","8C9"),"@E 999999.99")                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','042','REMUNERACION IMPONIBLE 5           E310 10TRANSFORM(TSICOSS("V","805"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','043','TRABAJADOR CONVENCIONADO 0-NO 1-SI E320  1IIF(SRA->RA_CODCONV $ "002/004","1","0")                                                       0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','044','REMUNERACION IMPONIBLE 6           E321 10TRANSFORM(TSICOSS("V","806"),"@E 9999999.99")                                                  0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','045','TIPO DE OPERACION                  E331  11                                                                                              0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','046','ADICIONALES                        E332 10TRANSFORM(TSICOSS("V","8E5"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','047','PREMIOS                            E342 10TRANSFORM(TSICOSS("V","8E6"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','048','REMUNERACION IMPONIBLE 8           E352 10TRANSFORM(TSICOSS("V","808"),"@E 9999999.99")                                                  0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','049','REMUNERACION IMPONIBLE 7           E362 10TRANSFORM(TSICOSS("V","807"),"@E 9999999.99")                                                  0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','050','CANTIDAD DE HORAS EXTRAS           E372  3TRANSFORM(TSICOSS("V","8E7"),"@E 999")                                                         0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','051','CONCEPTOS NO REMUNERATIVOS         E375 10TRANSFORM(TSICOSS("V","8F0"),"@E 9999999.99")                                                  0                                                                                                                 '})    
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','052','MATERNIDAD                         E385 10TRANSFORM(TSICOSS("V","8F2"),"@E 9999999.99")                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','053','RETIF. DE REMUNERACION             E395  90                                                                                              0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','054','REMUNERACION IMPONIBLE 9           E404 10TRANSFORM(TSICOSS("V","809"),"@E 9999999.99")                                                  0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','055','CONTRIBUICION TAREA DIFERENCIAL(%) E414  90                                                                                              0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','056','HORAS TRABAJADAS                   E423  3TRANSFORM(TSICOSS("H","8F3"),"@E 999")                                                         0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','057','SEGURO COLECTIVO VIDA OBLIGATORIO  E426  1IIf( SRA->RA_SEGVIDA=="1","1","0" )                                                            0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','058','DETRACCI๓N LEY 27430               E464 12STRTRAN(TRANSFORM(TSICOSS("V","836"),"@E 9999999.99"),"","0")                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','059','LIMPIA VARIABLES DE EMPLEADO       E  0  0LIMPIASTATIC()                                                                                 0                                                                                                                 '}) 

/*
Retirado conforme Ata: ATA_ARG11.6_RH_GPE_20120314.docx
$/Protheus_Padrao/Docs_Proj/V11/Release 11.6/GDPs/Recursos Humanos/Atas de Reuniใo

//Carrega informacoes da tabela S018 - MI Simplificacion Laboral

cNomeArq := "S018" 

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','TIPO DE REGISTRO                   E  1  2"01"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','CODIGO MOVIMIENTO                  E  3  2MOVFUNC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CUIL DEL EMPLEADO                  E  5 11SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','MARCA DE TRABAJADOR AGROPECUARIO   E 16  1"N"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','MODALIDAD DE CONTRATATO            E 17  3"0"+SRA->RA_MODALID                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','FECHA DE INICIO DE REL. LABORAL    E 20 10DATAINI()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','FECHA DE FIN DE REL. LABORAL       E 30 10DATAFIN()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','CODIGO DE OBRA SOCIAL              E 40  6cObra                                                                                         0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','CODIGO DE SITUACION DE BAJA        E 46  2BAJA()                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','FECHA RECEPCION TELEGRAMA RENUNCIA E 48 10DATAFIN()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','RETRIBUCION PACTADA                E 58 15SALA()                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','MODALIDAD DE LIQUIDACION           E 73  1MODALID()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','SUCURSAL - DOMICILIO DE DESEMPENO  E 74  5"00001"                                                                                       0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','ACTIVIDAD EN EL DOMICILIO DESEMP.  E 79  6"999999"                                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','PUESTO DESEMPENADO                 E 85  4"1111"                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','LIMPIA VARIABLES DE EMPLEADO       E  0  0U_LIMPIASTATIC()                                                                              0                                                                                                                 '}) 

				
//Carrega informacoes da tabela S019 - MI Simplificacion Complem.     

cNomeArq := "S019"
                                 	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','TIPO DE REGISTRO                   E  1  2"02"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','CODIGO DE MOVIMIENTO               E  3  2MOVFUNC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CUIL DEL EMPLEADO                  E  5 11SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','FECHA DE NACIMIENTO                E 16 10DATANAS()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','NIVEL DE FORMACION                 E 26  2SRA->RA_GRINRAI                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','MARCA DE DISCAPACIDAD              E 28  1"N"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','PREFIJO TELEFONICO DE PAIS         E 29  4"0054"                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','PREFIJO TELEFONICO DE AREA         E 33  4SRA->RA_CODAREA                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','NUMERO DE TELEFONO                 E 37 15SRA->RA_TELEFON                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','TIPO DE TELEFONO                   E 52  1"1"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','DIRECCION DE EMAIL                 E 53 60SRA->RA_EMAIL                                                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','TIPO DE EMAIL                      E113  1"1"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','CBU                                E114 22SRA->RA_CBU                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','DESCRIPCION DE LA CALLE            E136 30SRA->RA_ENDEREC                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','NUMERO DE LA PUERTA                E166  6TRANSFORM(VAL(SRA->RA_COMPLEM),"@e 999999")                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','TORRE                              E172  5SRA->RA_TORRE                                                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','BLOQUE                             E177  5SRA->RA_BLOQUE                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','PISO                               E182  5SRA->RA_PISO                                                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','DEPARTAMENTO                       E187  5SUBSTR(SRA->RA_DEPTO,5,5)                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','CODIGO POSTAL                      E192  8ALLTRIM(SRA->RA_CEP)                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','CODIGO DE LOCALIDAD                E200 10SRA->RA_LOCALID                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','CODIGO DE PROVINCIA-CAP FEDERAL    E210  2PROVINC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','LIMPIA VARIABLES DE EMPLEADO       E  0  0U_LIMPIASTATIC()                                                                              0                                                                                                                 '}) 


//Carrega informacoes da tabela S020 - MI Simplificacion C.B.U. 
cNomeArq := "S020"

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','TIPO DE REGISTRO                   E  1  2"03"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','CODIGO DE MOVIMIENTO               E  3  2MOVFUNC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CUIL DEL EMPLEADO                  E  5 11SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','CBU                                E 16 22SRA->RA_CBU                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','LIMPIA VARIABLES DE EMPLEADO       E  0  0U_LIMPIASTATIC()                                                                              0                                                                                                                 '}) 
  

//Carrega informacoes da tabela S021 - MI Simplificacion V. famil.
cNomeArq := "S021"

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','TIPO DE REGISTRO                   E  1  2"05"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','CODIGO DE MOVIMIENTO               E  3  2"AT"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CUIL DEL EMPLEADO                  E  5 11SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','CUIL DEL VINCULADO                 E 16 11SRB->RB_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','CODIGO DE EVENTO                   E 27  2SRB->RB_PARENT                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','FECHA DE INICIO VINCULO            E 29 10DATAINI()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','FECHA EMISION DOCUMENTACION        E 39 10DATADOC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','TOMO                               E 49  6SRB->RB_NREGCAR                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','FOLIO                              E 55  5SRB->RB_NUMLIVR                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','NUMERO DE ACTA                     E 60  7ACTA()                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','CODIGO DE PAIS NACIM-CASAM         E 67  4"0012"                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','CODIGO DE PROVINCIA-CAP FEDERAL    E 71  2PROVINC()                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','CODIGO DE LOCALIDAD                E 73 10SRB->RB_LOCALID                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','COMUNA                             E 83 30SPACE(30)                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','TRIBUNAL                           E113 50SPACE(50)                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','NUMERO DE JUZGADO                  E163  4"    "                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','NUMERO DE SECRETARIA               E167  4"    "                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','ESCOLARIDAD ANO                    E171  4"    "                                                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','ESCOLARIDAD TIPO                   E175  1"N"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','ESCOLARIDAD NIVEL                  E176  2SRB->RB_ESCNIVE                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','ESCOLARIDAD GRADO                  E178  1SRB->RB_ESCGRAD                                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','TEXTO DJ                           E179 70SPACE(70)                                                                                     0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','CODIGO DOCUMENTACION               E249  2EVEN_PAR()                                                                                    0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','CODIGO DOCUMENTACION EXTERIOR      E251  2"  "                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','LIMPIA VARIABLES DE EMPLEADO       E  0  0U_LIMPIASTATIC()                                                                              0                                                                                                                 '}) 
*/                        
       
//Carrega informacoes da tabela S022 - SICORE
cNomeArq := "S022"
                                         
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','CODIGO COMPROBANTE                 E  1  2VER_COMPROB()                                                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','FECHA EMISSION DEL COMPROBANTE     E  3 10VER_DATA()                                                                                    0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','NUMERO DEL COMPROBANTE             E 13 16STRZERO(VAL(SRA->RA_MAT),16)                                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','IMPORTE DEL COMPROBANTE            E 29 16TRANSFORM(0,"@E 9999999999999.99")                                                            0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','CODIGO DE IMPUESTO                 E 45  3"217"                                                                                         0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','CODIGO DE REGIMEN                  E 48  3"160"                                                                                         0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','CODIGO DE OPERACION                E 51  1"1"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','BASE DE CALCULO                    E 52 14TRANSFORM(nTotDevol,"@E 999999999.99")                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','FECHA DE EMISION DE LA RETENCION   E 66 10VER_DATA()                                                                                    0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','CODIGO DE CONDICION                E 76  2"01"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','RETENCION PRAT. SUJ. SUSP. SEG.    E 78  1" "                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','IMPORTE DE LA RETENCION            E 79 14TRANSFORM(nTotReten,"@E 999999999.99")                                                        0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','PORCENTAJE DE EXCLUSION            E 93  6TRANSFORM(0,"@E 999.99")                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','FECHA DE EMISSION DEL BOLETIN      E 99 10"          "                                                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','TIPO DE DOCUMENTO DEL RETENIDO     E109  2"86"                                                                                          0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','NUMERO DE DOCUMENTO DEL RETENIDO   E111 20SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','NUMERO DE CERTIFICADO ORIGINAL     E131 14"00000000000000"                                                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','LIMPIA VARIABLES DE EMPLEADO       E  0  0U_LIMPIASTATIC()                                                                              0                                                                                                                 '}) 

//Carrega informacoes da tabela S030 - Codigo AFIP - Impuesto a las Ganancias

cNomeArq := "S030" 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','019LIQUIDADAS POR LA ENTIDAD QUE ACTUA COMO AGENTE DE RETNCION                                                                                                                                                                                            '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','027APELIDOS Y NOMBRES O DENOMINACION Y DOMICILIO                                                                                                                                                                                                          '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','035INGRESOS LIQUIDADOS POR OTRAS ENTIDADES                                                                                                                                                                                                                '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','043INGRESOS LIQUIDADOS POR OTRAS ENTIDADES 2                                                                                                                                                                                                              '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','078INGRESOS LIQUIDADOS POR OTRAS ENTIDADES 3                                                                                                                                                                                                              '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','116APORTES JUBILATORIOS                                                                                                                                                                                                                                   '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','124APORTES PARA OBRAS SOCIALES Y CTAS MED. ASIST. (TOTAL RUBRO 11)                                                                                                                                                                                        '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','132PRIMA DE SEGURO PARA EL CASO DE MUERTE                                                                                                                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','140GASTOS DE SEPELIO PAGINA FRENTE                                                                                                                                                                                                                        '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','159GASTOS ESTIMATIVOS DE CORREDORES Y VIAJANTES DE COMERCIO                                                                                                                                                                                               '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','167OTRAS DEDUCCIONES PAGINA FRENTE                                                                                                                                                                                                                        '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','191DONACIONES 5% RUBRO 3                                                                                                                                                                                                                                  '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','213DEDUCCION ESPECIAL                                                                                                                                                                                                                                     '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','221GANANCIA NO IMPONIBLE                                                                                                                                                                                                                                  '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','256CONYUGE                                                                                                                                                                                                                                                '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','264HIJOS                                                                                                                                                                                                                                                  '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','272OTRAS CARGAS                                                                                                                                                                                                                                           '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','329TOTAL DEL IMPUESTO DETERMINADO                                                                                                                                                                                                                         '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','345RETENCIONES EFECTUADAS EN EL PERIODO  FISCAL ACUMULADAS                                                                                                                                                                                                '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','346RETENCIONES EFECTUADAS EN EL PERIODO FISCAL QUE SE LIQUIDA                                                                                                                                                                                             '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','347DEVOLUCIONES EFECTUADAS EN EL PERIODO FISCAL QUE SE LIQUIDA                                                                                                                                                                                            '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','348RETENCIONES EFECTUADAS EN EL PERIODO FISCAL ANTERIOR                                                                                                                                                                                                   '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','349DEVOLUCIONES EFECTUADAS EN EL PERIODO FISCAL ANTERIOR                                                                                                                                                                                                  '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','353REGIMENES DE PROMOCION (REBAJA DE IMPUESTO, DIFERIMIENTO U OTROS)                                                                                                                                                                                      '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','418OBRA SOCIAL                                                                                                                                                                                                                           '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','026','426CUOTAS MEDICO ASISTENCIAL                                                                                                                                                                                                                         '})                                                            
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','027','434CUOTA MEDICO ASISTENCIAL                                                                                                                                                                                                                               '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','028','507SEGUROS DE VIDA                                                                                                                                                                                                                                        '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','029','515PRIMAS DE SEGURO  DE VIDA                                                                                                                                                                                                                              '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','030','604SEPELIOS                                                                                                                                                                                                                                        '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','031','612GASTOS DE SEPELIO 2                                                                                                                                                                                                                                    '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','032','620GASTO DE SEPELIO                                                                                                                                                                                                                                       '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','033','701DONACIONES                                                                                                                                                                                                                                          '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','034','728DONACIONES 2                                                                                                                                                                                                                                           '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','035','736TOTAL DONACIONES                                                                                                                                                                                                                                       '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','036','809INTERESES HIPOTECARIOS                                                                                                                                                                                                                                        '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','037','817EMPLEADAS DOMESTICAS                                                                                                                                                                                                                                     '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','038','825SINDICATOS                                                                                                                                                                                                                                   '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','039','826HONORARIOS MEDICOS                                                                                                                                                                                                                                   '})
//AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','039','833OTRAS DEDUCCIIONES TOTAL                                                                                                                                                                                                                               '})

//Carga informacion de la tabla S037 - SU DECLARACION
cNomeArq := "S037"   

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','CUIL                               E  1 11SRA->RA_CIC                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','APELLIDO Y NOMBRE                  E 12 30SRA->RA_NOME                                                                                  0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','CONYUGE                            E 42  1xQtdParC                                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','CANTIDAD DE HIJOS                  E 43  2xQtdParF                                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','CODIGO DE SITUACION                E 45  2SITUACION()                                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','CODIGO DE CONDICION                E 47  2PADL(SRA->RA_COND,2,"0")                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','CODIGO DE ACTIVIDAD                E 49  3PADL(SRA->RA_ATIV,3,"0")                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','CODIGO DE ZONA                     E 52  2PADL(SRA->RA_ZONA,2,"0")                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','PORCENTAJE DE APORTE ADICIONAL SS  E 54  5STRTRAN(STRZERO(val(U_FPERCASS()),5,2),".",",")                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','CODIGO DE MODALID. DE CONTRATA     E 59  3ALLTRIM(SRA->RA_MODALID)                                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','CODIGO DE OBRA SOCIAL              E 62  6PADL(SRA->RA_CFGOSOC,6,"0")                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','CANTIDAD DE ADHERENTES             E 68  2IIf(!Empty(SRA->RA_DPASSME),SRA->RA_DPASSME,"00")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','REMUNERACION TOTAL                 E 70 12STRTRAN(STRZERO(TSICOSS("V","800"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','REMUNERACION IMPONIBLE 1           E 82 12STRTRAN(STRZERO(TSICOSS("V","801"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','ASIGNACIONES FAMILIARES PAGADAS    E 94  9STRTRAN(STRZERO(0,9,2),".",",")                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','IMPORTE APORTE VOLUNTARIO          E103  9STRTRAN(STRZERO(TSICOSS("V","8B6"),9,2),".",",")                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','IMPORTE ADICIONAL OS               E112  9STRTRAN(STRZERO(TSICOSS("V","8G2"),9,2),".",",")                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','IMPORTE EXCEDENTES APORTES SS      E121  9STRTRAN(STRZERO(0,9,2),".",",")                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','IMPORTE EXCEDENTES APORTES OS      E130  9STRTRAN(STRZERO(0,9,2),".",",")                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','PROVINCIA LOCALIDAD                E139 50FDESC("SX5","12"+SRA->RA_ESTADO,"X5_DESCSPA")                                                 0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','REMUNERACION IMPONIBLE 2           E189 12STRTRAN(STRZERO(TSICOSS("V","802"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','REMUNERACION IMPONIBLE 3           E201 12STRTRAN(STRZERO(TSICOSS("V","803"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','REMUNERACION IMPONIBLE 4           E213 12STRTRAN(STRZERO(TSICOSS("V","804"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','CODIGO DE SINIESTRADO              E225  2PADL(SRA->RA_SINIEST,2,"0")                                                                   0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','MARCA CORRESPONDE REDUCCION        E227  1STRZERO(0,9,2)                                                                                0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','026','CAPITAL DE RECOMPOSICION DE LTR    E228  9STRTRAN(STRZERO(0,9,2),".",",")                                                               0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','027','TIPO DE EMPRESA                    E237  11                                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','028','APORTE ADICIONAL DE OBRA SOCIAL    E238  9STRTRAN(STRZERO(TSICOSS("V","8G1"),9,2),".",",")                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','029','REGIMEN                            E247  1"1"                                                                                           0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','030','SITUACION DE REVISTA 1             E248  2SITUAREV("1","S")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','031','DIA INICIO SITUACION DE REVISTA 1  E250  2SITUAREV("1","D")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','032','SITUACION DE REVISTA 2             E252  2SITUAREV("1","S")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','033','DIA INICIO SITUACION REVISTA 2     E254  2SITUAREV("1","D")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','034','SITUACION REVISTA 3                E256  2SITUAREV("1","S")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','035','DIA INICIO SITUACION DE REVISTA 3  E258  2SITUAREV("1","D")                                                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','036','SUELDO+ADICIONALES                 E260 12STRTRAN(STRZERO(TSICOSS("V","8D2"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','037','SAC                                E272 12STRTRAN(STRZERO(TSICOSS("V","8D1"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','038','HORAS EXTRA                        E284 12STRTRAN(STRZERO(TSICOSS("V","8D0"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','039','ZONA DESFAVORABLE                  E296 12STRTRAN(STRZERO(TSICOSS("V","8D4"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','040','VACACIONES                         E308 12STRTRAN(STRZERO(TSICOSS("V","8D3"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','041','CANTIDAD DE DIAS TRABAJADOS        E320  9STRTRAN(STRZERO(TSICOSS("H","8C9"),9,2),".",",")                                              0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','042','REMUNERACION IMPONIBLE 5           E329 12STRTRAN(STRZERO(TSICOSS("V","805"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','043','TRABAJADOR CONVENCIONADO 0-NO 1-SI E341  1IIF(SRA->RA_CODCONV $ "002/004","1","0")                                                      0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','044','REMUNERACION IMPONIBLE 6           E342 12STRTRAN(STRZERO(TSICOSS("V","806"),12,2),".",",")                                             0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','045','TIPO DE OPERACION                  E354  11                                                                                             0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','046','ADICIONALES                        E355 12STRTRAN(STRZERO(TSICOSS("V","8E5"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','047','PREMIOS                            E367 12STRTRAN(STRZERO(TSICOSS("V","8E6"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','048','REMUNERACION IMPONIBLE 8           E379 12STRTRAN(STRZERO(TSICOSS("V","808"),12,2),".",",")                                             0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','049','REMUNERACION IMPONIBLE 7           E391 12STRTRAN(STRZERO(TSICOSS("V","807"),12,2),".",",")                                             0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','050','CANTIDAD DE HORAS EXTRAS           E403  3PADL(ROUND(TSICOSS("V","8E7"),0),3,"0")                                                       0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','051','CONCEPTOS NO REMUNERATIVOS         E406 12STRTRAN(STRZERO(TSICOSS("V","8F0"),12,2),".",",")                                             0                                                                                                                 '})    
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','052','MATERNIDAD                         E418 12STRTRAN(STRZERO(TSICOSS("V","8F2"),12,2),".",",")                                             0                                                                                                                 '})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','053','RETIF. DE REMUNERACION             E430  9STRTRAN(STRZERO( 0,9,2),".",",")                                                              0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','054','REMUNERACION IMPONIBLE 9           E439 12STRTRAN(STRZERO(TSICOSS("V","809"),12,2),".",",")                                             0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','055','CONTRIBUICION TAREA DIFERENCIAL(%) E451  9STRTRAN(STRZERO(0,9,2),".",",")                                                               0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','056','HORAS TRABAJADAS                   E460  3PADL(TSICOSS("H","8F3"),3,"0")                                                                0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','057','SEGURO COLECTIVO VIDA OBLIGATORIO  E463  1IIF( SRA->RA_SEGVIDA=="1","1","0" )                                                           0                                                                                                                 '}) 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','058','LIMPIA VARIABLES DE EMPLEADO       E  0  0LIMPIASTATIC()                                                                                0                                                                                                                 '}) 

cNomeArq := "S043"   

AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','1a Remuneraci๓n Bruta'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','1b Remuneraci๓n No alcanzada'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','1c Remuneraci๓n Exenta'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','1d Remuneraci๓n otros empleos'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','2a Aportes a fondo de jubilaci๓n, retiros, pensiones, o subsidios que se destinen a cajas nacionales, provinciales o municipales'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','2b Aportes Obra Social'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','2c Cuota Sindical'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','2d Aportes Jubilatorios Otros Empleos'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','2e Aportes Obras Sociales Otros Empleos'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','2f Cuota Sindical Otros Empleos'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','2g Cuotas Medico asistenciales'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','2h Primas del Seguro de Vida para caso de muerte'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','2i Gastos de Sepelio'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','2j Gastos estimativos para corredores y viajantes de comercio'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','2k Donaciones a fiscos nacional, provincial y municipales, y a instituciones comprometidas en el art. 20, inc E) y F) de la ley'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','2l Descuentos obligatorios establecidos por Ley Nacional, provincial, o municipal'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','2m Honorarios por servicios de asistencia sanitaria, m้dica y param้dica'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','2n Intereses Cr้ditos Hipotecarios'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','2o Aportes al capital social o al fondo de riesgo de socios protectores de sociedades de garantํa reciproca'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','2p Empleados del servicio dom้stico (Ley 26.063, art 16)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','2q Aportes a Cajas Complementarias de Previsi๓n, fondos compensadores de previsi๓n o similares'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','3a Ganancia NO Imponible'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','3b Deducci๓n Especial'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','3c C๓nyuge'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','3d Hijos'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','026','3e Otras Cargas'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','027','4a Remuneraci๓n Sujeta Impuesto (Rem Computables menos total punto 2 menos total punto 3)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','028','4b Impuesto Determinado'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','029','4c Impuesto Retenido'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','030','4d Pagos a Cuenta'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','031','4e Saldo'})

cNomeArq := "S042" 
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','001','IDENTIFICACION DEL TIPO DE REGISTROE1  2  04'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','002','CUIL DEL TRABAJADOR                E3  11 SRA->RA_CIC'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','003','MARCA DE CONYUGE                   E14 1  XQTDPARC'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','004','CANTIDAD DE HIJOS                  E15 2  XQTDPARF'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','005','MARCA DE TRABAJADOR EN CCT         E17 1  IIF(SRA->RA_CODCONV $ "002/004","1","0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','006','MARCA DE COBERTURA DE SCVO         E18 1  IIF( SRA->RA_SEGVIDA=="1","1","0" )'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','007','MARCA DE SI CORRESPONDE REDUCCION  E19 1  0'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','008','COD. DE EMPLEADOR ASOCIADO AL TRAB.E20 1  IIF( SRA->RA_MODALID=="102",2,1)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','009','CODIGO DE TIPO DE OPERACION        E21 1  0'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','010','CODIGO DE SITUACION DE REVISTA     E22 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUACION)")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','011','CODIGO DE CONDICION                E24 2  SRA->RA_COND'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','012','CODIGO DE ACTIVIDAD                E26 3  STRZERO(VAL(SRA->RA_ATIV),3)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','013','CODIGO DE MODALIDAD DE CONTRATACIONE29 3  SRA->RA_MODALID'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','014','CODIGO DE SINIESTRADO              E32 2  SRA->RA_SINIEST'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','015','CODIGO DE LOCALIDAD                E34 2  STRZERO(VAL(SRA->RA_ZONA),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','016','SITUACION DE REVISTA 1             E36 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""1"",""S"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','017','DIA DE INICIO SITUACION REVISTA 1  E38 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""1"",""D"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','018','SITUACION DE REVISTA 2             E40 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""2"",""S"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','019','DIA DE INICIO SITUACION REVISTA 2  E42 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""2"",""D"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','020','SITUACION DE REVISTA 3             E44 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""3"",""S"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','021','DIA DE INICIO SITUACION REVISTA 3  E46 2  STRZERO(VAL(&("STATICCALL(GPER801,SITUAREV,""3"",""D"")")),2)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','022','CANTIDAD DE DIAS TRABAJADOS        E48 2  TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""H"",""8C9"")"),"@E 99")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','023','CANTIDAD DE HORAS TRABAJADAS       E50 3  TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""8E7"")"),"@E 999")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','024','PORCENTAJE APORTE ADIC. DE SEG. SOCE53 5  PADL("",5,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','025','PORCENTAJE CONTRIB. POR TAREA DIF. E58 5  IIF( SRA->RA_CODCONV =="003","000200","000000")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','026','CODIGO OBRA SOCIAL DEL TRABAJADOR  E63 6  SRA->RA_CFGOSOC'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','027','CANTIDAD ADHERENTES DE OBRA SOCIAL E69 2  IIF(!EMPTY(SRA->RA_DPASSME),SRA->RA_DPASSME,"00")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','028','APORTE ADICIONAL DE OBRA SOCIAL    E71 15 STRZERO(&("STATICCALL(GPER801,TSICOSS,""V"",""821"")"),15)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','029','CONTRIBUCION ADICIONAL OBRA SOCIAL E86 15 STRZERO(&("STATICCALL(GPER801,TSICOSS,""V"",""84A"")"),15)'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','030','CALCULO DIF. DE APORTE DE O/S Y FSRE10115 PADL("",15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','031','CALCULO DIF. DE CONTR DE O/S Y FSR E11615 PADL("",15,"0")'})	
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','032','CALCULO DIF. LEY DE RIESGO DE TRAB.E13115 PADL("",15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','033','REMUNERACION MATERNIDAD PARA ANSES E14615 PADL("",15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','034','REMUNERACION BRUTA                 E16115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""800"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','035','BASE IMPONIBLE 1                   E17615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""801"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','036','BASE IMPONIBLE 2                   E19115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""802"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','037','BASE IMPONIBLE 3                   E20615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""803"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','038','BASE IMPONIBLE 4                   E22115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""804"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','039','BASE IMPONIBLE 5                   E23615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""805"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','040','BASE IMPONIBLE 6                   E25115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""806"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','041','BASE IMPONIBLE 7                   E26615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""807"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','042','BASE IMPONIBLE 8                   E28115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""808"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','043','BASE IMPONIBLE 9                   E29615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""809"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','044','BASE IMPONIBLE 10                  E31115 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""809"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','045','BASE IMPONIBLE 11                  E32615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""809"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','046','BASE IMPONIBLE 12                  E34115	PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""809"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})
AAdd(aTabRCC,{cFilRCC,cNomeArq, Space(FWGETTAMFILIAL),'      ','047','BASE IMPONIBLE 13                  E35615 PADL(STRTRAN(STRTRAN(ALLTRIM(TRANSFORM(&("STATICCALL(GPER801,TSICOSS,""V"",""809"")"),"@E 9999999999999.99")),",",""),".",""),15,"0")'})

//grava as tabelas 

	For nI := 1 To Len(aTabRCC) 	
		RecLock('RCC',.T.)
		Replace RCC_FILIAL With aTabRCC[nI][01]
		Replace RCC_CODIGO With aTabRCC[nI][02]
		Replace RCC_FIL    With aTabRCC[nI][03]
		Replace RCC_CHAVE  With aTabRCC[nI][04]	
		Replace RCC_SEQUEN With aTabRCC[nI][05]	
		Replace RCC_CONTEU With aTabRCC[nI][06]		
		MsUnLock()
	Next nI 
		
		
	MsgInfo(STR0010 , STR0009) //Aviso#Tabelas Carregadas

RestArea(aArea)

Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณGPER801DELบAutor  ณErika Kanamori      บ Data ณ  08/22/08   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณApaga tabelas RCC correspondentes a SIJP, my simplificacion บฑฑ
ฑฑบ          ณe SICORE.                                                   บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

Static Function GPER801DEL()
                    
Local aArea			:= GetArea()
Local nAux := 1
Local aNomeTab := {}
                     
Aadd(aNomeTab,"S017")
Aadd(aNomeTab,"S018")
Aadd(aNomeTab,"S019")
Aadd(aNomeTab,"S020")
Aadd(aNomeTab,"S021")
Aadd(aNomeTab,"S022")
Aadd(aNomeTab,"S030")    
Aadd(aNomeTab,"S037")
Aadd(aNomeTab,"S043")
Aadd(aNomeTab,"S042")

For nAux:= 1 to len(aNomeTab)
	If RCC->(dbSeek(cFilRCC + aNomeTab[nAux]),.T.)
    	While RCC->( !Eof() ) .And. RCC->(RCC_FILIAL+RCC_CODIGO) == cFilRCC+aNomeTab[nAux]
			IF RCC->( RecLock( "RCC" , .F. , .F. ) )
				RCC->( dbDelete() )
				RCC->( MsUnLock() )
			EndIF
			RCC->( DbSkip() )
		EndDo	 
	Endif
Next

RestArea(aArea)
Return( NIL )

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณRetcObra  บAutor  ณAlceu Pereira       บ Data ณ  12/01/09   บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณ Retorna o Codigo da obra social.		                      บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑบ          ณ   PARAMETROS:                                              บฑฑ
ฑฑบ          ณ    cTabela     == Nome da tabela que sera pesquisada       บฑฑ
ฑฑบ          ณ    cOperador   == Tipo de comparacao de valores            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP7                                                        บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/
Static Function RetcObra(cTabela,cOperador)

Local aArea			:= GetArea()
Local nPos := 0
Local cCodObra := 0

nPos := fPosTab(cTabela, SRA->RA_ASMEDIC , cOperador, 4  )
  
If nPos > 0 
 cCodObra := IF( FTABELA(cTabela, nPos , 12 ) <> NIL, FTABELA(cTabela,  nPos, 12 ) , 0 )
Endif                                               

RestArea(aArea)

Return cCodObra


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออหออออออัอออออออออออออปฑฑ
ฑฑบPrograma  ณfTipoProceบAutor  ณAlceu Pereira       บ Data ณ  15/04/2009 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออสออออออฯอออออออออออออนฑฑ
ฑฑบDesc.     ณCarrega janela com opcoes dos Processos.                    บฑฑ
ฑฑบ          ณ                                                            บฑฑ
ฑฑฬออออออออออุออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบUso       ณ AP                                                         บฑฑ
ฑฑศออออออออออฯออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/

User Function fTipoProce()

Local cTitulo	:= STR0016  //"tipo de relatorio"
Local cString	:= ""                 
Local MvParDef	:= ""
Local MvRetor	:= ""
Local nFor		:= 0
Local MvPar            
Local lExiste   := .F.
Private aSit	:= {}      
                                                                                            
cAlias := Alias() 					// Salva Alias Anterior   
          
If Upper(Alltrim(ReadVar() )) == "MV_PAR01"                        
	MvPar:=&(Alltrim(ReadVar()))	// Carrega o conteudo da variavel
	mvRet:=Alltrim(ReadVar())		// carrega o nome da variavel
Endif

CursorWait()  
	         		
MvParDef:= "12345"  

aAdd(aSit, "SIJP")
aAdd(aSit, "My Simpl. Laboral")
aAdd(aSit, "My Simpl. Complem.")
aAdd(aSit, "My Simpl. C.B.U.")
aAdd(aSit, "My Simpl. V. Fam.")
//aAdd(aSit, "SICORE")

CursorArrow()
	
	IF f_Opcoes(@MvPar,cTitulo,aSit,MvParDef,,,.F.,1,1)
		CursorWait()
		For nFor := 1 To Len( MvPar )
		   	IF ( SubStr( mVpar , nFor , 1 ) # "*" )   
				mvRetor += SubStr( mVpar , nFor , 1 )
		  	Endif
	   	Next nFor
		&MvRet := Alltrim(Mvretor)  //carrega o resultado da fopcoes
		CursorArrow()	
	EndIF	                                                   

dbSelectArea(cAlias) // Retorna Alias        

Return(.T.)

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณfProc     ณ Autor ณ Alceu Pereira         ณ Data ณ 15/04/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณSelecionar o Processo                               		  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ fProcesso() 												  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 												  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿/*/
User Function fProc(l1Elem, lTipoRet, aElem)

Local aArea			:= GetArea()
Local cTitulo	:=""
Local nFor		:= 0
Local nElem		:= 0
Local MvPar
Local MvParDef	:=""
Local MvRetor	:= ""
Local nX3Tam	:= 0

Private aSit:={}
l1Elem := If (l1Elem = Nil , .F. , .T.) 

DEFAULT lTipoRet 	:= .T. 
DEFAULT aElem		:= {}

cAlias := Alias() 					// Salva Alias Anterior

IF lTipoRet
	MvPar:=&(Alltrim(ReadVar()))	// Carrega Nome da Variavel do Get em Questao
	mvRet:=Alltrim(ReadVar())		// Iguala Nome da Variavel ao Nome variavel de Retorno
EndIF

dbSelectArea("RCJ")
If dbSeek(cFilial)
	CursorWait()
	While !Eof() .And. RCJ->RCJ_FILIAL == cFilial 
		If allTrim(RCJ->RCJ_CODIGO) != ""
			Aadd(aSit, RCJ->RCJ_CODIGO + " - " + Alltrim(RCJ->RCJ_DESCRI))
			MvParDef += RCJ->RCJ_CODIGO
		Endif			
		dbSkip()
	Enddo  
	If Len(aElem) > 0
		For nElem := 1 to Len(aElem)	
			Aadd(aSit, aElem[nElem]) 				//"EXT - Valores Extras"
			MvParDef += SubStr(aElem[nElem], 1, 3)	//MvParDef += "EXT"
		Next nElem
	EndIf
	CursorArrow()
Endif

IF lTipoRet         
	nX3Tam := GetSx3Cache("RCJ_CODIGO","X3_TAMANHO")
	IF f_Opcoes(@MvPar,cTitulo,aSit,MvParDef,,,l1Elem, nX3Tam)  // Chama funcao f_Opcoes
		CursorWait()
		For nFor := 1 To Len( mVpar ) Step 3
			IF ( SubStr( mVpar , nFor , 3 ) # "***" )      
				mvRetor += SubStr( mVpar , nFor , 3 )  
			Endif
		Next nFor
	   	If( Empty(mvRetor) )
			mvRetor := Space(nX3Tam)
		EndIf                       
		&MvRet 	:= mvRetor
		CursorArrow()	
	EndIF	
EndIF

dbSelectArea(cAlias) // Retorna Alias
RestArea(aArea)

Return( IF( lTipoRet , .T. , MvParDef ) )    


/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑษออออออออออัออออออออออหอออออออัออออออออออออออออออออออหออออออัออออออออออออปฑฑ
ฑฑบFuncao    ณSituaRev  บAutor  ณAlceu Pereira da Silvaบ Data ณ 22/09/2009 บฑฑ
ฑฑฬออออออออออุออออออออออสอออออออฯออออออออออออออออออออออสออออออฯออออออออออออนฑฑ
ฑฑบDesc.     ณResponsavel por buscar os afastamentos com os dias e informarบฑฑ
ฑฑบ          ณa situacao cadastrada na tabela "SR8" - Controle de ausencias บฑฑ
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ
ฑฑบParametro ณSitRev: Pode conter os seguintes valores:					   บฑฑ
ฑฑบ			 ณ 1  = Informa Status para Situacao de Revista 1			   บฑฑ
ฑฑบ          ณ 2  = Informa Status para Situacao de Revista 2			   บฑฑ
ฑฑบ          ณ 3  = Informa Status para Situacao de Revista 3			   บฑฑ              
ฑฑบ			 ณ                                                             บฑฑ 
ฑฑบ			 ณcSituac : Pode conter os seguintes valores:				   บฑฑ 
ฑฑบ			 ณ	"S"  = Retorna a Situacao                                  บฑฑ 
ฑฑบ			 ณ	"D"  = Retorna o primeiro dia em que ocorreu a situacao    บฑฑ 
ฑฑฬออออออออออุอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออนฑฑ              
ฑฑบUso       ณ Argentina P10                                               บฑฑ
ฑฑศออออออออออฯอออออออออออออออออออออออออออออออออออออออออออออออออออออออออออออผฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
*/
Static Function SituaRev(cSitRev,cSituac)     

Local aData       := {}
Local aArea       := GetArea()  
Local nLin	      := 0
Local cSit        := ""
Local nX
Local dBkpDtFim   := Ctod("  /  /  ")
Local nX2		  	
Local nDdesC	  := 0	

If Len(aDatasSR8) = 0                    
	
	DbSelectArea ("SR8")  //controle de ausencias
	DbSetOrder(1)
	dbSeek(SRA->RA_FILIAL+SRA->RA_MAT,.F.)
	           
	While !Eof() .And. SRA->RA_FILIAL+SRA->RA_MAT == SR8->R8_FILIAL+R8_MAT
		
		If Empty(SR8->R8_DATAFIM) .Or. AnoMes(SR8->R8_DATAFIM) >= cAno+cMes
			If !empty(SR8->R8_SITUAC)
				AAdd(aDatasSR8, {SR8->R8_SITUAC, SR8->R8_DATAINI, SR8->R8_DATAFIM, Space(01), SR8->R8_TIPOAFA, SR8->R8_DURACAO })
			EndIf	
		EndIf
		
		DbSkip()            	     
	EndDo  
                         
	RestArea(aArea)
       
	If Len(aDatasSR8) > 0  
		
		If Type("aRCMData") <>"U" .AND. Len(aRCMData) > 0 
			For nX := 1 to Len(aDatasSR8)			
  				If ( ( nPosRCM := aScan( aRCMData, { |x| x[nPosRCMTip] == aDatasSR8[nX,05] .and. x[nPosRCMSic] == '1' .and. x[nPosRCMFil] == xFilial("RCM") } ) ) > 0 )			
					If nPosRCM > 0             
						//ausencia come็ou no primeiro dia do m๊s e termina no ๚ltimo dia do m๊s 
						If aDatasSR8[nX,02] == cTod("01/"+cMes+"/"+cAno) .AND. AnoMes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) == (f_UltDia(cTod("01/"+cMes+"/"+cAno))) 
							nDdesC += f_UltDia(cTod("01/"+cMes+"/"+cAno))							
							//adiciona quantidades de dias para descontar dos dias trabalhados
							aAdd(aQtdAus, {nDdesC})  		    
                          
						ElseIf aDatasSR8[nX,02] == cTod("01/"+cMes+"/"+cAno) .AND. AnoMes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) < (f_UltDia(cTod("01/"+cMes+"/"+cAno)))//ausencia come็a depois do primeiro dia do m๊s e termina antes do ๚ltimo dia do m๊s 
						    nDdesc += aDatasSR8[nX,06]   
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						ElseIf aDatasSR8[nX,02] == cTod("01/"+cMes+"/"+cAno) .AND. AnoMes(aDatasSR8[nX,03]) > AnoMes(cTod("01/"+cMes+"/"+cAno)) //ausencia come็a no primeiro dia do m๊s e termina depois do ๚ltimo dia do m๊s 						
							nDdesC += f_UltDia(cTod("01/"+cMes+"/"+cAno))							
							aAdd(aQtdAus, {nDdesC}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    						

						ElseIf aDatasSR8[nX,02] > cTod("01/"+cMes+"/"+cAno) .AND. AnoMes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))//ausencia come็a depois do primeiro dia do m๊s e termina no ๚ltimo dia do m๊s 
						    nDdesc += aDatasSR8[nX,06]   
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						Elseif aDatasSR8[nX,02] > cTod("01/"+cMes+"/"+cAno) .AND. AnoMes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) < (f_UltDia(cTod("01/"+cMes+"/"+cAno)))//ausencia come็a depois do primeiro dia do m๊s e termina antes do ๚ltimo dia do m๊s 
						    nDdesc += aDatasSR8[nX,06]   
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						ElseIf aDatasSR8[nX,02] > cTod("01/"+cMes+"/"+cAno) .AND. Anomes(aDatasSR8[nX,03]) > AnoMes(cTod("01/"+cMes+"/"+cAno))//ausencia come็a depois do primeiro dia do m๊s e termina depois do ๚ltimo dia do m๊s  
							nDdesc += DateDiffDay(aDatasSR8[nX,02] , CtoD((StrZero(f_UltDia(cTod("01/"+cMes+"/"+cAno)),2) + "/" + cMes + "/" + cAno ) ))
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						ElseIf aDatasSR8[nX,02] < cTod("01/"+cMes+"/"+cAno) .AND. Anomes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))//ausencia come็a antes do primeiro dia do m๊s e termina no ๚ltimo dia do m๊s 
							nDdesC += f_UltDia(cTod("01/"+cMes+"/"+cAno))
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						Elseif aDatasSR8[nX,02] < cTod("01/"+cMes+"/"+cAno) .AND. Anomes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. Day(aDatasSR8[nX,03]) < (f_UltDia(cTod("01/"+cMes+"/"+cAno)))//ausencia come็a antes do primeiro dia do m๊s e termina antes do ๚ltimo dia do m๊s  
							nDdesc += DateDiffDay(cTod("01/"+cMes+"/"+cAno), aDatasSR8[nX,03] )							
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    

						Elseif aDatasSR8[nX,02] < cTod("01/"+cMes+"/"+cAno) .AND. Anomes(aDatasSR8[nX,03]) == AnoMes(cTod("01/"+cMes+"/"+cAno))//ausencia come็a antes do primeiro dia do m๊s e termina depois do ๚ltimo dia do m๊s  
							nDdesC += f_UltDia(cTod("01/"+cMes+"/"+cAno))
							aAdd(aQtdAus, {nDdesc}) //adiciona quantidades de dias para descontar dos dias trabalhados 		    
						Endif
					Endif  
				Endif	
   			Next
   		Endif 
   		
		If Len(aDatasSR8) <=3    
			
			aSort(aDatasSR8,,,{|aReg1,aReg2| aReg1[2] < aReg2[2]})//Ordena as datas em ordem crescente.	
			
			For nX := 1 to Len(aDatasSR8)
			
				If Empty(aDatasSR8[nX,04]) .And. aDatasSR8[nX,02] == cTod("01/"+cMes+"/"+cAno)
					If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
						cSit1	 := "01"            					//-Situacao do afastamento
						cDiaSit1 := StrZero(Day(dDtIngresso),2)        	//-A partir do dia
					Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
						cSit1	 := "01"            					//-Situacao do afastamento
						cDiaSit1 := StrZero(Day(dDtDespido),2)          	//-A partir do dia
					Else
						cSit1	 := aDatasSR8[nX,01]					//-Situacao do afastamento
						cDiaSit1 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
					
						dBkpDtFim  := aDatasSR8[nX,03]  
						dDtUltAfas := aDatasSR8[nX,03]  
						aDatasSR8[nX,04] := "x"      
					
						If nX == Len(aDatasSR8) .AND. AnoMes(dBkpDtFim) == cAno+cMes
							If (Val(StrZero(Day(aDatasSR8[Len(aDatasSR8),03]),2))) < (f_UltDia(cTod("01/"+cMes+"/"+cAno)))						
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
							    Else
									cSit2	 := '01' //Situacao							
									cDiaSit2 := StrZero(Day(dBkpDtFim)+1,2)
									dDtUltAfas := cDiaSit2   					
								Endif	
							Endif	
						Endif                 
					Endif        
			
				ElseIf Empty(aDatasSR8[nX,04]) .And. aDatasSR8[nX,02] > cTod("01/"+cMes+"/"+cAno)
					If Empty(cDiaSit1)    
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtDespido),2)        	//-A partir do dia
                        Else
							cSit1	 := "01"						 //-Situacao do afastamento
							cDiaSit1 := "01" 						//-A partir do dia         
						Endif	
						If (nX + 1) < (Len(aDatasSR8)) 
							dBkpDtFim := aDatasSR8[(nX+1),02]
							dDtUltAfas := dBkpDtFim
						Endif
						nX := 0
					ElseIf Empty(cDiaSit2) 
						If DateDiffDay(aDatasSR8[nX,02], dBkpDtFim) > 1 .AND. cSit1 != "01" 
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
                   	        	nX := (nX -1)					   																
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
                   	        	nX := (nX -1)					   
						    Else
								cSit2	 := '01' //Situacao
								cDiaSit2 :=	StrZero(Day(dBkpDtFim)+1,2) 
								dDtUltAfas := dBkpDtFim 
                   	        	nX := (nX -1)					   
                   	        Endif
						Else
							If AnoMes(aDatasSR8[Len(aDatasSR8),02]) == cAno+cMes     //Ausencia dentro del mismo mes
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] .AND. cSit1 != "01"
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtIngresso),2)        	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno))) .AND. cSit1 != "01"
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
							    Else							
									cSit2	 := aDatasSR8[nX,01]					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
								Endif	
							ElseIf AnoMes(aDatasSR8[nX,02]) == cAno+cMes 
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
							    Else							
									cSit2	 := aDatasSR8[nX,01]					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
								Endif	
							Endif	
						Endif                                                       
					ElseIf Empty(cDiaSit3) .AND. Day(dBkpDtFim) < (f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							If AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02] .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno))) .AND. cSit2 != "01"
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)       	//-A partir do dia
							Elseif AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 	
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
						    Else					
								cSit3	 := aDatasSR8[nX,01]  //Situacao
								cDiaSit3 :=	StrZero(Day(aDatasSR8[nX,02]),2) 
								dDtUltAfas := dBkpDtFim
							Endif	
					ElseIf Empty(cDiaSit3) .and. (nX = Len(aDatasSR8))
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] .AND. cSit2 != "01"
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno))) .AND. cSit2 != "01"
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
						Else								
							cSit3	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif	
						
						If cSit2 == cSit1 
						   cSit2 := cSit3
						   cDiaSit2 := cDiaSit3
						   cSit3 := Space(02)
						   cDiaSit3 := Space(02)
						Endif
					EndIf
				    
					If nX > 0 
						dBkpDtFim := aDatasSR8[nX,03]
						aDatasSR8[nX,04] := "x"
						dDtUltAfas := dBkpDtFim
					Endif	
				    
					If nX = Len(aDatasSR8) .And. AnoMes(aDatasSR8[nX,03]) == cAno+cMes
						If AnoMes(aDatasSR8[Len(aDatasSR8),03]) == cAno+cMes //Verifica se o m๊s e ano do termino do afastamento e igual ao Ano e mes de processamento
							If (Val(StrZero(Day(aDatasSR8[Len(aDatasSR8),03]),2))) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))  // Caso o final do afastamento seja o ultimo dia do mes considera 
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02]  .and. AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)        	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)         	//-A partir do dia
						   		Else							
									cSit3	 := aDatasSR8[Len(aDatasSR8),01]		//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),02]),2) 	//-A partir do dia
								Endif	
							Else //Caso o afastamento termine antes do final do mes considera a situacao como ativo(01)
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] .And. !Empty(dDtDespido)
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno))) .And. !Empty(dDtDespido)
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)        	//-A partir do dia
							    Else										    	
									If  (cSit3 != aDatasSR8[nX,01])
										If  Len(aDatasSR8) == 1   //Solo una ausencia y termina en el mes
											cSit3	 := '01' //Situacao
											cDiaSit3 :=	StrZero(Day(dBkpDtFim)+1,2) //A partir de la fecha fin (ausencia) + 1 dํa
										Else
											cSit3	 := aDatasSR8[nX,01]   //-Situacao do afastamento 
											cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),02]),2)  //-A partir do dia  
										Endif 
									Endif
								Endif
							Endif	
						Elseif AnoMes(aDatasSR8[Len(aDatasSR8),03]) != cAno+cMes //Caso o termino do afastamento seja maior que o m๊s vigente serแ considerado o inicio do afastamento e a situacao do afastamento
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)        	//-A partir do dia
						    Else						
								cSit3	 := aDatasSR8[Len(aDatasSR8),01]		         //-Situacao do afastamento
								cDiaSit3 := (f_UltDia(cTod("01/"+cMes+"/"+cAno))) //-Considera o ultimo dia do mes
							Endif	
						Endif	    
					EndIf
				
				ElseIf Empty(aDatasSR8[nX,04]) .And. AnoMes(aDatasSR8[nX,02]) > AnoMes(cTod("01/"+cMes+"/"+cAno))
					If Empty(cDiaSit1)
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtIngresso),2)       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else
							cSit1	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif	
					ElseIf Empty(cDiaSit2)
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit2	 := "01"            					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit2	 := "01"            					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else					
							cSit2	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif				
					ElseIf Empty(cDiaSit3) .and. (nX = Len(aDatasSR8))
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else										
							cSit3	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif	
					EndIf
				
					If nX > 0
						dBkpDtFim := aDatasSR8[nX,03]
						aDatasSR8[nX,04] := "x"
						dDtUltAfas := dBkpDtFim
					Endif	
				
					If nX = Len(aDatasSR8) .And. AnoMes(aDatasSR8[nX,03]) == cAno+cMes
						If AnoMes(aDatasSR8[Len(aDatasSR8),03]) == cAno+cMes //Verifica se o m๊s e ano do termino do afastamento e igual ao Ano e mes de processamento
							If (Val(StrZero(Day(aDatasSR8[Len(aDatasSR8),03]),2))) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))  // Caso o final do afastamento seja o ultimo dia do mes considera 
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else												
									cSit3	 := aDatasSR8[Len(aDatasSR8),01]		//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),02]),2) 	//-A partir do dia
								Endif
							Else //Caso o afastamento termine antes do final do mes considera a situacao como ativo(01)
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else												
									cSit3	 := "01"				//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(aDatasSR8[nX,03])+1,2) //-A partir do ultimo dia do afastamento mais um dia 
								Endif	
							Endif
						Elseif AnoMes(aDatasSR8[Len(aDatasSR8),03]) != cAno+cMes //Caso o termino do afastamento seja maior que o m๊s vigente serแ considerado o inicio do afastamento e a situacao do afastamento
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else						
								cSit3	 := aDatasSR8[Len(aDatasSR8),01]		         //-Situacao do afastamento
								cDiaSit3 := (f_UltDia(cTod("01/"+cMes+"/"+cAno))) //-Considera o ultimo dia do mes
							Endif	
						Endif	
					EndIf
				ElseIf Empty(aDatasSR8[nX,04]) .And. AnoMes(aDatasSR8[nX,02]) < AnoMes(cTod("01/"+cMes+"/"+cAno))
					If Empty(cDiaSit1)
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit1	 := "01"            					//-Situacao do afastamento
							cDiaSit1 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else					
							cSit1	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit1 := "01" //StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif	
					ElseIf Empty(cDiaSit2)
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit2	 := "01"            					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit2	 := "01"            					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else										
							cSit2	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit2 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif
					ElseIf Empty(cDiaSit3) .and. (nX = Len(aDatasSR8))
						If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
							cSit3	 := "01"            					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
						Else										
							cSit3	 := aDatasSR8[nX,01]					//-Situacao do afastamento
							cDiaSit3 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
						Endif	
					EndIf
					If nX > 0
						dBkpDtFim := aDatasSR8[nX,03]
						aDatasSR8[nX,04] := "x"
						dDtUltAfas := dBkpDtFim
					Endif	
				
					If nX = Len(aDatasSR8) .And. AnoMes(aDatasSR8[nX,03]) == cAno+cMes
						If AnoMes(aDatasSR8[Len(aDatasSR8),03]) == cAno+cMes //Verifica se o m๊s e ano do termino do afastamento e igual ao Ano e mes de processamento
							If (Val(StrZero(Day(aDatasSR8[Len(aDatasSR8),03]),2))) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))  // Caso o final do afastamento seja o ultimo dia do mes considera 
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else									
									cSit3	 := aDatasSR8[Len(aDatasSR8),01]		//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),02]),2) 	//-A partir do dia
								Endif	
							ElseIf Empty(cDiaSit2) //Caso o afastamento termine antes do final do mes considera a situacao como ativo(01)
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit2	 := "01"            					//-Situacao do afastamento
									cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else							
									cSit2	 := "01"				//-Situacao do afastamento
					 				cDiaSit2 := StrZero(Day(aDatasSR8[nX,03])+1,2) //-A partir do ultimo dia do afastamento mais um dia 
					 			Endif	
							Else //Caso o afastamento termine antes do final do mes considera a situacao como ativo(01)
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else							
									cSit3	 := "01"				//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(aDatasSR8[nX,03])+1,2) //-A partir do ultimo dia do afastamento mais um dia 
								Endif	
							Endif
						Elseif AnoMes(aDatasSR8[Len(aDatasSR8),03]) != cAno+cMes //Caso o termino do afastamento seja maior que o m๊s vigente serแ considerado o inicio do afastamento e a situacao do afastamento
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else
								cSit3	 := aDatasSR8[Len(aDatasSR8),01]		         //-Situacao do afastamento
								cDiaSit3 := (f_UltDia(cTod("01/"+cMes+"/"+cAno))) //-Considera o ultimo dia do mes
							Endif	
						Endif	
					EndIf
				EndIf
				Next nX
			Else //Caso tenha mais de 3 afastamentos no mes serao considerados o primeiro o segundo e o ultimo.
				For nX := 1 to Len(aDatasSR8)
					If Empty(aDatasSR8[nX,04]) .And. aDatasSR8[nX,02] > cTod("01/"+cMes+"/"+cAno)
						If Empty(cDiaSit1)
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								nX := 0
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else						
								cSit1	 := "01"						 //-Situacao do afastamento
								cDiaSit1 := "01" 						//-A partir do dia
								nX := 0
							Endif	
						ElseIf Empty(cDiaSit2) 
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
								nX := 0
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else						
								cSit2	 := aDatasSR8[nx,01]					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(aDatasSR8[nx,02]),2) 	//-A partir do dia
								nX := 0
							Endif
						ElseIf Empty(cDiaSit3)
							If AnoMes(aDatasSR8[Len(aDatasSR8),03]) == cAno+cMes //Verifica se o m๊s e ano do termino do afastamento e igual ao Ano e mes de processamento
								If (Val(StrZero(Day(aDatasSR8[Len(aDatasSR8),03]),2))) == (f_UltDia(cTod("01/"+cMes+"/"+cAno)))  // Caso o final do afastamento seja o ultimo dia do mes considera 
									If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
										cSit3	 := "01"            					//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
									Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
										cSit3	 := "01"            					//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
									Else														
										cSit3	 := aDatasSR8[Len(aDatasSR8),01]		//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),02]),2) 	//-A partir do dia
									Endif
								Else //Caso o afastamento termine antes do final do mes considera a situacao como ativo(01)
									If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
										cSit3	 := "01"            					//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
									Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
										cSit3	 := "01"            					//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
									Else																						
										cSit3	 := "01"				//-Situacao do afastamento
										cDiaSit3 := StrZero(Day(aDatasSR8[Len(aDatasSR8),03])+1,2) //-A partir do ultimo dia do afastamento mais um dia 
									Endif	
								Endif
							Elseif AnoMes(aDatasSR8[Len(aDatasSR8),03]) != cAno+cMes //Caso o termino do afastamento seja maior que o m๊s vigente serแ considerado o inicio do afastamento e a situacao do afastamento
								If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
									cSit3	 := "01"            					//-Situacao do afastamento
									cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
								Else																					
									cSit3	 := aDatasSR8[Len(aDatasSR8),01]		         //-Situacao do afastamento
									cDiaSit3 := StrZero(f_UltDia(cTod("01/"+cMes+"/"+cAno)),2) //-Considera o ultimo dia do mes
								Endif	
							Endif	
						EndIf
					    
						If nX > 0
							dBkpDtFim := aDatasSR8[nX,03]
							aDatasSR8[nX,04] := "x"
							dDtUltAfas := dBkpDtFim
						Endif	
					
					ElseIf Empty(aDatasSR8[nX,04]) .And. aDatasSR8[nX,02] == cTod("01/"+cMes+"/"+cAno)
						If Empty(cDiaSit1)
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit1	 := "01"            					//-Situacao do afastamento
								cDiaSit1 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit1	 := "01"            					//-Situacao do afastamento
								cDiaSit1 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else																				
								cSit1	 := aDatasSR8[nX,01]			       //-Situacao do afastamento
								cDiaSit1 := StrZero(Day(aDatasSR8[nX,02]),2)  //-A partir do dia
							Endif
						ElseIf Empty(cDiaSit2)
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit2	 := "01"            					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else						
								cSit2	 := aDatasSR8[nX,01]					//-Situacao do afastamento
								cDiaSit2 := StrZero(Day(aDatasSR8[nX,02]),2) 	//-A partir do dia
							Endif	
						ElseIf Empty(cDiaSit3) 
							If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
								cSit3	 := "01"            					//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
							Else						
								cSit3	 := aDatasSR8[Len(aDatasSR8),01]		//-Situacao do afastamento
								cDiaSit3 := StrZero(Day(aDatasSR8[nX,02])+1,2) 	//-A partir do dia
							Endif	
						EndIf
				
						If nX > 0
							dBkpDtFim := aDatasSR8[nX,03]
							aDatasSR8[nX,04] := "x"
							dDtUltAfas := dBkpDtFim
						Endif	
					Endif
		    	Next nX
			Endif	
	Else		
		If Len(aDatasSR8) > 0
			If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtIngresso < aDatasSR8[nX,02] 
				cSit1	 := "01"            					//-Situacao do afastamento
				cDiaSit1 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
			Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (dDtDespido < aDatasSR8[nX,02]  .OR. Day(dDtDespido) < f_UltDia(cTod("01/"+cMes+"/"+cAno)))
				cSit1	 := "01"            					//-Situacao do afastamento
				cDiaSit1 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
			Else	
				cSit1	 := "01"	//-Situacao do afastamento (Ativo)
				cDiaSit1 := "01"	//-A partir do dia
			Endif	
		Else
			If Empty(cDiaSit1) 
				If AnoMes(dDtIngresso) == AnoMes(cTod("01/"+cMes+"/"+cAno))
					cSit1	 := "01"            					//-Situacao do afastamento
					cDiaSit1 := StrZero(Day(dDtIngresso),2)                       	//-A partir do dia
				Elseif 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtDespido > cTod("01/"+cMes+"/"+cAno)  
					cSit1	 := "01" 								//-Situacao do afastamento
					cDiaSit1 := "01"                       			//-A partir do dia
				Elseif AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtDespido == cTod("01/"+cMes+"/"+cAno)	
					cSit1	 := "01"	//-Situacao do afastamento (Despedido)
					cDiaSit1 := "01"	//-A partir do dia
				Else
					cSit1	 := "01"            			//-Situacao do afastamento
					cDiaSit1 := "01"                       	//-A partir do dia
				Endif
			ElseIf Empty(cDiaSit2) .AND. cSit1 <> "06"
				If 	AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. dDtDespido > cTod("01/"+cMes+"/"+cAno)  
					cSit2	 := "01" 								//-Situacao do afastamento
					cDiaSit2 := StrZero(Day(dDtDespido),2)                 			//-A partir do dia      
				Endif	
			Endif		
		Endif	
		
		If cSitRev == "1" 
			cSit := "01"
		Else
			cSit := Space(02)
			
			cSit1 := Space(02)
			cSit2 := Space(02)
			cSit3 := Space(02)
			
			cDiaSit1 := Space(02)
			cDiaSit2 := Space(02)
			cDiaSit3 := Space(02)
		Endif
	Endif
EndIf

If cSit3 == cSit2 .AND. cDiaSit3 == cDiaSit2
	cSit3 := Space(02)
	cDiaSit3 := Space(02)	
ElseIf cSit2 == cSit1 .AND. cDiaSit2 == cDiaSit1	
	cSit2 := Space(02)                               
	cDiaSit2 := Space(02)
Endif

If cSitRev == "1"  .AND. Empty(cDiaSit1) .AND. AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (Day(dDtDespido) <= f_UltDia(cTod("01/"+cMes+"/"+cAno))) 
	cSit1	 := "01            					//-Situacao do afastamento
	cDiaSit1 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
ElseIf  cSitRev == "2" .AND. !Empty(cDiaSit1) .AND. Empty(cDiaSit2) .AND. AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (Day(dDtDespido) <= f_UltDia(cTod("01/"+cMes+"/"+cAno)))
	cSit2	 := "01"           					//-Situacao do afastamento
	cDiaSit2 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
ElseIf   cSitRev == "3" .AND. !Empty(cDiaSit2) .AND. Empty(cDiaSit3) .AND. AnoMes(dDtDespido) == AnoMes(cTod("01/"+cMes+"/"+cAno)) .AND. (Day(dDtDespido) <= f_UltDia(cTod("01/"+cMes+"/"+cAno))) 
	cSit3	 := "01"           					//-Situacao do afastamento
	cDiaSit3 := StrZero(Day(dDtDespido),2)                       	//-A partir do dia
Endif

If cSit3 == cSit2  
	cSit3 := Space(02)
	cDiaSit3 := Space(02)	
ElseIf cSit2 == cSit1 
	cSit2 := Space(02)                               
	cDiaSit2 := Space(02)
Endif   

If cSitRev == "1"
	If cSituac == "S"
		cSit := cSit1
	Else
		cSit := cDiaSit1
	EndIf

ElseIf cSitRev == "2"
	If cSituac == "S"
		cSit := cSit2
	Else
		cSit := cDiaSit2
	EndIf

ElseIf cSitRev == "3"
	If cSituac == "S"		
		cSit := cSit3
	Else
		cSit := cDiaSit3
	EndIf
	
 	If cSit3 == cSit2 .AND. cDiaSit3 == cDiaSit2                    
		cSit := Space(02) 		
 	Endif
	
EndIf

RestArea(aArea)

Return cSit 



/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณfTrabCon   ณ Autor ณ Alceu Pereira        ณ Data ณ 27/11/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณVerifica se o campo RA_PASSMED esta preenchido caso esteja, ณฑฑ
ฑฑณ			 ณretorna o conteudo deste campo na variavel cConv            ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ U_fTrabCon()       										  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 												  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function fTrabCon()

Local aArea			:= GetArea()      
Local cConv			:= "0"

If !Empty(SRA->RA_DPASSME)
	cConv := SRA->RA_DPASSME
Endif

RestArea(aArea)

Return cConv

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณFPERCASS   ณ Autor ณ Alceu Pereira        ณ Data ณ 27/11/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณRetorna conteudo do campo RA_PERASS.                        ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ U_FPERCASS()												  ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 												  ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
User Function FPERCASS()
      
Local aArea		:= GetArea()
Local cPerc		:= TRANSFORM(0,"@E 99.99")

If !Empty(SRA->RA_PERAASS) .AND. (SRA->RA_PERAASS<>0)
	cPerc := TRANSFORM(SRA->RA_PERAASS,"@E 99.99")
Endif

RestArea(aArea)

Return cPerc


/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณLimpiaStaticณ Autor ณ Alceu Pereira        ณ Data ณ 27/11/09 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณLimpa a ultima linha do arquivo gerado.                      ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ LimpiaStatic()											   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ Generico 											  	   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/
Static Function LimpiaStatic()
	aRemune		:=	Nil
	aDatasSR8	:=	Nil
Return 

/*/
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o	 ณfLoadRCM	  ณ Autor ณ Equipe RH  		     ณ Data ณ14/03/2011ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณCarrega os dados da tabela RCM - Tipos de Ausencia           ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณSintaxe	 ณ <Vide Parametros Formais>								   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso		 ณ GPER801	  											  	   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿
/*/

Static Function fLoadRCM( aData, aFields )

Local nCont		:= 0

Local cCpos		:= ""
Local cAliasRCM	:= "RCM"

Local aArea		:= GetArea()

aFields := 	(cAliasRCM)->(dbStruct())

For nCont := 1 To Len(aFields)

	If ( aFields[nCont,01] == "RCM_FILIAL" )
		nPosRCMFil := nCont
	ElseIf ( aFields[nCont,01] == "RCM_TIPO" )
		nPosRCMTip := nCont
	ElseIf ( aFields[nCont,01] == "RCM_PD" )
		nPosRCMPd := nCont
	ElseIf ( aFields[nCont,01] == "RCM_DDTSIC" )
		nPosRCMSic := nCont	
	EndIf
	
	If (nCont > 1)
		cCpos += " , " + aFields[ nCont, 01 ]
	Else
		cCpos += aFields[ nCont, 01 ]
	EndIf	
Next
cCpos := "%"+cCpos+"%"

#IFDEF TOP

	cAliasRCM := GetNextAlias()
	
	BeginSql Alias cAliasRCM
		%NoParser%
		SELECT 
			%Exp:cCpos%
		FROM 
			%Table:RCM% RCM
		WHERE
			RCM.%NotDel%
		ORDER BY 
			%Order:RCM%
	EndSql
	
#ELSE    

	/*/
	ฺฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฟ
	ณ Seleciona a area de trabalho								  ณ
	ภฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤู/*/
	dbSelectArea(cAliasRCM)
	(cAliasRCM)->(dbSetOrder(RetOrder( "RCM" , "RCM_FILIAL+RCM_TIPO" )))
	(cAliasRCM)->(dbGoTop())

#ENDIF

//Adiciona todos os tipos de Ausencia ao Array
While (cAliasRCM)->(!Eof())
	aAdd( aData, {} )
	For nCont := 1 To Len(aFields)
		aAdd( aData[Len(aData)], (cAliasRCM)->&(aFields[ nCont, 01 ]) )
	Next
	(cAliasRCM)->(dbSkip())
EndDo

RestArea(aArea)

Return (Nil)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
ฑฑฺฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤยฤฤฤฤฤฤยฤฤฤฤฤฤฤฤฤฤฤฤฟฑฑ
ฑฑณFun…o    ณTSICOSS		ณ Autor ณ  Equipe RH	           ณ Data ณ 16/02/2012 ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณDescri…o ณRealiza Totaliza็ใo das Verbas pela tabela SRC					   ณฑฑ
ฑฑณ			 ณNใo serแ inclusas verbas de roteiros do tipo '4' (SRY->RY_TIPO)	   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ 
ฑฑณParametro ณExpC1 - Qual ้ o tipo de verba que serแ totalizada ("H" ou "V")	   ณฑฑ
ฑฑณ			 ณExpC2 - Verba que sera filtrada e totalizada						   ณฑฑ
ฑฑรฤฤฤฤฤฤฤฤฤฤลฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤดฑฑ
ฑฑณ Uso      ณGPER801															   ณฑฑ
ฑฑภฤฤฤฤฤฤฤฤฤฤมฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤฤูฑฑ
ฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑฑ
฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿฿*/

Static Function TSICOSS(cTipo,cVerba)

Local aArea			:=	GetArea()
Local nResult		:= 0  
Local nX			:= 0 
Local nRetorno		:= 0
DEFAULT cTipo		:= NIL
DEFAULT cVerba		:= NIL

If (len(aVerbasFunc)>0) .AND. !empty(cVerba) .AND. !empty(cTipo) .AND. cTipo $ ("VH")
	For nX := 1 to Len(aVerbasFunc)
		nRetorno	:= aScan(aRoteiros,{|x|x[1]==aVerbasFunc[nX,11]})
		If aVerbasFunc[nX,3] == cVerba .and. nRetorno > 0
			If cTipo == "V"
				nResult +=  aVerbasFunc[nX,7]
			Else	
				nResult +=  aVerbasFunc[nX,6]
			Endif
	 	Endif
	Next nX                                      
EndIf

RestArea(aArea)
                                              
Return(nResult)
static function getCampos()
	If Len(aCampos) == 0
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_PROCES" , "X3_TITSPA")))
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_PER" , "X3_TITSPA")))
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_NUMPAG" , "X3_TITSPA")))
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_DTINI" , "X3_TITSPA")))
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_DTFIM" , "X3_TITSPA")))
		AADD(aCampos,AllTrim(POSICIONE("SX3", 2, "RCH_DTPAGO" , "X3_TITSPA")))
	EndIf
Return

/*Obtener procesos de nomina*/
User Function ObtPeriodos()
		
	//Private cAlias    := CriaTrab(Nil, .F.)
	Local lCheck := .T.    // Usando New
	Local aSvKeys := GetKeys()
	Local oBrowse
	Local oOk       := LoadBitmap( GetResources(), "LBOK")
	Local oNo       := LoadBitmap( GetResources(), "LBNO") 
	Local bSetF4 := {|| MarcaTodos(oBrowse,@aPerTodosC)}
	Local bSetF5 := {|| DesMarcaTodos(oBrowse,@aPerTodosC)}
	Local bSetF6 := {|| InvSel(oBrowse,@aPerTodosC)}
	
	aPerTds() 
   	If Len(aPerTodosC)<> 0       
   		 
   		getCampos()      
	    DEFINE DIALOG oDlg TITLE "Seleccion de Periodos" FROM 180,180 TO 525,650 PIXEL
	    oBrowse := TCBrowse():New( 01 , 01, 235, 136,,;
	                              {'',aCampos[1],aCampos[2],aCampos[3],aCampos[4],aCampos[5],aCampos[6]},{30,36,37,36,36,36,36},;//{40,30,30,30,30,30,30}
	                              oDlg,,,,,{||},,,,,,,.F.,,.T.,,.F.,,, )
	    
	                                                      
	    oBrowse:SetArray(aPerTodosC) 

		
		oBrowse:bLine      := {|| {IIf(aPerTodosC[oBrowse:nAt][1],oOk ,oNo ),;      //
                                aPerTodosC[oBrowse:nAt][9],;
                                aPerTodosC[oBrowse:nAt][3],;
                                aPerTodosC[oBrowse:nAt][4],;
                                aPerTodosC[oBrowse:nAt][7],;
                                aPerTodosC[oBrowse:nAt][8],;
                                aPerTodosC[oBrowse:nAt][11]}}
	   
	    oBrowse:bLDblClick   := {|| aPerTodosC[oBrowse:nAt][1] := !aPerTodosC[oBrowse:nAt][1], oBrowse:Refresh() }                                
	    
	    TButton():New( 146, 05, "Marca Todos - <F4>", oDlg,{|| Eval(bSetF4) },65,010,,,.F.,.T.,.F.,,.F.,,,.F.)
	    TButton():New( 160, 05, "Desmarca Todos - <F5>", oDlg,{||  Eval(bSetF5)},65,010,,,.F.,.T.,.F.,,.F.,,,.F.)
	    TButton():New( 146, 75, "Invierte Selecci๓n - <F6>", oDlg,{|| Eval(bSetF6) },65,010,,,.F.,.T.,.F.,,.F.,,,.F.)
       TButton():New( 160, 168, "Cancelar", oDlg,{|| aPerTodosC := {}, aPerTodos := {}, oDlg:End() },65,010,,,.F.,.T.,.F.,,.F.,,,.F.)
	    TButton():New( 146, 168, 'Confirmar', oDlg,{|| Elimina(),oDlg:End() },65, 010,,,.F.,.T.,.F.,,.F.,,,.F. )
	   TSay():New(138,05,{||'Seleccione los periodos a ser considerados'},oDlg,,,,,,.T.,CLR_RED,CLR_WHITE,200,20)
	   
	  ACTIVATE DIALOG oDlg CENTERED 
  /*Else
  		Alert(OemToAnsi("No hay datos para el periodo seleccionado"))*/
  	EndIf
  RestKeys( aSvKeys , .T. )
Return

static function aPerTds()
	Local nX := 0

	If aPerTodosC # Nil
		aPerTodosC := {}
		
		If Len(aPerAbe) > 0
			For nX := 1 To Len( aPerAbe )
				IF Len( aPerAbe[nX] ) < 10
					AADD( aPerTodosC, {.T., .T. , aPerAbe[nX][1], aPerAbe[nX][2], aPerAbe[nX][3], aPerAbe[nX][4], aPerAbe[nX][5], aPerAbe[nX][6], aPerAbe[nX][7], aPerAbe[nX][8], aPerAbe[nX][9]} )
				Else
					AADD( aPerTodosC, {.T., .T. , aPerAbe[nX][1], aPerAbe[nX][2], aPerAbe[nX][3], aPerAbe[nX][4], aPerAbe[nX][5], aPerAbe[nX][6], aPerAbe[nX][7], aPerAbe[nX][8], aPerAbe[nX][9], aPerAbe[nX][10]} )
				EndIf
			Next nX
		EndIf
		
		If Len(aPerFec) > 0
			For nX := 1 To Len( aPerFec )
				IF Len( aPerFec[nX] ) < 10
					AADD( aPerTodosC, {.T., .F. , aPerFec[nX][1], aPerFec[nX][2], aPerFec[nX][3], aPerFec[nX][4], aPerFec[nX][5], aPerFec[nX][6], aPerFec[nX][7], aPerFec[nX][8], aPerFec[nX][9]} )
				Else
					AADD( aPerTodosC, {.T., .F. , aPerFec[nX][1], aPerFec[nX][2], aPerFec[nX][3], aPerFec[nX][4], aPerFec[nX][5], aPerFec[nX][6], aPerFec[nX][7], aPerFec[nX][8], aPerFec[nX][9], aPerFec[nX][10]} ) 
				EndIf
			Next nX
		EndIf
		
	EndIf
	
Return


static function Elimina()
	Local nI := 0
	Local nCnt := 0

	For nI :=1 to len(aPerTodosC)
	
		If !aPerTodosC[nI][1]
			If aPerTodosC[nI][2]
				ADEL(aPerAbe,ComparaArregglo(aPerAbe, aPerTodosC[nI]))
				ASIZE(aPerAbe,Len(aPerAbe) - 1)	
			Else
				ADEL(aPerFec,ComparaArregglo(aPerFec, aPerTodosC[nI]))
				ASIZE(aPerFec,Len(aPerFec) - 1)	
			EndIf
		EndIf
		
	Next 
	
	If Len(aPerAbe) > 0 .And. Len(aPerFec) > 0
			aPerTodos := ACLONE(aPerAbe)
			For nCnt := 1 To Len( aPerFec )
				If Ascan( aPerTodos, { |x| x[1] == aPerFec[nCnt,1] } ) == 0
					AADD( aPerTodos, ACLONE(aPerFec[nCnt]) )
				EndIf
			Next nCnt
		ElseIf Len(aPerAbe) > 0
			aPerTodos := ACLONE( aPerAbe )
		ElseIf Len(aPerFec) > 0
			aPerTodos := ACLONE( aPerFec )
		EndIf
	
Return

static function ComparaArregglo(aOriginal, aCopia)
Local lRet := .T.
Local nI := 0
Local nX := 0

	While lRet
		nI += 1 
		For nX := 3 to Len(aCopia) 
			If aOriginal[nI][nX-2] <> aCopia[nX] 
				Exit
			EndIf
			If nX == Len(aCopia)
				lRet := .F.	
			EndIf
		Next
	Enddo			

Return nI

Static Function MarcaTodos(oListBox,aListBox)
Local nI := 0

	For nI :=1 to len(aListBox)
		aListBox[nI][1] := .T.
	Next 
	oListBox:nColPos := 1
	oListBox:Refresh()

Return  	

Static Function DesMarcaTodos(oListBox,aListBox)
Local nI := 0

	For nI :=1 to len(aListBox)
		aListBox[nI][1] := .F.
	Next 
	oListBox:nColPos := 1
	oListBox:Refresh()

Return  	


Static Function InvSel(oListBox,aListBox)
Local nI := 0

	For nI :=1 to len(aListBox)
			aListBox[nI][1] := !aListBox[nI][1]
	Next 
	oListBox:nColPos := 1
	oListBox:Refresh()

Return
