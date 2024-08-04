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
    slib.setLang("eprotect", "ru", "sc-preview", "Предпросмотр снимка экрана - ")
    slib.setLang("eprotect", "ru", "net-info", "Net Информация - ")
    slib.setLang("eprotect", "ru", "ip-info", "IP Информация - ")
    slib.setLang("eprotect", "ru", "id-info", "ID Информация - ")
    slib.setLang("eprotect", "ru", "ip-correlation", "IP Совпадение - ")
    slib.setLang("eprotect", "ru", "table-viewer", "Просмотр таблиц")

    slib.setLang("eprotect", "ru", "tab-general", "Главная")
    slib.setLang("eprotect", "ru", "tab-identifier", "Идентификатор")
    slib.setLang("eprotect", "ru", "tab-netlimiter", "Net Лимит")
    slib.setLang("eprotect", "ru", "tab-netlogger", "Net Регистратор")
    slib.setLang("eprotect", "ru", "tab-exploitpatcher", "Патчер эксплойтов")
    slib.setLang("eprotect", "ru", "tab-exploitfinder", "Поиск эксплойтов")
    slib.setLang("eprotect", "ru", "tab-fakeexploits", "Поддельные эксплойты")
    slib.setLang("eprotect", "ru", "tab-datasnooper", "Просмотр Data'ы игрока")

    slib.setLang("eprotect", "ru", "player-list", "Список игроков")

    slib.setLang("eprotect", "ru", "ratelimit", "Ограничение скорости оборотов")
    slib.setLang("eprotect", "ru", "ratelimit-tooltip", "Это общий предел скорости оборотов, который будет отменен конкретными установленными пределами. (Xs / Y)")

    slib.setLang("eprotect", "ru", "timeout", "Тайм-аут")
    slib.setLang("eprotect", "ru", "timeout-tooltip", "Это тайм-аут, который сбросит счетчик предельного числа оборотов..")
    
    slib.setLang("eprotect", "ru", "overflowpunishment", "Наказание за переполнение")
    slib.setLang("eprotect", "ru", "overflowpunishment-tooltip", "Если включено, то люди получат наказание за слишком большое количество трафика сети. (1 = Кик, 2 = Бан)")

    slib.setLang("eprotect", "ru", "enable-networking", "Включить сеть")
    slib.setLang("eprotect", "ru", "disable-networking", "Отключить сеть")

    slib.setLang("eprotect", "ru", "disable-all-networking", "Отключить все сети")
    slib.setLang("eprotect", "ru", "disable-all-networking-tooltip", "Если этот параметр включен, никто не сможет подключиться к серверу по сети!")

    slib.setLang("eprotect", "ru", "player", "Игрок")
    slib.setLang("eprotect", "ru", "net-string", "Net строка")
    slib.setLang("eprotect", "ru", "called", "Называется")
    slib.setLang("eprotect", "ru", "len", "Длина")
    slib.setLang("eprotect", "ru", "type", "Тип")
    slib.setLang("eprotect", "ru", "activated", "Активирована")
    slib.setLang("eprotect", "ru", "secure", "Защищена")
    slib.setLang("eprotect", "ru", "ip", "IP Адрес")
    slib.setLang("eprotect", "ru", "date", "Дата")
    slib.setLang("eprotect", "ru", "country-code", "Код страны")
    slib.setLang("eprotect", "ru", "status", "Статус")

    slib.setLang("eprotect", "ru", "unknown", "Неизвестно")
    slib.setLang("eprotect", "ru", "secured", "Защищена")

    slib.setLang("eprotect", "ru", "check-ids", "Проверить ID")
    slib.setLang("eprotect", "ru", "correlate-ip", "Соотнести IP")
    slib.setLang("eprotect", "ru", "family-share-check", "Проверить Семейный доступ")

    slib.setLang("eprotect", "ru", "ply-sent-invalid-data", "Этот игрок отправил неверные данные!")
    slib.setLang("eprotect", "ru", "ply-failed-retrieving-data", "%s не удалось получить данные!")

    slib.setLang("eprotect", "ru", "net-limit-desc", "Число здесь - это максимальное количество раз, которое люди могут отправить на сервер в секунду, прежде чем будут ограничены по частоте.")

    slib.setLang("eprotect", "ru", "capture", "Скриншот")
    slib.setLang("eprotect", "ru", "check-ips", "Проверить IP")
    slib.setLang("eprotect", "ru", "fetch-data", "Получить Data'у ")
elseif SERVER then
    slib.setLang("eprotect", "ru", "invalid-player", "Этот игрок недействителен!")
    slib.setLang("eprotect", "ru", "kick-net-overflow", "Вас выгнали за переполнение сети!")
    slib.setLang("eprotect", "ru", "banned-net-overflow", "Вас забанили за переполнение сети!")
    slib.setLang("eprotect", "ru", "banned-net-exploitation", "Вас забанили за эксплуатацию в сети!")
    slib.setLang("eprotect", "ru", "kick-malicious-intent", "Вас выгнали за злой умысел!")
    slib.setLang("eprotect", "ru", "banned-malicious-intent", "Вас забанили за злой умысел!")

    slib.setLang("eprotect", "ru", "banned-exploit-attempt", "Вас забанили за попытку использовать эксплоит!")

    slib.setLang("eprotect", "ru", "sc-timeout", "Вам нужно подождать %s секунд, пока вы снова не сможете сделать снимок экрана %s!")
    slib.setLang("eprotect", "ru", "sc-failed", "Не удалось получить снимок экрана %s, это подозрительно!")

    slib.setLang("eprotect", "ru", "has-family-share", "%s играет в игру через семейный ресурс, SteamID64 владельца %s!")
    slib.setLang("eprotect", "ru", "no-family-share", "%s не играет в игру через семейный просмотр.")
    slib.setLang("eprotect", "ru", "no-correlation", "Нам не удалось сопоставить IP-адреса для %s")
end