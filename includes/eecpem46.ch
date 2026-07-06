#ifdef SPANISH
	#define STR0001 "No se encontraron datos en el Historial"
	#define STR0002 "Para este documento, las informaciones vendran del Embarque."
	#define STR0003 "Informacion"
	#define STR0004 "Telefono: "
	#define STR0005 "  Fax.: "
	#define STR0006 "¿Producto Principal?"
	#define STR0007 "Si"
	#define STR0008 "No"
	#define STR0009 "¿Buscar ultima Impresion?"
	#define STR0010 "No"
	#define STR0011 "Embalaje"
	#define STR0012 "Descripcion"
	#define STR0013 "Dimension"
	#define STR0014 "Peso Bruto"
	#define STR0015 "Codigo"
	#define STR0016 "Descripcion"
	#define STR0017 "No se encontraron datos para este documento."
	#define STR0018 "Items"
	#define STR0019 "Notifys"
	#define STR0020 "Observaciones"
	#define STR0021 "No se encontro la conformacion de embalajes para el producto: "
	#define STR0022 "Atencion"
#else
	#ifdef ENGLISH
		#define STR0001 "No data found in the History"
		#define STR0002 "for this document, the information will be given by Shipment."
		#define STR0003 "Information"
		#define STR0004 "Tel.No.: "
		#define STR0005 "  Fax.: "
		#define STR0006 "Main Product?"
		#define STR0007 "Yes"
		#define STR0008 "No"
		#define STR0009 "Search for last printing?"
		#define STR0010 "No"
		#define STR0011 "Package"
		#define STR0012 "Description"
		#define STR0013 "Dimension"
		#define STR0014 "Gross Weight"
		#define STR0015 "Code"
		#define STR0016 "Description"
		#define STR0017 "No data found for this document."
		#define STR0018 "Items"
		#define STR0019 "Notify's"
		#define STR0020 "Notes"
		#define STR0021 "No packaging composition for this product has been found:  "
		#define STR0022 "Warning"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Não Foram Encontrados Dados No Histórico", "Não foram encontrados dados no Histórico" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "Para Este Documento, As Informações Virão Do Embarque.", "para este documento, as informações virão do Embarque." )
		#define STR0003 "Informação"
		#define STR0004 "Tel.: "
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "  fax.: ", "  Fax.: " )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Artigo Pai?", "Produto Pai?" )
		#define STR0007 "Sim"
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Não", "Nao" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Procurar última Impressão?", "Buscar última Impressão?" )
		#define STR0010 "Não"
		#define STR0011 "Embalagem"
		#define STR0012 If( cPaisLoc $ "ANG|PTG", "Descrição", "Descricao" )
		#define STR0013 "Dimensão"
		#define STR0014 "Peso Bruto"
		#define STR0015 "Código"
		#define STR0016 "Descrição"
		#define STR0017 "Não foram encontrados dados para este documento."
		#define STR0018 "Itens"
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "Notificações", "Notify's" )
		#define STR0020 "Observações"
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "Não foi encontrada composição de embalagens para o artigo: ", "Não foi encontrada composição de embalagens para o produto: " )
		#define STR0022 "Atenção"
	#endif
#endif
