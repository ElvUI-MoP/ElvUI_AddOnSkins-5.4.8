local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local function LoadSkin()
	if(not E.private.addOnSkins.Clique) then return end

	CliqueDialog:StripTextures()
	CliqueDialog:SetTemplate("Transparent")

	CliqueConfig:StripTextures()
	CliqueConfig:SetTemplate("Transparent")

	CliqueClickGrabber:StripTextures()
	CliqueClickGrabber:SetTemplate("Transparent")

	CliqueConfigBindAlert:StripTextures()
	CliqueConfigBindAlert:SetTemplate("Transparent")

	for i = 1, 2 do
		_G["CliqueConfigPage"..i]:StripTextures()
		_G["CliqueConfigPage"..i]:SetTemplate("Transparent")
	end

	CliqueSpellTab:StyleButton(nil, true)
	CliqueSpellTab:SetTemplate("Default", true)
	CliqueSpellTab:GetNormalTexture():SetTexCoord(unpack(E.TexCoords))
	CliqueSpellTab:GetNormalTexture():SetInside()
	select(1, CliqueSpellTab:GetRegions()):Hide()

	S:HandleButton(CliqueConfigPage1ButtonSpell)
	S:HandleButton(CliqueConfigPage1ButtonOther)
	S:HandleButton(CliqueConfigPage1ButtonOptions)
	S:HandleButton(CliqueDialogButtonBinding)
	S:HandleButton(CliqueDialogButtonAccept)
	S:HandleButton(CliqueConfigPage2ButtonBinding)
	S:HandleButton(CliqueConfigPage2ButtonSave)
	S:HandleButton(CliqueConfigPage2ButtonCancel)

	CliqueConfigPage1:SetScript("OnShow", function()
		for i = 1, 12 do
			local Row = _G["CliqueRow"..i]
			local Icon = _G["CliqueRow"..i.."Icon"]
			local Bind = _G["CliqueRow"..i.."Bind"]

			if(Row) then
				Row:CreateBackdrop()
				Row.backdrop:SetOutside(Icon)

				Icon:SetTexCoord(unpack(E.TexCoords))
				Icon:SetParent(Row.backdrop)

				Row:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)

				Bind:ClearAllPoints()
				if(Row == CliqueRow1) then
					Bind:SetPoint("RIGHT", Row, 8, 0)
				else
					Bind:SetPoint("RIGHT", Row, -9, 0)
				end
			end
		end

		CliqueRow1:ClearAllPoints()
		CliqueRow1:SetPoint("TOPLEFT", 5, - (CliqueConfigPage1Column1:GetHeight() + 3))
	end)

	CliqueConfigPage1Column1:StripTextures()
	CliqueConfigPage1Column2:StripTextures()

	CliqueConfigPage1Column1:StyleButton()
	CliqueConfigPage1Column2:StyleButton()

	CliqueConfigPage1_VSlider:StripTextures(true)

	CliqueConfigInset:StripTextures()

	CliqueConfigBindAlertArrow:Kill()
	CliqueConfigBindAlert:ClearAllPoints()
	CliqueConfigBindAlert:Point("TOPLEFT", SpellBookFrame, "TOPLEFT", 0, 45)

	CliqueConfigPage1ButtonSpell:SetPoint("BOTTOMLEFT", CliqueConfig, "BOTTOMLEFT", 3, 2)
	CliqueConfigPage1ButtonOptions:SetPoint("BOTTOMRIGHT", CliqueConfig, "BOTTOMRIGHT", -5, 2)
	CliqueConfigPage2ButtonSave:SetPoint("BOTTOMLEFT", CliqueConfig,"BOTTOMLEFT", 3, 2)
	CliqueConfigPage2ButtonCancel:SetPoint("BOTTOMRIGHT", CliqueConfig, "BOTTOMRIGHT", -5, 2)

	S:HandleScrollBar(CliqueScrollFrameScrollBar)

	S:HandleCloseButton(CliqueConfigCloseButton)

	CliqueTabAlert:StripTextures()
	CliqueTabAlert:SetTemplate()

	S:HandleCloseButton(CliqueTabAlertClose)
end

S:AddCallbackForAddon("Clique", "Clique", LoadSkin)