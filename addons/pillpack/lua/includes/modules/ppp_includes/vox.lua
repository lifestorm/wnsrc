--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

AddCSLuaFile()
local voxPacks = {}

function registerVox(name, tbl)
    voxPacks[name] = tbl
end

if CLIENT then
    concommand.Add("pk_pill_voxmenu", function(ply, cmd, args, str)
        if pk_pills.getMappedEnt(ply) and pk_pills.getMappedEnt(ply).formTable.voxSet then
            local voiceMenuSrc = [[
				<head>
					<style>
						body {-webkit-user-select: none; font-family: Arial;}
						h1 {margin: 10px 0; background-color: #CCF; border: 1px solid #00A; color: #00A; width: 150px; font-style:italic;}
						.close {background: red; border: 2px solid black; float: right;}
						.close:hover {background: #F44;}
						#input {height: 55px; background: white; border: 1px solid gray; overflow-x: auto; white-space: nowrap; font-size: 30px;}
						#picker {background: #CCC; border: 1px solid black; margin-top: 10px; overflow-y: auto; position: relative;}
						#picker>div {margin: 4px;cursor: pointer;}
						#cursor {display: inline-block; width: 0; height: 26px; border-left: 2px solid black; margin-top: 2px;}
						
						#picker>div:hover {background-color: #FFC; border: 1px solid #AA0;}
						#selected {background-color: #CCF; border: 1px solid #00A;}
						
						.highlight {color: red; font-weight: bold;}
					</style>
				</head>
				<body>
					<button class="close" onclick="console.log('RUNLUA:SELF:Remove()')">X</button>
					<h1>PillVox</h1>
					<div id="input"></div>
					<div id="picker"></div>
				</body>
				<script>
					var picker = document.getElementById('picker')
					var input = document.getElementById('input')
					picker.style.height= (window.innerHeight-150)+"px"

					var phrases = []
					
					var txt=""
					var cPos=0

					function htmlSafe(str) {
						return String(str).replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;').replace(/ /g,'&nbsp;')
					}

					function render(renderpicker) {
						//search
						var begin = txt.substr(0,cPos)
						var end = txt.substr(cPos)

						input.innerHTML=htmlSafe(begin)+"<div id='cursor'></div>"+htmlSafe(end)
						input.scrollLeft = input.scrollWidth

						//picker
						if (renderpicker) {
							var out=[]
							if (txt=="") {
								for (var i in phrases) {
									out.push("<div data-phrase='"+phrases[i]+"' onclick='pick(this)'>"+phrases[i]+"</div>")
								}
							} else {
								var tosort=[]
								for (var i in phrases) {
									var phrase = phrases[i]
									
									var fragments = txt.trim().split(' ')
									var score=0
									
									var highlighted = phrase.replace(new RegExp(fragments.join("|"),"gi"), function(matched) {
										score+=matched.length
										return "<span class='highlight'>"+matched+"</span>"
									})
									score+=1/phrase.length

									if (highlighted!=phrase) {
										tosort.push({html: ("<div data-phrase='"+phrase.replace(/'/g,"&#39;")+"' onclick='pick(this)'>"+highlighted+"</div>"), score: score})
									}

								}

								tosort.sort(function(a,b) {return b.score-a.score})
								for (j in tosort) {
									out.push(tosort[j].html)
								}
							}
							picker.innerHTML=out.join('')

							var selectedElement = picker.childNodes[0]
							if (selectedElement) {
								selectedElement.setAttribute("id","selected")
								selected = selectedElement.dataset.phrase
							}
						}
					}

					function pick(e) {
						console.log('RUNLUA:RunConsoleCommand("pk_pill_vox","'+e.dataset.phrase+'")')
    					console.log('RUNLUA:SELF:Remove()')
					}

					function init(t) {
						for (k in t) {
							phrases.push(k)
						}
						phrases.sort()
						render(true)
					}

					//cursor
					setInterval(function() {
						var cursor = document.getElementById('cursor')
						if (cursor.style.visibility=='visible')
							cursor.style.visibility='hidden'
						else
							cursor.style.visibility='visible'
					},400)

					document.addEventListener('keydown', function(event) {
    					var key = event.keyCode

    					if (key>=65 && key<=90) {
    						txt=txt.substr(0,cPos)+String.fromCharCode(key+32)+txt.substr(cPos)
    						cPos++
    						render(true)
    					} else if (key>=48 && key<=57 || key==32) {
    						txt=txt.substr(0,cPos)+String.fromCharCode(key)+txt.substr(cPos)
    						cPos++
    						render(true)
    					} else if (key==8) {
							if (cPos>0) {
								txt=txt.substr(0,cPos-1)+txt.substr(cPos)
								cPos--
							}
							render(true)
    					} else if (key==13) {
    						var selectedElement = document.getElementById('selected')
	    					if (selectedElement) {
	    						pick(selectedElement)
	    					} else {
	    						console.log('RUNLUA:SELF:Remove()')
	    					}
	    					render()
	    				} else if (key==37) {
	    					if (cPos>0) {
								cPos--
							}
							render()
	    				} else if (key==39) {
	    					if (cPos<txt.length) {
								cPos++
							}
							render()
	    				} else if (key==38) {
	    					var selectedElement = document.getElementById('selected')
	    					if (selectedElement.previousSibling) {
		    					selectedElement.removeAttribute('id')
		    					selectedElement=selectedElement.previousSibling
		    					selectedElement.setAttribute("id","selected")
								picker.scrollTop = selectedElement.offsetTop-225
							}
	    				} else if (key==40) {
	    					var selectedElement = document.getElementById('selected')
	    					if (selectedElement.nextSibling) {
		    					selectedElement.removeAttribute('id')
		    					selectedElement=selectedElement.nextSibling
		    					selectedElement.setAttribute("id","selected")
								picker.scrollTop = selectedElement.offsetTop-225
							}
	    				}
        			})
				</script>
			]]
            local html = vgui.Create("DHTML", panel)
            html:SetPos(10, ScrH() / 6)
            html:SetSize(300, ScrH() * (2 / 3))
            html:SetAllowLua(true)
            html:SetHTML(voiceMenuSrc)
            html:RunJavascript("init(" .. util.TableToJSON(voxPacks[pk_pills.getMappedEnt(ply).formTable.voxSet]) .. ")")
            html:MakePopup()
        end
    end)
else
    concommand.Add("pk_pill_vox", function(ply, cmd, args, str)
        if pk_pills.getMappedEnt(ply) and pk_pills.getMappedEnt(ply).formTable.voxSet then
            pk_pills.getMappedEnt(ply):EmitSound(voxPacks[pk_pills.getMappedEnt(ply).formTable.voxSet][args[1]])
        end
    end)
end
