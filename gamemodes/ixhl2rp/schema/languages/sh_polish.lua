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
	schemaName = "Half-Life Roleplay",
	tying = "Związywanie...",
	unTying = "Rozwiązywanie...",
	isTied = "Związany",
	fTiedUp = "Zostałeś związany.",
	fBeingTied = "Jesteś związywany.",
	tiedUp = "Jest związany.",
	beingTied = "Jest związywany.",
	beingUntied = "Jest rozwiązywany.",
	needRequestDevice = "W tym celu potrzebne jest urządzenie zgłoszeniowe.",
	cantViewData = "Nie możesz wyświetlić danych tej osoby.",
	cid = "CID",
	citizenid = "Citizen ID",
	lastEdit = "Ostania rewizja przez",
	lastEditDate = "Ostatnia rewizja w dniu",
	objectivesTitle = "Obecne cele",
	searchingCorpse = "Przeszukiwanie zwłok...",
	radioNotOn = "Twoje radio nie jest włączone!",
	radioRequired = "W tym celu potrzebne jest radio.",
	radioAlreadyOn = "Masz już włączone radio!",
	economy = "Ekonomia",
	itemAlreadyEquipped = "Masz już taki wyposażony przedmiot!",

	-- combine display messages
	cViewData = "Pobieranie danych profilu obywatela...",
	cViewDataExpired = "BŁĄD! Nie udało się wgrać aktualnych danych profilu obywatela...",
	cViewDataUpdate = "Wgrywanie aktualnych danych profilu obywatela...",
	cViewDataFiller = "Buforowanie aktualnej bazy danych profili obywateli...",
	cViewObjectives = "Pobieranie celu manifestu Overwatch...",
	cViewObjectivesUpdate = "Przesyłam uaktualniony cel manifestu Overwatch...",
	cViewObjectivesFiller = "Pobieranie nadchodzącego celu manifestu Overwatch (REWIZJA %d)...",
	cCivilJudgement = "Sporządzanie protokołów czynności orzeczniczych w sprawie cywilnej...",
	cRequest = "Pobieranie pakietu żądań...",
	cCitizenLoaded = "Rekonstrukcja manifestu obywatelskiego...",
	cCombineLoaded = "Aktualizacja współrzędnych biosygnału...",
	cLostBiosignal = "Pobieranie utraconego biosygnału...",
	cLostBiosignalLocation = "OSTRZEŻENIE! UTRACONO BIOSYGNAŁ DLA JEDNOSTKI %s",
	cUnitCriticallyInjured = "OSTRZEŻENIE! JEDNOSTKA %s WYMAGA NATYCHMIASTOWEJ POMOCY MEDYCZNEJ",
	cTrauma = "OSTRZEŻENIE! Wykryto uraz %s.",
	cDroppingVitals = "OSTRZEŻENIE! SPADEK PARAMETRÓW ŻYCIOWYCH, NALEŻY NATYCHMIAST ZWRÓCIĆ SIĘ O POMOC MEDYCZNĄ",
	cStaminaLost = "UWAGA: Nadmierny wysiłek użytkownika, podawanie środków pobudzających...",
	cStaminaGained = "PODANO STYMULANT",
	cLosingContact = "Pobieranie utraconych informacji kontaktowych radia...",
	cLostContact = "OSTRZEŻENIE! Utracono kontakt radiowy z jednostką w nieznanej lokalizacji...",

	voices = "Głosy",
	dispatchsound = "Dźwięk Dispatch",

	optColorModify = "Włącz modyfikacje koloru",
    optdColorModify = "Włącz lub wyłącza modyfikacje koloru.",

	optColorSaturation = "Nasycenie kolorów",
	optdColorSaturation = "Nasycenie kolorów ekranu. Nic nie robi, jeśli opcja 'Włącz modyfikacje koloru' jest wyłączona.",

	administration = "Administracja",
	notice = "Powiadomienia",
	civilprot = "Civil Protection",

	optSeeGlobalOOC = "Pokaż globalne OOC",
	optdSeeGlobalOOC = "Pokaż globalny czat OOC w oknie czatu.",
	optIconIncognitoMode = "Tryb incognito ikony administratora OOC/LOOC",
	optdIconIncognitoMode = "Pokaż/nie pokazuj ikony administratora w LOOC i OOC.",
	optStandardIconsEnabled = "Włącz standardowe ikony",
	optdStandardIconsEnabled = "Włącz/wyłącz standardowe ikony przed każdą wiadomością czatu.",

	dispatchTypoWarning = "To, co zamierzasz transmitować, nie jest prawidłowym poleceniem głosowym. Wyślij ponownie w ciągu 5 sekund, aby nadać transmisję mimo to.",
	textDoubleCommand = "Twój tekst zawierał dodatkowy tekst '%s' na początku, ale został on odfiltrowany. Uważaj!",
	cmdPunch = "Pozwala jednostce OTA uderzyć kogoś, natychmiast go nokautując.",
	cmdListColors = "Wydrukuj wszystkie dostępne kolory w konsoli.",
	ColorsPrinted = "Wszystkie dostępne kolory zostały wydrukowane w konsoli.",
	cmdVisorMessage = "Wyświetl komunikat w wizjerze wszystkich jednostek Overwatch Transhuman Arm.",
	cmdPlyNotify = "Wyślij powiadomienie do konkretnego gracza.",
	notificationSent = "Powiadomienie zostało wysłane.",
	cmdWD = "Szepnij coś do konkretnej osoby w pobliżu. Użyj \"@\", aby skierować polecenie do osoby znajdującej się przed tobą.",
	targetTooFar = "Ta osoba jest zbyt daleko, by usłyszeć twój szept!",
	cmdGetCWUFlags = "Przyznaj sobie tymczasowe flagi PET do użytku podczas Cyklów Pracy.",
	cwuFlagsCooldown = "Musisz odczekać godzinę przed użyciem tego polecenia!",
	cwuFlagsGivenAdmins = "%s (%s) nadał sobie tymczasowe flagi PET za pomocą polecenia /GetCWUFlags!",
	cwuFlagsGivenPlayer = "Przyznałeś sobie flagi PET na jedną (1) godzinę. Nadużywanie lub niewłaściwe używanie tej komendy w jakikolwiek sposób będzie karane.",
	cmdUnstuck = "Uwolnij się, jeśli jesteś w ścianie, zostałeś zabity przez prop itp. Nadużycie przewiduje karę.",
	unstuckCooldown = "Musisz odczekać godzinę przed użyciem tego polecenia!",
	unstuckAdmins = "%s (%s) użył komendy /UnStuck w %s! Powodem użycia komendy /UnStuck jest: %s",
	unstuckPlayer = "Uwolniłeś się. Administracja została powiadomiona.",
	unstuckAnswerIncorrect = "Nie jest to poprawna odpowiedź!",
	unstuckAnswerInvalid = "Nie jest to właściwa odpowiedź!"
}