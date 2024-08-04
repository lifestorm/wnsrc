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
-- this needs to be here because nutscript likes to load things depth first sometimes
--color = Color(255,0,0), -for adding color to subtitles
--sound = "soundpath", -for adding sound to subtitles/scenes
--songFade = true, -add this to the last scene to add songfadeout
PLUGIN.cutscenes = PLUGIN.cutscenes or {}


PLUGIN.cutscenes["green"] = {
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268239196292780113/image.png?ex=66abb34b&is=66aa61cb&hm=4e9f1089a840f76aea63a914a2d39a2a789cd2e8f0fb87ba7d7837737d39d48a&=&format=webp&quality=lossless&width=1609&height=905", -- The image to be displayed (1920 x 810)
        sound = "", -- Plays in the background until this scene ends
        subtitles = {
            {
                color = Color(255,255,255),
                text = "Peu de temps après la guerre des sept Heures, le Cartel avait tenté de faire d'Orléans une Cité tout comme Paris. | Shortly after the War of the Seven Hours, the Combines had tried to make Orléans a City like Paris.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 12, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "Malheureusement pour des raisons qui n'ont jamais été documenté la colonisations d'Orléans avait échoué. | Unfortunately, for reasons that have never been documented, the colonization of Orleans had failed.",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 10,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268239195567030343/image.png?ex=66abb34a&is=66aa61ca&hm=9db084da74ff693ddf0c191c5321ac6adf41e1e911049f39c90c4de55089ccc2&=&format=webp&quality=lossless&width=1616&height=905", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "Depuis sotn abandon la ville autrefois prospère n'était plus que ruine. Envahie par la végétation. | Since its abandonment, the once prosperous town has been reduced to rubble. Overgrown with vegetation.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 9, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "Il était cependant dit que des groupes de survivants partaient parfois s'y installer. Leurs objectif était de se cacher de l'AirWatch de Cité 13 au sein de la ville en Ruine. | It was said, however, that groups of survivors sometimes set up camp there. Their aim was to hide from the City 13 AirWatch within the Ruines of the City.",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 13,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
                
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268239195177222243/image.png?ex=66abb34a&is=66aa61ca&hm=77c2ac59086f5e82f7fdcae9cdee67000daf370842635e5386e44866e4b3255e&=&format=webp&quality=lossless&width=1612&height=905", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "La Ville offrait un réseau étendue de soutérain, idéal pour se cacher rapidement en cas de patrouille aérienne du Cartel. | The city offered an extensive underground network, ideal for quick concealment in the event of a Combine air patrol.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 10, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
                
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268239877791682631/image.png?ex=66abb3ed&is=66aa626d&hm=fd97f356bb52a9a8a618063735995d0a17e0c149997775907cdf07735298c370&=&format=webp&quality=lossless&width=1615&height=905", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "Chaque nouveaux groupes de survivants qui arrivait dans la ville découvrit des abris. Tous, étaient vide. | Each new group of survivors arriving in the city discovered many shelters. All were empty.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 10, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "Quelques chose ne tournait pas rond dans cette ville. Des rumeurs circulèrent dans la régions, disant que des groupes rentraient dans Orléans pour ne jamais en revenir. | Something wasn't quite right in this town. Rumors circulated in the region that groups were going to Orleans, never to return.",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 11,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
                
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268240344613519360/image.png?ex=66abb45c&is=66aa62dc&hm=3910f4e0949b5193c7e180fed484536fd62b181edaaac83d91d4bd5c4b5ebf30&=&format=webp&quality=lossless&width=1615&height=905", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "Ces rumeurs avait probablement du vrai. Il était probable qu'une infestation Xen soit dans la ville. Rendant l'habitation de celle-ci dangereuse. | The rumors were probably true. It was likely that a Xen infestation was in the city. Making it a dangerous place to live.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 10, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "Peut-être étais-ce simplement une Colonie d'Antlion. | Perhaps it was simply an Antlion Colony.",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 6,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 1,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
                
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/454343791067922441/1268244534781935687/image.png?ex=66abb843&is=66aa66c3&hm=525941bf0dfa40068daa2469ac576f85622fa45e3b29fcdbb1487aa0bd59370d&=&format=webp&quality=lossless&width=550&height=308", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "Mais récemment, le Cartel avait gagné un intérêt étrange pour la vielle ville. | But recently, the Combines had gained a strange interest in the old town.", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "Les patrouilles ce faisait plus régulière de semaines en semaines. | Patrols became more regular with each passing week.",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 7,
            },
            {
                color = Color(255,255,255),
                text = "Et finalement tout cela se croncrétisa dans une Razor-Train qui arriva avec hommes, matériel et vivre. | And finally it all came together in a Razor-Train, which arrived with men, equipment and food.",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 10,
            },
            {
                color = Color(255,255,255),
                text = "Leurs objectif était inconnue des survivant de l'outland. Mais il était sur que rien de bon n'en viendrait. | Their objectives were unknown to the survivors of the outland. But it was sure that nothing good would come of it.",
                font = "ixMediumFont",
                sound = "", -- The sound it plays when this text starts
                duration = 10,
            },
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
                
            },
        }
    },
}

PLUGIN.cutscenes["act4credits"] = cutscene

local cutscene = {
    {
        image = "https://i.gyazo.com/c99b26a888238f9ebefc21c087bccced.jpg", -- The image to be displayed (1920 x 810)
        sound = "", -- Plays in the background until this scene ends
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "HALF LIFE: ASYLUM", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 12, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206348954661425193/20240107011134_1.png?ex=65dbaf03&is=65c93a03&hm=5ea52ac0a4c4fab8ea1b762290b0872db30fb265fda4e54c9f1ca1a589d72d6c&=&format=webp&quality=lossless&width=1618&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "WRITTEN BY BRAVO & KNIGHT", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 10, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206348646803570738/gmod_2glEXk9Dqa.png?ex=65dbaeba&is=65c939ba&hm=a66b83b8555cae98de10f4c095c8eb28a81fc55287ac020c98f2d48aef64817e&=&format=webp&quality=lossless&width=1811&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "PRODUCED BY ITALICS, FIZZLE, RYAN GEARPERMER, VENTED, CRISPY & VERTIX", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206348119491743855/defining_choice.png?ex=65dbae3c&is=65c9393c&hm=4dd335a73e076a8c8947788ab203d4765fcb46600b8ad12a9be68b452f4f8a89&=&format=webp&quality=lossless&width=1618&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "VISUALS AND CINEMATOGRAPHY BY RYAN GEARPERMER, & CRISPY", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206347063143436349/gmod_Qa259Ur0w3.png?ex=65dbad40&is=65c93840&hm=8f9dfa3f13cf273539c3429c4db0fd8eb3b97d0c0583da569e99861cd64b1f46&=&format=webp&quality=lossless&width=1920&height=891", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "SCHEMA BY VENTED, FILTERFEEDER AND LIBERTY", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1170163448005537902/1173515133214011492/b91ed109e73e664351b9da7dd6013419.png?ex=65d2fa22&is=65c08522&hm=63bfb435f0ca3267160b158dcbaa490452499b5e8271819e71de4a5fd1911255&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "SPECIAL THANKS TO JUSTWATS, TUKI, CRISPY, KILLIAN, VENTED AND OUR PLAYERS", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
            },
            {
                color = Color(255,255,255),
                text = "SERVER AWARDS...",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 8,
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        image = "https://media.discordapp.net/attachments/1170163448005537902/1195574270840016966/fc29e505e7da9dacfc6d94eff8740ede.jpg?ex=65d9664e&is=65c6f14e&hm=e07aeb6e8d559ab88d7b1c99646764cf4709307b9169b3f816ec83a4193962e7&=&format=webp&width=1599&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BEST SPY -  David 'Who?' Beaumont [Gambler Skeleton]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
            },
            {
                color = Color(255,255,255),
                text = "BEST PLAYER PAC - Charles Fu [Potatogod]",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 8,
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1206082105285681252/image.png?ex=65dab67d&is=65c8417d&hm=c5da7a6e69e9da5950f581ac22b16eb1f37265b99ca21b2335656110971a6f15&=&format=webp&quality=lossless&width=1792&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BIGGEST BLUNDER - The Device", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens  
            },
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens				
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206349336389095424/image.png?ex=65dbaf5e&is=65c93a5e&hm=eac15cb03ec7c6c4235af6896e6286b4e4b180f69a41979977f30c4968f3e7fa&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BEST DEATH - Lowe [Switchblades]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens  
            },
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens				
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206347066578706512/gmod_2jMLraPlvj.png?ex=65dbad41&is=65c93841&hm=c069ed5e0870a47a7f5323d8b6474ed4e9912ca185d0e627b039991eebda2cbc&=&format=webp&quality=lossless&width=1920&height=861", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "WORST DEATH - Johnny Riggs [Jack Noble]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 6, -- How long it stays on the screen before the next thing happens       
            },
            {
                color = Color(255,255,255),
                text = "SIDEPLOT SAGE - Alvi Lehto [Zab]",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 9,
			},	
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1182154800285110384/image.png?ex=65d6b8f3&is=65c443f3&hm=9fe10646a292764c439450035bb45b223820cdcc561de10b8e5fbb5f77741b8e&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "MOST SCAMMED BY TRADERS - Che Cabello [Goliath]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 6, -- How long it stays on the screen before the next thing happens       
            },
            {
                color = Color(255,255,255),
                text = "MOST ADMINHELPS - Tuki",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 9,
			},	
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1206342350159351848/1206347304685150258/fadi4.png?ex=65dbad7a&is=65c9387a&hm=aebaa33740d97613fe259562248fb2111a8a3c2a7e0e45a6c048fa3c1433492c&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BEST SCREENSHOTS - Justwats", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 17, -- How long it stays on the screen before the next thing happens               
            },
            {
                color = Color(255,255,255),
                text = "PERFECT ATTENDANCE - Orphan",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 10,
            },
			{
                color = Color(255,255,255),
                text = "CASHFLOW AWARD (ESG) - Furnaxx ",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 11,
			},	
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1170549267035861032/image.png?ex=65daa4f5&is=65c82ff5&hm=5b8b9ef9139648ac087e5bad1146124beaaad81753516669cb386268d26fce73&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "EMPLOYEE OF THE SERVER - Fizzle", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 17, -- How long it stays on the screen before the next thing happens               
            },
            {
                color = Color(255,255,255),
                text = ".",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 1,
			},
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1195989105515966505/imhim.png?ex=65dae8a7&is=65c873a7&hm=4d4c0705121d9a2c21a735d69d8b1ae19591e8fa1feebca43bc70619ba0be4f4&=&format=webp&quality=lossless", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BEST DIALOGUE - Cedric List, PhD. [Romeo]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 5, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://images-ext-1.discordapp.net/external/qOT-7lv2vU38aWpLCuILXtv1ufMj0i1Pz6BVfgmXX0A/https/i.gyazo.com/0c1d87daa5425aa4f9d0f7ae3df11141.png?format=webp&quality=lossless&width=1034&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "BEST CHARACTER - Leslie Dickens [RileyTheRoomba] ", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 5, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1196324313389879409/127be6b436c9477f4094ae2da008315f.png?ex=65d2e656&is=65c07156&hm=78f2ff37aed37550317ff35eb4ff863147b881218fb65d18a3fee893f78b23ef&=&format=webp&quality=lossless&width=1920&height=886", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "DIRECTORS' CHOICE AWARD - Marieke Breytenbach [Carnifex]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 5, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
    {
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1206112316266123284/image.png?ex=65dad2a0&is=65c85da0&hm=c1191622978e8390f3cc80d8f6c2634077df71b60483fe141b16e6c31110d0ba&=&format=webp&quality=lossless&width=1104&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "ORDER OF KLEINER 1ST CLASS - Evelyn Kendrick [Orin]", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 5, -- How long it stays on the screen before the next thing happens
			},
			{
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
        }
    },
	{
        color = Color(255,255,255),
        image = "https://media.discordapp.net/attachments/1170163448005537902/1181075766369329202/image.png?ex=65d2cc06&is=65c05706&hm=161988cf0fca25d735e9a25d0a3be198ae012084b4707a4542cb901a3a018806&=&format=webp&quality=lossless&width=1818&height=910", -- The image to be displayed (1920 x 810)
        subtitles = {
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },
            {
                color = Color(255,255,255),
                text = "HALF-LIFE: ASYLUM", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 8, -- How long it stays on the screen before the next thing happens
                
            },
            {
                color = Color(255,255,255),
                text = "THANKS FOR PLAYING!",
                font = "ixMediumFont",
                sound = "buttons/lever_005.wav", -- The sound it plays when this text starts
                duration = 10,
			},	
            {
                color = Color(255,255,255),
                text = "", -- Subtitle text
                font = "ixMediumFont", -- The font is uses
                sound = "", -- The sound it plays when this text starts
                duration = 1, -- How long it stays on the screen before the next thing happens        
            },                
        }
	},
}


PLUGIN.cutscenes["asylumcredits"] = cutscene