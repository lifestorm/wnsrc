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
    slib.setLang("eprotect", "tr", "sc-preview", "Ekranı Görüntüle - ")
    slib.setLang("eprotect", "tr", "net-info", "Ağ bilgisi - ")
    slib.setLang("eprotect", "tr", "ip-info", "IP bilgisi - ")
    slib.setLang("eprotect", "tr", "id-info", "ID bilgisi - ")
    slib.setLang("eprotect", "tr", "ip-correlation", "IP ilişkisi - ")
    slib.setLang("eprotect", "tr", "table-viewer", "Masa Görüntülemesi")

    slib.setLang("eprotect", "tr", "tab-general", "Genel")
    slib.setLang("eprotect", "tr", "tab-identifier", "Tanımlayıcı")
    slib.setLang("eprotect", "tr", "tab-netlimiter", "Bağ limitleyicisi")
    slib.setLang("eprotect", "tr", "tab-netlogger", "Ağ kayıtçısı")
    slib.setLang("eprotect", "tr", "tab-exploitpatcher", "Exploit Güncelleyici")
    slib.setLang("eprotect", "tr", "tab-exploitfinder", "Exploit Bulucusu")
    slib.setLang("eprotect", "tr", "tab-fakeexploits", "Sahte Exploitler")
    slib.setLang("eprotect", "tr", "tab-datasnooper", "Kayıt ağı")

    slib.setLang("eprotect", "tr", "player-list", "Oyuncu Listesi")

    slib.setLang("eprotect", "tr", "ratelimit", "Hız sınırlayıcısı")
    slib.setLang("eprotect", "tr", "ratelimit-tooltip", "Bu genel bir hız sınırlayıcısı. (Xs/Y)")

    slib.setLang("eprotect", "tr", "timeout", "Zaman Aşımı")
    slib.setLang("eprotect", "tr", "timeout-tooltip", "Bu zaman aşımı genel hız sınırlayıcısına karşıdır.")
    
    slib.setLang("eprotect", "tr", "overflowpunishment", "Taşma cezası")
    slib.setLang("eprotect", "tr", "overflowpunishment-tooltip", "Bu ceza ağı rahatlatmak için uygulanır. (1 = kick, 2 = ban)")

    slib.setLang("eprotect", "tr", "enable-networking", "Ağ oluşturmayı aktifleştir")
    slib.setLang("eprotect", "tr", "disable-networking", "Ağ oluşturmayı engelle")

    slib.setLang("eprotect", "tr", "disable-all-networking", "Tüm ağ oluşturmayı engelle")
    slib.setLang("eprotect", "tr", "disable-all-networking-tooltip", "Eğer bu aktif olursa kimse sunucuya giremez!")

    slib.setLang("eprotect", "tr", "player", "Player")
    slib.setLang("eprotect", "tr", "net-string", "Net String")
    slib.setLang("eprotect", "tr", "called", "Called")
    slib.setLang("eprotect", "tr", "len", "Len")
    slib.setLang("eprotect", "tr", "type", "Type")
    slib.setLang("eprotect", "tr", "activated", "Activated")
    slib.setLang("eprotect", "tr", "secure", "Secured")
    slib.setLang("eprotect", "tr", "ip", "IP Adress")
    slib.setLang("eprotect", "tr", "date", "Date")
    slib.setLang("eprotect", "tr", "country-code", "Country code")
    slib.setLang("eprotect", "tr", "status", "Status")

    slib.setLang("eprotect", "tr", "unknown", "Unknown")
    slib.setLang("eprotect", "tr", "secured", "Secured")

    slib.setLang("eprotect", "tr", "check-ids", "ID'leri kontrol et")
    slib.setLang("eprotect", "tr", "correlate-ip", "IP adreslerini ilişkilendir")
    slib.setLang("eprotect", "tr", "family-share-check", "Aile paylaşımını kontrol et")

    slib.setLang("eprotect", "tr", "ply-sent-invalid-data", "Bu oyuncu geçersiz data gönderdi!")
    slib.setLang("eprotect", "tr", "ply-failed-retrieving-data", "%s data alınamadı!")

    slib.setLang("eprotect", "tr", "net-limit-desc", "Buradaki sayı, insanların hız sınırlandırılmadan önce bir saniye içinde sunucuya maksimum ağ kurma sayısıdır..")

    slib.setLang("eprotect", "tr", "capture", "Screenshot")
    slib.setLang("eprotect", "tr", "check-ips", "Check IP(s)")
    slib.setLang("eprotect", "tr", "fetch-data", "Fetch Data")
elseif SERVER then
    slib.setLang("eprotect", "tr", "invalid-player", "böyle bir oyuncu yok!")
    slib.setLang("eprotect", "tr", "kick-net-overflow", "Net ağına karşı kötü niyetli eylem gerçekleştirdiğinizden dolayı atıldınız!")
    slib.setLang("eprotect", "tr", "banned-net-overflow", "Net ağına karşı kötü niyetli eylem gerçekleştirdiğinizden dolayı yasaklandınız !")
    slib.setLang("eprotect", "tr", "banned-net-exploitation", "Net ağına karşı kötü niyetli eylem gerçekleştirdiğinizden dolayı yasaklandınız!")
    slib.setLang("eprotect", "tr", "kick-malicious-intent", "Kötü niyetli eylem gerçekleştirdiğinizden dolayı sunucudan atıldınız!")
    slib.setLang("eprotect", "tr", "banned-malicious-intent", "Kötü niyetli eylem gerçekleştirdiğinizden dolayı sunucudan yasaklandınız!")

    slib.setLang("eprotect", "tr", "banned-exploit-attempt", "Exploit kullanmaya çalıştığın için sunucudan yasaklandın !")

    slib.setLang("eprotect", "tr", "sc-timeout", "Şu kadar  %s saniye beklemen gerek %s tekrar ekran görüntüsü almak için!")
    slib.setLang("eprotect", "tr", "sc-failed", "Şu kişiden ekran görüntüsü alınamadı %s, şüpheli!")

    slib.setLang("eprotect", "tr", "has-family-share", "%s Aile paylaşımından oynuyor oyunu  ödünç aldığı kişinin ID'si %s!")
    slib.setLang("eprotect", "tr", "no-family-share", "%s Aile paylaşımından oynamıyor!")
    slib.setLang("eprotect", "tr", "no-correlation", "Şu değer için hiç bir IP adresi ilişkilendirilemedi %s")
end