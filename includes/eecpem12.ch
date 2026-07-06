#ifdef SPANISH
	#define STR0001 "Pagina"
	#define STR0002 "Linea"
	#define STR0003 "It. Numero"
	#define STR0004 "Mark's"
	#define STR0005 "Descripcion"
	#define STR0006 "Crit.Orig"
	#define STR0007 "Peso Bruto"
	#define STR0008 "Invoice"
	#define STR0009 "NCM    "
	#define STR0010 "Re     "
	#define STR0011 "Fch. Re  "
	#define STR0012 "Vlr. FOB "
	#define STR0013 "Peso Neto"
	#define STR0014 "Situela "
	#define STR0015 "¦"
	#define STR0016 " copia del Form A."
	#define STR0017 "Aviso"
#else
	#ifdef ENGLISH
		#define STR0001 "Page"
		#define STR0002 "Row"
		#define STR0003 "It.Number"
		#define STR0004 "Mark's"
		#define STR0005 "Description"
		#define STR0006 "Source Criterion"
		#define STR0007 "Gross Wght"
		#define STR0008 "Invoice"
		#define STR0009 "CNM    "
		#define STR0010 "Re     "
		#define STR0011 "Re. Dt."
		#define STR0012 "Vl.FOB "
		#define STR0013 "Net Weight"
		#define STR0014 "Place the"
		#define STR0015 "¦"
		#define STR0016 " Form A copy."
		#define STR0017 "Warning"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Página", "Pagina" )
		#define STR0002 "Linha"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Número it.", "It.Number" )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Marcas", "Mark's" )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Crit. orig", "Crit.Orig" )
		#define STR0007 "Peso Bruto"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Factura", "Invoice" )
		#define STR0009 "Ncm    "
		#define STR0010 "Re     "
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "Dt.re  ", "Dt.Re  " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Val.fob ", "Vl.FOB " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "Peso Líq.", "Peso Liq." )
		#define STR0014 "Posicione a "
		#define STR0015 "¦"
		#define STR0016 If( cPaisLoc $ "ANG|PTG", " Via Do Form. A", " via do Form A." )
		#define STR0017 "Aviso"
	#endif
#endif
