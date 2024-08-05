--[[
| This file was obtained through the combined efforts
| of Madbluntz & Plymouth Antiquarian Society.
|
| Credits: lifestorm, Gregory Wayne Rossel JR.,
| 	Maloy, DrPepper10 @ RIP, Atle!
|
| Visit for more: https://plymouth.thetwilightzone.ru/
--]]

local f = string.format

VyHub.Dashboard = VyHub.Dashboard or {}

VyHub.Dashboard.ui = VyHub.Dashboard.ui or nil

VyHub.Dashboard.html_ready = false
VyHub.Dashboard.html_generated = VyHub.Dashboard.html_generated or false

local dashboard_html = dashboard_html or "Loading, please try again. If this does not help, please ask the server owner to check for errors in the server console. In most cases, vyhub-gmod has not been downloaded correctly and is missing files."

function VyHub.Dashboard:create_ui()
	VyHub.Dashboard.html_ready = false

	local xsize = ScrW() - ScrW()/4
	local ysize = ScrH() - ScrH()/4
	local xpos  = ScrW()/2 - xsize/2
	local ypos  = ScrH()/2 - ysize/2
	local title = "VyHub Server-Dashboard"
	local box_color = Color(94, 0, 0, 255)

	VyHub.Dashboard.ui = vgui.Create("DFrame")
	VyHub.Dashboard.ui:SetSize(xsize, ysize)
	VyHub.Dashboard.ui:SetPos(xpos, ypos)
	VyHub.Dashboard.ui:SetDraggable(true)
	VyHub.Dashboard.ui:SetTitle(title)
	VyHub.Dashboard.ui:SetDeleteOnClose(false)
	function VyHub.Dashboard.ui.Paint(self, w, h)
		surface.SetDrawColor(box_color)
		surface.DrawRect(0, 0, w, 24)
	end

	VyHub.Dashboard.ui_html = vgui.Create("DHTML", VyHub.Dashboard.ui)
	VyHub.Dashboard.ui_html:SetSize(xsize, ysize - 24)
	VyHub.Dashboard.ui_html:SetPos(0, 24)
	VyHub.Dashboard.ui_html:SetHTML(dashboard_html)

	function VyHub.Dashboard.ui_html:OnDocumentReady()
		MsgN("VyHub Dashboard: HTML Loaded")
		VyHub.Dashboard.html_ready = true
		VyHub.Dashboard.ui_html:RunJavascript('local_steamid64 = ' .. LocalPlayer():SteamID64())
	end

	VyHub.Dashboard.ui_html:AddFunction("vyhub", "warning_toggle", function (warning_id)
		LocalPlayer():ConCommand(f("vh_warning_toggle %s", warning_id))
	end)
	VyHub.Dashboard.ui_html:AddFunction("vyhub", "warning_delete", function (warning_id)
		LocalPlayer():ConCommand(f("vh_warning_delete %s", warning_id))
	end)
	VyHub.Dashboard.ui_html:AddFunction("vyhub", "ban_set_status", function (ban_id, status)
		LocalPlayer():ConCommand(f("vh_ban_set_status %s %s", ban_id, status))
	end)
	VyHub.Dashboard.ui_html:AddFunction("vyhub", "warning_create", function (steamid, reason)
		LocalPlayer():ConCommand(f('vh_warn %s "%s"', steamid, VyHub.Util:escape_concommand_str(reason)))
	end)
	VyHub.Dashboard.ui_html:AddFunction("vyhub", "ban_create", function (steamid, minutes, reason)
		LocalPlayer():ConCommand(f('vh_ban %s "%s" "%s"', steamid, minutes, VyHub.Util:escape_concommand_str(reason)))
	end)
end

function VyHub.Dashboard:load_html()
	VyHub.Dashboard.html_generated = true
	dashboard_html = [[
		<html>
			<head>
				<meta charset="utf-8">
				<meta name="viewport" content="width=device-width, initial-scale=1">

				<link rel="stylesheet" href="http://cdn.vyhub.net/assets/roboto-v30-latin/roboto-v30-latin.css">
				<link rel="stylesheet" href="http://cdn.vyhub.net/assets/font-awesome-4.7.0/css/font-awesome.min.css">
				<link rel="stylesheet" href="http://cdn.vyhub.net/assets/bootswatch-darkly.min.css">

				<style>
					::selection {
						background: #b5b5b5; /* WebKit/Blink Browsers */
					}

					body{
						overflow-x: hidden;
						overflow-y: scroll;
						font-family: Roboto !important;
					}

					.vh-input {
						background-color: #303030; 
						color: white; 
						height: 30px;
					}

					.nav-pills .active {
						background-color: #303030;
						font-weight: bold;
						margin-left: 4px;
					}

					.user-tab {
						padding: 3px 6px 3px 6px;
						border-radius: 8px;
						text-overflow: ellipsis;
						overflow:hidden; 
					}

					#user_name {
						width: 50%;
						text-overflow: ellipsis;
						overflow: hidden;
					}
				</style>
			</head>
			<body>	
				<div class="row" style="margin: 10px">
					<div class="col-xs-4 col-lg-3">
						<div class="input-group">
							<div class="input-group-addon"><i class="fa fa-search"></i></div>
							<input style="height: 40px;" id="user_search" type="text" class="form-control vh-input" onclick="$('#user_search').val(''); generate_user_list();" onkeyup="generate_user_list()" >
						</div>
						<br/>
						<ul class="nav nav-pills nav-stacked" id="user_list">

						</ul>
					</div>
					<div class="col-xs-8 col-lg-9">
						<div id="user_content_empty">
							]] .. VyHub.lang.dashboard.select_user .. [[
						</div>
						<div class="tab-content" id="user_content" style="display: none;">
							<h3 style="margin: 5px 0px 0px 0;">
								<div class="row">
									<div class="col-xs-9">
										<span id="user_name">
											<span class="label label-default" style="background-color: #5E0000; border-radius: .25em 0 0 .25em;">
												<i class="fa fa-user"></i> &nbsp;<span id="user_content_name"></span>
											</span>
											<span class="label label-default" style="border-radius: 0 .25em .25em 0;">
												<span id="user_content_username"></span>
											</span>
										</span>
									</div>
									<div class="col-xs-3">
										<span id="user_memberships" class="pull-right">
										</span>
									</div>
								</div>
							</h3>

							<hr/>

							<h4><span class="label label-default"><i class="fa fa-exclamation-triangle"></i> &nbsp;]] .. VyHub.lang.other.warnings .. [[</span></h3>

							<div class="row perm-warning_edit">
								<div class="col-xs-10">
									<input id="user_warn" type="text" class="form-control vh-input" onclick="$('#user_warn').val('');" placeholder="]] .. VyHub.lang.other.reason .. [[" />
								</div>
								<div class="col-xs-2" style="padding-left: 0;">
									<button style="height: 30px;" onclick="create_warning()" class="btn btn-warning btn-xs btn-block"><i class="fa fa-exclamation-triangle"></i> &nbsp; ]] .. VyHub.lang.dashboard.action_warn .. [[</button>
								</div>
							</div>

							<br/>

							<table class="table table-condensed table-hover">
								<tr>
									<th width="10px"></th>
									<th>]] .. VyHub.lang.other.reason .. [[</th>
									<th>]] .. VyHub.lang.other.admin .. [[</th>
									<th>]] .. VyHub.lang.other.date .. [[</th>
									<th class="text-right">]] .. VyHub.lang.other.actions .. [[</th>
								</tr>

								<tbody id="user_content_warnings">
								</tbody>
							</table>

							<div>
								<span class="label label-success"><i class="fa fa-check"></i>&nbsp; ]] .. VyHub.lang.other.active .. [[</span>
								<span class="label label-warning"><i class="fa fa-hourglass"></i>&nbsp; ]] .. VyHub.lang.other.inactive .. [[</span>
								<span class="label label-default"><i class="fa fa-times"></i>&nbsp; ]] .. VyHub.lang.other.disabled .. [[</span>
							</div>

							<hr />
							
							<h4><span class="label label-default"><i class="fa fa-gavel"></i> &nbsp;]] .. VyHub.lang.other.bans .. [[</span></h3>

							<div class="row perm-ban_edit">
								<div class="col-xs-8">
									<input id="user_ban_reason" type="text" class="form-control vh-input" onclick="$('#user_ban_reason').val('');" placeholder="]] .. VyHub.lang.other.reason .. [[" />
								</div>
								<div class="col-xs-2" style="padding-left: 0;">
									<input id="user_ban_minutes" type="text" class="form-control vh-input" onclick="$('#user_ban_minutes').val('');" placeholder="]] .. VyHub.lang.other.minutes .. [[" />
								</div>
								<div class="col-xs-2" style="padding-left: 0;">
									<button style="height: 30px;" onclick="create_ban()" class="btn btn-danger btn-xs btn-block"><i class="fa fa-gavel"></i> &nbsp; ]] .. VyHub.lang.dashboard.action_ban .. [[</button>
								</div>
							</div>

							<br/>

							<table class="table table-condensed table-hover">
								<tr>
									<th width="10px"></th>
									<th>]] .. VyHub.lang.other.reason .. [[</th>
									<th>]] .. VyHub.lang.other.admin .. [[</th>
									<th>]] .. VyHub.lang.other.date .. [[</th>
									<th>]] .. VyHub.lang.other.minutes .. [[</th>
									<th class="text-right">]] .. VyHub.lang.other.actions .. [[</th>
								</tr>

								<tbody id="user_content_bans">
								</tbody>
							</table>

							<div>
								<span class="label label-success"><i class="fa fa-check"></i>&nbsp; ]] .. VyHub.lang.other.active .. [[</span>
								<span class="label label-info"><i class="fa fa-globe"></i>&nbsp; ]] .. VyHub.lang.other.active_global .. [[</span>
								<span class="label label-warning"><i class="fa fa-times"></i>&nbsp; ]] .. VyHub.lang.other.unbanned .. [[</span>
								<span class="label label-danger"><i class="fa fa-hourglass"></i>&nbsp; ]] .. VyHub.lang.other.inactive .. [[</span>
							</div>
						</div>
					</div>
				</div>
			</body>

			<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/2.2.4/jquery.min.js"></script>
			<script src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.30.1/moment.min.js"></script>
			<script>
				var perms = null;
				var users = [];
				var users_by_id = {};
				var current_user = null;
				var local_steamid64 = null;

				function escape(str) {
					return $("<div>").text(str).html();
				}

				function format_date(iso_str) {
					return moment(iso_str).format('YYYY-MM-DD HH:mm');
				}

				function load_data(new_data) {
					users = new_data;
					users_by_id = {};
					
					new_data.forEach(function(user) {
						users_by_id[user.id] = user;
					});

					generate_user_list() 
				}

				function load_perms(new_perms) {
					perms = new_perms;
				}
				
				function enforce_perms() {
					if (perms == null) { return; }

					Object.keys(perms).forEach(function(perm) {
						var has_perm = perms[perm];

						if (has_perm) {
							$('.perm-' + perm).show();
						} else {
							$('.perm-' + perm).hide();
						}
					});
				}

				function generate_user_list() {
					$('#user_list').html('');

					var filter = null;

					if ($('#user_search').val()) {
						filter = $('#user_search').val().toLowerCase();
					}

					var ids = [];

					var only_local_user = perms == null || (!perms.warning_show && !perms.ban_show);

					users.forEach(function(user) {
						var activity = user.activities[0];

						if (activity == null) { return; }
						if (only_local_user && user.identifier !== local_steamid64) { return; }

						if (filter != null) {
							if (activity.extra.Nickname.toLowerCase().indexOf(filter) == -1 && user.username.toLowerCase().indexOf(filter) == -1) {
								return;
							}
						}

						var color = 'white';
						if (user.memberships.length > 0) {
							color = user.memberships[0].group.color;
						}

						var warn_badge_color = ((user.warnings.length == 0) ? '#444' : "#f0ad4e");
						var ban_badge_color = ((user.bans.length == 0) ? '#444' : "#d9534f");

						$('#user_list').append(' \
						<li class="user-tab" id="user_tab_' + user.id + '" onclick="generate_user_overview(\'' + user.id + '\')" style="cursor:pointer; color: ' + color + ';"> \
							' + escape(activity.extra.Nickname) + ' \
							<span class="badge pull-right" style="background-color: ' + ban_badge_color + ';">' + user.bans.length + ' <i class="fa fa-gavel"></i></span> \
							<span class="badge pull-right" style="background-color: ' + warn_badge_color + '; margin-left: 3px; margin-right: 3px;">' + user.warnings.length + ' <i class="fa fa-exclamation-triangle"></i></span> \
						</li> \
						');

						ids.push(user.id);
					});

					if (ids.length == 1) {
						generate_user_overview(ids[0]);
					} else if (ids.length == 0) {
						$('#user_content_empty').show();
						$('#user_content').hide();
					}
				}

				function generate_user_overview(user_id) {
					current_user = null;

					$('#user_content_empty').hide();
					$('#user_content').hide();

					var user = users_by_id[user_id];
					if (user == null) {	return; }

					var activity = user.activities[0];
					if (activity == null) { return; }

					current_user = user;

					$('#user_content_name').text(activity.extra.Nickname);
					$('#user_content_username').text(user.username);

					if (activity.extra.Nickname === user.username) {
						$('#user_content_username').hide();
					} else {
						$('#user_content_username').show();
					}

					$('.user-tab').removeClass("active");
					$('#user_tab_' + user_id).addClass("active");

					$('#user_content_warnings').html('');
					user.warnings.forEach(function(warning) {
						var row_class = "success";

						if (warning.disabled) {
							row_class = "active";
						} else if (!warning.active) {
							row_class = "warning";
						}

						$('#user_content_warnings').append(' \
							<tr> \
								<td class="' + row_class + '"></td> \
								<td>' + escape(warning.reason) + '</td> \
								<td>' + escape(warning.creator.username) + '</td> \
								<td>' + format_date(warning.created_on) + '</td> \
								<td class="text-right"> \
									<button class="btn btn-default btn-xs perm-warning_edit" onclick="vyhub.warning_toggle(\'' + warning.id + '\')"><i class="fa fa-play"></i><i class="fa fa-pause"></i></button> \
									<button class="btn btn-default btn-xs perm-warning_delete" onclick="vyhub.warning_delete(\'' + warning.id + '\')"><i class="fa fa-trash"></i></button> \
								</td> \
							</tr> \
						');
					});

					$('#user_content_bans').html('');
					user.bans.forEach(function(ban) {
						var minutes = '∞';

						if (ban.length != null) {
							minutes = Math.round(ban.length/60);
						}

						var row_class = "success";

						if (ban.status == "UNBANNED") {
							row_class = "warning";
						} else if (!ban.active) {
							row_class = "danger";
						} else if (ban.serverbundle == null) {
							row_class = "info";
						}

						var actions = "";

						if (ban.status == "ACTIVE") {
							actions += '<button class="btn btn-default btn-xs perm-ban_edit" onclick="vyhub.ban_set_status(\'' + ban.id + '\', \'UNBANNED\')"><i class="fa fa-check"></i> &nbsp;]] .. VyHub.lang.other.unban .. [[</button>';
						} else if (ban.status == "UNBANNED") {
							actions += '<button class="btn btn-default btn-xs perm-ban_edit" onclick="vyhub.ban_set_status(\'' + ban.id + '\', \'ACTIVE\')"><i class="fa fa-gavel"></i> &nbsp;]] .. VyHub.lang.other.reban .. [[</button>';
						}

						$('#user_content_bans').append(' \
							<tr> \
								<td class="' + row_class + '"></td> \
								<td>' + escape(ban.reason) + '</td> \
								<td>' + escape(ban.creator.username) + '</td> \
								<td>' + format_date(ban.created_on) + '</td> \
								<td>' + minutes + '</td> \
								<td class="text-right">' + actions + '</td> \
							</tr> \
						');
					});

					$('#user_memberships').html('');

					user.memberships.forEach(function(membership) {
						$('#user_memberships').append('<span class="label label-default" style="background-color: ' + membership.group.color + ';">' + membership.group.name + '</span>');
					});

					$('#user_content').show();

					enforce_perms();
				}

				function reload_current_user() {
					if (current_user != null) {
						generate_user_overview(current_user.id);
					}
				}

				function create_warning() {
					if (current_user == null) {
						return;
					}

					var reason = $('#user_warn').val();

					vyhub.warning_create(current_user.identifier, reason);

					$('#user_warn').val('');
				}

				function create_ban() {
					if (current_user == null) {
						return;
					}

					var reason = $('#user_ban_reason').val();
					var minutes = $('#user_ban_minutes').val();

					vyhub.ban_create(current_user.identifier, minutes, reason);

					$('#user_ban_reason').val('');
					$('#user_ban_minutes').val('');
				}
			</script>
		</html>
	]]
end


function VyHub.Dashboard:load_users(users_json) 
	VyHub.Dashboard.ui_html:RunJavascript("load_data(" .. users_json .. ");")
	VyHub.Dashboard.ui_html:RunJavascript("reload_current_user();")
end

function VyHub.Dashboard:load_perms(perms_json) 
	VyHub.Dashboard.ui_html:RunJavascript("load_perms(" .. perms_json .. ");")
end

concommand.Add("vh_dashboard", function ()
	if VyHub.Dashboard.ui == nil or not VyHub.Dashboard.ui:IsValid() then
		VyHub.Dashboard:create_ui()
		VyHub.Dashboard.ui:Show()
		VyHub.Dashboard.ui:MakePopup()
	else
		-- VyHub.Dashboard:create_ui()

--		if VyHub.Dashboard.ui != nil and VyHub.Dashboard.ui:IsValid() and VyHub.Dashboard.ui:IsVisible() then
--			VyHub.Dashboard.ui:Hide()
--		else
			VyHub.Dashboard.ui:Show()
			VyHub.Dashboard.ui:MakePopup()
--		end
	end

	net.Start("vyhub_dashboard")
	net.SendToServer()
end)


net.Receive("vyhub_dashboard", function()
	local data_length = net.ReadUInt(16)
	local data_raw = net.ReadData(data_length)
	local perms_json = net.ReadString()
	local users_json = util.Decompress(data_raw)

	timer.Create("vyhub_dashboard_html_ready", 0.3, 20, function ()
		if not VyHub.Dashboard.html_ready then
			MsgN("VyHub Dashboard: Waiting for HTML to load.")
			return
		end

		timer.Remove("vyhub_dashboard_html_ready")

		VyHub.Dashboard:load_perms(perms_json)
		VyHub.Dashboard:load_users(users_json)
	end)
end)


net.Receive("vyhub_dashboard_reload", function()
	if VyHub.Dashboard.ui and VyHub.Dashboard.ui:IsVisible() then
		MsgN("Reloading dashboard data, because server told us.")
		net.Start("vyhub_dashboard")
		net.SendToServer()
	end
end)

hook.Add("vyhub_lang_loaded", "vyhub_dashboard_vyhub_lang_loaded", function ()
	VyHub.Dashboard:load_html()
end)

if VyHub.Dashboard.html_generated then
	VyHub.Dashboard:load_html()
end

