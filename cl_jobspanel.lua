net.Receive("postapo_jobs_open", function(len)
	local ply = LocalPlayer()

	local actual = 1
	local jobs_numbers = table.getn(RPExtraTeams)
	local desctxt = ""


	print("[PostApoRP Jobs System] Script ON")
	print("[PostApoRP Jobs System] Nombres de JOBS : " .. jobs_numbers)

	surface.CreateFont( "petitle", {
		font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 15,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "pe", {
		font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 50,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )

	surface.CreateFont( "pedesc", {
		font = "Roboto", -- Use the font-name which is shown to you by your operating system Font Viewer, not the file name
		extended = false,
		size = 25,
		weight = 500,
		blursize = 0,
		scanlines = 0,
		antialias = true,
		underline = false,
		italic = false,
		strikeout = false,
		symbol = false,
		rotary = false,
		shadow = false,
		additive = false,
		outline = false,
	} )


	local frame = vgui.Create("DFrame")

	frame:SetPos(ScrW()/2 - 175, ScrH()/2 - 250)
	frame:SetTitle('')
	frame:MakePopup()
	frame:SetSize(350, 550)

	function frame:Paint(w,h)
		draw.RoundedBox(5, 0, 0, w, h, Color(22,22,22))
		draw.RoundedBox(0, 0, 0, w, 25, Color(255,185,0))
		draw.SimpleText("Pôle-Emplois","petitle" ,5,5, Color( 22,22,22), TEXT_ALIGN_LEFT)
		draw.SimpleText(actual.."/"..jobs_numbers,"petitle" ,330,30, Color( 255,255,255), TEXT_ALIGN_CENTER)
		draw.SimpleText(RPExtraTeams[actual].name,"pe" ,175,25, Color( 255,255,255), TEXT_ALIGN_CENTER)
	end

	local model = vgui.Create("DModelPanel", frame)
	--model:SetPos(45, 50)
	--model:Dock(FILL)
	model:SetPos(0, 20)
	model:SetSize(350, 500)
	model:SetModel(table.Random(RPExtraTeams[1].model))
	function model:LayoutEntity(ent) return end
	local eyepos = model.Entity:GetBonePosition( model.Entity:LookupBone( "ValveBiped.Bip01_Head1" ) )
	eyepos:Add( Vector( 0, 0, 2 ) )
	model:SetLookAt( eyepos )
	model:SetCamPos( eyepos-Vector( -20, 0, 0 ) )
	model.Entity:SetEyeTarget( eyepos-Vector( -20, -0, 0 ) )
	print(model:GetSize())

	local frame2 = vgui.Create("DFrame", frame)
	frame2:SetDraggable(false)
	frame2:SetPos(0, 400)
	frame2:SetSize(350, 150)
	frame2:SetTitle('')
	frame2:ShowCloseButton( false )

	function frame2:Paint(w,h)
		draw.RoundedBox(5, 0, 0, w, h, Color(22,22,22))
		draw.SimpleText("Description :","pedesc" ,5,5, Color( 255,255,255), TEXT_ALIGN_LEFT)

	end

	local desc = vgui.Create("DTextEntry", frame2)
	desctxt = RPExtraTeams[actual].description
	desc:SetPos(5,30)
	desc:SetSize(340,65)
	desc:SetMultiline(true)
	desc:SetEnabled(false)
	desc:SetVerticalScrollbarEnabled( true )
	desc:SetText(desctxt)


	local prev_button = vgui.Create("DButton", frame)
	prev_button:SetSize(50, 50)
	prev_button:SetPos(5,200)
	prev_button:SetText("<")
	prev_button.DoClick = function()
		if actual == 1 then
			actual = jobs_numbers
			local is_table = istable(RPExtraTeams[actual].model)
			desctxt = RPExtraTeams[actual].description
			print(desctxt)
			desc:SetText(desctxt)	
			if is_table == true then 
	            local random_model = table.Random(RPExtraTeams[actual].model)
	            model:SetModel(random_model)
	            print(random_model)
	        else
	            model:SetModel(RPExtraTeams[actual].model)
	        end
		else
			actual = actual - 1
			local is_table = istable(RPExtraTeams[actual].model)
			desctxt = RPExtraTeams[actual].description
			print(desctxt)
			desc:SetText(desctxt)	
			if is_table == true then 
	            local random_model = table.Random(RPExtraTeams[actual].model)
	            model:SetModel(random_model)
	            print(random_model)
	        else
	            model:SetModel(RPExtraTeams[actual].model)
	        end	
		end 	
	end


	local next_button = vgui.Create("DButton", frame)

	next_button:SetSize(50, 50)
	next_button:SetPos(295,200)
	next_button:SetText(">")
	next_button.DoClick = function()
		if actual == jobs_numbers then
			actual = 1
			local is_table = istable(RPExtraTeams[actual].model)
			desctxt = RPExtraTeams[actual].description
			print(desctxt)
			desc:SetText(desctxt)		
			if is_table == true then 
	            local random_model = table.Random(RPExtraTeams[actual].model)
	            model:SetModel(random_model)
	            
	        else
	            model:SetModel(RPExtraTeams[actual].model)
	        end
		else
			actual = actual + 1
			local is_table = istable(RPExtraTeams[actual].model)
			desctxt = RPExtraTeams[actual].description
			print(desctxt)
			desc:SetText(desctxt)
			--model:SetModel(RPExtraTeams[actual].model)
			if is_table == true then 
	            local random_model = table.Random(RPExtraTeams[actual].model)
	            model:SetModel(random_model)
	            print(random_model)
	        else
	            model:SetModel(RPExtraTeams[actual].model)
	        end	
		end 			


	end

	function job_func()
		if RPExtraTeams[actual].vote == true then
			ply:ConCommand( "say /vote" ..RPExtraTeams[actual].command)
			frame:Close()
		else
			RunConsoleCommand("darkrp", RPExtraTeams[actual].command)
			frame:Close()
		end
	end


	local join_btn = vgui.Create("DButton", frame2)
	join_btn:SetSize(340, 45)
	join_btn:SetPos(5,100)
	join_btn:SetText("Rejoindre ce métier.")

	join_btn.DoClick = job_func

end)