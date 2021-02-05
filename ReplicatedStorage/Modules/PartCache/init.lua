--!strict

local table = require(script:WaitForChild("Table"))

local PartCacheStatic = {}
PartCacheStatic.__index = PartCacheStatic
PartCacheStatic.__type = "PartCache"

export type PartCache = {
	Open: {[number]: BasePart},
	InUse: {[number]: BasePart},
	CurrentCacheParent: Instance,
	Template: BasePart,
	ExpansionSize: number
}

local CF_REALLY_FAR_AWAY = CFrame.new(0, 10e8, 0)
local ERR_NOT_INSTANCE = "Cannot statically invoke method '%s' - It is an instance method. Call it on an instance of this class created via %s"
local ERR_INVALID_TYPE = "Invalid type for parameter '%s' (Expected %s, got %s)"

local function assertwarn(requirement: boolean, messageIfNotMet: string)
	if requirement == false then
		warn(messageIfNotMet)
	end
end

local function MakeFromTemplate(template: BasePart, currentCacheParent: Instance): BasePart
	local part: BasePart = template:Clone()
	
	part.CFrame = CF_REALLY_FAR_AWAY
	part.Anchored = true
	part.Parent = currentCacheParent
	return part
end

function PartCacheStatic.new(template: BasePart, numPrecreatedParts: number?, currentCacheParent: Instance?): PartCache
	local newNumPrecreatedParts: number = numPrecreatedParts or 5
	local newCurrentCacheParent: Instance = currentCacheParent or workspace.PartCache
	
	assert(numPrecreatedParts > 0, "PrecreatedParts can not be negative!")
	assertwarn(numPrecreatedParts ~= 0, "PrecreatedParts is 0! This may have adverse effects when initially using the cache.")
	assertwarn(template.Archivable, "The template's Archivable property has been set to false, which prevents it from being cloned. It will temporarily be set to true.")
	
	local oldArchivable = template.Archivable
	template.Archivable = true
	local newTemplate: BasePart = template:Clone()
	
	template.Archivable = oldArchivable
	template = newTemplate
	
	local object: PartCache = {
		Open = {},
		InUse = {},
		CurrentCacheParent = newCurrentCacheParent,
		Template = template,
		ExpansionSize = 10
	}
	setmetatable(object, PartCacheStatic)
	
	for _ = 1, newNumPrecreatedParts do
		table.insert(object.Open, MakeFromTemplate(template, object.CurrentCacheParent))
	end
	object.Template.Parent = nil
	
	return object
end

function PartCacheStatic:GetPart(): BasePart
	assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("GetPart", "PartCache.new"))
	
	if #self.Open == 0 then
		warn("No parts available in the cache! Creating [" .. self.ExpansionSize .. "] new part instance(s) - this amount can be edited by changing the ExpansionSize property of the PartCache instance... (This cache now contains a grand total of " .. tostring(#self.Open + #self.InUse + self.ExpansionSize) .. " parts.)")
		for i = 1, self.ExpansionSize, 1 do
			table.insert(self.Open, MakeFromTemplate(self.Template, self.CurrentCacheParent))
		end
	end
	local part = self.Open[#self.Open]
	self.Open[#self.Open] = nil
	table.insert(self.InUse, part)
	return part
end

function PartCacheStatic:ReturnPart(part: BasePart)
	assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("ReturnPart", "PartCache.new"))
	
	local index = table.indexOf(self.InUse, part)
	if index ~= nil then
		table.remove(self.InUse, index)
		table.insert(self.Open, part)
		part.CFrame = CF_REALLY_FAR_AWAY
		part.Anchored = true
	else
		error("Attempted to return part \"" .. part.Name .. "\" (" .. part:GetFullName() .. ") to the cache, but it's not in-use! Did you call this on the wrong part?")
	end
end

function PartCacheStatic:SetCacheParent(newParent: Instance)
	assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("SetCacheParent", "PartCache.new"))
	assert(newParent:IsDescendantOf(workspace) or newParent == workspace, "Cache parent is not a descendant of Workspace! Parts should be kept where they will remain in the visible world.")
	
	self.CurrentCacheParent = newParent
	for i = 1, #self.Open do
		self.Open[i].Parent = newParent
	end
	for i = 1, #self.InUse do
		self.InUse[i].Parent = newParent
	end
end

function PartCacheStatic:Expand(numParts: number): ()
	assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("Expand", "PartCache.new"))
	if numParts == nil then
		numParts = self.ExpansionSize
	end
	
	for i = 1, numParts do
		table.insert(self.Open, MakeFromTemplate(self.Template, self.CurrentCacheParent))
	end
end

function PartCacheStatic:Dispose()
	assert(getmetatable(self) == PartCacheStatic, ERR_NOT_INSTANCE:format("Dispose", "PartCache.new"))
	for i = 1, #self.Open do
		self.Open[i]:Destroy()
	end
	for i = 1, #self.InUse do
		self.InUse[i]:Destroy()
	end
	self.Template:Destroy()
	self.Open = {}
	self.InUse = {}
	self.CurrentCacheParent = nil
	
	self.GetPart = nil
	self.ReturnPart = nil
	self.SetCacheParent = nil
	self.Expand = nil
	self.Dispose = nil
end

return PartCacheStatic