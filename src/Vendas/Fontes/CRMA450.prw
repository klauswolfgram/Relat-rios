/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#INCLUDE "PROTHEUS.CH"
#INCLUDE "CRMA450.CH"

 //------------------------------------------------------------------------------
/*/{Protheus.doc} CRMA450

Rotina que faz a chamada para o relatorio de oportunidades X processos de venda  

@sample	U_CRMA450()

@return	Nenhum

@author	Thiago Tavares
@since		10/04/2014
@version	P12
/*/
//------------------------------------------------------------------------------
User Function CRMA450()

ProcRegua( 0 ) 
IncProc( STR0001 )	// "Só um momento, localizando as oportunidades e os processos de venda..." 

FATR060( .T. )     // Relatorio de Oportunidades x Processos de Venda

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

Private aRotina := FWLoadMenuDef( "FATR060" )

Return( aRotina )
