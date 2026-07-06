#ifdef SPANISH
	#define STR0001 "Contactos"
	#define STR0002 "Mensajes"
	#define STR0003 "Contacto 1 "
#else
	#ifdef ENGLISH
		#define STR0001 "Contacts"
		#define STR0002 "Messages"
		#define STR0003 "Contact 1 "
	#else
		#define STR0001 If( cPaisLoc $ "ANG|PTG", "Contactos", "Contatos" )
		#define STR0002 "Mensagens"
		#define STR0003 If( cPaisLoc $ "ANG|PTG", "Contacto 1 ", "Contato 1 " )
	#endif
#endif
