--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]


-- Copyright (c) 2018-2020 TFA Base Devs

-- Permission is hereby granted, free of charge, to any person obtaining a copy
-- of this software and associated documentation files (the "Software"), to deal
-- in the Software without restriction, including without limitation the rights
-- to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
-- copies of the Software, and to permit persons to whom the Software is
-- furnished to do so, subject to the following conditions:

-- The above copyright notice and this permission notice shall be included in all
-- copies or substantial portions of the Software.

-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
-- IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
-- FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
-- AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
-- LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
-- OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
-- SOFTWARE.

--this presents from becoming blank
--[[
--general
TFA_GetStat(wepom,stat,value) --modify value in here, oh and you have to return
--deploy+init
TFA_SetupDataTables(wepom) --do things in here
TFA_PathStatsTable(wepom) --do things in here
TFA_PreInitialize(wepom) --do things in here
TFA_Initialize(wepom) --do things in here
TFA_PreDeploy(wepom) --do things in here
TFA_Deploy(wepom) --do things in here; return to override what the thingy returns
--holster+remove
TFA_PreHolster(wepom, target) --do things in here, called before we truly holster, but in the holster hook; return to override what the thingy returns
TFA_Holster(wepom) --really the finishholster func; return to override what the thingy returns
TFA_OnRemove(wepom) --return to override what the thingy returns
TFA_OnDrop(wepom) -- return to override what the thingy returns
--think
--primary fire related things
TFA_PreCanPrimaryAttack(wepom) --return to override our answer before doing base checks
TFA_CanPrimaryAttack(wepom) --return to override our answer, after TFA's checks
TFA_PrimaryAttack(wepom) --do things here; return to prevent proceeding
TFA_PostPrimaryAttack(wepom) --do things here
--secondary
TFA_SecondaryAttack(wepom) --do things here; return to override
--reload related things
TFA_PreReload(wepom,keyreleased) --called before sanity checks.  do things here; return to prevent proceeding
TFA_Reload(wepom) --called when you take ammo.  do things here; return to prevent proceeding
TFA_LoadShell(wepom) --called when insert a shotgun shell and play an animation.  This runs before that; return to do your own logic
TFA_Pump(wepom) --called when you pump the shotgun as a separate action, playing the animation.  This runs before that; return to do your own logic
TFA_CompleteReload(wepom) --the function that takes from reserve and loads into clip; return to override
TFA_CheckAmmo(wepom) --the function that fidgets when you reload with a full clip; return to override
TFA_PostReload(wepom) --do things here
--FOV
TFA_PreTranslateFOV(wepom,fov) --return a value to entirely override the fov with your own stuff, before TFA Base calcs it
TFA_TranslateFOV(wepom,fov) --return a value to modify the fov with your own stuff
--attachments
TFA_PreInitAttachments(wepom) --modify attachments here
TFA_PostInitAttachments(wepom) --runs before building attachment cache
TFA_FinalInitAttachments(wepom) --final attachment init hook
TFA_PreCanAttach(wepom, attid) --can we attach a thingy?  called before exclusions/dependencies
TFA_CanAttach(wepom, attid) --can we attach a thingy?  called after exclusions/dependencies
TFA_Attachment_Attached(wepom, attid, atttable, category, attindex, forced) --called after attachment was attached to the gun
TFA_Attachment_Detached(wepom, attid, atttable, category, attindex, forced) --called after attachment was detached from the gun
--animation
TFA_AnimationRate(wep,act,rate) --return modified rate value here
--effects
TFA_MakeShell(wep) --return something to cancel making a shell.  runs predicted
TFA_EjectionSmoke(wep) --return something to cancel making an effect.  runs predicted
TFA_MuzzleSmoke(wep) --return something to cancel making an effect.  runs predicted
TFA_MuzzleFlash(wep) --return something to cancel making an effect.  runs predicted
--ironsights
TFA_IronSightSounds(wepom) --called when we actually play a sound; return to prevent this
--HUD
TFA_DrawCrosshair(wepom, x, y) -- crosshair; return false to draw only hl2 crosshair, true to prevent drawing both
TFA_DrawHUDAmmo(wepom, x, y, alpha) -- 3d2d ammo indicator; return false to disable, true to override values (return true, x, y, alpha)
TFA_DrawScopeOverlay(wepom) -- called when 2d scope overlay is drawn; return true to prevent
--bash
TFA_CanBash(wepom) -- called before bashing; return false to prevent bashing
TFA_Bash(wepom) -- called after all checks, animation started playing
TFA_PostBash(wepom) -- do things here
--Inspection VGUI
TFA_InspectVGUI_Start(wepom) -- called before creating main panel; return false to prevent
TFA_InspectVGUI_Finish(wepom, mainpanel, contentpanel) -- called after adding every panel
TFA_InspectVGUI_InfoStart(wepom, contentpanel) -- called before adding main info (weapon name and stuff); return false to prevent
TFA_InspectVGUI_InfoFinish(wepom, contentpanel) -- called after adding main info
TFA_InspectVGUI_StatsStart(wepom, contentpanel) -- called before adding bottom info (stats); return false to prevent
TFA_InspectVGUI_StatsFinish(wepom, contentpanel) -- called after adding bottom info
TFA_InspectVGUI_AttachmentsStart(wepom, contentpanel) -- called before adding attachments panel; return false to prevent
TFA_InspectVGUI_AttachmentsFinish(wepom, contentpanel, attachmentspanel) -- called after adding attachments panel
TFA_InspectVGUI_FalloffStart(wepom, contentpanel) -- called before adding damage falloff graph; return false to prevent
TFA_InspectVGUI_FalloffFinish(wepom, contentpanel, falloffpanel) -- called after adding falloff panel
]]