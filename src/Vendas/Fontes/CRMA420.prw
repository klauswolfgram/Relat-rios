/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "CRMA420.CH"

 //------------------------------------------------------------------------------
/*/{Protheus.doc} CRMA420

Rotina que faz a chamada para o relatorio de oportunidades

@sample	U_CRMA420()

@return	Nenhum

@author	Thiago Tavares
@since		10/04/2014
@version	P12
/*/
//------------------------------------------------------------------------------
User Function CRMA420()

ProcRegua( 0 ) 
IncProc( STR0001 )	// "Só um momento, localizando as oportunidades..." 

FATR010( .T. )		// Relatorio de Oportunidades

Return Nil



//------------------------------------------------------------------------------
/*/{Protheus.doc} MenuDef()

MenuDef - Operações que serão utilizadas pela aplicação

@return   	aRotina - Array das operações

@author		Vendas CRM
@since		15/05/2015
@version	12
/*/
//------------------------------------------------------------------------------
Static Function MenuDef()

Private aRotina := FWLoadMenuDef( "FATR010" )

Return( aRotina )
