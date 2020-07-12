local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local _G = _G
local select, unpack = select, unpack

local function LoadSkin()
	if not E.private.addOnSkins.PetTracker then return end

	E:Delay(1, function()
		PetTrackerProgressBar1.Overlay:StripTextures()
		PetTrackerProgressBar1.Overlay:CreateBackdrop()
		PetTrackerProgressBar1.Overlay.backdrop:SetBackdropColor(0, 0, 0, 0)

		for i = 1, PetTracker.MaxQuality do
			PetTrackerProgressBar1[i]:SetStatusBarTexture(E.media.normTex)
		end
	end)

	S:HandleEditBox(PetTrackerMapFilter)
	PetTrackerMapFilterSuggestions:SetTemplate("Transparent")

	for i = 1, PetTrackerMapFilterSuggestions:GetNumChildren() do
		local button = select(i, PetTrackerMapFilterSuggestions:GetChildren())

		button:SetFrameLevel(PetTrackerMapFilterSuggestions:GetFrameLevel() + 1)
	end

	WorldMapShowDropDownButton:HookScript("OnClick", function()
		SushiDropdownFrame1:ClearAllPoints()
		SushiDropdownFrame1:Point("BOTTOMRIGHT", WorldMapShowDropDownButton, "TOPRIGHT", 0, 4)

		if SushiDropdownFrame1.isSkinned then return end

		for i = 1, SushiDropdownFrame1:GetNumChildren() do
			local region = select(i, SushiDropdownFrame1:GetChildren())

			if region:IsObjectType("Frame") then
				region:SetBackdrop()
				region.SetBackdrop = E.noop

				SushiDropdownFrame1:SetTemplate("Transparent")
				SushiDropdownFrame1.isSkinned = true
			end
		end
	end)

	for i = 1, 2 do
		local mapTip = _G["PetTrackerMapTip"..i]

		if mapTip then
			mapTip:StripTextures()
			mapTip:SetTemplate("Transparent")

			mapTip:HookScript("OnUpdate", function(self)
				for i = 1, self:NumLines() do
					local Line = self:GetLine(i)
					local Texture, Text = strmatch(Line:GetText(), "^|T(.-)|t(.+)")

					if Texture and not strmatch(Texture, "PetIcon") then
						Texture = strsplit(":", Texture)
						self:GetLine(i):SetFormattedText("|T%s:20:20:0:0:64:64:4:60:4:60|t %s", Texture, Text)
					end
				end
			end)
		end
	end

	E:Delay(1, function()
		for i = 1, 6 do
			local button = _G["PetTrackerAbilityAction"..i]

			if button then
				button:StripTextures()
				button:CreateBackdrop()
				button.Icon:SetTexCoord(unpack(E.TexCoords))
			end
		end
	end)
end

local function LoadSkin2()
	if not E.private.addOnSkins.PetTracker then return end

	PetTrackerSwap:StripTextures()
	PetTrackerSwap:SetTemplate("Transparent")

	PetTrackerSwapInset:StripTextures()

	S:HandleCloseButton(PetTrackerSwapCloseButton)

	PetTrackerSwap:HookScript("OnShow", function(self)
		if not self.isSkinned then
			for i = 1, 6 do
				local slot = _G["PetTrackerBattleSlot"..i]

				slot:SetTemplate("Transparent")
				slot:CreateBackdrop()
				slot.backdrop:SetOutside(slot.Icon)
				slot.backdrop:SetFrameLevel(slot.backdrop:GetFrameLevel() + 2)

				slot:HookScript("OnEnter", function(self)
					self:SetBackdropBorderColor(unpack(E.media.rgbvaluecolor))
				end)
				slot:HookScript("OnLeave", function(self)
					self:SetBackdropBorderColor(unpack(E.media.bordercolor))
				end)

				hooksecurefunc(slot.Quality, "SetVertexColor", function(_, r, g, b)
					slot.backdrop:SetBackdropBorderColor(r, g, b)
				end)

				slot.Icon:SetTexCoord(unpack(E.TexCoords))
				slot.Icon:SetParent(slot.backdrop)

				slot.Level:FontTemplate(nil, 12, "OUTLINE")
				slot.Level:SetTextColor(1, 1, 1)
				slot.Level:SetParent(slot.backdrop)

				slot.Health:StripTextures()
				slot.Health:CreateBackdrop()
				slot.Health:SetStatusBarTexture(E.media.normTex)

				slot.Xp:StripTextures()
				slot.Xp:CreateBackdrop()
				slot.Xp:SetStatusBarTexture(E.media.normTex)

				slot.Type:Size(70, 40)
				slot.Type.Icon:SetTexCoord(0.200, 0.710, 0.746, 0.917)

				slot.IsEmpty:SetInside()

				slot.Highlight:StripTextures()
				slot.Bg:Hide()
				slot.Quality:Hide()
				slot.LevelBG:Hide()
				slot.IconBorder:Hide()
				slot.Hover:Kill()
				slot.Shadows:Hide()
			end

			for i = 1, self:GetNumChildren() do
				local region = select(i, self:GetChildren())

				if region and region:IsObjectType("Frame") then
					local a, _, c, d, e = region:GetPoint()

					if a == "TOP" and c == "TOP" and d == 0 and e == 2 then
						region:SetAlpha(0)
					end
				end
			end

			-- Abilities
			for i = 1, 36 do
				local button = _G["PetTrackerAbilityButton"..i]

				for j = 1, button:GetNumRegions() do
					local region = select(j, button:GetRegions())

					if region and region:IsObjectType("Texture") then
						if region:GetTexture() == "Interface\\Spellbook\\Spellbook-Parts" then
							region:SetTexture(nil)
						end
					end
				end

				button:CreateBackdrop()
				button:StyleButton()
				button.hover:SetInside(button.backdrop)
				button.pushed:SetInside(button.backdrop)

				button.Icon:SetTexCoord(unpack(E.TexCoords))
				button.Icon:SetInside(button.backdrop)

				button.Type:Hide()
			end

			self.isSkinned = true
		end
	end)
end

local function LoadSkin3()
	if not E.private.addOnSkins.PetTracker then return end

	PetTrackerTamerJournalCard:StripTextures()
	PetTrackerTamerJournalCard:CreateBackdrop("Transparent")
	PetTrackerTamerJournalCard.backdrop:Point("TOPLEFT", 3, -3)
	PetTrackerTamerJournalCard.backdrop:Point("BOTTOMRIGHT", -3, 0)

	PetTrackerTamerJournal.Count:StripTextures()
	PetTrackerTamerJournal.Count:SetTemplate("Transparent")
	PetTrackerTamerJournal.Count:Point("TOPLEFT", 4, -25)

	S:HandleCheckBox(PetTracker_JournalTrackToggle)
	S:HandleTab(PetJournalParentTab3)

	S:HandleEditBox(PetTrackerTamerJournalSearchBox)
	PetTrackerTamerJournalSearchBox:Width(256)
	PetTrackerTamerJournalSearchBox:Point("TOPLEFT", MountJournal.LeftInset, 1, -9)

	PetTrackerTamerJournalCard.quest.ring:Kill()
	PetTrackerTamerJournalCard.quest.icon:SetTexCoord(unpack(E.TexCoords))

	PetTrackerTamerJournal.Team:StripTextures()
	PetTrackerTamerJournal.Team.Border:StripTextures()
	PetTrackerTamerJournal.Team:DisableDrawLayer("BORDER")

	PetTrackerTamerJournal.Team.Border.Text:ClearAllPoints()
	PetTrackerTamerJournal.Team.Border.Text:Point("TOP", PetTrackerJournalSlot1, "TOP", 0, 32)

	PetTrackerTamerJournalMapBorder:Kill()
	PetTrackerTamerJournalMapShadow:Kill()

	PetTrackerTamerJournalMap:CreateBackdrop()

	S:HandleButton(PetTrackerTamerJournal.History.LoadButton)
	PetTrackerTamerJournal.History.LoadButton:Point("BOTTOMRIGHT", PetTrackerTamerJournal, -9, 4)

	-- Scroll Frame
	PetTrackerTamerJournal.ListInset:StripTextures()

	PetTrackerTamerJournalList:CreateBackdrop("Transparent")
	PetTrackerTamerJournalList.backdrop:Point("TOPLEFT", -3, 1)
	PetTrackerTamerJournalList.backdrop:Point("BOTTOMRIGHT", 0, -2)

	S:HandleScrollBar(PetTrackerTamerJournalListScrollBar)
	PetTrackerTamerJournalListScrollBar:ClearAllPoints()
	PetTrackerTamerJournalListScrollBar:Point("TOPRIGHT", PetTrackerTamerJournalList, 23, -15)
	PetTrackerTamerJournalListScrollBar:Point("BOTTOMRIGHT", PetTrackerTamerJournalList, 0, 14)

	PetTrackerTamerJournal.History:StripTextures()
	PetTrackerTamerJournal.History:CreateBackdrop("Transparent")
	PetTrackerTamerJournal.History.backdrop:Point("TOPLEFT", 2, -2)
	PetTrackerTamerJournal.History.backdrop:Point("BOTTOMRIGHT", -2, 2)

	-- Tabs
	for i = 1, 3 do
		local tab = PetTrackerTamerJournal["Tab"..i]

		if tab then
			tab:SetTemplate(nil, true)

			tab.Icon:SetTexCoord(unpack(E.TexCoords))
			tab.Icon:SetInside()

			tab.Highlight:SetTexture(1, 1, 1, 0.30)
			tab.Highlight:SetInside()

			tab.Hider:SetTexture(0, 0, 0, 0.8)
			tab.Hider:SetInside()

			tab.TabBg:Kill()

			tab:ClearAllPoints()
			if i == 3 then
				tab:Point("BOTTOM", PetTrackerTamerJournalCard, "TOPRIGHT", -20, 2)
			elseif i == 2 then
				tab:Point("RIGHT", PetTrackerTamerJournal["Tab3"], "LEFT", -5, 0)
			else
				tab:Point("RIGHT", PetTrackerTamerJournal["Tab2"], "LEFT", -5, 0)
			end
		end
	end

	PetTrackerTamerJournal:HookScript("OnShow", function(self)
		if self.isSkinned then return end

		-- Loot
		for i = 1, 4 do
			local button = _G["PetTrackerTamerJournalCardLoot"..i]

			if button then
				S:HandleItemButton(button)
				button.hover:SetAllPoints()
				button.pushed:SetAllPoints()
			end
		end

		-- Scroll Frame
		for i = 1, 12 do
			local button = _G["PetTrackerTamerJournalListButton"..i]

			if button then
				S:HandleItemButton(button)
				button.pushed:SetInside(button.backdrop)

				button.icon:Size(40)

				button.model:SetParent(button.backdrop)
				button.model:Point("TOPLEFT", button.backdrop, 2, -2)
				button.model:Point("BOTTOMRIGHT", button.backdrop, -2, 2)

				button.model.level:SetTextColor(1, 1, 1)
				button.model.level:FontTemplate(nil, 12, "OUTLINE")

				button.model.quality:Hide()
				button.model.levelRing:SetAlpha(0)

				S:HandleButtonHighlight(button)
				button.handledHighlight:SetInside()

				button.selectedTexture:SetTexture(E.Media.Textures.Highlight)
				button.selectedTexture:SetAlpha(0.35)
				button.selectedTexture:SetInside()
				button.selectedTexture:SetTexCoord(0, 1, 0, 1)

				hooksecurefunc(button.model.quality, "SetVertexColor", function(_, r, g, b)
					button.name:SetTextColor(r, g, b)
					button.backdrop:SetBackdropBorderColor(r, g, b)
					button.selectedTexture:SetVertexColor(r, g, b)
					button.handledHighlight:SetVertexColor(r, g, b)
				end)
			end
		end

		-- Pet Slots
		for i = 1, 3 do
			local slot = _G["PetTrackerJournalSlot"..i]

			if slot then
				slot:SetTemplate("Transparent")
				slot:Size(405, 106)
				slot:CreateBackdrop()
				slot.backdrop:SetOutside(slot.Icon)
				slot.backdrop:SetFrameLevel(slot.backdrop:GetFrameLevel() + 2)

				if i == 1 then
					slot:Point("TOP", PetTrackerTamerJournalTeam, 1, 3)
				elseif i == 2 then
					slot:Point("TOP", PetTrackerTamerJournalTeam, 1, -108)
				elseif i == 3 then
					slot:Point("TOP", PetTrackerTamerJournalTeam, 1, -219)
				end

 				slot.Icon:SetTexCoord(unpack(E.TexCoords))
				slot.Icon:SetParent(slot.backdrop)
				slot.Icon:Point("TOPLEFT", slot, 4, -4)

				slot.Level:FontTemplate(nil, 12, "OUTLINE")
				slot.Level:SetTextColor(1, 1, 1)
				slot.Level:SetParent(slot.backdrop)
				slot.Level:Point("BOTTOMRIGHT", 0, 2)

				slot.Type:StripTextures()
				slot.Type:Size(36)
				slot.Type.Icon:Size(36)
				slot.Type.Icon:ClearAllPoints()
				slot.Type.Icon:Point("BOTTOMLEFT", slot, 6, 12)

				slot.Model:Point("TOPRIGHT", -5, -5)

				slot.IsEmpty:SetInside()

				hooksecurefunc(slot.Quality, "SetVertexColor", function(_, r, g, b)
					slot.backdrop:SetBackdropBorderColor(r, g, b)
				end)

				slot.PowerIcon:Point("TOPLEFT", slot.Icon, "BOTTOMLEFT", 46, -7)

				slot.HealthIcon:ClearAllPoints()
				slot.HealthIcon:Point("TOPLEFT", slot.SpeedIcon, "BOTTOMLEFT", 0, -2)

				slot.Bg:Hide()
				slot.Quality:Hide()
				slot.Hover:Kill()
				slot.IconBorder:Hide()
				slot.LevelBG:Hide()
				slot.Shadows:Hide()
			end
		end

		-- Abilities
		for i = 1, 15 do
			local button = _G["PetTrackerAbilityButton"..i]

			if button then
				button:SetTemplate()
				button:StyleButton()

				button.Icon:SetTexCoord(unpack(E.TexCoords))
				button.Icon:SetInside()

				button.Type:Hide()

				if i == 1 or i == 7 or i == 13 then
					button:Point("CENTER", -45, -15)
				elseif i == 2 or i == 8 or i == 14 then
					button:Point("CENTER", -7, -15)
				elseif i == 3 or i == 9 or i == 15 then
					button:Point("CENTER", 30, -15)
				end

				for j = 1, button:GetNumRegions() do
					local region = select(j, button:GetRegions())

					if region and region:IsObjectType("Texture") then
						if region:GetTexture() == "Interface\\Spellbook\\Spellbook-Parts" then
							region:SetTexture()
						end
					end
				end
			end
		end

		-- History
		for i = 1, 9 do
			local record = _G["PetTrackerRecord"..i]

			if record then
				S:HandleButton(record, true)

				for j = 1, 3 do
					local button = record.Content["Pet"..j]
					local icon = button:GetNormalTexture()

					button:SetTemplate()
					button:CreateBackdrop()
					button.backdrop:SetOutside(button.Health)
					button:StyleButton(nil, true)
					button:Size(32)
					button:SetScale(1)
					button.SetScale = E.noop

					icon:SetTexCoord(unpack(E.TexCoords))
					icon:SetInside()

					button.Health:Point("BOTTOMLEFT", 1, 36)
					button.Health:Width(30)
					button.Health.SetWidth = E.noop
					button.Health:SetTexture(E.media.normTex)
					button.Health:SetVertexColor(0.8, 1, 0.2)

					button.Dead:SetTexture("Interface\\PetBattles\\DeadPetIcon")
					button.Dead:SetTexCoord(0, 1, 0, 1)
					button.Dead:SetInside()

					button.IconBorder:SetAlpha(0)
					button.HealthBorder:SetAlpha(0)
					button.HealthBg:SetAlpha(0)
				end
			end
		end

		self.isSkinned = true
	end)
end

S:AddCallbackForAddon("PetTracker", "PetTracker", LoadSkin)
S:AddCallbackForAddon("PetTracker_Switcher", "PetTracker_Switcher", LoadSkin2)
S:AddCallbackForAddon("PetTracker_Journal", "PetTracker_Journal", LoadSkin3)