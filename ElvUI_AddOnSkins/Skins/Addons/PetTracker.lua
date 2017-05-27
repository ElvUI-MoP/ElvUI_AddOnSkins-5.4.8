local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if(not E.private.addOnSkins.PetTracker) then return end

	E:Delay(1, function()
		PetTrackerProgressBar1.Overlay:StripTextures()
		PetTrackerProgressBar1.Overlay:CreateBackdrop()
		PetTrackerProgressBar1.Overlay.backdrop:SetBackdropColor(0, 0, 0, 0)

		for i = 1, PetTracker.MaxQuality do
			PetTrackerProgressBar1[i]:SetStatusBarTexture(E["media"].normTex)
		end
	end)

	S:HandleEditBox(PetTrackerMapFilter)
	PetTrackerMapFilterSuggestions:SetTemplate("Transparent")

	for i = 1, PetTrackerMapFilterSuggestions:GetNumChildren() do
		local Button = select(i, PetTrackerMapFilterSuggestions:GetChildren())
		Button:SetFrameLevel(PetTrackerMapFilterSuggestions:GetFrameLevel() + 1)
	end

	WorldMapShowDropDownButton:HookScript("OnClick", function()
		SushiDropdownFrame1:ClearAllPoints()
		SushiDropdownFrame1:Point("BOTTOMRIGHT", WorldMapShowDropDownButton, "TOPRIGHT", 0, 4)

		if SushiDropdownFrame1.IsDone then return end
		for i = 1, SushiDropdownFrame1:GetNumChildren() do
			local Region = select(i, SushiDropdownFrame1:GetChildren())
			if Region:IsObjectType("Frame") then
				Region:SetBackdrop(nil)
				Region.SetBackdrop = E.noop
				SushiDropdownFrame1:SetTemplate("Transparent")
				SushiDropdownFrame1.IsDone = true
			end
		end
	end)

	for i = 1, 2 do
		local MapTip = _G["PetTrackerMapTip"..i]
		if MapTip then
			MapTip:StripTextures()
			MapTip:SetTemplate("Transparent")
			MapTip:HookScript("OnUpdate", function(self)
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

S:AddCallbackForAddon("PetTracker", "PetTracker", LoadSkin)

local function LoadSkin2()
	if(not E.private.addOnSkins.PetTracker) then return end

	PetTrackerSwap:HookScript("OnUpdate", function(self)
		if not self.IsSkinned then
			self:StripTextures()
			self:SetTemplate("Transparent")
			S:HandleCloseButton(PetTrackerSwapCloseButton)
			self.IsSkinned = true
		end
		PetTrackerSwapInset:StripTextures()

		for i = 1, self:GetNumChildren() do
			local Region = select(i, self:GetChildren())
			if Region and Region:IsObjectType("Frame") and not Region.IsSkinned then
				local a, b, c, d, e = Region:GetPoint()
				if a == "TOP" and c == "TOP" and d == 0 and e == 2 then
					Region:Kill()
					Region.IsSkinned = true
				end
			end
		end

		for i = 1, 6 do
			local Slot = _G["PetTrackerBattleSlot"..i]
			if not Slot.IsSkinned then
				Slot:SetTemplate("Transparent")
				Slot:CreateBackdrop()
				Slot.backdrop:SetOutside(Slot.Icon)
				Slot.backdrop:SetFrameLevel(Slot.backdrop:GetFrameLevel() + 2)

				Slot.Icon:SetTexCoord(unpack(E.TexCoords))
				Slot.Icon:SetParent(Slot.backdrop)

				Slot.Level:FontTemplate(nil, 12, "OUTLINE")
				Slot.Level:SetTextColor(1, 1, 1)
				Slot.Level:SetParent(Slot.backdrop)
				Slot.Bg:Hide()
				Slot.IconBorder:Hide()
				Slot.Quality:Hide()
				Slot.LevelBG:Hide()

				Slot.Type:Size(70, 40)
				Slot.Type.Icon:SetTexCoord(0.200, 0.710, 0.746, 0.917)

				Slot.Highlight:StripTextures()
				Slot.Highlight:HookScript("OnShow", function() Slot:SetBackdropBorderColor(1, 1, 0) end)
				Slot.Highlight:HookScript("OnHide", function() Slot:SetBackdropBorderColor(unpack(E["media"].bordercolor)) end)

				Slot.Health:StripTextures()
				Slot.Health:CreateBackdrop()
				Slot.Health:SetStatusBarTexture(E["media"].normTex)

				Slot.Xp:StripTextures()
				Slot.Xp:CreateBackdrop()
				Slot.Xp:SetStatusBarTexture(E["media"].normTex)

				Slot.IsSkinned = true
			end
		end

		for i = 1, 45 do
			local Ability = _G["PetTrackerAbilityButton"..i]
			if Ability and not Ability.IsSkinned then
				for i = 1, Ability:GetNumRegions() do
					local Region = select(i, Ability:GetRegions())
					if Region and Region:IsObjectType("Texture") then
						if Region:GetTexture() == "Interface\\Spellbook\\Spellbook-Parts" then
							Region:SetTexture(nil)
						end
					end
				end
				Ability:StyleButton()
				Ability.Icon:SetTexCoord(unpack(E.TexCoords))

				Ability.IsSkinned = true
			end
		end
	end)
end

S:AddCallbackForAddon("PetTracker_Switcher", "PetTracker_Switcher", LoadSkin2)

local function LoadSkin3()
	if(not E.private.addOnSkins.PetTracker) then return end

	S:HandleCheckBox(PetTracker_JournalTrackToggle)
	S:HandleTab(PetJournalParentTab3)

	PetTrackerTamerJournal:HookScript("OnShow", function(self)
		if not self.IsSkinned then
			PetTrackerTamerJournalCard:StripTextures()
			PetTrackerTamerJournalCard:SetTemplate("Transparent")
			PetTrackerTamerJournalCard.quest.ring:Kill()
			PetTrackerTamerJournalCard.quest.icon:SetTexCoord(unpack(E.TexCoords))

			PetTrackerTamerJournal.Count:StripTextures()
			PetTrackerTamerJournal.Count:SetTemplate()
			PetTrackerTamerJournal.ListInset:StripTextures()

			PetTrackerTamerJournal.Team:StripTextures()
			PetTrackerTamerJournal.Team.Border:StripTextures()
			PetTrackerTamerJournal.Team:DisableDrawLayer("BORDER")

			PetTrackerTamerJournal.Team.Border.Text:ClearAllPoints()
			PetTrackerTamerJournal.Team.Border.Text:Point("TOP", PetTrackerJournalSlot1, "TOP", 0, 32)

			PetTrackerTamerJournalMapBorder:Kill()
			PetTrackerTamerJournalMap:CreateBackdrop()

			S:HandleEditBox(PetTrackerTamerJournalSearchBox)
			S:HandleScrollBar(PetTrackerTamerJournalListScrollBar)

			PetTrackerTamerJournal.History:StripTextures()
			S:HandleButton(PetTrackerTamerJournal.History.LoadButton)

			for i = 1, 4 do
				if _G["PetTrackerTamerJournalCardLoot"..i] then
					S:HandleItemButton(_G["PetTrackerTamerJournalCardLoot"..i])
				end
			end

			for i = 1, 11 do
				local button = _G["PetTrackerTamerJournalListButton"..i]
				if button then
					S:HandleItemButton(button)
					button:StyleButton()
					button.model:SetParent(button.backdrop)
					button.model.quality:Hide()

					button.icon:Size(40)
					button.model:Point("TOPLEFT", button.backdrop, 2, -2)
					button.model:Point("BOTTOMRIGHT", button.backdrop, -2, 2)

					hooksecurefunc(PetTrackerTamerJournalList, "update", function(...) button.backdrop:SetBackdropBorderColor(button.model.quality:GetVertexColor()) end)
					hooksecurefunc(PetTrackerTamerJournalList, "update", function(...) button.name:SetTextColor(button.model.quality:GetVertexColor()) end)
					button.model.levelRing:SetAlpha(0)
				end
			end

			self.IsSkinned = true

			for i = 1, 3 do
				local Slot = _G["PetTrackerJournalSlot"..i]
				if Slot then
					Slot:SetTemplate("Transparent")

					Slot:CreateBackdrop()
					Slot.backdrop:SetOutside(Slot.Icon)
					Slot.backdrop:SetFrameLevel(Slot.backdrop:GetFrameLevel() + 2)
					hooksecurefunc(Slot.Quality, "SetVertexColor", function(_, r, g, b)
						Slot.backdrop:SetBackdropBorderColor(r, g, b)
					end)

 					Slot.Icon:SetTexCoord(unpack(E.TexCoords))
					Slot.Icon:SetParent(Slot.backdrop)

					Slot.Level:FontTemplate(nil, 12, "OUTLINE")
					Slot.Level:SetTextColor(1, 1, 1)
					Slot.Level:SetParent(Slot.backdrop)

					Slot.Bg:Hide()
					Slot.Quality:Hide()
					Slot.Hover:Kill()
					Slot.IconBorder:Hide()
					Slot.LevelBG:Hide()

					Slot.Type:Size(70, 40)
					Slot.Type.Icon:SetTexCoord(0.200, 0.710, 0.746, 0.917)
					Slot.IsSkinned = true

					local Tab = PetTrackerTamerJournal["Tab"..i]
					if Tab then
						Tab:SetTemplate("Transparent")
						Tab.TabBg:Kill()
						Tab.Icon:SetTexCoord(unpack(E.TexCoords))
						Tab.Icon:SetInside()
						Tab.Highlight:SetTexture(1, 1, 1, 0.30)
						Tab.Highlight:SetAllPoints(Tab.Icon)
					end
				end

				for i = 1, 15 do
					local Ability = _G["PetTrackerAbilityButton"..i]
					if Ability then
						for i = 1, Ability:GetNumRegions() do
							local Region = select(i, Ability:GetRegions())
							if Region and Region:IsObjectType("Texture") then
								if Region:GetTexture() == "Interface\\Spellbook\\Spellbook-Parts" then
									Region:SetTexture(nil)
								end
							end
						end

						Ability:StyleButton()
						Ability.Icon:SetTexCoord(unpack(E.TexCoords))
					end
				end

				for i = 1, 9 do
					local Record = _G["PetTrackerRecord"..i]
					if Record then
						Record:StripTextures()
						S:HandleButton(Record)
					end
				end
			end
		end
	end)
end

S:AddCallbackForAddon("PetTracker_Journal", "PetTracker_Journal", LoadSkin3)