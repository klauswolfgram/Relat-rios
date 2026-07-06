#ifdef SPANISH
	#define STR0001 "Seleccion de PLI"
	#define STR0002 "Seleccion de Item - PLI"
	#define STR0003 "Mantenimiento de Lote / PLI"
	#define STR0004 "Cerrando archivo "
	#define STR0005 "Cerrando archivos ..."
	#define STR0006 "Nº de PLI:"
	#define STR0007 "Grabando archivos de trabajo ..."
	#define STR0008 "Apertura de Archivos"
	#define STR0011 "Nº de PLI"
	#define STR0012 "Nº de PO"
	#define STR0013 "Und. Solic."
	#define STR0014 "Nº de SI"
	#define STR0015 "Codigo Item"
	#define STR0016 "Descripcion Item"
	#define STR0017 "Ctd"
	#define STR0018 "Manutenção Lote"
	#define STR0019 "Buscar"
	#define STR0020 "Visual"
	#define STR0021 "Incluir"
	#define STR0022 "Modificar"
	#define STR0023 "Borrar"
	#define STR0024 "Ctd. Lote"
	#define STR0025 "Nº de Lote"
	#define STR0026 "Fch. Validez"
	#define STR0027 "Observacion"
	#define STR0028 "Nº de PO:"
	#define STR0029 "Unid. Solic.:"
	#define STR0030 "Nº de SI:"
	#define STR0031 "Cod. Item:"
	#define STR0032 "Descr. Item:"
	#define STR0033 "Ctd. Item:"
	#define STR0034 "Saldo Item:"
	#define STR0035 "Incluir"
	#define STR0036 "Alterar"
	#define STR0037 "Excluir"
	#define STR0038 "Grabando archivos del sistema ..."
	#define STR0041 " - Inclusion de Lote"
	#define STR0043 " - Modificacion de Lote"
	#define STR0045 " - Borrado de Lote"
	#define STR0046 "Mantenimiento de Lote"
	#define STR0047 "Anuentes"
	#define STR0048 "No Anuentes"
	#define STR0049 "Lote para Items : "
	#define STR0050 "Seleccion de Procesos"
	#define STR0051 "Seleccion de Item - Proceso"
	#define STR0052 "Mantenimiento de Lote / Proceso"
	#define STR0053 "Proceso:"
	#define STR0056 "Proceso"
#else
	#ifdef ENGLISH
		#define STR0001 "Select PLI"
		#define STR0002 "Item Selection - P.L.I."
		#define STR0003 "Lot Maintenance / P.L.I."
		#define STR0004 "Closing file "
		#define STR0005 "Closing files ..."
		#define STR0006 "PLI Number:"
		#define STR0007 "Saving work files ..."
		#define STR0008 "Open files"
		#define STR0011 "PLI Number"
		#define STR0012 "PO Number"
		#define STR0013 "Requ.Unit"
		#define STR0014 "SI Number"
		#define STR0015 "Item Code"
		#define STR0016 "Item Description"
		#define STR0017 "Qtty"
		#define STR0018 "Manutenção Lote"
		#define STR0019 "Search"
		#define STR0020 "View"
		#define STR0021 "Insert"
		#define STR0022 "Edit"
		#define STR0023 "Delete"
		#define STR0024 "Qtty. Lot"
		#define STR0025 "Lot Number"
		#define STR0026 "Maturity Dt."
		#define STR0027 "Notes"
		#define STR0028 "PO Number:"
		#define STR0029 "Requ. Unit:"
		#define STR0030 "SI Number:"
		#define STR0031 "Item Code:"
		#define STR0032 "Item Desc.:"
		#define STR0033 "Item Qtty.:"
		#define STR0034 "Item Bala.:"
		#define STR0035 "Incluir"
		#define STR0036 "Alterar"
		#define STR0037 "Excluir"
		#define STR0038 "Saving system files ..."
		#define STR0041 " - Insert Lot"
		#define STR0043 " - Edit Lot"
		#define STR0045 " - Delete Lot"
		#define STR0046 "Lot Maintenance"
		#define STR0047 "Consenting"
		#define STR0048 "Not Consenting"
		#define STR0049 "Lot to Items : "
		#define STR0050 "Select Processes"
		#define STR0051 "Item Selection - Process"
		#define STR0052 "Lot / Process Maintenance"
		#define STR0053 "Process:"
		#define STR0056 "Process"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Selecção de pli", "Seleção de PLI" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Selecção de elemento - p.l.i.", "Seleção de Item - P.L.I." )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Manutenção de lote / p.l.i.", "Manutenção de Lote / P.L.I." )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "A fechar ficheiro ", "Fechando arquivo " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "A fechar ficheiros ...", "Fechando arquivos ..." )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Nº Da P.l.i.:", "Nro. da PLI:" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "A gravar ficheiros de trabalho ...", "Gravando arquivos de trabalho ..." )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Abertura De Arquivos", "Abertura de Arquivos" )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Nro. Da Pli", "Nro. da PLI" )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Nr. Da Enc", "Nro. do PO" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Und.requis.", "Und.Requis." )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "Nro. Da Si", "Nro. da SI" )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Código Item", "Codigo Item" )
		#define STR0016 "Descrição Item"
		#define STR0017 "Qtde"
		#define STR0018 "Manutenção Lote"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Pesquisar", "Pesqusar" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Visual.", "Visual" )
		#define STR0021 "Incluir"
		#define STR0022 "Alterar"
		#define STR0023 "Excluir"
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Qtd. Lote", "Qtde. Lote" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Nº Do Lote", "Nro. do Lote" )
		#define STR0026 "Dt. Validade"
		#define STR0027 "Observação"
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Nº Do Po:", "Nro. do PO:" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Unid.requis.:", "Unid.Requis.:" )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Nr. Da Si:", "Nro. da SI:" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Cód. Elemento:", "Cod. Item:" )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Descr.elemento:", "Descr.Item:" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Qtd. Elemento:", "Qtde. Item:" )
		#define STR0034 "Saldo Item:"
		#define STR0035 "Incluir"
		#define STR0036 "Alterar"
		#define STR0037 "Excluir"
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "A gravar ficheiros do sistema ...", "Gravando arquivos do sistema ..." )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", " - inserção de lote", " - Inclusão de Lote" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", " - alteração de lote", " - Alteração de Lote" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", " - eliminação de lote", " - Exclusão de Lote" )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Manutenção de lote", "Manutenção de Lote" )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "Devedores", "Anuentes" )
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "Não Devedores", "Não Anuentes" )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "Lote para itens : ", "Lote para Itens : " )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Seleção De Processos", "Seleção de Processos" )
		#define STR0051 If( cPaisLoc $ "ANG|PTG", "Selecção de elemento - processo", "Seleção de Item - Processo" )
		#define STR0052 If( cPaisLoc $ "ANG|PTG", "Manutenção de lote / processo", "Manutenção de Lote / Processo" )
		#define STR0053 "Processo:"
		#define STR0056 "Processo"
	#endif
#endif
