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
	optGmod_mcore_test = "Rendu multicœur",
	optdGmod_mcore_test = "Active/désactive le rendu multicœur pour votre jeu. Nécessite un redémarrage.",
	optMat_queue_mode = "Mode de file d'attente du matériel",
	optdMat_queue_mode = "Le mode de file d'attente/thread que le système matériel devrait utiliser (-1 = par défaut, 0 = synchrone simple fil, 1 = file d'attente simple fil, 2 = file d'attente multi-fil)",
	optCl_threaded_bone_setup = "Système d'os multithreadé",
	optdCl_threaded_bone_setup = "Toggles parallel processing for the bone system",
	optR_decals = "Max decals",
	optdR_decals = "Le nombre maximum de décalcomanies autorisées à rendre à un moment donné",
	optR_drawmodeldecals = "Décalques du modèle",
	optdR_drawmodeldecals = "Si les décalcomanies doivent être rendues sur les modèles ou non",
	optR_maxmodeldecal = "Max model decals",
	optdR_maxmodeldecal = "Le nombre maximum de décalcomanies autorisées à être rendues sur les modèles à un moment donné",
	optCl_ragdoll_collide = "Collision ragdoll côté client",
	optdCl_ragdoll_collide = "Si les modèles côté client doivent avoir des collisions ou non",
	optR_WaterDrawReflection = "Reflets de l'eau",
	optdR_WaterDrawReflection = "Si l'eau doit avoir des réflexions",
	optR_WaterDrawRefraction = "Réfraction de l'eau",
	optdR_WaterDrawRefraction = "Si l'eau doit avoir des réfractions",
	optR_shadows = "Ombres du modèle",
	optdR_shadows = "Si les modèles et les accessoires doivent avoir des ombres",
	optMat_mipmaptextures = "Textures 'Mipmap'",
	optdMat_mipmaptextures = "Augmente la qualité des textures en échange de la performance",
	optMat_filtertextures = "Textures de filtre",
	optdMat_filtertextures = "Augmente la qualité des textures en échange de la performance",
	optMat_envmapsize = "Taille de la carte d'environnement",
	optdMat_envmapsize = "Ajuste la résolution des cartes d'environnement qui sont utilisées pour les surfaces réfléchissantes.",
	optCl_phys_props_enable = "Props de physique côté client",
	optdCl_phys_props_enable = "Toggles clientside physics props. Nécessite une reconnexion",
	optCl_ejectbrass = "Ejecter le laiton",
	optdCl_ejectbrass = "Indique si les balles doivent être éjectées de l'arme lors du tir",
	optMat_filterlightmaps = "Filtrer les lightmaps",
	optdMat_filterlightmaps = "Augmente la qualité de la lumière en échange de la performance",
	optMuzzleflash_light = "Lumière flash de bouche",
	optdMuzzleflash_light = "Si le muzzleflash doit éclairer le viewmodel du joueur",
	optProps_break_max_pieces = "Maximum prop gibs",
	optdProps_break_max_pieces = "Nombre maximum de pièces cassables des accessoires (-1 = modèle par défaut)",
	optR_3dsky = "Skybox 3D",
	optdR_3dsky = "Si les 3D Skyboxes doivent être rendus",
	optR_maxdlights = "Maximum Dynamic Lights",
	optdR_maxdlights = "Le maximum de lumières dynamiques autorisées à exister à un moment donné",
	optR_eyemove = "Mouvement des yeux",
	optdR_eyemove = "Si les yeux des personnages et des PNJ doivent bouger",
	optR_eyes = "Rendu des yeux",
	optdR_eyes = "Si les yeux du personnage et du NPC doivent être rendus",
	optR_teeth = "Rendu des dents",
	optdR_teeth = "Si les dents du personnage et du PNJ doivent être rendues",
	optR_radiosity = "Paramètre de radiosité",
	optdR_radiosity = "La manière dont la radiosité est échantillonnée (0 = pas de radiosité, 1 = radiosité avec cube ambiant (6 échantillons), 2 = radiosité avec 162 échantillons, 3 = 162 échantillons pour les accessoires statiques, 6 échantillons pour tout le reste)",
	optR_worldlights = "Lumières du monde",
	optdR_worldlights = "Le nombre de lumières du monde à utiliser par vertex",
	optRope_averagelight = "Rope Average Light",
	optdRope_averagelight = "Les cordes utilisent la moyenne de l'éclairage cubemap au lieu de l'intensité maximale",
	optRope_collide = "Collisions des cordes",
	optdRope_collide = "Si les cordes doivent entrer en collision avec le monde",
	optRope_rendersolid = "Rendu des cordes",
	optdRope_rendersolid = "Si les cordes doivent être rendues.",
	optRope_smooth = "Anti-crénelage des cordes",
	optdRope_smooth = "Si les cordes doivent avoir des mesures d'anti-crénelage appliquées sur eux.",
	optRope_subdiv = "Subdivision des cordes",
	optdRope_subdiv = "Montant de la subdivision des cordes",
	optViolence_ablood = "Sang d'alien",
	optdViolence_ablood = "Si le sang étranger doit être rendu.",
	optViolence_agibs = "Gibs d'alien",
	optdViolence_agibs = "Doit rendre les gibs aliens",
	optViolence_hblood = "Sang humain",
	optdViolence_hblood = "Doit rendre le sang humain.",
	optViolence_hgibs = "Gibs humain",
	optdViolence_hgibs = "Doit rendre les gibs humains",
	optAi_expression_optimization = "Optimisation de l'expression de l'IA",
	optdAi_expression_optimization = "Si les expressions des PNJ ne doivent pas être rendues si vous ne pouvez pas les voir",
	optCl_detaildist = "Distance de détail",
	optdCl_detaildist = "Distance à laquelle les accessoires de détail ne sont plus visibles",
	optCl_detailfade = "Detail Fade",
	optdCl_detailfade = "Distance à laquelle les accessoires de détail s'estompent",
	optR_fastzreject = "Fast Z Reject",
	optdR_fastzreject = "Active/désactive un algorithme de réglage rapide de l'axe Z pour tirer parti du matériel avec un rejet rapide de l'axe Z. Utilisez -1 pour utiliser les paramètres du matériel par défaut. Utilisez -1 pour utiliser les paramètres du matériel par défaut.",
	optCl_show_splashes = "Rendu des éclaboussures d'eau",
	optdCl_show_splashes = "Si les éclaboussures d'eau doivent être rendues.",
	optR_drawflecks = "Rendu des mouchetures",
	optdR_drawflecks = "Si des particules doivent être créées lorsqu'un mur est tiré",
	optR_threaded_particles = "Système de particules multithreadées",
	optdR_threaded_particles = "Toggles parallel processing for the particle system",
	optSnd_mix_async = "Système de sonorisation multithreadé",
	optdSnd_mix_async = "Active le traitement parallèle pour le système de sonorisation",
	optR_threaded_renderables = "Système de rendu multithreadé",
	optdR_threaded_renderables = "Active le traitement parallèle pour le système de rendu",
	optCl_forcepreload = "Force Pre-Load",
	optdCl_forcepreload = "Force le préchargement de tout le contenu avant le chargement de la carte, par opposition au chargement des choses lorsque cela est nécessaire."
}
