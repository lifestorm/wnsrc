--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

if CLIENT then
    slib.setLang("eprotect", "es", "sc-preview", " Preview de Screenshot - ")
    slib.setLang("eprotect", "es", "net-info", "Información Net - ")
    slib.setLang("eprotect", "es", "ip-info", "Información de IP - ")
    slib.setLang("eprotect", "es", "id-info", "Información de ID - ")
    slib.setLang("eprotect", "es", "ip-correlation", "Correlación de IP - ")
    slib.setLang("eprotect", "es", "table-viewer", "Visor de Mesas")

    slib.setLang("eprotect", "es", "tab-general", "General")
    slib.setLang("eprotect", "es", "tab-identifier", "Identificador")
    slib.setLang("eprotect", "es", "tab-netlimiter", "Limitador Net")
    slib.setLang("eprotect", "es", "tab-netlogger", "Loggs Net")
    slib.setLang("eprotect", "es", "tab-exploitpatcher", "Parcheador de Exploits")
    slib.setLang("eprotect", "es", "tab-exploitfinder", "Buscador de Exploits")
    slib.setLang("eprotect", "es", "tab-fakeexploits", "Exploits Falsos")
    slib.setLang("eprotect", "es", "tab-datasnooper", "Fisgón de Datos")

    slib.setLang("eprotect", "es", "player-list", "Lista de Jugadores")

    slib.setLang("eprotect", "es", "ratelimit", "LimitadorRate")
    slib.setLang("eprotect", "es", "ratelimit-tooltip", "Este es un Limitador-Rate y funciona para poner ciertos limites. (Xs/Y)")

    slib.setLang("eprotect", "es", "timeout", "Tiempo")
    slib.setLang("eprotect", "es", "timeout-tooltip", "El tiempo el el intervalo entre que se resetea el contador del LimitadorRate.")
    
    slib.setLang("eprotect", "es", "overflowpunishment", "Castigo de Overflow")
    slib.setLang("eprotect", "es", "overflowpunishment-tooltip", "Este es el castigo que va a tener la gente que usa demasiado network. (1 = kick, 2 = ban)")

    slib.setLang("eprotect", "es", "enable-networking", "Habilitar networking")
    slib.setLang("eprotect", "es", "disable-networking", "Deshabilitar networking")

    slib.setLang("eprotect", "es", "disable-all-networking", "Deshabilitar todo el networking")
    slib.setLang("eprotect", "es", "disable-all-networking-tooltip", "Si esto esta habilitado, nadie va a poder usar el network en el server!")

    slib.setLang("eprotect", "es", "player", "Jugador")
    slib.setLang("eprotect", "es", "net-string", "Net String")
    slib.setLang("eprotect", "es", "called", "LLamado")
    slib.setLang("eprotect", "es", "len", "Len")
    slib.setLang("eprotect", "es", "type", "Tipo")
    slib.setLang("eprotect", "es", "activated", "Activado")
    slib.setLang("eprotect", "es", "secure", "Seguro")
    slib.setLang("eprotect", "es", "ip", "Dirección IP")
    slib.setLang("eprotect", "es", "date", "Fecha")
    slib.setLang("eprotect", "es", "country-code", "Código de País")
    slib.setLang("eprotect", "es", "status", "Status")

    slib.setLang("eprotect", "es", "unknown", "Desconocido")
    slib.setLang("eprotect", "es", "secured", "Seguro")

    slib.setLang("eprotect", "es", "check-ids", "Checkear ID(s)")
    slib.setLang("eprotect", "es", "correlate-ip", "Correlacionar IP(s)")
    slib.setLang("eprotect", "es", "family-share-check", "Checkear Cuentas Familiares")

    slib.setLang("eprotect", "es", "ply-sent-invalid-data", "Este Jugador envió datos inválidos!")
    slib.setLang("eprotect", "es", "ply-failed-retrieving-data", "%s Fallo al recibir datos!")

    slib.setLang("eprotect", "es", "net-limit-desc", "Este nuemero es la cantidad de veces que la gente puede usar network en un segundo antes de usar el LimitadorRate.")

    slib.setLang("eprotect", "es", "capture", "Screenshot")
    slib.setLang("eprotect", "es", "check-ips", "Checkear IP(s)")
    slib.setLang("eprotect", "es", "fetch-data", "Buscar Datos")
elseif SERVER then
    slib.setLang("eprotect", "es", "invalid-player", "Este Jugador en invalido!")
    slib.setLang("eprotect", "es", "kick-net-overflow", "Fuiste expulsado por net overflow!")
    slib.setLang("eprotect", "es", "banned-net-overflow", "Fuiste suspendido por net overflow!")
    slib.setLang("eprotect", "es", "banned-net-exploitation", "Fuiste expulsado por exploitiar mensajes net!")
    slib.setLang("eprotect", "es", "kick-malicious-intent", "Fuiste expulsado por intenciones maliciosas!")
    slib.setLang("eprotect", "es", "banned-malicious-intent", "Fuiste suspendido por intenciones maliciosas!")

    slib.setLang("eprotect", "es", "banned-exploit-attempt", "Fuiste suspendido por intentar usar un maliciosas!")

    slib.setLang("eprotect", "es", "sc-timeout", "Tenes que esperar %s segundos antes de poder screeshotear a %s otra vez!")
    slib.setLang("eprotect", "es", "sc-failed", "Fallo al cargar screenshot de %s, sospechoso...")

    slib.setLang("eprotect", "es", "has-family-share", "%s esta jugando con una cuenta familiar, el SteamD64 del dueño es %s")
    slib.setLang("eprotect", "es", "no-family-share", "%s no esta jugando con una cuenta familiar!")
    slib.setLang("eprotect", "es", "no-correlation", "No se pudieron correlacionar IPs con %s")
end