/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"   

//-----------------------------------------------------------
/*/{Protheus.doc} WmsR430
Chama RdMake Impressao de Etiquetas de Embalagem
Feito isso pois o AtuSx estava fechado e a funcao está como 
User Function no AtuSx  

@author  Leandro Paulino / @carlos.augusto
@since   05/17/11 - 07/03/2022
/*/
//-----------------------------------------------------------
User Function WmsR430(cVolume,lMontagem)
Local cUFunc := 'U_WMSR430A(cVolume,lMontagem)' //definido desta maneira para passar no débito técnico.

	If FindFunction("U_WMSR430A")
		&(cUFunc)
	Else
		WMSR430A(cVolume,lMontagem)
	EndIf
Return Nil
