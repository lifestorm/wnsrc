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
local math = math
local CurTime = CurTime
local charDelay = 0.05

function PLUGIN:RenderScreenspaceEffects()
    if IsValid(LocalPlayer()) then 
        local client = LocalPlayer() 

        local movieBars = client:GetNetVar("MovieBars");
 
        local frameTime = FrameTime();
        local interval = frameTime / 5;
        
        if not colorModify then
            colorModify = {
                brightness = 0,
                contrast = 1,
                color = 1,
                addr = 0,
                addg = 0,
                addb = 0
            };
        end;

        if colorModify["$pp_colour_brightness"] == nil then
            colorModify["$pp_colour_brightness"] = 0;
        end
        
        if colorModify["$pp_colour_contrast"] == nil then
            colorModify["$pp_colour_contrast"] = 1;
        end
        
        if colorModify["$pp_colour_colour"] == nil then
            colorModify["$pp_colour_colour"] = 1;
        end

        if (movieBars) then
            colorModify.brightness = math.Approach(colorModify.brightness, -0.1, interval); 
            colorModify.contrast = math.Approach(colorModify.contrast, 1, interval);
            colorModify.color = math.Approach(colorModify.color, 0.7, interval); 
        else
            colorModify.brightness = math.Approach(colorModify.brightness, 0, interval); 
            colorModify.contrast = math.Approach(colorModify.contrast, 1, interval);
            colorModify.color = math.Approach(colorModify.color, 1, interval);
        end;
        
        colorModify["$pp_colour_brightness"] = colorModify.brightness;
        colorModify["$pp_colour_contrast"] = colorModify.contrast;
        colorModify["$pp_colour_colour"] = colorModify.color;

        DrawColorModify(colorModify)
    end;
end;

local colorWhite = Color(255, 255, 255);
local colorBlack = Color(0, 0, 0);

function PLUGIN:HUDPaint()
    if not IsValid(LocalPlayer()) then return end
    
    local client = LocalPlayer() 
    local movieBars = client:GetNetVar("MovieBars");
    local frameTime = FrameTime();
    local scrW, scrH = ScrW(), ScrH();


    if not self.movieLength then
        self.movieLength = 0;
    end

    if movieBars then
        self.movieLength = math.Approach(self.movieLength, scrH * 0.34, 64 * frameTime);
    else
        self.movieLength = math.Approach(self.movieLength, 0, 64 * frameTime);
    end;

    draw.RoundedBox(2, -10, scrH - (self.movieLength / 2), scrW + 20, scrH - self.movieLength, colorBlack);
    draw.RoundedBox(2, -10, -10 - (self.movieLength / 2), scrW + 20, 0 + self.movieLength, colorBlack);
end;

