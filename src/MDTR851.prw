/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

#Include "Protheus.ch"

//-------------------------------------------------------------------
/*/{Protheus.doc} MDTR851
Chama o PPRA, pois os documentos possuem o mesmo conteúdo.
@type function

@author	Gabriel Sokacheski
@since 26/07/2021

/*/
//-------------------------------------------------------------------
User Function MDTR851()

    SetKey( VK_F9, { | | NGVersao( "MDTR851" , 1 ) } )
    Private nTipoDoc := 2 //Indica que o documento é o PGR

    MDTREL850()

Return
