#ifdef SPANISH
	#define STR0001 "EMPRESA       "
	#define STR0002 "AT            "
	#define STR0003 "FAX           "
	#define STR0004 "TELEFONO      "
	#define STR0005 "DE ACUERDO CON CONTACTO TELEFONICO MANTENIDO CON Ud. FAVOR PROVIDENCIAR LA RESERVA DE"
	#define STR0006 "ESPACIO CONFORME SIGUIENTES DETALLES."
	#define STR0007 "*** CUANDO SE CONFIRME VIA FAX, PEDIMOS HACER MENCION AL NUMERO DE NUESTRA"
	#define STR0008 "REFERENCIA, AGENTE DE DESTINO, SI TENDRA TRANSBORDO Y SI ES POSITIVO, DETALLES"
	#define STR0009 "DEL NAVIO QUE EFECTUARA LA CONEXION. ***"
	#define STR0010 "                          RESERVA DE PLAZA  NR"
	#define STR0011 "N / REF.:   "
	#define STR0012 " CLIENTE: "
	#define STR0013 "# BARCO                   => "
	#define STR0014 "# PUERTO                  => "
	#define STR0015 "# ARMADOR                 => "
	#define STR0016 "# ETA / ETS ORIGEN        => "
	#define STR0017 "# ETA DESTINO             => "
	#define STR0018 "# FECHA ENTREGA CARGA / DOCS.=> FAVOR INFORMAR"
	#define STR0019 "# LOCAL P/ ENTREGA-DE CARGA=> FAVOR INFORMAR"
	#define STR0020 "# DESPACHANTE             => "
	#define STR0021 "# TELEF. / CONTACTO       => "
	#define STR0022 "# MERCADERIA              => "
	#define STR0023 "# EMBALAJE FINAL          => "
	#define STR0024 "# TOTAL DE EMBALAJES      => "
	#define STR0025 "# P. BRUTO TOTAL - KG     => "
	#define STR0026 "# M3 TOTAL                => "
	#define STR0027 "# FLETE                   => "
	#define STR0028 "                          => FAVOR CONFIRMAR"
	#define STR0029 "# S/ RESERVA               => "
	#define STR0030 "# OBSERVACIONES           => "
	#define STR0031 "ATENTAMENTE "
	#define STR0032 "TELEFONO: "
	#define STR0033 "Fax : "
	#define STR0034 "RESERVA DE PLAZA NR"
#else
	#ifdef ENGLISH
		#define STR0001 "COMPANY       "
		#define STR0002 "AT            "
		#define STR0003 "FAX           "
		#define STR0004 "TEL.NO.          "
		#define STR0005 "BASED ON TELEPHONE CALLS, WE WOULD LIKE YOU TO PROVIDE THE RESERVATION"
		#define STR0006 "ACCORDING TO THE DETAILS BELOW."
		#define STR0007 "*** AS SOON AS CONFIRMED BY FAX, PLEASE REFER OUR REFERENCE NUMBER"
		#define STR0008 "TARGET FORWARDING AGENT AND IF IT WILL HOLD TRANSHIPMENT. iF SO, ADD DETAILS"
		#define STR0009 "CONCERNING THE SHIP WHICH WILL HOLD THE CONNECTION. ***"
		#define STR0010 "                          RESERVE SQUARE NUMB. "
		#define STR0011 "N/REF.:   "
		#define STR0012 " CUSTOMER: "
		#define STR0013 "# SHIP                   => "
		#define STR0014 "# HARBOUR                   => "
		#define STR0015 "# SHIPOWNER                 => "
		#define STR0016 "# SOURCE ETA/ETS      => "
		#define STR0017 "# ETA Target             => "
		#define STR0018 "# DELIV.DATE   LOAD/ DOCS.=> PLEASE INFORM "
		#define STR0019 "# LOAD DELIVERY PLACE     => PLEASE INFORM "
		#define STR0020 "# FORWARDING AGENT             => "
		#define STR0021 "# FONE / CONTACT          => "
		#define STR0022 "# GOODS                   => "
		#define STR0023 "# FINAL PACKAGE               => "
		#define STR0024 "# PACKAGING TOTAL         => "
		#define STR0025 "# T.GROSS WEIGHT - KG     => "
		#define STR0026 "# M3 TOTAL                => "
		#define STR0027 "# FREIGHT                   => "
		#define STR0028 "                          =>PLEASE CONFIRM "
		#define STR0029 "# NO/RESERVATION          => "
		#define STR0030 "# NOTES                   => "
		#define STR0031 "YOURS TRULY "
		#define STR0032 "TEL.NO.: "
		#define STR0033 "FAX : "
		#define STR0034 "RESERVE SQUARE NUMB."
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Empresa       ", "EMPRESA       " )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "At            ", "AT            " )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Fax           ", "FAX           " )
		#define STR0004 If( cPaisLoc $ "ANG|PTG", "Telefone          ", "FONE          " )
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Conforme Contacto Telefónico Mantido Com V.exa., Por Favor Providenciar A Reserva De", "CONFORME CONTATO TELEFONICO MANTIDO COM V.SA. FAVOR PROVIDENCIAR A RESERVA DE" )
		#define STR0006 If( cPaisLoc $ "ANG|PTG", "Espaço Conforme Detalhes Abaixo.", "ESPACO CONFORME DETALHES ABAIXO." )
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "***  Quando Efectuar A Confirmação Via Fax, Por Favor Indique O Número Do Nosso", "***  QUANDO DA CONFIRMACAO VIA FAX, GENTILEZA MENCIONAR O NUMERO DA NOSSA" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Referência, Agente De Destino, Se Será Com Transbordo E Caso Positivo, Detalhes", "REFERENCIA, AGENTE DE DESTINO, SE SERA COM TRANSBORDO E CASO POSITIVO, DETALHES" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Do navio que fará a ligação. ***", "DO NAVIO QUE FARA A CONEXAO. ***" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "                          reserva de andar  nº ", "                          RESERVA DE PRACA  NR " )
		#define STR0011 If( cPaisLoc $ "ANG|PTG", "N/ref.:   ", "N/REF.:   " )
		#define STR0012 If( cPaisLoc $ "ANG|PTG", " cliente: ", " CLIENTE: " )
		#define STR0013 If( cPaisLoc $ "ANG|PTG", "# navio                   => ", "# NAVIO                   => " )
		#define STR0014 If( cPaisLoc $ "ANG|PTG", "# porto                   => ", "# PORTO                   => " )
		#define STR0015 If( cPaisLoc $ "ANG|PTG", "# armador                 => ", "# ARMADOR                 => " )
		#define STR0016 If( cPaisLoc $ "ANG|PTG", "# eta/ets origem          => ", "# ETA/ETS ORIGEM          => " )
		#define STR0017 If( cPaisLoc $ "ANG|PTG", "# eta destino             => ", "# ETA DESTINO             => " )
		#define STR0018 If( cPaisLoc $ "ANG|PTG", "# Data Entrega Carga/doc.=> Favor Informar", "# DATA ENTREGA CARGA/DOCS.=> FAVOR INFORMAR" )
		#define STR0019 If( cPaisLoc $ "ANG|PTG", "# Local P/entrega Da Carga=> Favor Informar", "# LOCAL P/ENTREGA-DA CARGA=> FAVOR INFORMAR" )
		#define STR0020 If( cPaisLoc $ "ANG|PTG", "# despachante             => ", "# DESPACHANTE             => " )
		#define STR0021 If( cPaisLoc $ "ANG|PTG", "# telefone / contacto          => ", "# FONE / CONTATO          => " )
		#define STR0022 If( cPaisLoc $ "ANG|PTG", "# mercadoria              => ", "# MERCADORIA              => " )
		#define STR0023 If( cPaisLoc $ "ANG|PTG", "# embalagem final         => ", "# EMBALAGEM FINAL         => " )
		#define STR0024 If( cPaisLoc $ "ANG|PTG", "# total de embalagens     => ", "# TOTAL DE EMBALAGENS     => " )
		#define STR0025 If( cPaisLoc $ "ANG|PTG", "# p. bruto total - kg     => ", "# P. BRUTO TOTAL - KG     => " )
		#define STR0026 If( cPaisLoc $ "ANG|PTG", "# m3 total                => ", "# M3 TOTAL                => " )
		#define STR0027 If( cPaisLoc $ "ANG|PTG", "# transportar                   => ", "# FRETE                   => " )
		#define STR0028 If( cPaisLoc $ "ANG|PTG", "                          => Favor Confirmar", "                          => FAVOR CONFIRMAR" )
		#define STR0029 If( cPaisLoc $ "ANG|PTG", "# s/reserva               => ", "# S/RESERVA               => " )
		#define STR0030 If( cPaisLoc $ "ANG|PTG", "# observações             => ", "# OBSERVACOES             => " )
		#define STR0031 If( cPaisLoc $ "ANG|PTG", "Atenciosamente ", "ATENCIOSAMENTE " )
		#define STR0032 If( cPaisLoc $ "ANG|PTG", "Telefone: ", "FONE: " )
		#define STR0033 If( cPaisLoc $ "ANG|PTG", "Fax : ", "FAX : " )
		#define STR0034 If( cPaisLoc $ "ANG|PTG", "Reserva de praca nr ", "RESERVA DE PRAÇA NR " )
	#endif
#endif
