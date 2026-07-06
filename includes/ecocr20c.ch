#ifdef SPANISH
	#define STR0001 "NUMERO DEL H. A. W. B."
	#define STR0002 "NUMERO DE LA D. I."
	#define STR0003 "DESPACHANTE"
	#define STR0004 "NUMERO DEL LOTE"
	#define STR0005 "NUMERO DE LA FACTURA ENTR."
	#define STR0006 "FECHA DEL RECIBO FISCAL"
	#define STR0007 "NUMERO DE LA D. A. I."
	#define STR0008 "NUMERO DE LA FACT. COMP."
	#define STR0009 "PAGADO POR EL IMPORTADOR"
	#define STR0010 "ICMS PAGADO POR EL IMP."
	#define STR0011 "MULTAS PAGADAS POR EL IMP."
	#define STR0012 "VALOR DE FLETE"
	#define STR0013 "I. I."
	#define STR0014 "I. P. I."
	#define STR0015 "ICMS PAGADO POR EL DESP."
	#define STR0016 "MULTAS PAGADAS POR EL DESP."
	#define STR0017 "PAGADO POR EL DESPACHANTE"
	#define STR0018 "ICMS S/ MULTAS - DESP."
	#define STR0019 "ICMS S/ MULTAS - IMP."
	#define STR0020 "FLETE DE CARRETERAS"
	#define STR0021 "SEGURO"
	#define STR0022 "ALMACEN PORTUARIO"
	#define STR0023 "ALMACEN AEREO"
	#define STR0024 "ALMACEN DAP/MULTITERMINALES"
	#define STR0025 "VAR. CAMBIARIA (DESPACHO) F. O. B."
	#define STR0026 "VAR. CAMBIARIA (DESPACHO) FLETE"
	#define STR0027 "VALOR GASTO 5.09"
	#define STR0028 "VALOR INTERESES"
	#define STR0029 "VALOR I. R."
	#define STR0030 "VALOR GASTO BANCARIO"
	#define STR0031 "VALOR CREDITO A BANCO"
	#define STR0032 "CREDITO-IMPORT. EN MARCHA"
	#define STR0033 "VALOR FACT."
	#define STR0034 "VALOR FACTURA"
	#define STR0035 "VALOR FACT. CP"
	#define STR0036 "VALOR FACT. COMPL."
	#define STR0037 "COM. ALMACEN"
	#define STR0038 "FLETE"
	#define STR0039 "ICMS"
	#define STR0040 "GASTO GUIA"
	#define STR0041 "FOB. D. I."
	#define STR0042 "FECHA PAGO. IMPUESTOS"
	#define STR0043 "D. C. I."
	#define STR0044 "ALMACEN AEREO"
	#define STR0045 "COM. GASTO"
	#define STR0046 "FLETE CARRETERA"
	#define STR0047 "VALOR FOB INVOICE"
	#define STR0048 "El sistema no origino este registro."
	#define STR0049 "TASA FOB INVOICE"
	#define STR0050 "COMP. ALMACEN"
	#define STR0051 "ALMACEN DAP"
	#define STR0052 "GASTO COMP"
	#define STR0053 "Nº P. O./ INV./ PROVEE."
	#define STR0054 "VALOR FOB P. O."
#else
	#ifdef ENGLISH
		#define STR0001 "H.A.W.B. NUMBER"
		#define STR0002 "I.D. NUMBER"
		#define STR0003 "CUSTOMS BROKER"
		#define STR0004 "LOT NUMBER"
		#define STR0005 "INFLOW INVOICE NUMBER"
		#define STR0006 "FISCAL RECEVBTO FISCAL"
		#define STR0007 "NUMERO DA D.IVING DATE"
		#define STR0008 "COMPL. INVOICE NUMBER"
		#define STR0009 "PAID BY THE IMPORTER"
		#define STR0010 "ICMS PAID BY THE IMP."
		#define STR0011 "FINES PAID BY THE IMP."
		#define STR0012 "FREIGHT VALUE"
		#define STR0013 "I.I."
		#define STR0014 "I.P.I."
		#define STR0015 "ICMS PAID BY THE CUST.BROK."
		#define STR0016 "FINES PAID BY THE CUST.BROK."
		#define STR0017 "PAID BY THE CUST.BROK."
		#define STR0018 "ICMS W/O FINES - DISP."
		#define STR0019 "ICMS W/O FINES - IMP."
		#define STR0020 "ROAD FREIGHT"
		#define STR0021 "INSURANCE"
		#define STR0022 "PORT WAREHOUSE"
		#define STR0023 "AIR FREIGHT WAREHOUSE"
		#define STR0024 "WAREH. DAP/MULTI TERMINALS"
		#define STR0025 "EXCH.VARIAT.(DISEMB.) F.O.B."
		#define STR0026 "EXCH.VARIAT.(DISEMB.)FREIGHT"
		#define STR0027 "EXPENSES VALUE 5.09"
		#define STR0028 "INTERESTS VALUE"
		#define STR0029 "INCOME TAX VALUE"
		#define STR0030 "BANK EXPENSES VALUE"
		#define STR0031 "CREDIT VALUE TO BANK"
		#define STR0032 "CREDIT-IMPORT. IN PROGRESS"
		#define STR0033 "INV. VALUE"
		#define STR0034 "INVOICE VALUE"
		#define STR0035 "COMPL.INV.VAL"
		#define STR0036 "COMPL.INV.VALUE"
		#define STR0037 "WRH.CRM."
		#define STR0038 "FREIGHT"
		#define STR0039 "ICMS"
		#define STR0040 "FORM DISP."
		#define STR0041 "I.D. FOB "
		#define STR0042 "TAXES PAYMENT DATE"
		#define STR0043 "D.C.I."
		#define STR0044 "AIR.FRE.WRH."
		#define STR0045 "EXP. COM."
		#define STR0046 "RAOD FREIGHT"
		#define STR0047 "INVOICE FOB VALUE"
		#define STR0048 "Record was not originated by the system."
		#define STR0049 "INVOICE FOB RATE"
		#define STR0050 "WRH.COMPL."
		#define STR0051 "DAP WRH."
		#define STR0052 "COMP.EXP."
		#define STR0053 "NO. O.P./INV./SUPP."
		#define STR0054 "O.P. FOB VALUE"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Número Do H.a.w.b.", "NÚMERO DO H.A.W.B." )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Número da d.i.", "NÚMERO DA D.I." )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Despachante", "DESPACHANTE" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Número Do Lote", "NÚMERO DO LOTE" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Número Da Fact. Entr.", "NÚMERO DA N.F. ENTR." )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Data Do Recebimento Fiscal", "DATA DO RECEBTO FISCAL" )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Número Da D.a.i.", "NÚMERO DA D.A.I." )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Número Da Factura Comp.", "NÚMERO DA N.F. COMP." )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Pagamento Pelo Importador", "PAGO PELO IMPORTADOR" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Icms Pagamento Pelo Imp.", "ICMS PAGO PELO IMP." )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Penalizações Pagas Pelo Imp.", "MULTAS PAGA PELO IMP." )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Valor De Frete", "VALOR DE FRETE" )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "I.i.", "I.I." )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "IVA", "I.P.I." )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "Iuc Pago Pelo Desp.", "ICMS PAGO PELO DESP." )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "Multas Pagas Pelo Desp.", "MULTAS PAGA PELO DESP." )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "Pagamento Pelo Despachante", "PAGO PELO DESPACHANTE" )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "Icms S/ Penalizações - Desp.", "ICMS S/ MULTAS - DESP." )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Icms S/ Penalizações - Imp.", "ICMS S/ MULTAS - IMP." )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "Frete Rodoviário", "FRETE RODOVIÁRIO" )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Seguro", "SEGURO" )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "Armaz. Portuária", "ARMAZ. PORTUÁRIA" )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "Armaz. Aérea", "ARMAZ. AÉREA" )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "Armaz. Dap/multiterminais", "ARMAZ. DAP/MULTITERMINAIS" )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "Var.cambial (desemb.) F.o.b.", "VAR.CAMBIAL (DESEMB.) F.O.B." )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "Var.cambial (desemb.) Transportar", "VAR.CAMBIAL (DESEMB.) FRETE" )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "Valor despesa 5.09", "VALOR DESPESA 5.09" )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "Valor Juros", "VALOR JUROS" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "Valor IRS", "VALOR I.R." )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "Valor Da Desp. Bancária", "VALOR DESP.BANCARIA" )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Valor Do Crédito Bancário", "VALOR CRÉDITO A BANCO" )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Crédito-import. Em Andamento", "CRÉDITO-IMPORT. EM ANDAMENTO" )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Valor Nf", "VALOR NF" )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Valor Da Factura", "VALOR N.FISCAL" )
		#define STR0035 If( cPaisLoc $ "ANG|PTG", "Valor Factura Cp", "VALOR NF CP" )
		#define STR0036 If( cPaisLoc $ "ANG|PTG", "Valor Factura Compl.", "VALOR NF COMPL." )
		#define STR0037 If( cPaisLoc $ "ANG|PTG", "Com.arm.", "COM.ARM." )
		#define STR0038 If( cPaisLoc $ "ANG|PTG", "Frete", "FRETE" )
		#define STR0039 If( cPaisLoc $ "ANG|PTG", "Icms  ", "ICMS" )
		#define STR0040 If( cPaisLoc $ "ANG|PTG", "Desp. da guia", "DESP.GUIA" )
		#define STR0041 If( cPaisLoc $ "ANG|PTG", "Fob. D.i.", "FOB. D.I." )
		#define STR0042 If( cPaisLoc $ "ANG|PTG", "Data Pgt. Impostos", "DATA PAGTO. IMPOSTOS" )
		#define STR0043 If( cPaisLoc $ "ANG|PTG", "D.c.i.", "D.C.I." )
		#define STR0044 If( cPaisLoc $ "ANG|PTG", "Arm.aéreo", "ARM.AÉREO" )
		#define STR0045 If( cPaisLoc $ "ANG|PTG", "Com.desp.", "COM.DESP." )
		#define STR0046 If( cPaisLoc $ "ANG|PTG", "Transportar Rod", "FRETE ROD" )
		#define STR0047 If( cPaisLoc $ "ANG|PTG", "Valor Fob Factura", "VALOR FOB INVOICE" )
		#define STR0048 If( cPaisLoc $ "ANG|PTG", "O registo não foi originado pelo módulo.", "Registro não foi originado pelo sistema." )
		#define STR0049 If( cPaisLoc $ "ANG|PTG", "Taxa Fob Da Factura", "TAXA FOB INVOICE" )
		#define STR0050 If( cPaisLoc $ "ANG|PTG", "Comp.arm.", "COMP.ARM." )
		#define STR0051 If( cPaisLoc $ "ANG|PTG", "Arm. Dap", "ARM. DAP" )
		#define STR0052 If( cPaisLoc $ "ANG|PTG", "Desp.comp", "DESP.COMP" )
		#define STR0053 If( cPaisLoc $ "ANG|PTG", "Nr. P.o./fact./forn.", "NRO. P.O./INV./FORN." )
		#define STR0054 If( cPaisLoc $ "ANG|PTG", "Valor Fob Do P.o.", "VALOR FOB P.O." )
	#endif
#endif
