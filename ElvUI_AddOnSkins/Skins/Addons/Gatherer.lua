local E, L, V, P, G = unpack(ElvUI)
local S = E:GetModule("Skins")

local _G = _G
local pairs, select = pairs, select

local function LoadSkin()
	if not E.private.addOnSkins.Gatherer then return end

	-- Report Frame
	GathererReportFrame:StripTextures()
	GathererReportFrame:CreateBackdrop("Transparent")
	GathererReportFrame.backdrop:Point("TOPLEFT", 0, -28)
	GathererReportFrame:Height(562)

	GathererReportFrame.Drag:StripTextures()
	GathererReportFrame.Drag:SetTemplate(nil, true)
	GathererReportFrame.Drag:ClearAllPoints()
	GathererReportFrame.Drag:Point("TOPLEFT", GathererReportFrame, 0, -1)
	GathererReportFrame.Drag:Size(901, 26)

	GathererReportFrame.SearchBox:SetBackdrop(nil)
	S:HandleEditBox(GathererReportFrame.SearchBox)
	GathererReportFrame.SearchBox:Size(230, 20)
	GathererReportFrame.SearchBox:ClearAllPoints()
	GathererReportFrame.SearchBox:Point("TOPLEFT", GathererReportFrame, 8, -36)
	GathererReportFrame.SearchBox:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

	GathererReportFrame.Actions.SendEdit:StripTextures()
	S:HandleEditBox(GathererReportFrame.Actions.SendEdit)

	for i = 1, GathererReportFrame:GetNumChildren() do
		local child = select(i, GathererReportFrame:GetChildren())
		for j = 1, child:GetNumRegions() do
			local region = select(j, child:GetRegions())

			if region.IsObjectType and region:IsObjectType("Texture") then
				if region.GetTexture and region:GetTexture() == "Interface\\Buttons\\UI-CheckBox-Up" then
					S:HandleCheckBox(child)
				end
			end
		end
	end

	GathererReportFrame.Results:StripTextures()
	GathererReportFrame.Results:ClearAllPoints()
	GathererReportFrame.Results:Point("TOPLEFT", GathererReportFrame.SearchBox, "BOTTOMLEFT", 0, -25)
	GathererReportFrame.Results:Point("BOTTOMRIGHT", GathererReportFrame, "BOTTOMRIGHT", -150, 7)

	GathererReportFrame.Results:CreateBackdrop("Transparent")
	GathererReportFrame.Results.backdrop:Point("TOPLEFT", 6, 0)
	GathererReportFrame.Results.backdrop:Point("BOTTOMRIGHT", -26, 0)

	S:HandleScrollBar(GathererResultsScrollScrollBar)
	GathererResultsScrollScrollBar:ClearAllPoints()
	GathererResultsScrollScrollBar:Point("TOPRIGHT", GathererReportFrame.Results, -4, -18)
	GathererResultsScrollScrollBar:Point("BOTTOMRIGHT", GathererReportFrame.Results, 0, 18)

	for i = 1, 30 do
		local frame = GathererReportFrame.Results[i].Highlight

		local checked = frame:GetCheckedTexture()
		checked:SetTexture(E.Media.Textures.Highlight)
		checked:SetVertexColor(1, 0.80, 0.10, 0.35)

		local highlight = frame:GetHighlightTexture()
		highlight:SetTexture(E.Media.Textures.Highlight)
		highlight:SetVertexColor(1, 1, 1, 0.35)
	end

	local buttons = {
		GathererReportFrame.Done,
		GathererReportFrame.Config,
		GathererReportFrame.NodeSearch,
		GathererReportFrame.Actions.SelectAll,
		GathererReportFrame.Actions.SelectNone,
		GathererReportFrame.Actions.SelectClear,
		GathererReportFrame.Actions.SendSelected,
		GathererReportFrame.Actions.DeleteSelected
	}

	for _, frame in pairs(buttons) do
		S:HandleButton(frame)
		frame:Size(134, 20)
	end

	GathererReportFrame.Done:ClearAllPoints()
	GathererReportFrame.Done:Point("BOTTOMRIGHT", GathererReportFrame, -10, 7)

	GathererReportFrame.Config:ClearAllPoints()
	GathererReportFrame.Config:Point("BOTTOM", GathererReportFrame.Done, "TOP", 0, 4)

	GathererReportFrame.NodeSearch:ClearAllPoints()
	GathererReportFrame.NodeSearch:Point("BOTTOM", GathererReportFrame.Config, "TOP", 0, 4)

	GathererReportFrame.Actions.SelectAll:ClearAllPoints()
	GathererReportFrame.Actions.SelectAll:Point("TOPLEFT", GathererReportFrame.Actions)

	GathererReportFrame.Actions.SelectNone:ClearAllPoints()
	GathererReportFrame.Actions.SelectNone:ClearAllPoints()
	GathererReportFrame.Actions.SelectNone:Point("TOP", GathererReportFrame.Actions.SelectAll, "BOTTOM", 0, -4)

	GathererReportFrame.Actions.SelectClear:ClearAllPoints()
	GathererReportFrame.Actions.SelectClear:Point("TOP", GathererReportFrame.Actions.SelectNone, "BOTTOM", 0, -10)

	GathererReportFrame.Actions.SendEdit:ClearAllPoints()
	GathererReportFrame.Actions.SendEdit:Point("TOPLEFT", GathererReportFrame.Actions.SelectCount, "BOTTOMLEFT", 0, -10)
	GathererReportFrame.Actions.SendEdit:Size(132, 18)

	GathererReportFrame.Actions.SendSelected:ClearAllPoints()
	GathererReportFrame.Actions.SendSelected:Point("TOPLEFT", GathererReportFrame.Actions.SendEdit, "BOTTOMLEFT", 0, -10)
end

S:AddCallbackForAddon("Gatherer", "Gatherer", LoadSkin)