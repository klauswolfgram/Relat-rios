#ifdef SPANISH
	#define STR0001 "-TRANSPORTADOR"
	#define STR0002 "-AGENTE EMBARCADOR"
	#define STR0003 "Agente Actual"
	#define STR0004 "Agente Nuevo"
	#define STR0005 "Embarc.Actual"
	#define STR0006 "Embarc. Nueva"
	#define STR0007 "ETA Actual"
	#define STR0008 "ETA Nuevo"
	#define STR0009 "ETS Actual"
	#define STR0010 "ETS Nuevo"
#else
	#ifdef ENGLISH
		#define STR0001 "-CARRIER"
		#define STR0002 "-FORWARDING AGENT"
		#define STR0003 "Current Agent"
		#define STR0004 "New Agent"
		#define STR0005 "Current Shipment"
		#define STR0006 "New Shipment"
		#define STR0007 "Current ETS"
		#define STR0008 "New ETS"
		#define STR0009 "Current ETS"
		#define STR0010 "New ETS"
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "-transportadora", "-TRANSPORTADORA" )
		#define STR0002 If( cPaisLoc $ "ANG|PTG", "-agente Embarcador ", "-AGENTE EMBARCADOR" )
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Agente Actual", "Agente Atual" )
		#define STR0004 "Agente Novo"
		#define STR0005 If( cPaisLoc $ "ANG|PTG", "Embarc. actual", "Embarc.Atual" )
		#define STR0006 "Embarc. Novo"
		#define STR0007 If( cPaisLoc $ "ANG|PTG", "Eta Actual", "ETA Atual" )
		#define STR0008 If( cPaisLoc $ "ANG|PTG", "Eta Novo", "ETA Novo" )
		#define STR0009 If( cPaisLoc $ "ANG|PTG", "Ets Actual", "ETS Atual" )
		#define STR0010 If( cPaisLoc $ "ANG|PTG", "Ets Novo", "ETS Novo" )
	#endif
#endif
