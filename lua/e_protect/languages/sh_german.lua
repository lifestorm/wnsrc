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
    slib.setLang("eprotect", "de", "sc-preview", "Screenshot Vorschau - ")
    slib.setLang("eprotect", "de", "net-info", "Net Info - ")
    slib.setLang("eprotect", "de", "ip-info", "IP Info - ")
    slib.setLang("eprotect", "de", "id-info", "ID Info - ")
    slib.setLang("eprotect", "de", "ip-correlation", "IP Korrelation - ")
    slib.setLang("eprotect", "de", "table-viewer", "Tabellenbetrachtung")

    slib.setLang("eprotect", "de", "tab-general", "Generell")
    slib.setLang("eprotect", "de", "tab-identifier", "Kennung")
    slib.setLang("eprotect", "de", "tab-netlimiter", "Net-Begrenzer")
    slib.setLang("eprotect", "de", "tab-netlogger", "Net Logger")
    slib.setLang("eprotect", "de", "tab-exploitpatcher", "Exploit Patcher")
    slib.setLang("eprotect", "de", "tab-exploitfinder", "Exploit Finder")
    slib.setLang("eprotect", "de", "tab-fakeexploits", "Fake Exploits")
    slib.setLang("eprotect", "de", "tab-datasnooper", "Datenschnüffler")

    slib.setLang("eprotect", "de", "player-list", "Spielerliste")

    slib.setLang("eprotect", "de", "ratelimit", "Bewertungslimit")
    slib.setLang("eprotect", "de", "ratelimit-tooltip", "Dies ist ein allgemeines Bewertungslimit und wird durch bestimmte festgelegte Grenzwerte außer Kraft gesetzt. (Xs / Y)")

    slib.setLang("eprotect", "de", "timeout", "Timeout")
    slib.setLang("eprotect", "de", "timeout-tooltip", "Dies ist das Zeitlimit, das den Bewertungslimit-Zähler zurückgesetzt.")

    slib.setLang("eprotect", "de", "overflowpunishment", "Overflow Bestrafung")
    slib.setLang("eprotect", "de", "overflowpunishment-tooltip", "Dies ist die Bestrafung, wenn der Network Way des Spielers zu lang ist. (1 = Kick, 2 = Bann)")

    slib.setLang("eprotect", "de", "enable-networking", "Aktiviere Networking")
    slib.setLang("eprotect", "de", "disable-networking", "Deaktiviere Networking")

    slib.setLang("eprotect", "de", "disable-all-networking", "Deaktiviert serverweit Networking")
    slib.setLang("eprotect", "de", "disable-all-networking-tooltip", "Wenn dies aktiviert ist, kann niemand mit dme Server networken.")

    slib.setLang("eprotect", "de", "player", "Spieler")
    slib.setLang("eprotect", "de", "net-string", "Net String")
    slib.setLang("eprotect", "de", "called", "Aufgerufen")
    slib.setLang("eprotect", "de", "len", "Len")
    slib.setLang("eprotect", "de", "type", "Typ")
    slib.setLang("eprotect", "de", "activated", "Aktiviert")
    slib.setLang("eprotect", "de", "secure", "Gesichert")
    slib.setLang("eprotect", "de", "ip", "IP Adresse")
    slib.setLang("eprotect", "de", "date", "Datum")
    slib.setLang("eprotect", "de", "country-code", "Landesvorwahl")
    slib.setLang("eprotect", "de", "status", "Status")

    slib.setLang("eprotect", "de", "unknown", "Unbekannt")
    slib.setLang("eprotect", "de", "secured", "Gesichert")

    slib.setLang("eprotect", "de", "check-ids", "Check ID(s)")
    slib.setLang("eprotect", "de", "correlate-ip", "Zusammenhängende IP(s)")
    slib.setLang("eprotect", "de", "family-share-check", "Prüfe Family Share")

    slib.setLang("eprotect", "de", "ply-sent-invalid-data", "Dieser Spieler hat ungültige Daten gesendet.")
    slib.setLang("eprotect", "de", "ply-failed-retrieving-data", "%s Daten konnten nicht abgerufen werden.")

    slib.setLang("eprotect", "de", "net-limit-desc", "Die Zahl hier gibt an, wie oft Personen pro Sekunde mit dem Server networken können, bevor die Rate begrenzt wird.")

    slib.setLang("eprotect", "de", "capture", "Screenshot")
    slib.setLang("eprotect", "de", "check-ips", "Prüfe IP(s)")
    slib.setLang("eprotect", "de", "fetch-data", "Daten abrufen")
elseif SERVER then
    slib.setLang("eprotect", "de", "invalid-player", "Dieser Spieler ist ungültig!")
    slib.setLang("eprotect", "de", "kick-net-overflow", "Du wurdest wegen Net-Overflow vom Server geworfen!")
    slib.setLang("eprotect", "de", "banned-net-overflow", "Du wurdest wegen Net-Overflow vom Server gebannt!")
    slib.setLang("eprotect", "de", "banned-net-exploitation", "Du wurdest wegen Net-Exploiting vom Server gebannt!")
    slib.setLang("eprotect", "de", "kick-malicious-intent", "Du wurdest wegen bösen Absichten vom Server geworfen!")
    slib.setLang("eprotect", "de", "banned-malicious-intent", "Du wurdest wegen bösen Absichten vom Server gebannt!")

    slib.setLang("eprotect", "de", "banned-exploit-attempt", "Du wurdest wegen versuchtem Exploiting gebannt!")

    slib.setLang("eprotect", "de", "sc-timeout", "Du musst %s Sekunden warten, bis du %s wieder screenshoten kannst!")
    slib.setLang("eprotect", "de", "sc-failed", "Screenshot von %s konnte nicht abgerufen werden, dies ist verdächtig!")

    slib.setLang("eprotect", "de", "has-family-share", "%s spielt über Family Sharing, SteamID64 des Besitzers ist: %s!")
    slib.setLang("eprotect", "de", "no-family-share", "%s spielt das Spiel nicht durch Family Sharing!")
    slib.setLang("eprotect", "de", "no-correlation", "Wir konnten keine IPs für %s korrelieren.")
end