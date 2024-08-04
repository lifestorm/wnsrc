--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

LANGUAGE = {
	schemaName = "Half-Life 2 Roleplay",
	tying = "Bağlanıyor...",
	unTying = "Çözülüyor...",
	isTied = "Bağlı",
	fTiedUp = "Bağlandınız.",
	fBeingTied = "Bağlanıyorsunuz.",
	tiedUp = "Bağlanmışlar.",
	beingTied = "Bağlanıyorlar.",
	beingUntied = "Çözülüyorlar.",
	needRequestDevice = "Bunu yapabilmek için bir talep cihazına ihtiyacınız var.",
	cantViewData = "Bu kişinin verilerini göremiyorsunuz.",
	cid = "CID",
	citizenid = "Vatandaş ID",
	lastEdit = "Son düzenleyen",
	lastEditDate = "Son düzenleme tarihi",
	objectivesTitle = "Mevcut Hedefler",
	searchingCorpse = "Ceset aranıyor...",
	radioNotOn = "Radyonuz açık değil!",
	radioRequired = "Bunu yapabilmek için bir radyoya ihtiyacınız var.",
	radioAlreadyOn = "Zaten açık olan bir radyonuz var!",
	economy = "Ekonomi",
	itemAlreadyEquipped = "Bu türden bir eşyanız zaten donanımda!",

	-- combine display messages
	cViewData = "Vatandaş profil verileri indiriliyor...",
	cViewDataExpired = "HATA! Revize edilmiş vatandaş profil verileri yüklenemedi...",
	cViewDataUpdate = "Revize edilmiş vatandaş profil verileri yükleniyor...",
	cViewDataFiller = "Revize edilmiş vatandaş profil veri tabanı önbelleğe alınıyor...",
	cViewObjectives = "Koruma hedef manifestosu indiriliyor...",
	cViewObjectivesUpdate = "Revize edilmiş koruma hedef manifestosu yükleniyor...",
	cViewObjectivesFiller = "Gelen koruma hedef manifestosu alınıyor (REVISION %d)...",
	cCivilJudgement = "Sivil yargı yönetim protokollerini hazırlıyor...",
	cRequest = "Talep paketi indiriliyor...",
	cCitizenLoaded = "Vatandaş manifestosu yeniden oluşturuluyor...",
	cCombineLoaded = "Biosinyal koordinatları güncelleniyor...",
	cLostBiosignal = "Kayıp biosinyal indiriliyor...",
	cLostBiosignalLocation = "UYARI! ÜNİTE İÇİN BIOSİNYAL KAYIP %s",
	cUnitCriticallyInjured = "UYARI! ÜNİTE %s ACİL MEDİKAL YARDIM İHTİYACI VAR",
	cTrauma = "UYARI! %s travma tespit edildi.",
	cDroppingVitals = "UYARI! YAŞAMSAL BELİRTİLER DÜŞÜYOR, ACİL MEDİKAL YARDIM ALIN",
	cStaminaLost = "DİKKAT: Aşırı kullanıcı zorlaması, uyarıcı uygulanıyor...",
	cStaminaGained = "UYARICI UYGULANDI",
	cLosingContact = "Kayıp radyo teması bilgileri indiriliyor...",
	cLostContact = "UYARI! Bilinmeyen bir konumda ünite için radyo teması kaybedildi...",

	voices = "Sesler",
	dispatchsound = "Dispatch Sesi",

	optColorModify = "Renk Değiştirme Çizimi",
    optdColorModify = "Renk değişikliklerinin çizimini etkinleştirir veya devre dışı bırakır.",

	optColorSaturation = "Renk Doygunluğu",
	optdColorSaturation = "'Renk Değiştirme Çizimi' devre dışı ise, ekranın renk doygunluğunu değiştirmez.",

	administration = "Yönetim",
	notice = "Bildirimler",
	civilprot = "Sivil Koruma",

	optSeeGlobalOOC = "Global OOC'yi Göster",
	optdSeeGlobalOOC = "Chat kutunuzda Global OOC sohbetini göster.",
	optIconIncognitoMode = "OOC/LOOC Admin Simgesi İncognito Modu",
	optdIconIncognitoMode = "LOOC ve OOC'de Admin Simgesini Göster/ Gösterme.",
	optStandardIconsEnabled = "Standart Simgeleri Etkinleştir",
	optdStandardIconsEnabled = "Her sohbet mesajının önünde standart sohbet simgelerini aç/kapat.",

	dispatchTypoWarning = "Yayınlayacağınız şey geçerli bir Ses Komutu değil. 5 saniye içinde tekrar göndermek için onaylayın.",
	textDoubleCommand = "Metninizin başında ekstra bir '%s' metni vardı, ancak bu filtrelendi. Dikkatli olun!",
	cmdPunch = "OTA ünitesinin birini yumruklayarak anında bayıltmasına izin verir.",
	cmdListColors = "Tüm mevcut renkleri konsola yazdır.",
	ColorsPrinted = "Tüm mevcut renkler konsola yazdırıldı.",
	cmdVisorMessage = "Tüm Overwatch Transhuman Kol ünitelerine bir vizör mesajı göster.",
	cmdPlyNotify = "Belirli bir oyuncuya bir bildirim gönder.",
	notificationSent = "Bildirim gönderildi.",
	cmdWD = "Yanınızdaki belirli bir kişiye bir şey fısıldayın. Kişiyi hedeflemek için \"@\" kullanın.",
	targetTooFar = "Bu kişi fısıltınızı duyacak kadar uzakta değil!",
	cmdGetCWUFlags = "Çalışma vardiyalarında kullanmak üzere kendinize geçici PET bayrakları verin.",
	cwuFlagsCooldown = "Bu komutu kullanmadan önce bir saat beklemelisiniz!",
	cwuFlagsGivenAdmins = "%s (%s) kendilerine /GetCWUFlags komutu ile geçici PET bayrakları verdi!",
	cwuFlagsGivenPlayer = "Kendinize bir (1) saat için PET bayrakları verdiniz. Bu komutu kötüye kullanmak veya yanlış kullanmak ceza alacaktır.",
	cmdUnstuck = "Eğer bir duvarın içindeyseniz, bir eşya tarafından öldürüldüyseniz vb. kendinizi kurtarın. Kötüye kullanım ceza alacaktır.",
	unstuckCooldown = "Bu komutu kullanmadan önce bir saat beklemelisiniz!",
	unstuckAdmins = "%s (%s) %s konumunda /UnStuck komutunu kullandı! /UnStuck komutunu çalıştırma nedenleri: %s",
	unstuckPlayer = "Kendinizi kurtardınız. Personel üyeleri bilgilendirildi.",
	unstuckAnswerIncorrect = "Bu doğru bir cevap değil!",
	unstuckAnswerInvalid = "Bu geçerli bir cevap değil!"
}
