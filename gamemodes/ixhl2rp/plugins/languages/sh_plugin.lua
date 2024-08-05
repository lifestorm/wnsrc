--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local PLUGIN = PLUGIN

PLUGIN.name = "Languages"
PLUGIN.author = "Fruity"
PLUGIN.description = "Adds a library that can handle registration of languages and actual speech of it."

ix.util.Include("cl_hooks.lua")
ix.util.Include("sv_hooks.lua")

function PLUGIN:AdjustCreationPayload(client, payload, newPayload)
    if (newPayload.data.languages) then
        newPayload.languages = newPayload.data.languages
        newPayload.data.languages = nil
    end

    newPayload.data.language = nil
end

ix.lang.AddTable("english", {
    optLanguageFlagsEnabled = "Enable Language Flags",
    optdLanguageFlagsEnabled = "Enable chat icons to indicate the language in which something is spoken for non-english language IC text."
})

ix.lang.AddTable("spanish", {
	optLanguageFlagsEnabled = "Activa las Flags de Idiomas",
	optdLanguageFlagsEnabled = "Activa los iconos de para indicar el idioma de cosas habladas en otro idioma que no sea español dentro del chat IC."
})

ix.char.RegisterVar("languages", {
	field = "languages",
	default = {},
	isLocal = true,
	bNoDisplay = true
})

ix.char.RegisterVar("learningLanguages", {
	field = "learningLanguages",
	default = {},
	isLocal = true,
	bNoDisplay = true
})

do
    -- Vortigese
    local language = ix.languages:New()
    language.name = "Vortigese"
    language.uniqueID = "vort"
    language.color = Color(51, 153, 51)
    language.notSelectable = true
    function language:PlayerCanSpeakLanguage(client)
        if (client:GetCharacter():IsVortigaunt() and !client:GetNetVar("ixVortNulled")) then
            return true
        end

        return ix.languages:PlayerCanSpeakLanguage(self, client)
    end
    language.gibberish = {"ahglah", "ahhhr", "alla", "allu", "baah", "beh", "bim", "buu", "chaa", "chackt", "churr", "dan", "darr", "dee", "eeya", "ge", "ga", "gaharra",
    "gaka", "galih", "gallalam", "gerr", "gog", "gram", "gu", "gunn", "gurrah", "ha", "hallam", "harra", "hen", "hi", "jah", "jurr", "kallah", "keh", "kih",
    "kurr", "lalli", "llam", "lih", "ley", "lillmah", "lurh", "mah", "min", "nach", "nahh", "neh", "nohaa", "nuy", "raa", "ruhh", "rum", "saa", "seh", "sennah",
    "shaa", "shuu", "surr", "taa", "tan", "tsah", "turr", "uhn", "ula", "vahh", "vech", "veh", "vin", "voo", "vouch", "vurr", "xkah", "xih", "zurr"}

    language:Register()
end

do
    -- Danish
    local language = ix.languages:New()
    language.name = "Danish"
    language.uniqueID = "dan"
    language.icon = "flags16/dk.png"
    language.gibberish = {"alt", "hænder", "ingen", "enig", "mange", "større", "afsted", "hånden", "pludselig", "sød", "tilfreds", "ordre", "færdig", "menneske", "hurtigt", "voksen", "spillede", "papirer",
    "valgt", "lkke", "seks", "sherif", "ringe", "dronning", "opmærksomhed", "kæft", "kiggede", "fald", "morder", "sammen", "forsvinder", "hop", "forsøge", "kaldte", "oberst", "mødte", "brugte",
    "tal", "sad", "røg", "her", "fis", "rigtig", "alvorligt", "vidst", "kop", "danny", "dreng", "været", "bilen", "tror", "masser", "sat", "lade", "bryde", "fart", "skoven",
    "tale", "kører", "dens", "klarede", "rummet", "luk", "føre", "blevet", "trænger", "and", "været", "spørger", "nede", "endda", "stor", "vågn", "købt", "klasse", "overlever"}

    language:Register()
end

do
    -- Japanese
    local language = ix.languages:New()
    language.name = "Japanese"
    language.uniqueID = "jap"
    language.icon = "flags16/jp.png"
    language.gibberish = {"通り", "危険", "全部", "ある", "見つかる", "聞こえる", "すわる", "あめ", "料理", "返す", "準備", "被る", "ひも", "など", "やくしょ、役所", "二日", "まず", "下げる",
    "通る", "つもり", "低い", "ひくい", "選ぶ", "だの", "降る", "相談", "エンジニア", "朝", "残念", "うるさい", "うるさい", "勉強", "年間", "みせ、店", "大切", "たいせつ", "あれ", "買い物", "歯",
    "こぼれる", "給料", "嫌", "公園", "太い", "英語", "みかん", "やかん", "開く", "セーター", "サンドイッチ", "訪ねる", "場所", "ずっと", "高校生", "なみだ", "うまい", "トラック", "四つ角", "最初",
    "どうぞ", "彼", "父", "男の子", "どろ、泥", "生活", "とても", "まま", "そっち", "火傷", "努力", "病院", "帰る", "教科書", "スイカ、西瓜", "複雑", "いとこ", "遊び", "クラス", "緩い", "小さい"}

    language:Register()
end

do
    -- Korean. It is very awkward for Koreans in real life. Change to Medieval Korean
    local language = ix.languages:New()
    language.name = "Korean"
    language.uniqueID = "kor"
    language.icon = "flags16/kr.png"
    language.gibberish = {"력황도가", "빈니산", "상단포", "광참은", "녈하", "홀퍄이", "샤도", "듕귁", "댤하", "나랃말", "싸미", "수므며", "서르", "사맏띠", "젼차", "뜨들", "몯할", "이랄", "어엳삐",
    "해여", "날로", "쑤메", "뼌안킈", "하고져", "녀려신", "머리곰", "노코시라", "졈그", "셰라", "비취오", "시라", "옌니응", "샤미", "회신", "향주", "탼명", "추자", "한두", "대막간", "오행", "세존",
    "상", "채헐", "왕후", "관물", "빛쳐", "말정", "개국", "빛", "못", "놀뎌", "탸다", "텽퍄", "합격", "엇리", "매일", "영겨", "롬", "가야", "금관", "권상", "천강", "지곡",
    "월인", "방문", "여뱌", "관자", "용봉", "창살", "드세욜", "세라", "어긔", "어강됴리", "다롱", "디리", "달하", "마리", "둘흔", "밤드리", "네히어라", "엇디호", "릿고", "만구", "투치아", "악탐", "밴지하"}

    language:Register()
end

do
    -- Chinese
    local language = ix.languages:New()
    language.name = "Chinese"
    language.uniqueID = "chi"
    language.icon = "flags16/cn.png"
    language.gibberish = {"相对", "服务", "认识", "普遍", "假如", "只是", "改变", "报纸", "然而", "王", "部", "具", "展开", "政策", "教育部", "理论", "国际", "其", "保持", "培养",
    "非常", "感到", "算是", "以", "台大", "博物馆", "全球", "担心", "北京", "词", "好像", "设", "差异", "观点", "间", "属", "宇宙", "公斤", "欢迎", "教", "无论", "股票", "照顾",
    "执行", "定", "放弃", "女儿", "院长", "工人", "留", "打", "直到", "里面", "考虑", "原本", "光", "牠们", "避免", "上课", "自动化", "构成", "音乐", "工作", "原", "组成", "组织",
    "过程", "人文", "或者", "才", "清楚", "革命", "功能", "办法", "马", "加以", "在一起", "学术", "股票", "代表", "热", "住", "台北", "种", "参加", "提高", "品质", "妈妈", "重新"}

    language:Register()
end

do
    -- Spanish
    local language = ix.languages:New()
    language.name = "Spanish"
    language.uniqueID = "spa"
    language.icon = "flags16/es.png"
    language.gibberish = {"listos", "tarjeta", "ayudarte", "parecen", "siempre", "si", "gustó", "minuto", "tanto", "cuarto", "ios", "quedarse", "regreso", "caso", "tengas", "dan", "vuelto", "dejó",
    "llamada", "fuiste", "haberte", "aquellos", "terminar", "déjeme", "con", "traje", "habéis", "nosotras", "posición", "negra", "tony", "línea", "metros", "debió", "caballeros", "dedos", "abuela",
    "nosotros", "duro", "eres", "probablemente", "bella", "nada", "mes", "inmediatamente", "brazo", "futuro", "brillante", "usar", "sube", "haya", "propósito", "eran", "más", "médico", "volverá", "hazlo",
    "vistazo", "george", "humano", "caso", "oportunidad", "perfecto", "pelea", "lugares", "llevó", "tome", "hoy", "banco", "diferente", "algunos", "estas", "otra", "informe", "durante", "entrada"}

    language:Register()
end

do
    -- Russian
    local language = ix.languages:New()
    language.name = "Russian"
    language.uniqueID = "rus"
    language.icon = "flags16/ru.png"
    language.gibberish = {"поделиться", "хитрость", "посвистывать", "схема", "развиться", "однородный", "беспокоить", "правление", "торжественно", "пять", "пень", "венок", "обедня", "неизбежный",
    "неразрывно", "дружина", "зрелище", "мозг", "раздел", "как", "скульптор", "март", "платить", "развести", "тень", "сгорание", "лепёшка", "пронестись", "скопление", "пятнадцать", "хрусталь",
    "припомнить", "глубинный", "некий", "временно", "обозреватель", "закуривать", "пускай", "отдохнуть", "зелень", "рукавица", "сейчас", "голосовать", "выдавать", "весёлый", "оживление",
    "отправляться", "прорыв", "целесообразный", "ширма", "копия", "металлургический", "верность", "история", "выработать", "познавать", "синяк", "серебряный", "версия", "таракан", "тропа"}

    language:Register()
end

do
    -- Bulgarian
    local language = ix.languages:New()
    language.name = "Bulgarian"
    language.uniqueID = "bul"
    language.icon = "flags16/bg.png"
    language.gibberish = {"гледай", "коя", "поговоря", "чу", "момента", "защото", "някакво", "направил", "излизай", "големите", "спра", "сила", "светлина", "намери", "обратно", "срещу", "връщам",
    "мои", "вид", "малката", "бизнеса", "отиде", "дълго", "песен", "надявам", "маса", "направим", "използва", "отвън", "направят", "казвам", "бива", "свят", "имаме", "живи", "честит", "дядо", "шеф",
    "спомням", "съпруга", "предам", "брат", "случи", "вечерята", "начина", "вечно", "останало", "умре", "движи", "документи", "гледат", "нужно", "щеше", "дадем", "излезеш", "макс", "първото",
    "семейство", "голямо", "сине", "пред", "тръгна", "тях", "появи", "града", "влюбен", "вдигни", "казаха", "мария", "пиеш", "децата", "излиза", "тялото", "бе", "си", "край", "полиция", "чао"}

    language:Register()
end

do
    -- German
    local language = ix.languages:New()
    language.name = "German"
    language.uniqueID = "ger"
    language.icon = "flags16/de.png"
    language.gibberish = {"durchsuchen", "gerecht", "draußen", "zusehen", "international", "behalten", "verbrannt", "deswegen", "geführt", "dahinter", "abhalten", "blödsinn", "rache", "als",
    "die Untersuchung", "der Brauch", "immer", "beinahe", "erscheinen", "Schuld", "endlich", "dass", "riechen", "unterscheiden", "kollege", "fahrer", "beziehung", "reissen", "kleider",
    "angetan", "erde", "huhn", "fein", "entkommen", "rause", "stimmen", "wunderbar", "tot", "haus", "senden", "schade", "woche", "nutzen", "lunge", "anfassen", "schiff", "wissen", "geld",
    "zahlen", "begeistert", "hungrig", "einsam", "schalfen", "vertraut", "bein", "tragen", "spiegel", "heimat", "schuldig", "sie", "festhalten", "irgendwann", "zurecht"}

    language:Register()
end

do
    -- French
    local language = ix.languages:New()
    language.name = "French"
    language.uniqueID = "fre"
    language.icon = "flags16/fr.png"
    language.gibberish = {"plénier", "hier", "caresser", "charge", "huitième", "journée", "bras", "commerçant", "aspiration", "hélas", "pétrole", "succéder", "marche", "talent", "vérification",
    "rigoler", "contribuable", "vraisemblablement", "différence", "recherche", "efficace", "d'ailleurs", "domine", "radio", "survenir", "naval", "gouverneur", "relever", "vieillard", "déchirer",
    "amendement", "satisfaisant", "motif", "souhait", "opérateur", "courrier", "conservation", "formalité", "aire", "augmentation", "tard", "vague", "vanter", "détruire", "vanter", "besoin",
    "accorder", "fait", "fonder", "dizaine", "logiciel", "chirurgien", "confus", "borne", "baigner", "restructuration", "règlement", "pleuvoir", "vingt-quatre", "croyant", "orientation"}

    language:Register()
end

do
    -- Arabic
    local language = ix.languages:New()
    language.name = "Arabic"
    language.uniqueID = "ara"
    language.icon = "flags16/sa.png"
    language.gibberish = {"الابتسامة", "منزلي", "ولكني", "مجرد", "فقرة", "اللعنة", "للغاية", "الشعر", "أسفل", "سمعت", "الولادة", "حصة",
    "الوحيدة", "سيدى", "كتلة", "السليم", "الموقف", "منا", "المقبل", "الجحيم", "موقف", "غذاء", "الطعام", "سيئة", "النار", "انتهت", "خطأ", "سيحدث",
    "هنالك", "الواضح", "نقطة", "الكرة", "أيضا", "اعتقدت", "بـ", "صرخة", "تسمع", "بأنني", "فيكتور",
    "مستر", "يطير", "عنصر", "العين", "يفعل", "اعمل", "الآن", "البلاد", "البلاد", "خاص", "ذاك", "مرة", "منطقة", "سمع", "وظيفة", "الجيد", "ساعات", "تريدون", "السابق", "على الرغم من",
    "الارض", "يريد", "إلهى", "أهل"}

    language:Register()
end

do
    -- Italian
    local language = ix.languages:New()
    language.name = "Italian"
    language.uniqueID = "ita"
    language.icon = "flags16/it.png"
    language.gibberish = {"che", "nostro", "qualsiasi", "oro", "vuoi", "siediti", "new", "last", "capelli", "terribile", "danneggiare", "alcuni", "un po'", "qualche", "testa", "guerra", "povero",
    "niente", "mettere", "caso", "ho", "dirmi", "vestire", "attraverso", "dovere", "unica", "tieni", "peccato", "già", "chiave", "persone", "apparire", "lasciami", "felice", "circa", "vedi", "prima",
    "condurre", "sembrare", "settimana", "speranza", "qui", "resto", "doveva", "centro", "lasci", "fine", "affari", "ricordare", "vuole", "sapete", "prendere", "sposare", "portafoglio", "completamente",
    "cosa", "possiamo", "via", "radio", "attento", "morire", "vincere", "regolare", "sento", "bisogno", "cibo", "primo", "incidente", "capelli", "avrei", "quante", "sinistra", "cielo", "piede", "lasciato"}

    language:Register()
end

do
    -- Dutch
    local language = ix.languages:New()
    language.name = "Dutch"
    language.uniqueID = "dut"
    language.icon = "flags16/nl.png"
    language.gibberish = {"ik", "toen", "werk", "vandaag", "enige", "buiten", "probleem", "krijgt", "minuten", "blij", "vergeten", "mevrouw", "betekent", "belangrijk", "verloren", "ervoor", "acht",
    "getrouwd", "kantoor", "vliegtuig", "boot", "vliegen", "voorstellen", "mocht", "bekend", "paard", "gebouw", "broek", "and", "club", "bereiken", "lot", "hoeven", "aandacht", "neuken", "hoelang",
    "bedanken", "geslagen", "geweten", "reed", "dol", "kleur", "genoegen", "station", "vrolijk", "papier", "dankbaar", "wensen", "wed", "meegemaakt", "wie", "alleen", "niemand", "werd", "gebeurd",
    "kleine", "pak", "vanavond", "ergens", "hoi", "los", "rust", "avond", "valt", "kopen", "gisteren", "gebruik", "liefje", "wonen", "beschermen", "jong", "tafel", "ruimte", "belde", "regelen", "spul"}

    language:Register()
end

do
    -- Finnish
    local language = ix.languages:New()
    language.name = "Finnish"
    language.uniqueID = "fin"
    language.icon = "flags16/fi.png"
    language.gibberish = {"kaikki", "kädet", "ei mitään", "olla samaa mieltä", "monta", "suurempi", "vinossa", "käsi", "yhtäkkiä", "makea", "tyytyväinen", "tilaus", "tehty", "ihminen", "nopeasti", "aikuinen", "soitti", "paperit",
    "valitut", "ei", "kuusi", "sheriffi", "soittaa puhelimella", "kuningatar", "huomio", "turpa kiinni", "vähennä", "tappaja", "yhdessä", "hypätä", "yrittää", "nimeltään", "eversti", "tavannut", "käytetty",
    "puhua", "surullinen", "savu", "tässä", "oikea", "vakavasti", "tunnettu", "kuppi", "poika", "ajatella", "massat", "aseta", "antaa", "tauko", "nopeus", "metsä",
    "puhua", "ajo", "sen", "selvitettävä", "huone", "karjala", "omena", "täyslihapihvi", "kana", "idiootti", "makkara", "saatana", "helvetti", "jumalauta", "perkele", "kalja", "sauna"}

    language:Register()
end

do
    -- Swedish
    local language = ix.languages:New()
    language.name = "Swedish"
    language.uniqueID = "swe"
    language.icon = "flags16/se.png"
    language.gibberish = {"aldrig", "alla", "andra", "andra", "att", "att", "av", "bara", "barn", "bli", "bra", "de", "dem", "den", "denna", "det", "detta", "dig", "dom", "du", "då", "där", "efter", "eller", "en", "ett", "finnas",
    "från", "få", "för", "gå", "göra", "ha", "han", "helt", "hon", "honom", "hur", "här", "i", "idag", "innan", "inte", "jag", "ju", "kanske", "komma", "kunna", "lite", "man", "med", "men", "mig", "min",
    "mot", "mycket", "många", "måste", "ni", "nog", "nu", "någon", "något", "några", "när", "och", "också", "om", "om", "på", "samma", "se", "sen", "sen", "sig",
    "sin", "själv", "skola", "som", "Sverige", "så", "säga", "till", "tro", "två", "tycka", "under", "utan", "vad", "vara", "veta", "vi", "vid", "vilja", "väl", "väl", "år", "än", "även", "över"}

    language:Register()
end

do
    -- Greek
    local language = ix.languages:New()
    language.name = "Greek"
    language.uniqueID = "gre"
    language.icon = "flags16/gr.png"
    language.gibberish = {"έτος", "εβδομάδα", "σήμερα", "αύριο", "χθες", "ημερολόγιο", "δευτερόλεπτο", "ώρα", "λεπτό", "η ώρα", "μια ώρα", "μπορώ", "χρησιμοποιώ", "κάνω", "πηγαίνω", "έρχομαι", "γελάω", "φτιάχνω", "βλέπω", "μακρινός",
    "μικρός", "καλός", "όμορφος", "άσχημος", "δύσκολος", "εύκολος", "κακός", "κοντινός", "Χαίρω πολύ", "Γειά", "Καλημέρα", "Καλησπέρα", "Καλησπέρα", "Καληνύχτα", "Τι κάνεις", "Σ' ευχαριστώ", "Όχι", "Νόστιμο", "Αντίο", "Ναι", "Δευτέρα",
    "Τρίτη", "Τετάρτη", "Πέμπτη", "Σάββατο", "ένα", "μηδέν", "δύο", "μπίρα", "τσάι"}

    language:Register()
end

do
    -- Hindi
    local language = ix.languages:New()
    language.name = "Hindi"
    language.uniqueID = "hin"
    language.icon = "icon16/world.png"
    language.gibberish = {"हां", "नहीं", "नमस्ते", "आप कैसे हैं", "परीक्षण", "बेवकूफ", "क्या", "कैसे", "कब", "क्यों", "कहा पे", "आप कैसे हैं", "शिखर सम्मेलन", "प्रेम", "घृणा", "दिलकश", "विचार", "कल्पना करना", "सर्वर", "कौन",
    "करना", "मैं", "बटन", "मौजूद", "गूगल", "अनुवाद करना", "संघ", "जोड़ना", "जादू", "जिंदगी", "पेड़", "घास", "खोलना", "बंद करे", "कप", "कांच", "पुस्तक", "सेब", "पाई", "चापलूसी", "घृणा",
    "कोई नहीं कर सकता", "आपका क्या मतलब है", "यह कैसे हो सकता है", "अस्तित्व", "जोड़ना", "पॉप", "गुब्बारे", "डेस्क", "का अस्तित्व"}

    language:Register()
end

do
    -- Bengali
    local language = ix.languages:New()
    language.name = "Bengali"
    language.uniqueID = "ben"
    language.icon = "icon16/world.png"
    language.gibberish = {"পরীক্ষা", "হ্যালো", "কেন", "কিভাবে", "কোথায়", "আমি", "কেন এটা", "ভাষা", "গুগল", "অনুবাদ করা", "বই", "গাছ", "ঘাস", "গ্লাস", "কাপ", "আপেল", "খাদ্য", "প্রেমিকা", "পরীক্ষামূলক", "জীবন",
    "বিদ্যমান", "অস্তিত্ব", "বিশ্ব", "এটা", "কখন", "মৃত্যু", "ভালবাসা", "ঘৃণা", "ঘৃণা", "মুখ", "শরীর", "বোতাম", "বেলুন", "মজা", "ডেস্ক", "খাদ্য", "বিয়ার", "সমুদ্র", "জল", "আকাশ", "একত্রিত করুন",
    "মিলন", "সর্বজনীন", "দেশ", "জমি", "জাহাজ", "ক্রুজ", "হাঁটা", "চালান", "সম্প্রচার"}

    language:Register()
end

do
    -- Croatian
    local language = ix.languages:New()
    language.name = "Croatian"
    language.uniqueID = "cro"
    language.icon = "icon16/world.png"
    language.gibberish = {"Unija", "Kombinirati", "emitirati", "Univerzalni", "Obrazovanje", "Tko", "Kada", "Gdje", "Što", "Zašto", "postojati", "Postojanje", "Opstanak", "Trava", "Zemljište", "Drvo", "Nebo", "More", "Voda", "Više",
    "Dodvoravanje", "Život", "Smrt", "Pametan", "Glup", "glazba, muzika", "Koncert", "Ljubavnici", "Mrziti", "Mržnja", "Bolest", "Zemlja", "Prevedi", "Jezik", "stranica", "Ne", "Da", "Stol", "Stolica", "Glumi", "mreža"}

    language:Register()
end

do
    -- Swahili
    local language = ix.languages:New()
    language.name = "Swahili"
    language.uniqueID = "swa"
    language.icon = "icon16/world.png"
    language.gibberish = {"Mtandao", "Muungano", "Ardhi", "Mti", "Pai", "Chakula", "Zaidi", "Wakati", "Kwa nini", "Vipi", "Nini", "Wapi", "Lini", "Zipo", "Chai", "Kahawa", "Tafsiri", "Lugha", "Ulimwengu", "Unganisha",
    "Pakiti", "Mfuko", "Nchi", "Kimbia", "Tembea", "Gurudumu", "Lori", "Treni", "Jiji", "Upendo", "Chuki", "Funga", "Fungua", "Uza", "Nunua", "Hifadhi", "Upepo", "Wingu", "Anga", "Bahari", "Maji"}

    language:Register()
end

do
    -- Serbian
    local language = ix.languages:New()
    language.name = "Serbian"
    language.uniqueID = "ser"
    language.icon = "icon16/world.png"
    language.gibberish = {"Здраво", "Иди", "Зашто", "Шта", "Љубав", "Спринт", "Изађи", "Интеллигенце", "Оверватцх трансхуман арм", "Цивилна заштита", "Зомбие", "Мртав", "Трцати", "ти", "ја", "изговор",
    "Извињавам се", "Ауто", "Не", "Вода", "кафу", "Живот", "Комбинујте", "Цити", "Остави", "Требао би", "Није у реду", "Изађи одавде", "Ш'а има", "Нешто"}

    language:Register()
end

do
    -- Turkish
    local language = ix.languages:New()
    language.name = "Turkish"
    language.uniqueID = "tur"
    language.icon = "icon16/world.png"
    language.gibberish = {"Merhaba", "Sayın", "Koşmak", "sürat koşusu", "yakın", "Nasılsın", "programcı", "kafa", "ayak", "tavuk", "satıcı", "bira", "güzel", "gülmek", "Yapabilmek", "kullanmak", "Yapmak",
    "takvim", "yarın", "bugün", "Ev", "Menşei", "Ülke", "vatandaş", "Gün batımı", "Şehir", "Güneş", "Sivil Savunma", "birleştir", "Aşk"}

    language:Register()
end

do
    -- Romanian
    local language = ix.languages:New()
    language.name = "Romanian"
    language.uniqueID = "rom"
    language.icon = "icon16/world.png"
    language.gibberish = {"Buna ziua", "păsări", "farfurie", "drept", "spațiu", "în mare măsură", "mai puțin", "sector", "cerere", "pâine", "dispus", "origine", "curat", "bunic", "date", "domnișoară", "furtună",
    "petrece", "risc", "îngrijire", "militar", "relief", "tigru", "conveni", "îndepărta", "vecin", "apărea", "elefant", "prezice", "scump"}

    language:Register()
end

do
    -- Flipino
    local language = ix.languages:New()
    language.name = "Flipino"
    language.uniqueID = "fli"
    language.icon = "icon16/world.png"
    language.gibberish = {"Kamusta", "oras ng paggawa", "tahanan", "maglaro", "kung", "hanay", "tatlong", "gusto", "gumagana", "pamanahan", "ibang", "ang kanilang", "gawin", "namin", "maaari", "isang", "nagkaroon",
    "kung ano", "para sa", "noon ay", "na", "sa", "ito", "ngunit", "salita", "sa pamamagitan ng", "mayroon", "may", "kanyang", "bilang"}

    language:Register()
end

do
    -- Irish
    local language = ix.languages:New()
    language.name = "Gaeilge"
    language.uniqueID = "gai"
    language.icon = "flags16/ie.png"
    language.gibberish = {"Ar chuala", "Tá a lán", "Tráthnóna ciúin", "Tá súil", "gcloiseann", "tú sinn", "chóras Londain", "chun báis", "bhfaca tú ár", "Massacre Phádraig",
	"chathair", "rudaí i gcuimhne", "Uaireanta", "smaoiním", "páirceanna", "dúchais", "cúis imní dúinn", "gcéad", "ghlúin", "súil", "atá", "caite", "chách", "thubaiste",
	"fhios", "phláinéid", "éiceachóras", "ndáiríre", "ndeachaigh", "dhílseoir", "bheith", "bealach", "An é", "agam", "ráflaí", "chuala", "Tá mé tinn", "níos fearr", "Tíogair",
	"Longthógáil", "Gáire", "Pólus", "Impireacht", "Úll", "prátaí", "go raibh maith agat", "Is amadán thú", "tharrang", "thar maoil", "fuar"}
	
	language:Register()
end

do
    -- Albanian
    local language = ix.languages:New()
    language.name = "Albanian"
    language.uniqueID = "alb"
    language.icon = "flags16/al.png"
    language.gibberish = {"viti", "javë", "sot", "nesër", "dje", "kalendar", "sekonda", "orë", "minutë", "orë", "një orë", "mund", "përdor", "bëj", "shko", "vij", "qesh", "bëj", "shih", "i largët", "i vogël", "mirë", "i bukur", "i keq", "i vështirë", "i lehtë", "i keq", "i afërt", "I gëzohem të njohesh", "Përshëndetje", "Mirëmbrëma", "Mirëmbrëma", "Mirëmbajtje", "Si je", "Faleminderit", "Jo", "I shijshëm", "Përshëndetje", "Po", "E hënë", "E martë", "E mërkurë", "E enjte", "E premte", "një", "zero", "dy", "bira", "çaj"}

    language:Register()
end

do
    -- Bosnian
    local language = ix.languages:New()
    language.name = "Bosnian"
    language.uniqueID = "bos"
    language.icon = "flags16/ba.png"
    language.gibberish = {"godina", "tjedan", "danas", "sutra", "jučer", "kalendar", "sekunda", "sat", "minuta", "sat", "jedan sat", "može", "koristiti", "učiniti", "ići", "doći", "smijati se", "napraviti", "vidjeti", "daleko", "mali", "dobar", "lijep", "ružan", "teško", "lako", "loše", "blizu", "Lijepo te upoznati", "Pozdrav", "Dobro jutro", "Dobar dan", "Dobro veče", "Dobro jutro", "Kako si", "Hvala", "Ne", "Užitak", "Doviđenja", "Da", "Ponedjeljak", "Utorak", "Srijeda", "Četvrtak", "Subota", "jedan", "nula", "dva", "pivo", "čaj"}

    language:Register()
end

do
    -- Polish
    local language = ix.languages:New()
    language.name = "Polish"
    language.uniqueID = "pol"
    language.icon = "flags16/pl.png"
    language.gibberish = {"rok", "tydzień", "dzisiaj", "jutro", "wczoraj", "kalendarz", "sekunda", "godzina", "minuta", "godzina", "jedna godzina", "może", "użyć", "robić", "iść", "przyjść", "śmiać się", "robić", "widzieć", "daleko", "mały", "dobry", "piękny", "brzydki", "trudny", "łatwy", "zły", "blisko", "Miło Cię poznać", "Cześć", "Dzień dobry", "Dzień dobry", "Dobry wieczór", "Dobranoc", "Jak się masz", "Dziękuję", "Nie", "Smaczne", "Do widzenia", "Tak", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Sobota", "jeden", "zero", "dwa", "piwo", "herbata"}

    language:Register()
end

do
    -- Gaelic
    local language = ix.languages:New()
    language.name = "Gaelic"
    language.uniqueID = "gae"
    language.icon = "flags16/gb.png"
    language.gibberish = {"bliain", "seachtain", "inniu", "amárach", "inné", "foclóir", "soicind", "uair", "nóiméad", "uair", "uair amháin", "céad", "úsáid", "déan", "téigh", "téigh", "bualadh", "cruthaigh", "féach", "faoi", "beag", "gorm", "beo", "cosúil", "dubh", "difriúil", "easpa", "dubh", "líne", "Is maith liom tabhairt duit", "Dia dhuit", "Dia mhaith", "Dia duit", "Dia mhaith", "Dia mhaith", "Conas atá tú", "Go raibh maith agat", "Níl", "Bia iontach", "Slán", "Tá", "Dé Luain", "Dé Máirt", "Dé Céadaoin", "Déardaoin", "Dé hAoine", "aon", "sifre", "dhá", "bíodh", "beoir", "té"}

    language:Register()
end

do
    -- Portuguese
    local language = ix.languages:New()
    language.name = "Portuguese"
    language.uniqueID = "por"
    language.icon = "flags16/pt.png"
    language.gibberish = {"ano", "semana", "hoje", "amanhã", "ontem", "calendário", "segundo", "hora", "minuto", "em ponto", "uma hora", "pode", "usar", "fazer", "ir", "vir", "rir", "fazer", "ver", "longe", "pequeno", "bom", "bonito", "feio", "difícil", "fácil", "ruim", "perto", "Prazer em conhecê-lo", "Olá", "Bom dia", "Boa tarde", "Boa noite", "Boa noite", "Como vai você", "Obrigado", "Não", "Delicioso", "Tchau", "Sim", "Segunda-feira", "Terça-feira", "Quarta-feira", "Quinta-feira", "Sábado", "um", "zero", "dois", "cerveja", "chá"}

    language:Register()
end

do
    -- Indonesian
    local language = ix.languages:New()
    language.name = "Indonesian"
    language.uniqueID = "ind"
    language.icon = "flags16/id.png"
    language.gibberish = {"tahun", "minggu", "hari ini", "besok", "kemarin", "kalender", "detik", "jam", "menit", "jam", "satu jam", "bisa", "gunakan", "lakukan", "pergi", "datang", "tertawa", "buat", "lihat", "jauh", "kecil", "baik", "indah", "jelek", "sulit", "mudah", "buruk", "dekat", "Senang bertemu Anda", "Halo", "Selamat pagi", "Selamat siang", "Selamat sore", "Selamat malam", "Bagaimana kabarmu", "Terima kasih", "Tidak", "Enak", "Selamat tinggal", "Ya", "Senin", "Selasa", "Rabu", "Kamis", "Sabtu", "satu", "nol", "dua", "bir", "teh"}

    language:Register()
end

do
    -- Hebrew
    local language = ix.languages:New()
    language.name = "Hebrew"
    language.uniqueID = "heb"
    language.icon = "flags16/il.png"
    language.gibberish = {"שנה", "שבוע", "היום", "מחר", "אתמול", "לוח שנה", "שנייה", "שעה", "דקה", "שעון", "שעה אחת", "יכול", "להשתמש", "לעשות", "ללכת", "לבוא", "לצחוק", "לעשות", "לראות", "רחוק", "קטן", "טוב", "יפה", "גרוע", "קשה", "קל", "רע", "קרוב", "נחמד להכיר אותך", "שלום", "בוקר טוב", "צהריים טובים", "ערב טוב", "לילה טוב", "איך אתה", "תודה", "לא", "נהדר", "להתראות", "כן", "יום שני", "יום שלישי", "יום רביעי", "יום חמישי", "יום שישי", "אחד", "אפס", "שתיים", "בירה", "תה"}

    language:Register()
end

do
    -- Czech
    local language = ix.languages:New()
    language.name = "Czech"
    language.uniqueID = "cze"
    language.icon = "flags16/cz.png"
    language.gibberish = {"rok", "týden", "dnes", "zítra", "včera", "kalendář", "sekunda", "hodina", "minuta", "hodin", "jedna hodina", "může", "použít", "dělat", "jít", "přijít", "smát se", "udělat", "vidět", "daleko", "malý", "dobrý", "krásný", "hrozný", "těžký", "lehký", "špatný", "blízko", "Příjemné vás poznat", "Ahoj", "Dobré ráno", "Dobré odpoledne", "Dobrý večer", "Dobrou noc", "Jak se máš", "Děkuji", "Ne", "Chutná", "Nashledanou", "Ano", "Pondělí", "Úterý", "Středa", "Čtvrtek", "Sobota", "jeden", "nula", "dva", "pivo", "čaj"}

    language:Register()
end

do
    -- Hungarian
    local language = ix.languages:New()
    language.name = "Hungarian"
    language.uniqueID = "hun"
    language.icon = "flags16/hu.png"
    language.gibberish = {"év", "hét", "ma", "holnap", "tegnap", "naptár", "másodperc", "óra", "perc", "óra", "egy óra", "tud", "használ", "csinál", "megy", "jön", "nevet", "csinál", "lát", "messze", "kicsi", "jó", "szép", "csúnya", "nehez", "könnyű", "rossz", "közel", "Örülök, hogy találkoztunk", "Szia", "Jó reggelt", "Jó napot", "Jó estét", "Jó éjszakát", "Hogy vagy", "Köszönöm", "Nem", "Finom", "Viszlát", "Igen", "Hétfő", "Kedd", "Szerda", "Csütörtök", "Szombat", "egy", "nulla", "kettő", "sör", "tea"}

    language:Register()
end

do
    -- Mongolian
    local language = ix.languages:New()
    language.name = "Mongolian"
    language.uniqueID = "mon"
    language.icon = "flags16/mn.png"
    language.gibberish = {"жил", "долоо хоног", "өнөөдөр", "маргааш", "өчигдөр", "хуанли", "секунд", "цаг", "минут", "нэг цаг", "чадна", "ашиглах", "хийх", "явах", "ирэх", "инээх", "харах", "хол", "жижиг", "сайн", "сайхан", "муухай", "хүнд", "хялбар", "муу", "ойрхон", "Уулзсандаа таатай байна", "Сайн уу", "Өглөөний мэнд", "Өдрийн мэнд", "Оройн мэнд", "Сайхан амраарай", "Юу байна", "Баярлалаа", "Үгүй", "Амттай", "Баяртай", "Тийм", "Даваа гараг", "Мягмар гараг", "Лхагва гараг", "Пүрэв гараг", "Бямба гараг", "нэг", "тэг", "хоёр", "шар айраг", "цай", "ус", "хоол", "гурил", "талх", "жүрж", "алим", "ногоо", "мах", "өндөг", "цаг агаар", "гэр", "машин", "гудамж", "эмнэлэг", "сургууль", "их сургууль", "дэлгүүр", "зах", "ном", "кино", "театр", "аялал", "амралт", "ажил", "албан газар", "компьютер", "утас", "телевизор", "музeй", "цэцэрлэг", "ногоон", "хөх", "улаан", "шар", "цэнхэр", "цагаан", "хар"}

    language:Register()
end

do
    -- Vietnamese
    local language = ix.languages:New()
    language.name = "Vietnamese"
    language.uniqueID = "vie"
    language.icon = "flags16/vn.png"
    language.gibberish = {"năm", "tuần", "hôm nay", "ngày mai", "hôm qua", "lịch", "giây", "giờ", "phút", "một giờ", "có thể", "sử dụng", "làm", "đi", "đến", "cười", "nhìn", "xa", "nhỏ", "tốt", "đẹp", "xấu", "nặng", "dễ", "tồi", "gần", "Rất vui được gặp bạn", "Xin chào", "Chào buổi sáng", "Chào buổi chiều", "Chào buổi tối", "Chúc ngủ ngon", "Bạn khỏe không", "Cảm ơn", "Không", "Ngon", "Tạm biệt", "Có", "Thứ hai", "Thứ ba", "Thứ tư", "Thứ năm", "Thứ bảy", "một", "không", "hai", "bia", "trà", "nước", "thức ăn", "bột mì", "bánh mì", "cam", "táo", "rau", "thịt", "trứng", "thời tiết", "nhà", "xe hơi", "đường phố", "bệnh viện", "trường học", "đại học", "cửa hàng", "chợ", "sách", "phim", "rạp hát", "du lịch", "kỳ nghỉ", "công việc", "văn phòng", "máy tính", "điện thoại", "tivi", "bảo tàng", "vườn", "xanh lá cây", "xanh dương", "đỏ", "vàng", "xanh nước biển", "trắng", "đen"}

    language:Register()
end

do
    -- Alien
    local language = ix.languages:New()
    language.name = "Xendarian"
    language.uniqueID = "xen"
    language.icon = "icon16/briefcase.png"
    language.notSelectable = true
    language.color = Color(92, 29, 5)
    language.gibberish = {"⊑⟒⌰⌰⍜", "⍙⊑⊬", "⏃", "⋏⍜", "⍙⊑⏃⏁", "⟟⋔⌿⍜⌇⌇⟟⏚⌰⟒", "⌿⍜⌇⌇⟟⏚⌰⟒", "☊⏃⋏'⏁", "⌿⍀⍜☌⍀⏃⋔⋔⟟⋏☌", "☊⍜⎅⟟⋏☌", "⋉⟒⏁⏃", "⌇⌿⊑⟒⍀⟟☊⏃⌰", "⌇⟒☊⏁⍜⍀",
    "⎎⎍⋏⋏⊬", "⍾⍙⟒⍀⏁⊬", "⎅⏃", "⋏⍜⎍", "⊑⍜⍙", "⍙⊑⟒⋏", "⋏⟒⎐⟒⍀", "⊬⟒⏃⍀⌇", "⎅⏃⊬⌇", "⋔⍜⋏⏁⊑⌇", "⎅⟒☊⏃⎅⟒⌇", "☊⟒⋏⏁⎍⍀⊬", "⊬⍜⍀☍", "⋏⟒⍙", "⌇⍜⋔⟒⍙⊑⏃⏁", "⌇⏃⎎⟒", "⎎⍜⌰⌰⍜⍙",
    "☊⍜⋔⟒", "⍙⟟⏁⊑", "⋔⟒", "⋏⍜⍙", "⍙⏃⏁⟒⍀", "⎎⍜⍜⎅", "⟊⏃☊⍜⏚", "⟊⍜⏚", "⏁⟟⌇", "⎍⋏⍙⟟⌇⟒", "⍙⟟⌇⟒", "⏁⍜", "☌⍜", "⏁⊑⟒⍀⟒","⌿⍜⌿", "⌿⍜☌☌⟒⍀⌇", "⏁⟟⏁", "☊⏃", "☊⌿", "⍜⏁⏃", "⌇⊬⋏⏁⊑", "⌇⏁⍀⟟⎅⟒⍀",
    "⏃⟟⍀⍙⏃⏁☊⊑", "☌⍀⍜⎍⋏⎅⍙⏃⏁☊⊑", "☊⟟⏁⊬", "⋔⏃⌿", "⋔⍜", "⏚⍜⏃⊑", "☊⟟⏁⟟⋉⟒⋏", "⎅⟒⎎⟒⋏⌇⟒", "⌇⟒☊⏁⍜⍀ ⌇⟒☊⎍⍀⟒", "⏚⏃⋏", "⎅⟒⏃⏁⊑", "☌⍜⏁", "⌰⍜", "☌⍀⟒⋏⏃⎅⟒", "☊⎎", "☍⍜⌿", "☊⍜⌿",
    "⌇⟒", "⍙⊑⟟⋏⟒", "⏚⍜⋔⏚", "⋏⟒☌⏃⏁⟟⎐⟒", "⏃⎎⎎⟟⍀⋔⏃⏁⟟⎐⟒", "⍜⎐⟒⍀⍙⏃⏁☊⊑", "⌇⏁⏃⋏⎅⏚⊬", "⊬⏃⋔⏃⏁⍜", "⊬⏃", "⊬⍜", "⌇⏁⍜⌿", "☌⟒⏁ ⎅⍜⍙⋏", "⏚⏃☊☍", "⍾⍙", "⎎⏃⟟⌰⎍⍀⟒", "⟒⋏⍜⎍☌⊑", "☌⏃⊬",
    "⏃⏁⌰⟒", "⎅⟒⎐", "⎐⟒☊⏁⍜⍀", "⊑⍜⌿⌿⟒⍀", "⋔⟟⋏⟒", "⋔⟟⋏⟒⎎⟟⟒⌰⎅", "⋔⟟⌰⟟⏁⏃⍀⊬", "☊⍜⋏⌇☊⍀⟟⌿⏁", "⏁⍀⟒⌇⌿⏃⌇⌇⟒⍀", "⎍⋏⟟⏁⟒", "⎍⋏⟟⎎⊬", "⋉⏃⏁", "⟊⏃☊☍", "⍙⊑⊬ ⍙⍜⎍⌰⎅ ⊬⍜⎍ ⎅⍜ ⏁⊑⟟⌇ ⏁⍜ ⋔⟒",
    "⏃⟟", "⎐⟟", "☊⍜⍀⟒", "⌿⍜⍙⟒⍀", "⎅⟒⌇⏁⍀⎍☊⏁⟟⍜⋏", "⍀⎍⟟⋏", "⌰⏃⌇⏁⌰⊬", "⍙⟒"}

    language:Register()
end

do
    -- Alien
    local language = ix.languages:New()
    language.name = "Incongruous"
    language.uniqueID = "inc"
    language.icon = "icon16/briefcase.png"
    language.notSelectable = true
    language.color = Color(92, 29, 5)
    language.gibberish = {"⊑⟒⌰⌰⍜", "⍙⊑⊬", "⏃", "⋏⍜", "⍙⊑⏃⏁", "⟟⋔⌿⍜⌇⌇⟟⏚⌰⟒", "⌿⍜⌇⌇⟟⏚⌰⟒", "☊⏃⋏'⏁", "⌿⍀⍜☌⍀⏃⋔⋔⟟⋏☌", "☊⍜⎅⟟⋏☌", "⋉⟒⏁⏃", "⌇⌿⊑⟒⍀⟟☊⏃⌰", "⌇⟒☊⏁⍜⍀",
    "⎎⎍⋏⋏⊬", "⍾⍙⟒⍀⏁⊬", "⎅⏃", "⋏⍜⎍", "⊑⍜⍙", "⍙⊑⟒⋏", "⋏⟒⎐⟒⍀", "⊬⟒⏃⍀⌇", "⎅⏃⊬⌇", "⋔⍜⋏⏁⊑⌇", "⎅⟒☊⏃⎅⟒⌇", "☊⟒⋏⏁⎍⍀⊬", "⊬⍜⍀☍", "⋏⟒⍙", "⌇⍜⋔⟒⍙⊑⏃⏁", "⌇⏃⎎⟒", "⎎⍜⌰⌰⍜⍙",
    "☊⍜⋔⟒", "⍙⟟⏁⊑", "⋔⟒", "⋏⍜⍙", "⍙⏃⏁⟒⍀", "⎎⍜⍜⎅", "⟊⏃☊⍜⏚", "⟊⍜⏚", "⏁⟟⌇", "⎍⋏⍙⟟⌇⟒", "⍙⟟⌇⟒", "⏁⍜", "☌⍜", "⏁⊑⟒⍀⟒","⌿⍜⌿", "⌿⍜☌☌⟒⍀⌇", "⏁⟟⏁", "☊⏃", "☊⌿", "⍜⏁⏃", "⌇⊬⋏⏁⊑", "⌇⏁⍀⟟⎅⟒⍀",
    "⏃⟟⍀⍙⏃⏁☊⊑", "☌⍀⍜⎍⋏⎅⍙⏃⏁☊⊑", "☊⟟⏁⊬", "⋔⏃⌿", "⋔⍜", "⏚⍜⏃⊑", "☊⟟⏁⟟⋉⟒⋏", "⎅⟒⎎⟒⋏⌇⟒", "⌇⟒☊⏁⍜⍀ ⌇⟒☊⎍⍀⟒", "⏚⏃⋏", "⎅⟒⏃⏁⊑", "☌⍜⏁", "⌰⍜", "☌⍀⟒⋏⏃⎅⟒", "☊⎎", "☍⍜⌿", "☊⍜⌿",
    "⌇⟒", "⍙⊑⟟⋏⟒", "⏚⍜⋔⏚", "⋏⟒☌⏃⏁⟟⎐⟒", "⏃⎎⎎⟟⍀⋔⏃⏁⟟⎐⟒", "⍜⎐⟒⍀⍙⏃⏁☊⊑", "⌇⏁⏃⋏⎅⏚⊬", "⊬⏃⋔⏃⏁⍜", "⊬⏃", "⊬⍜", "⌇⏁⍜⌿", "☌⟒⏁ ⎅⍜⍙⋏", "⏚⏃☊☍", "⍾⍙", "⎎⏃⟟⌰⎍⍀⟒", "⟒⋏⍜⎍☌⊑", "☌⏃⊬",
    "⏃⏁⌰⟒", "⎅⟒⎐", "⎐⟒☊⏁⍜⍀", "⊑⍜⌿⌿⟒⍀", "⋔⟟⋏⟒", "⋔⟟⋏⟒⎎⟟⟒⌰⎅", "⋔⟟⌰⟟⏁⏃⍀⊬", "☊⍜⋏⌇☊⍀⟟⌿⏁", "⏁⍀⟒⌇⌿⏃⌇⌇⟒⍀", "⎍⋏⟟⏁⟒", "⎍⋏⟟⎎⊬", "⋉⏃⏁", "⟊⏃☊☍", "⍙⊑⊬ ⍙⍜⎍⌰⎅ ⊬⍜⎍ ⎅⍜ ⏁⊑⟟⌇ ⏁⍜ ⋔⟒",
    "⏃⟟", "⎐⟟", "☊⍜⍀⟒", "⌿⍜⍙⟒⍀", "⎅⟒⌇⏁⍀⎍☊⏁⟟⍜⋏", "⍀⎍⟟⋏", "⌰⏃⌇⏁⌰⊬", "⍙⟒"}

    language:Register()
end

do
    -- Combine
    local language = ix.languages:New()
    language.name = "Imperial"
    language.uniqueID = "imp"
    language.icon = "icon16/briefcase.png"
    language.notSelectable = true
    language.color = Color(145, 45, 6)
    language.gibberish = {"⊑⟒⌰⌰⍜", "⍙⊑⊬", "⏃", "⋏⍜", "⍙⊑⏃⏁", "⟟⋔⌿⍜⌇⌇⟟⏚⌰⟒", "⌿⍜⌇⌇⟟⏚⌰⟒", "☊⏃⋏'⏁", "⌿⍀⍜☌⍀⏃⋔⋔⟟⋏☌", "☊⍜⎅⟟⋏☌", "⋉⟒⏁⏃", "⌇⌿⊑⟒⍀⟟☊⏃⌰", "⌇⟒☊⏁⍜⍀",
    "⎎⎍⋏⋏⊬", "⍾⍙⟒⍀⏁⊬", "⎅⏃", "⋏⍜⎍", "⊑⍜⍙", "⍙⊑⟒⋏", "⋏⟒⎐⟒⍀", "⊬⟒⏃⍀⌇", "⎅⏃⊬⌇", "⋔⍜⋏⏁⊑⌇", "⎅⟒☊⏃⎅⟒⌇", "☊⟒⋏⏁⎍⍀⊬", "⊬⍜⍀☍", "⋏⟒⍙", "⌇⍜⋔⟒⍙⊑⏃⏁", "⌇⏃⎎⟒", "⎎⍜⌰⌰⍜⍙",
    "☊⍜⋔⟒", "⍙⟟⏁⊑", "⋔⟒", "⋏⍜⍙", "⍙⏃⏁⟒⍀", "⎎⍜⍜⎅", "⟊⏃☊⍜⏚", "⟊⍜⏚", "⏁⟟⌇", "⎍⋏⍙⟟⌇⟒", "⍙⟟⌇⟒", "⏁⍜", "☌⍜", "⏁⊑⟒⍀⟒","⌿⍜⌿", "⌿⍜☌☌⟒⍀⌇", "⏁⟟⏁", "☊⏃", "☊⌿", "⍜⏁⏃", "⌇⊬⋏⏁⊑", "⌇⏁⍀⟟⎅⟒⍀",
    "⏃⟟⍀⍙⏃⏁☊⊑", "☌⍀⍜⎍⋏⎅⍙⏃⏁☊⊑", "☊⟟⏁⊬", "⋔⏃⌿", "⋔⍜", "⏚⍜⏃⊑", "☊⟟⏁⟟⋉⟒⋏", "⎅⟒⎎⟒⋏⌇⟒", "⌇⟒☊⏁⍜⍀ ⌇⟒☊⎍⍀⟒", "⏚⏃⋏", "⎅⟒⏃⏁⊑", "☌⍜⏁", "⌰⍜", "☌⍀⟒⋏⏃⎅⟒", "☊⎎", "☍⍜⌿", "☊⍜⌿",
    "⌇⟒", "⍙⊑⟟⋏⟒", "⏚⍜⋔⏚", "⋏⟒☌⏃⏁⟟⎐⟒", "⏃⎎⎎⟟⍀⋔⏃⏁⟟⎐⟒", "⍜⎐⟒⍀⍙⏃⏁☊⊑", "⌇⏁⏃⋏⎅⏚⊬", "⊬⏃⋔⏃⏁⍜", "⊬⏃", "⊬⍜", "⌇⏁⍜⌿", "☌⟒⏁ ⎅⍜⍙⋏", "⏚⏃☊☍", "⍾⍙", "⎎⏃⟟⌰⎍⍀⟒", "⟒⋏⍜⎍☌⊑", "☌⏃⊬",
    "⏃⏁⌰⟒", "⎅⟒⎐", "⎐⟒☊⏁⍜⍀", "⊑⍜⌿⌿⟒⍀", "⋔⟟⋏⟒", "⋔⟟⋏⟒⎎⟟⟒⌰⎅", "⋔⟟⌰⟟⏁⏃⍀⊬", "☊⍜⋏⌇☊⍀⟟⌿⏁", "⏁⍀⟒⌇⌿⏃⌇⌇⟒⍀", "⎍⋏⟟⏁⟒", "⎍⋏⟟⎎⊬", "⋉⏃⏁", "⟊⏃☊☍", "⍙⊑⊬ ⍙⍜⎍⌰⎅ ⊬⍜⎍ ⎅⍜ ⏁⊑⟟⌇ ⏁⍜ ⋔⟒",
    "⏃⟟", "⎐⟟", "☊⍜⍀⟒", "⌿⍜⍙⟒⍀", "⎅⟒⌇⏁⍀⎍☊⏁⟟⍜⋏", "⍀⎍⟟⋏", "⌰⏃⌇⏁⌰⊬", "⍙⟒"}

    language:Register()
end

function PLUGIN:InitializedPlugins()
	for _, v in pairs(ix.languages.stored) do
		if v.name != "Xendarian" and v.name != "Incongruous" and v.name != "Imperial" and v.name != "Vortigese" then
			for i = 1, 5 do
				local ITEM = ix.item.Register("audiobook_"..i..v.name, nil, false, nil, true)
				ITEM.name = "Learn "..v.name.." - Chapter "..i.." - An Audiobook"
				ITEM.category = "Audiobooks"
				ITEM.model = "models/props_lab/reciever01d.mdl"
                ITEM.description = "An audiobook of 5 chapters used to learn "..v.name
                if (SERVER) then
                    ITEM.language = v
                end

				ITEM.functions.Listen = {
					OnRun = function(itemTable)
                        return PLUGIN:ListenToAudioBook(itemTable, itemTable.player)
					end
				}

				local RECIPE = ix.recipe:New()

				RECIPE.uniqueID = "audiobook_"..i..v.name
				RECIPE.name = "Audiobook - "..v.name.." - Chapter: "..i
				RECIPE.description = "Listening to this rustic audiobook device will help teach you "..v.name..". This is chapter "..i.." out of 5"
				RECIPE.model = "models/props_lab/reciever01d.mdl"
				RECIPE.category = "Audiobooks"
				RECIPE.hidden = false
				RECIPE.skill = "bartering"
				RECIPE.cost = 15
				RECIPE.result = {["audiobook_"..i..v.name] = 1}
				RECIPE.buyAmount = 1 -- amount TEXT
				RECIPE.level = 15
				RECIPE.experience = {
                    {level = 15, exp = 60}, -- full XP
                    {level = 25, exp = 30}, -- half XP
                    {level = 30, exp = 0} -- 0 XP
				}

				RECIPE:Register()
			end
		end
	end
end
