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

--[[
    FIELD LIST:
    -sell:      (optional) price when smuggler sells to player. Note that if not provided, buy price should be!
    -buy:       (optional) price when smuggler buys from player. Note that if not provided, sell price should be!
    -cat:       (optional) override category, uses item category otherwise (for recipe on skill panel and in smuggling edit UI)
    -level:     (optional) minimal level required, defaults to 0 (no level required)
    -maxStock:  (optional) limit stock on this item on top of total stock limit, smuggler will no longer buy if it reaches this limit
    -buyExp:    (optional) override buy experience (when buying from player), defaults to buy price
    -sellExp:   (optional) override sell experience (when selling to the player), defaults to sell prace

]]
PLUGIN.itemList = {
    --Basics
    ["ing_flour"] =     {sell = 12, buy = 4, cat = "Ingrédients", level = 2},
    ["ing_vinegar"] =   {sell = 12, buy = 4, cat = "Ingrédients", level = 3},
    ["ing_herbs"] =     {sell = 10, buy = 3, cat = "Ingrédients", level = 2},
    ["ing_egg"] =       {sell = 25, buy = 12, cat = "Ingrédients", level = 4},
    ["ing_margarine"] = {sell = 9, buy = 3, cat = "Ingrédients", level = 2},
    ["ing_salt"] =      {sell = 9, buy = 3, cat = "Ingrédients", level = 1},
    ["ing_spices"] =    {sell = 12, buy = 6, cat = "Ingrédients", level = 3},
    ["ing_vegetable_pack"] = {sell = 12, buy = 4, cat = "Ingrédients", level = 3},
    ["ing_noodles"] =   {sell = 9, buy = 3, cat = "Ingrédients", level = 2},
    ["ing_protein"] =   {sell = 10, buy = 3, cat = "Ingrédients", level = 2},
    ["ing_sweet"] =     {sell = 8, buy = 4, cat = "Ingrédients", level = 3},
    ["drink_milk"] =    {sell = 10, buy = 4, cat = "Ingrédients", level = 2},
    ["fruit_berries"] =     {sell = 12, buy = 6, cat = "Ingrédients", level = 1},
    ["ing_headcrab_meat"] =    {sell = 15, buy = 3, cat = "Ingrédients", level = 0},
    ["ing_antlion_meat"] =    {sell = 15, buy = 3, cat = "Ingrédients", level = 0},
    ["drink_beer"] =    {sell = 60, buy = 25, cat = "Alcool", level = 3},
    ["drink_bourbon"] = {sell = 70, buy = 30, cat = "Alcool", level = 4},
    ["drink_whiskey"] = {sell = 70, buy = 30, cat = "Alcool", level = 4},
    ["drink_vodka"] =   {sell = 70, buy = 30, cat = "Alcool", level = 4},

    --Components
    ["comp_plastic"] =  {sell = 7, buy = 2, cat = "Composants pour crafting", level = 0},
    ["comp_wood"] =     {sell = 8, buy = 3, cat = "Composants pour crafting", level = 0},
    ["comp_cloth"] =    {sell = 8, buy = 3, cat = "Composants pour crafting", level = 0},
    ["comp_metal"] =    {sell = 9, buy = 3, cat = "Composants pour crafting", level = 0},
    ["comp_glass"] =    {sell = 7, buy = 2, cat = "Composants pour crafting", level = 0},
    ["comp_electronics"] = {sell = 10, buy = 3, cat = "Composants pour crafting", level = 0},

    ["comp_adhesive"] =             {sell = 25, buy = 10, cat = "Composants pour crafting", level = 4},
    ["comp_alcohol"] =              {sell = 35, buy = 18, cat = "Composants pour crafting", level = 7},
    ["comp_unrefinedchemical"] =    {sell = 23, buy = 11, cat = "Composants pour crafting", level = 7},
    ["comp_craftwork_wood"] =       {sell = 51, buy = 26, cat = "Composants pour crafting", level = 9},
    ["comp_stitched_cloth"] =       {sell = 43, buy = 23, cat = "Composants pour crafting", level = 12},
    ["comp_nails_screws"] =         {sell = 26, buy = 12, cat = "Composants pour crafting", level = 6},

    ["comp_strong_adhesive"] =      {sell = 88, buy = 38, cat = "Composants pour crafting", level = 15},
    ["comp_refinedchemical"] =      {sell = 50, buy = 26, cat = "Composants pour crafting", level = 15},
    ["comp_improved_nails_screws"] = {sell = 113, buy = 44, cat = "Composants pour crafting", level = 15},
    ["comp_refined_plastic"] =      {sell = 42, buy = 16, cat = "Composants pour crafting", level = 15},
    ["comp_reshaped_metal"] =       {sell = 52, buy = 22, cat = "Composants pour crafting", level = 15},

    ["comp_refined_metal"] =        {sell = 260, buy = 115, cat = "Composants pour crafting", level = 20},
    ["comp_fabric"] =               {sell = 200, buy = 81, cat = "Composants pour crafting", level = 20},
    ["comp_explosive"] =            {sell = 220, buy = 95, cat = "Composants pour crafting", level = 20},

    --Medical
    ["comp_purifier"] =             {sell = 50, buy = 26, cat = "Composants médicaux", level = 10},
    ["comp_syringe"] =              {sell = 30, buy = 14, cat = "Composants médicaux", level = 5},

    ["bandage"] =                   {sell = 44, buy = 12, cat = "Médecine", level = 5, stackSize = 6},
    ["disinfectant_bottle"] =       {sell = 98, buy = 45, cat = "Médecine", level = 5, stackSize = 6},
    ["painkillers"] =               {sell = 90, buy = 33, cat = "Médecine", level = 8, stackSize = 4},
    ["disinfected_bandage"] =       {sell = 112, buy = 58, cat = "Médecine", level = 10, stackSize = 4},
    ["bloodbag"] =                  {sell = 440, buy = 320, cat = "Médecine", level = 15, stackSize = 4},
    ["bloodstabilizer"] =           {sell = 237, buy = 97, cat = "Médecine", level = 12, stackSize = 4},
    ["adrenaline"] =                {sell = 90, buy = 33, cat = "Médecine", level = 13, stackSize = 3},
    ["morphine"] =                  {sell = 90, buy = 35, cat = "Médecine", level = 16, stackSize = 3},
    ["firstaid"] =                  {sell = 480, buy = 200, cat = "Médecine", level = 19, stackSize = 3},
    ["surgerykit"] =                {sell = 778, buy = 300, cat = "Médecine", level = 20, stackSize = 3},

    -- Tools
    ["head_gasmask"] =              {sell = 320, buy = 180, cat = "Equipement", level = 20},
    ["highquality_filter"] =        {sell = 550, buy = 200, cat = "Equipement", level = 20},
    ["face_bandana"] =              {sell = 72, buy = 26, cat = "Equipement", level = 4},
    ["head_military_cap"] =         {sell = 80, buy = 38, cat = "Equipement", level = 9},
    ["smallbag"] =                  {sell = 160, buy = 85, cat = "Equipement", level = 4},
    ["largebag"] =                  {sell = 250, buy = 146, cat = "Equipement", level = 13},
    ["flashlight"] =                {sell = 22, buy = 8, cat = "Equipement", level = 2},
    ["handheld_radio"] =            {sell = 420, buy = 240, cat = "Equipement", level = 20},
    ["old_radio"] =                 {sell = 260, buy = 100, cat = "Equipement", level = 11},

    ["waterbottle"] =               {sell = 20, buy = 5, cat = "Outils", level = 0},
    ["watervalve"] =                {sell = 30, buy = 10, cat = "Outils", level = 8},
    ["tool_wrench"] =               {sell = 160, buy = 70, cat = "Outils", level = 12},
    ["tool_toolkit"] =              {sell = 103, buy = 60, cat = "Outils", level = 7},
    ["tinderbox"] =                 {sell = 47, buy = 30, cat = "Outils", level = 9},
    ["lighter"] =                   {sell = 40, buy = 13, cat = "Outils", level = 0},
    ["beard_razor"] =               {sell = 48, buy = 13, cat = "Outils", level = 4},
    ["tool_scissors"] =             {sell = 18, buy = 5, cat = "Outils", level = 0},
    ["tool_cookingpot"] =           {sell = 45, buy = 20, cat = "Outils", level = 6},
    ["tool_spoon"] =                {sell = 22, buy = 10, cat = "Outils", level = 2},
    ["tool_knife"] =                {sell = 34, buy = 14, cat = "Outils", level = 3},
    ["tool_fryingpan"] =            {sell = 45, buy = 20, cat = "Outils", level = 4},
    ["tool_mixer"] =                {sell = 160, buy = 80, cat = "Outils", level = 20},
}
