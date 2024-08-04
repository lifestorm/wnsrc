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
    slib.setLang("eprotect", "pl", "sc-preview", "Podgląd zrzutu ekranu - ")
    slib.setLang("eprotect", "pl", "net-info", "Net Info - ")
    slib.setLang("eprotect", "pl", "ip-info", "IP Info - ")
    slib.setLang("eprotect", "pl", "id-info", "ID Info - ")
    slib.setLang("eprotect", "pl", "ip-correlation", "Lokalizacja IP - ")
    slib.setLang("eprotect", "pl", "table-viewer", "Table Viewer")

    slib.setLang("eprotect", "pl", "tab-general", "Ogólne")
    slib.setLang("eprotect", "pl", "tab-identifier", "Identifier")
    slib.setLang("eprotect", "pl", "tab-netlimiter", "Ogranicznik Net")
    slib.setLang("eprotect", "pl", "tab-netlogger", "Rejestrator Net")
    slib.setLang("eprotect", "pl", "tab-exploitpatcher", "Łatka Exploitów")
    slib.setLang("eprotect", "pl", "tab-exploitfinder", "Exploit Finder")
    slib.setLang("eprotect", "pl", "tab-fakeexploits", "Fake Exploits")
    slib.setLang("eprotect", "pl", "tab-datasnooper", "Data Snooper")

    slib.setLang("eprotect", "pl", "player-list", "Lista graczy")

    slib.setLang("eprotect", "pl", "ratelimit", "Ratelimit")
    slib.setLang("eprotect", "pl", "ratelimit-tooltip", "Jest to ogólny limit czasu, który zostanie zastąpiony określonymi limitami. (Xs/Y)")

    slib.setLang("eprotect", "pl", "timeout", "Timeout")
    slib.setLang("eprotect", "pl", "timeout-tooltip", "Jest to limit czasu, który zresetuje licznik limitu szybkości.")
    
    slib.setLang("eprotect", "pl", "overflowpunishment", "Próg kary Net Exploit")
    slib.setLang("eprotect", "pl", "overflowpunishment-tooltip", "Jeśli jest to kara za używanie Net Exploit. (1 = kick, 2 = ban)")

    slib.setLang("eprotect", "pl", "enable-networking", "Włącz sieć")
    slib.setLang("eprotect", "pl", "disable-networking", "Wyłącz sieć")

    slib.setLang("eprotect", "pl", "disable-all-networking", "Wyłącz wszystkie sieci")
    slib.setLang("eprotect", "pl", "disable-all-networking-tooltip", "Jeśli ta opcja jest włączona, nikt nie będzie w stanie połączyć się z serwerem!")

    slib.setLang("eprotect", "pl", "player", "Gracz")
    slib.setLang("eprotect", "pl", "net-string", "Zmienna Net")
    slib.setLang("eprotect", "pl", "called", "Zapytanie")
    slib.setLang("eprotect", "pl", "len", "Rozmiar")
    slib.setLang("eprotect", "pl", "type", "Typ")
    slib.setLang("eprotect", "pl", "activated", "Aktywowany")
    slib.setLang("eprotect", "pl", "secure", "Zabezpieczone")
    slib.setLang("eprotect", "pl", "ip", "IP Adress")
    slib.setLang("eprotect", "pl", "date", "Data")
    slib.setLang("eprotect", "pl", "country-code", "Kod kraju")
    slib.setLang("eprotect", "pl", "status", "Status")

    slib.setLang("eprotect", "pl", "unknown", "Nieznany")
    slib.setLang("eprotect", "pl", "secured", "Zabezpieczone")

    slib.setLang("eprotect", "pl", "check-ids", "Sprawdź ID")
    slib.setLang("eprotect", "pl", "correlate-ip", "Lokalizacja IP")
    slib.setLang("eprotect", "pl", "family-share-check", "Sprawdź Family Share")

    slib.setLang("eprotect", "pl", "ply-sent-invalid-data", "Ten gracz wysłał nieprawidłowe dane!")
    slib.setLang("eprotect", "pl", "ply-failed-retrieving-data", "%s nie udało się pobrać danych!")

    slib.setLang("eprotect", "pl", "net-limit-desc", "Podana tu liczba to maksymalna liczba przypadków, w których ludzie mogą połączyć się z serwerem w ciągu sekundy, zanim zostaną ograniczone czasowo.")

    slib.setLang("eprotect", "pl", "capture", "Screenshot")
    slib.setLang("eprotect", "pl", "check-ips", "Sprawdź IP(s)")
    slib.setLang("eprotect", "pl", "fetch-data", "Sprawdź Dane")
elseif SERVER then
    slib.setLang("eprotect", "pl", "invalid-player", "Nie ma takiego Gracza!")
    slib.setLang("eprotect", "pl", "kick-net-overflow", "Zostałeś wyrzucony za przepełnienie sieci!")
    slib.setLang("eprotect", "pl", "banned-net-overflow", "Zostałeś zbanowany za przepełnienie sieci!")
    slib.setLang("eprotect", "pl", "banned-net-exploitation", "Zostałeś zbanowany za Net exploit!")
    slib.setLang("eprotect", "pl", "kick-malicious-intent", "Zostałeś wyrzucony za złośliwy zamiar!")
    slib.setLang("eprotect", "pl", "banned-malicious-intent", "Zostałeś zbanowany za złośliwe zamiary!")

    slib.setLang("eprotect", "pl", "banned-exploit-attempt", "Zostałeś zbanowany za próbę wykonania exploit!")

    slib.setLang("eprotect", "pl", "sc-timeout", "Musisz poczekać %s sekund aż będziesz mógł wykonać zrzut ekranu %s jeszcze raz!")
    slib.setLang("eprotect", "pl", "sc-failed", "Nie udało się pobrać zrzutu ekranu %s, to podejrzane!")

    slib.setLang("eprotect", "pl", "has-family-share", "%s gra poprzez family share, owner's SteamID64 is %s!")
    slib.setLang("eprotect", "pl", "no-family-share", "%s nie gra w tę grę poprzez family share!")
    slib.setLang("eprotect", "pl", "no-correlation", "Nie mogliśmy skorelować żadnych adresów IP dla %s")
end