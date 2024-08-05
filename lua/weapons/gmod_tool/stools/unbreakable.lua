--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

﻿/*******************
 *
 *                              Unbreakable STool
 *
 *
 *   Date   : 28  janvier 2007			Date	: 04 December 2013 - 16th June 2015
 *
 *   Auteur : Chaussette™			Author	: XxWestKillzXx + Gui + Sparky
 *
 *******************************************************************************/

if( SERVER ) then
    // Comment this line if you don't want to send this stool to clients
    AddCSLuaFile( "weapons/gmod_tool/stools/unbreakable.lua" )
    
    local RemakeFilterDamage
    local function MakeFilterDamage()
       
        local FilterDamage = ents.Create( "filter_activator_name" )
       
        FilterDamage:SetKeyValue( "TargetName", "FilterDamage" )
        FilterDamage:SetKeyValue( "negated", "1" )
        FilterDamage:Spawn()
       
        FilterDamage:CallOnRemove( "RemakeFilter", function () timer.Simple(0, RemakeFilterDamage) end )
     
    end
   
    RemakeFilterDamage = function()
               
        MakeFilterDamage()
               
        for k, v in pairs(ents.GetAll()) do
            if v:GetVar( "Unbreakable" ) then
                Element:Fire  ( "SetDamageFilter", "FilterDamage", 0 )
            end
        end
			
    end
       
    hook.Add( "InitPostEntity", "MakeFilterDamage", MakeFilterDamage )
 
   
    local function MakeUnbreakable( Element, Value )
       
    local Filter = ""
    if( Value ) then Filter = "FilterDamage" end
     
    if( Element && Element:IsValid() ) then
           
        Element:SetVar( "Unbreakable", Value )
        Element:Fire  ( "SetDamageFilter", Filter, 0 )
        duplicator.StoreEntityModifier( Element, "Unbreakable", {On = Value} )
        
		end
	end
       
    function TOOL:Unbreakable( Element, Value )
       
        MakeUnbreakable( Element, Value )
               
    end
		
		
    local function dupeUnbreakable( Player, Entity, Data )
		if Data.On then
            MakeUnbreakable( Entity, true )
        end
    end
		
    duplicator.RegisterEntityModifier( "Unbreakable", dupeUnbreakable )
		
    function TOOL:Run( Element, Value )
        
        if( Element && Element:IsValid() && ( Element:GetVar( "Unbreakable" ) != Value )) then
            
            self:Unbreakable( Element, Value )
            
            if( Element.Constraints ) then
                
                for x, Constraint in pairs( Element.Constraints ) do
                    for x = 1, 4, 1 do
                        
                        if( Constraint[ "Ent" .. x ] ) then self:Run( Constraint[ "Ent" .. x ], Value ) end
                    end
                end
            end
        end
    end
end


TOOL.Category		= "Constraints"
TOOL.Name			= "Unbreakable"
TOOL.Command		= nil
TOOL.ConfigName		= ""

TOOL.ClientConVar[ "toggle" ] = "1"


if ( CLIENT ) then
    
    language.Add( "tool.unbreakable.name", "Unbreakable" )
    language.Add( "tool.unbreakable.desc", "Make a prop unbreakable" )
    language.Add( "tool.unbreakable.0", "Left click to make a prop unbreakable. Right click to restore its previous settings" )
    language.Add( "tool.unbreakable.toggle", "Extend To Constrained Objects" )
end




function TOOL:Action( Element, Value )
    
    if( Element && Element:IsValid() ) then
        
        if( CLIENT ) then return true end
        
        if( self:GetClientNumber( "toggle" ) == 0 ) then
            
            self:Unbreakable( Element, Value )
        else
            
            self:Run( Element, Value )
        end
        
        return true
    end
    
    return false
end




function TOOL:LeftClick( Target )
    
    return self:Action( Target.Entity, true )
end


function TOOL:RightClick( Target )
    
    return self:Action( Target.Entity, false )
end

function TOOL.BuildCPanel( Panel )
    
    Panel:AddControl( "Header", { Text = "#tool.unbreakable.name", Description = "#tool.unbreakable.desc" }  )
    Panel:AddControl( "Checkbox", { Label = "#tool.unbreakable.toggle", Command = "unbreakable_toggle" } )
end
