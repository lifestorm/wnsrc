--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

gravityEventStarted = false

function startGravityEvent()
    if gravityEventStarted then return end
    gravityEventStarted = true
    print("Gravity event başlatıldı.")
    util.ScreenShake(Vector(0, 0, 0), 5, 3, 10, 9999999, true)
    net.Start("ixPlaySound")
        net.WriteString("event/gravitystart.mp3")
        net.WriteBool(true)
    net.Send(player.GetAll())
    timer.Simple(5, function()
        ix.chat.Send(nil, "broadcast", "<:: Dikkat! Manyetik alan dalgalanması tespit edildi. Kapalı bir alana girmeniz şiddetle tavsiye edilir! ::>", false, nil, {speakerName = "Citadel"})
    end)
    timer.Simple(20, function()
        RunConsoleCommand("sv_gravity", "-1")
        util.ScreenShake(Vector(0, 0, 0), 6, 3, 15, 9999999, true)
        ix.chat.Send(nil, "broadcast", "<:: Manyetik alan bozulması! Bastırıcı konuşlandırılıyor... ::>", false, nil, {speakerName = "Citadel"})
        local players = player.GetAll()
        for i = 1, #players do
            local ply = players[i]
            if ply:Alive() then
                ply:ScreenFade(SCREENFADE.IN, Color(0, 5, 25, 200), 2, 0)
                ply:SetPos(ply:GetPos() + Vector(0,0,5))
                ply:SetVelocity(Vector(0,0,50))
            end
        end
    end)
    timer.Simple(35, function()
        RunConsoleCommand("sv_gravity", "600")
        ix.chat.Send(nil, "broadcast", "<:: Bastırıcı aktif. Sorunun kaynağı tespit edilemedi. ::>", false, nil, {speakerName = "Citadel"})
        gravityEventStarted = false
    end)    
end
