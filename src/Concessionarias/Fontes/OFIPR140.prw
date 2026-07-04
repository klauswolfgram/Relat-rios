/*
Me siga no youtube: youtube.com/@KlausWolfgram
Aprenda sobre Protheus, entre outras tecnologias, de forma prática e de fácil entendimento acessando esse catalogo de cursos na udemy: https://www.udemy.com/user/klaus-wolfgram/
*/

// ÉÍÍÍÍÍÍÍÍËÍÍÍÍÍÍÍÍ»
// º Versao º 13     º
// ÈÍÍÍÍÍÍÍÍÊÍÍÍÍÍÍÍÍ¼

#INCLUDE "OFIPR140.ch"
#include "protheus.ch"

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Funcao    ³ OFIPR140 ³ Autor ³ Thiago                ³ Data ³ 08/03/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Pecas sem Movimento de ENTRADA e SAIDA                     ³±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFIPR140
   Private aVetCampos := {}
   Private aReturn    := {STR0002, 1, STR0003, 2, 2, 1, "", 1} // Zebrado / Administracao
   Private cPerg      := "OFP140"
   Private cTitulo    := STR0001 // Inventario Diario

   // Mesmo passando a pergunte para o TReport
   // preciso carregar para as MV_PAR existirem
   PERGUNTE(cPerg, .F.)
   U_OFPR140R3()
Return

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ OFPR140R3³ Autor ³  Thiago        ³ Data ³ 21/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Pecas sem Movimento de ENTRADA e SAIDA              |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
User Function OFPR140R3()
   Local oReport

   oReport := ReportDef() // Nesta função nós definimos a estrutura do relatório, por exemplo as seções, campos, totalizadores e etc.
   oReport:SetPortrait()  // Define orientação de página do relatório como retrato.
   oReport:PrintDialog()  // Essa função serve para disparar a impressão do TReport, ela que faz com que seja exibida a tela de configuração de impressora e os botões de parâmetros.
Return

/*/{Protheus.doc} ReportDef
Criando o padrão para impressão do Inventário Diário
@author Fernando Vitor Cavani
@since 13/01/2020
@version undefined
@type function
/*/
Static Function ReportDef()
   Local cDesc := ""
   Local oReport
   Local oSection1
   Local oSection2

   cTit := ""
   cLoc := cGrp := cCod := cDes := cABC := ""
   nQtd := 0

   // Descrição
   cDesc := STR0013 // Este programa tem como objetivo imprimir o Inventario Diario

   // TReport
   oReport := TReport():New(        ;
      "OFIPR140",                   ;
      cTitulo,                      ;
      cPerg,                        ;
      {|oReport| ImpOSInt(oReport)},;
      cDesc)

   // Título
   oSection1 := TRSection():New(oReport, "oTitulo")

   oSection1:SetLineStyle()    // Define se imprime as células da seção em linhas
   oSection1:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

   TRCell():New(oSection1, "oTit",, "", "@!", 200,, {|| cTit },,,,,,,,, .t.) // Título

   // Dados
   oSection2 := TRSection():New(oReport, "oDados")

   oSection2:SetLinesBefore(1) // Define a quantidade de linhas que serão saltadas antes da impressão da seção

   TRCell():New(oSection2, "oLoc",, STR0014, "@!"           ,  50,, {|| cLoc },,,        ,,,,,,) // Localização
   TRCell():New(oSection2, "oGrp",, STR0015, "@!"           ,   8,, {|| cGrp },,,        ,,,,,,) // Grupo
   TRCell():New(oSection2, "oCod",, STR0016, "@!"           ,  40,, {|| cCod },,,        ,,,,,,) // Código do Item
   TRCell():New(oSection2, "oDes",, STR0017, "@!"           , 100,, {|| cDes },,,        ,,,,,,) // Descrição
   TRCell():New(oSection2, "oABC",, STR0018, "@!"           ,  20,, {|| cABC },,,        ,,,,,,) // Classificação do ABC VENDA e ABC CUSTO
   TRCell():New(oSection2, "oQtd",, STR0019, "@E 999,999.99",  30,, {|| nQtd },,, "RIGHT",,,,,,) // Quantidade Disponível
Return(oReport)

/*
ÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜÜ
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
±±ÚÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÂÄÄÄÄÄÄÂÄÄÄÄÄÄÄÄÄÄ¿±±
±±³Fun‡„o    ³ ImpOSInt ³ Autor ³  Thiago        ³ Data ³ 21/06/02 ³±±
±±ÃÄÄÄÄÄÄÄÄÄÄÅÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄ´±±
±±³Descri‡ao ³ Impressao									                |±±
±±ÀÄÄÄÄÄÄÄÄÄÄÁÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÙ±±
±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±±
ßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßßß
*/
Static Function ImpOSInt(oReport)
   Local oSection1 := oReport:Section(1)
   Local oSection2 := oReport:Section(2)

   Local lSBZ      := (SuperGetMV("MV_ARQPROD", .F., "SB1") == "SBZ")
   Local lLocSoSBZ := (lSBZ .And. GetNewPar("MV_MIL0096", "S") == "N") // A locação da peça também deve ser considerada na tabela SB5 quando o parâmetro MV_ARQPROD estiver configurado com SBZ? (S = Considera / N = Não Considera)
   Local cAl       := ""
   Local cQAlVO2   := "SQLVO2" // sql filtrar VO2
   Local cQAlSBL   := "SQLSBL" // sql filtrar SBL
   Local cQAlSD2   := "SQLSD2" // sql filtrar SD2
   Local cQAlSD1   := "SQLSD1" // sql filtrar SD1
   Local cQuery    := ""
   Local cLOCALI2  := ""
   Local cAbcVend  := ""
   Local cAbcCust  := ""
   Local cAno      := strzero(Year(dDataBase), 4)
   Local cMes      := strzero(Month(dDataBase) - 1, 2)
   Local lImprimir := .f.

   If cMes == "00"
      cAno := strzero(Year(dDataBase) - 1, 4)
      cMes := "12"
   EndIf

   // Cria Arquivo de Trabalho
   aadd(aVetCampos, {"TRB_LOCALI", "C", TamSx3("B5_LOCALI2")[1] , 0                   }) // Endereco DMS
   aadd(aVetCampos, {"TRB_GRUPO" , "C", TamSx3("VO3_GRUITE4")[1], 0                   }) // Grupo do Item
   aadd(aVetCampos, {"TRB_CODIGO", "C", TamSx3("VO3_CODITE")[1] , 0                   }) // Codigo do Item
   aadd(aVetCampos, {"TRB_DESC"  , "C", TamSx3("B1_DESC")[1]    , 0                   }) // Descricao do Item
   aadd(aVetCampos, {"TRB_ABCVEN", "C", TamSx3("BL_ABCVEND")[1] , 0                   }) // Classificacao do ABC VENDA
   aadd(aVetCampos, {"TRB_ABCCUS", "C", TamSx3("BL_ABCCUST")[1] , 0                   }) // Classificacao do ABC CUSTO
   aadd(aVetCampos, {"TRB_DISPON", "N", TamSx3("B2_QATU")[1]    , TamSx3("B2_QATU")[2]}) // Quantidade Disponivel
   aadd(aVetCampos, {"TRB_PECINT", "C", TamSx3("B1_COD")[1]     ,  0                  }) // Codigo Interno da Peca
   aadd(aVetCampos, {"TRB_TIPO"  , "C", 1                       ,  0                  }) // Movimentado / Nao Movimentado

   oObjTempTable := OFDMSTempTable():New()
   oObjTempTable:cAlias     := "TRB"
   oObjTempTable:aVetCampos := aVetCampos
   oObjTempTable:AddIndex(, {"TRB_LOCALI", "TRB_GRUPO", "TRB_CODIGO"})
   oObjTempTable:CreateTable()

   // VO2
   cQuery := " SELECT VO2.VO2_NOSNUM "
   cQuery += " FROM " + RetSqlName("VO2") + " VO2 "
   cQuery += " WHERE VO2.VO2_FILIAL = '" + xFilial("VO2") + "' "

   If !Empty(MV_PAR01)
      cQuery += "   AND VO2.VO2_DATREQ >= '" + dtos(MV_PAR01) + "' "
   EndIf

   If !Empty(MV_PAR02)
      cQuery += "   AND VO2.VO2_DATREQ <= '" + dtos(MV_PAR02) + "' "
   EndIf

   cQuery += "   AND VO2.D_E_L_E_T_ = ' ' "
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlVO2, .F., .T.)

   While !(cQAlVO2)->(Eof())
      // cAl
      cAl := GetNextAlias()
      If lSBZ .And. SBZ->(FieldPos("BZ_LOCALI2")) > 0
         If lLocSoSBZ
            cQuery := " SELECT VO3.VO3_CODITE, VO3.VO3_GRUITE, VO3.VO3_PECINT, SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, SBZ.BZ_LOCALI2 AS LOCALI2 "
            cQuery += " FROM " + RetSqlName("VO3") + " VO3 "
            cQuery += " JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SB1.B1_CODITE = VO3.VO3_CODITE AND SB1.B1_GRUPO = VO3.VO3_GRUITE AND SB1.D_E_L_E_T_ = ' ' "
            cQuery += " JOIN " + RetSqlName("SBZ") + " SBZ ON SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' AND SBZ.BZ_COD = SB1.B1_COD AND SBZ.D_E_L_E_T_ = ' ' "
            cQuery += " WHERE VO3.VO3_FILIAL = '" + xFilial("VO3") + "' "
            cQuery += "   AND VO3.VO3_NOSNUM = '" + (cQAlVO2)->(VO2_NOSNUM) + "' "
            cQuery += "   AND VO3.D_E_L_E_T_ = ' ' "
         Else
            cQuery := " SELECT VO3.VO3_CODITE, VO3.VO3_GRUITE, VO3.VO3_PECINT, SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, "
            cQuery += "  CASE WHEN (SBZ.BZ_LOCALI2 IS NULL OR SBZ.BZ_LOCALI2 = ' ') THEN SB5.B5_LOCALI2 ELSE SBZ.BZ_LOCALI2 END LOCALI2 "
            cQuery += " FROM " + RetSqlName("VO3") + " VO3 "
            cQuery += " JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SB1.B1_CODITE = VO3.VO3_CODITE AND SB1.B1_GRUPO = VO3.VO3_GRUITE AND SB1.D_E_L_E_T_ = ' ' "
            cQuery += " LEFT JOIN " + RetSqlName("SBZ") + " SBZ ON SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' AND SBZ.BZ_COD = SB1.B1_COD AND SBZ.D_E_L_E_T_ = ' ' "
            cQuery += " LEFT JOIN " + RetSqlName("SB5") + " SB5 ON SB5.B5_FILIAL = '" + xFilial("SB5") + "' AND SB5.B5_COD = SB1.B1_COD AND SB5.D_E_L_E_T_ = ' ' "
            cQuery += " WHERE VO3.VO3_FILIAL = '" + xFilial("VO3") + "' "
            cQuery += "   AND VO3.VO3_NOSNUM = '" + (cQAlVO2)->(VO2_NOSNUM) + "' "
            cQuery += "   AND VO3.D_E_L_E_T_ = ' ' "
         EndIf
      Else
         cQuery := " SELECT VO3.VO3_CODITE, VO3.VO3_GRUITE, VO3.VO3_PECINT, SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, SB5.B5_LOCALI2 AS LOCALI2 "
         cQuery += " FROM " + RetSqlName("VO3") + " VO3 "
         cQuery += " JOIN " + RetSqlName("SB1") + " SB1 ON SB1.B1_FILIAL = '" + xFilial("SB1") + "' AND SB1.B1_CODITE = VO3.VO3_CODITE AND SB1.B1_GRUPO = VO3.VO3_GRUITE AND SB1.D_E_L_E_T_ = ' ' "
         cQuery += " JOIN " + RetSqlName("SB5") + " SB5 ON SB5.B5_FILIAL = '" + xFilial("SB5") + "' AND SB5.B5_COD = SB1.B1_COD AND SB5.D_E_L_E_T_ = ' ' "
         cQuery += " WHERE VO3.VO3_FILIAL = '" + xFilial("VO3") + "' "
         cQuery += "   AND VO3.VO3_NOSNUM = '" + (cQAlVO2)->(VO2_NOSNUM) + "' "
         cQuery += "   AND VO3.D_E_L_E_T_ = ' ' "
      EndIf
      dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAl, .F., .T.)

      While !(cAl)->(Eof())
         If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
            If (cAl)->(LOCALI2) < MV_PAR03 .Or. (cAl)->(LOCALI2) > MV_PAR04
               (cAl)->(dbSkip())

               Loop
            EndIf
         EndIf

         // SB1
         SB1->(dbGoto((cAl)->(recnoB1))) // Apontar por causa do SB1->B1_LOCPAD

         // SB2
         dbSelectArea("SB2")
         dbSetOrder(1)
         If dbSeek(xFilial("SB2") + (cAl)->(B1_COD) + FM_PRODSBZ((cAl)->(B1_COD), "SB1->B1_LOCPAD"))
            // SBL
            cQuery := " SELECT SBL.BL_ABCVEND, SBL.BL_ABCCUST "
            cQuery += " FROM " + RetSqlName("SBL") + " SBL "
            cQuery += " WHERE SBL.BL_FILIAL  = '" + xFilial("SBL") + "' "
            cQuery += "   AND SBL.BL_PRODUTO = '" + (cAl)->(B1_COD) + "' "
            cQuery += "   AND SBL.BL_ANO     = '" + cAno + "' "
            cQuery += "   AND SBL.BL_MES     = '" + cMes + "' "
            cQuery += "   AND SBL.D_E_L_E_T_ = ' ' "
            dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSBL, .F., .T.)

            cAbcVend := ""
            cAbcCust := ""

            If !(cQAlSBL)->(Eof())
               cAbcVend := (cQAlSBL)->(BL_ABCVEND)
               cAbcCust := (cQAlSBL)->(BL_ABCCUST)
            EndIf

            (cQAlSBL)->(dbCloseArea())

            // TRB
            DbSelectArea("TRB")
            If !dbSeek((cAl)->(LOCALI2) + (cAl)->(VO3_GRUITE) + (cAl)->(VO3_CODITE))
               RecLock("TRB", .t.)
                  TRB->TRB_LOCALI := (cAl)->(LOCALI2)
                  TRB->TRB_GRUPO  := (cAl)->(VO3_GRUITE)
                  TRB->TRB_CODIGO := (cAl)->(VO3_CODITE)
                  TRB->TRB_DESC   := (cAl)->(B1_DESC)
                  TRB->TRB_ABCVEN := cAbcVend
                  TRB->TRB_ABCCUS := cAbcCust
                  TRB->TRB_PECINT := (cAl)->(VO3_PECINT)
                  TRB->TRB_DISPON := SaldoSB2()
                  TRB->TRB_TIPO   := "S"
               MsUnlock()
            EndIf
         EndIf

         (cAl)->(dbSkip())
      EndDo

      (cAl)->(dbCloseArea())

      (cQAlVO2)->(dbSkip())
   EndDo

   (cQAlVO2)->(dbCloseArea())

   dbSelectArea("VO2")

   // SD2
   cQuery := " SELECT SD2.D2_COD, SD2.D2_GRUPO "
   cQuery += " FROM " + RetSqlName("SD2") + " SD2 "
   cQuery += " JOIN " + RetSqlName("SF4") + " SF4 ON SF4.F4_FILIAL = '" + xFilial("SF4") + "' AND SF4.F4_CODIGO = SD2.D2_TES AND SF4.F4_ESTOQUE <> 'N' AND SF4.D_E_L_E_T_ = ' ' "
   cQuery += " JOIN " + RetSqlName("SF2") + " SF2 ON SF2.F2_FILIAL = '" + xFilial("SF2") + "' AND SF2.F2_DOC = SD2.D2_DOC AND SF2.F2_SERIE = SD2.D2_SERIE AND SF2.F2_CLIENTE = SD2.D2_CLIENTE "
   cQuery += "   AND SF2.F2_LOJA = SD2.D2_LOJA AND SF2.F2_PREFORI NOT IN('" + GetNewPar("MV_PREFOFI","OFI") + "', '" + GetNewPar("MV_PREFVEI","VEI") + "') AND SF2.D_E_L_E_T_ = ' ' "
   cQuery += " WHERE SD2.D2_FILIAL = '" + xFilial("SD2") + "' "

   If !Empty(MV_PAR01)
      cQuery += "   AND SD2.D2_EMISSAO >= '" + dtos(MV_PAR01) + "' "
   EndIf

   If !Empty(MV_PAR02)
      cQuery += "   AND SD2.D2_EMISSAO <= '" + dtos(MV_PAR02) + "' "
   EndIf

   cQuery += "   AND SD2.D_E_L_E_T_ = ' ' "
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSD2, .F., .T.)

   While !(cQAlSD2)->(Eof())
      // SB1
      DbSelectArea("SB1")
      DbSetOrder(1)
      DbSeek(xFilial("SB1") + (cQAlSD2)->(D2_COD))

      // SB5
      DbSelectArea("SB5")
      DbSetOrder(1)
      DbSeek(xFilial("SB5") + SB1->B1_COD)

      cLOCALI2 := FM_PRODSBZ(SB1->B1_COD, "SB5->B5_LOCALI2")

      If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
         If cLOCALI2 < MV_PAR03 .Or. cLOCALI2 > MV_PAR04
            (cQAlSD2)->(dbSkip())

            Loop
         EndIf
      EndIf

      // SB2
      dbSelectArea("SB2")
      dbSetOrder(1)
      If dbSeek(xFilial("SB2") + SB1->B1_COD + FM_PRODSBZ(SB1->B1_COD, "SB1->B1_LOCPAD"))
         // SBL
         cQuery := " SELECT SBL.BL_ABCVEND, SBL.BL_ABCCUST "
         cQuery += " FROM " + RetSqlName("SBL") + " SBL "
         cQuery += " WHERE SBL.BL_FILIAL  = '" + xFilial("SBL") + "' "
         cQuery += "   AND SBL.BL_PRODUTO = '" + SB1->B1_COD + "' "
         cQuery += "   AND SBL.BL_ANO     = '" + cAno + "' "
         cQuery += "   AND SBL.BL_MES     = '" + cMes + "' "
         cQuery += "   AND SBL.D_E_L_E_T_ = ' ' "
         dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSBL, .F., .T.)

         cAbcVend := ""
         cAbcCust := ""

         If !(cQAlSBL)->(Eof())
            cAbcVend := (cQAlSBL)->(BL_ABCVEND)
            cAbcCust := (cQAlSBL)->(BL_ABCCUST)
         EndIf

         (cQAlSBL)->(dbCloseArea())

         // TRB
         DbSelectArea("TRB")
         If !dbSeek(cLOCALI2 + (cQAlSD2)->(D2_GRUPO) + SB1->B1_CODITE)
            RecLock("TRB", .t.)
               TRB->TRB_LOCALI := cLOCALI2
               TRB->TRB_GRUPO  := (cQAlSD2)->(D2_GRUPO)
               TRB->TRB_CODIGO := SB1->B1_CODITE
               TRB->TRB_DESC   := SB1->B1_DESC
               TRB->TRB_ABCVEN := cAbcVend
               TRB->TRB_ABCCUS := cAbcCust
               TRB->TRB_PECINT := (cQAlSD2)->(D2_COD)
               TRB->TRB_DISPON := SaldoSB2()
               TRB->TRB_TIPO   := "S"
            MsUnlock()
         EndIf
      EndIf

      (cQAlSD2)->(dbSkip())
   EndDo

   (cQAlSD2)->(dbCloseArea())

   dbSelectArea("SD2")

   // SD1
   cQuery := " SELECT SD1.D1_COD, SD1.D1_GRUPO "
   cQuery += " FROM " + RetSqlName("SD1") + " SD1 "
   cQuery += " JOIN " + RetSqlName("SF4") + " SF4 ON SF4.F4_FILIAL = '" + xFilial("SF4") + "' AND SF4.F4_CODIGO = SD1.D1_TES AND SF4.F4_ESTOQUE <> 'N' AND SF4.D_E_L_E_T_ = ' ' "
   cQuery += " JOIN " + RetSqlName("SF1") + " SF1 ON SF1.F1_FILIAL = '" + xFilial("SF1") + "' AND SF1.F1_DOC = SD1.D1_DOC AND SF1.F1_SERIE = SD1.D1_SERIE  "
   cQuery += "   AND SF1.F1_FORNECE = SD1.D1_FORNECE AND SF1.F1_LOJA = SD1.D1_LOJA AND (SF1.F1_STATUS <> '' AND SF1.F1_STATUS IS NOT NULL) AND SF1.D_E_L_E_T_ = ' ' "
   cQuery += " WHERE SD1.D1_FILIAL = '" + xFilial("SD1") + "' "

   If !Empty(MV_PAR01)
      cQuery += "   AND SD1.D1_DTDIGIT >= '" + dtos(MV_PAR01) + "' "
   EndIf

   If !Empty(MV_PAR02)
      cQuery += "   AND SD1.D1_DTDIGIT <= '" + dtos(MV_PAR02) + "' "
   EndIf

   cQuery += "   AND SD1.D_E_L_E_T_ = ' ' "
   dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSD1, .F., .T.)

   While !(cQAlSD1)->(Eof())
      // SB1
      DbSelectArea("SB1")
      DbSetOrder(1)
      DbSeek(xFilial("SB1") + (cQAlSD1)->(D1_COD))

      // SB5
      DbSelectArea("SB5")
      DbSetOrder(1)
      DbSeek(xFilial("SB5") + SB1->B1_COD)

      cLOCALI2 := FM_PRODSBZ(SB1->B1_COD, "SB5->B5_LOCALI2")

      If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
         If cLOCALI2 < MV_PAR03 .Or. cLOCALI2 > MV_PAR04
            (cQAlSD1)->(dbSkip())

            Loop
         EndIf
      EndIf

      // SB2
      DbSelectArea("SB2")
      DbSetOrder(1)
      If DbSeek(xFilial("SB2") + SB1->B1_COD + FM_PRODSBZ(SB1->B1_COD, "SB1->B1_LOCPAD"))
         // SBL
         cQuery := " SELECT SBL.BL_ABCVEND, SBL.BL_ABCCUST "
         cQuery += " FROM " + RetSqlName("SBL") + " SBL "
         cQuery += " WHERE SBL.BL_FILIAL  = '" + xFilial("SBL") + "' "
         cQuery += "   AND SBL.BL_PRODUTO = '" + SB1->B1_COD + "' "
         cQuery += "   AND SBL.BL_ANO     = '" + cAno + "' "
         cQuery += "   AND SBL.BL_MES     = '" + cMes + "' "
         cQuery += "   AND SBL.D_E_L_E_T_ = ' ' "
         dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSBL, .F., .T.)

         cAbcVend := ""
         cAbcCust := ""

         If !(cQAlSBL)->(Eof())
            cAbcVend := (cQAlSBL)->(BL_ABCVEND)
            cAbcCust := (cQAlSBL)->(BL_ABCCUST)
         EndIf

         (cQAlSBL)->(dbCloseArea())

         // TRB
         DbSelectArea("TRB")
         If !dbSeek(cLOCALI2 + (cQAlSD1)->(D1_GRUPO) + SB1->B1_CODITE)
            RecLock("TRB", .t.)
               TRB->TRB_LOCALI := cLOCALI2
               TRB->TRB_GRUPO  := (cQAlSD1)->(D1_GRUPO)
               TRB->TRB_CODIGO := SB1->B1_CODITE
               TRB->TRB_DESC   := SB1->B1_DESC
               TRB->TRB_ABCVEN := cAbcVend
               TRB->TRB_ABCCUS := cAbcCust
               TRB->TRB_PECINT := (cQAlSD1)->(D1_COD)
               TRB->TRB_DISPON := SaldoSB2()
               TRB->TRB_TIPO   := "S"
            MsUnlock()
         EndIf
      EndIf

     (cQAlSD1)->(dbSkip())
   EndDo

   (cQAlSD1)->(dbCloseArea())

   dbSelectArea("SD1")

   If MV_PAR06 >= 2
      // cAl
      cAl := GetNextAlias()
      If lSBZ .And. SBZ->(FieldPos("BZ_LOCALI2")) > 0
         If lLocSoSBZ
            cQuery := " SELECT SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, SB1.B1_GRUPO, SB1.B1_CODITE, SBZ.BZ_LOCALI2 AS LOCALI2 "
            cQuery += " FROM " + RetSqlName("SB1") + " SB1 "
            cQuery += " JOIN " + RetSqlName("SBZ") + " SBZ ON SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' AND SBZ.BZ_COD = SB1.B1_COD AND SBZ.D_E_L_E_T_ = ' ' "
            cQuery += " WHERE SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
            cQuery += "   AND SB1.D_E_L_E_T_ = ' ' "
         Else
            cQuery := " SELECT SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, SB1.B1_GRUPO, SB1.B1_CODITE, "
            cQuery += "  CASE WHEN (SBZ.BZ_LOCALI2 IS NULL OR SBZ.BZ_LOCALI2 = ' ') THEN SB5.B5_LOCALI2 ELSE SBZ.BZ_LOCALI2 END LOCALI2 "
            cQuery += " FROM " + RetSqlName("SB1") + " SB1 "
            cQuery += " LEFT JOIN " + RetSqlName("SBZ") + " SBZ ON SBZ.BZ_FILIAL = '" + xFilial("SBZ") + "' AND SBZ.BZ_COD = SB1.B1_COD AND SBZ.D_E_L_E_T_ = ' ' "
            cQuery += " LEFT JOIN " + RetSqlName("SB5") + " SB5 ON SB5.B5_FILIAL = '" + xFilial("SB5") + "' AND SB5.B5_COD = SB1.B1_COD AND SB5.D_E_L_E_T_ = ' ' "
            cQuery += " WHERE SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
            cQuery += "   AND SB1.D_E_L_E_T_ = ' ' "
         EndIf
      Else
         cQuery := " SELECT SB1.R_E_C_N_O_ AS recnoB1, SB1.B1_COD, SB1.B1_DESC, SB1.B1_GRUPO, SB1.B1_CODITE, SB5.B5_LOCALI2 AS LOCALI2 "
         cQuery += " FROM " + RetSqlName("SB1") + " SB1 "
         cQuery += " JOIN " + RetSqlName("SB5") + " SB5 ON SB5.B5_FILIAL = '" + xFilial("SB5") + "' AND SB5.B5_COD = SB1.B1_COD AND SB5.D_E_L_E_T_ = ' ' "
         cQuery += " WHERE SB1.B1_FILIAL = '" + xFilial("SB1") + "' "
         cQuery += "   AND SB1.D_E_L_E_T_ = ' ' "
      EndIf
      dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cAl, .F., .T.)

      While !(cAl)->(Eof())
         If !Empty(MV_PAR03) .And. !Empty(MV_PAR04)
            If (cAl)->(LOCALI2) < MV_PAR03 .Or. (cAl)->(LOCALI2) > MV_PAR04
               (cAl)->(dbSkip())

               Loop
            EndIf
         EndIf

         // TRB
         DbSelectArea("TRB")
         If dbSeek((cAl)->(LOCALI2) + (cAl)->(B1_GRUPO) + (cAl)->(B1_CODITE))
            (cAl)->(dbSkip())

            Loop
         EndIf

         // SB1
         SB1->(dbGoto((cAl)->(recnoB1))) // Apontar por causa do SB1->B1_LOCPAD

         // SB2
         dbSelectArea("SB2")
         dbSetOrder(1)
         If dbSeek(xFilial("SB2") + (cAl)->(B1_COD) + FM_PRODSBZ((cAl)->(B1_COD), "SB1->B1_LOCPAD"))
            // SBL
            cQuery := " SELECT SBL.BL_ABCVEND, SBL.BL_ABCCUST "
            cQuery += " FROM " + RetSqlName("SBL") + " SBL "
            cQuery += " WHERE SBL.BL_FILIAL  = '" + xFilial("SBL") + "' "
            cQuery += "   AND SBL.BL_PRODUTO = '" + (cAl)->(B1_COD) + "' "
            cQuery += "   AND SBL.BL_ANO     = '" + cAno + "' "
            cQuery += "   AND SBL.BL_MES     = '" + cMes + "' "
            cQuery += "   AND SBL.D_E_L_E_T_ = ' ' "
            dbUseArea(.T., "TOPCONN", TcGenQry(,, cQuery), cQAlSBL, .F., .T.)

            cAbcVend := ""
            cAbcCust := ""

            If !(cQAlSBL)->(Eof())
               cAbcVend := (cQAlSBL)->(BL_ABCVEND)
               cAbcCust := (cQAlSBL)->(BL_ABCCUST)
            EndIf

            (cQAlSBL)->(dbCloseArea())

            // TRB
            DbSelectArea("TRB")
            RecLock("TRB", .t.)
               TRB->TRB_LOCALI := (cAl)->(LOCALI2)
               TRB->TRB_GRUPO  := (cAl)->(B1_GRUPO)
               TRB->TRB_CODIGO := (cAl)->(B1_CODITE)
               TRB->TRB_DESC   := (cAl)->(B1_DESC)
               TRB->TRB_ABCVEN := cAbcVend
               TRB->TRB_ABCCUS := cAbcCust
               TRB->TRB_PECINT := (cAl)->(B1_COD)
               TRB->TRB_DISPON := SaldoSB2()
               TRB->TRB_TIPO   := "N"
            MsUnlock()
         EndIf

         (cAl)->(dbSkip())
      EndDo

      (cAl)->(dbCloseArea())
   EndIf

   // Título
   oSection1:Init()

   cTit := STR0001 + "   -   " + dtoc(MV_PAR01) + STR0005 + dtoc(MV_PAR02) + "   -   " // Inventario Diario /  a 
   cTit += If(MV_PAR06 == 1, STR0006, If(MV_PAR06 == 2, STR0007, STR0008))             // Itens Movimentados / Itens Nao Movimentados / Todos os Itens

   oSection1:PrintLine()

   oSection1:Finish()

   // Dados
   oSection2:Init()

   // TRB
   dbSelectArea("TRB")
   dbGotop()
   While !TRB->(Eof())
      lImprimir := .f.

      If MV_PAR06 == 2
         If TRB->TRB_TIPO == "N"
            lImprimir := .t.
         EndIf
      Else
         lImprimir := .t.
      EndIf

      If lImprimir
         cLoc := TRB->TRB_LOCALI                               // Localização
         cGrp := TRB->TRB_GRUPO                                // Grupo
         cCod := TRB->TRB_CODIGO                               // Código do Item
         cDes := TRB->TRB_DESC                                 // Descrição
         cABC := TRB->TRB_ABCVEN + TRB->TRB_ABCCUS + " _____"  // Classificação do ABC VENDA e ABC CUSTO
         nQtd := If(MV_PAR05 == 1, TRB->TRB_DISPON, 0)         // Quantidade Disponível

         oSection2:PrintLine()
      EndIf

      dbSelectArea("TRB")
      dbSkip()
   EndDo

   oSection2:Finish()

   oObjTempTable:CloseTable()
Return