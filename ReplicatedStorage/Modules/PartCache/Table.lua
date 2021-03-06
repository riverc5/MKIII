--!nocheck

local RNG = Random.new()
local Table = {}

for index, value in pairs(table) do
	Table[index] = value
end

Table.contains = function (tbl, value)
	return Table.indexOf(tbl, value) ~= nil 
end

Table.indexOf = function (tbl, value)
	local fromFind = table.find(tbl, value)
	if fromFind then return fromFind end
	
	return Table.keyOf(tbl, value)
end

Table.keyOf = function (tbl, value)
	for index, obj in pairs(tbl) do
		if obj == value then
			return index
		end
	end
	return nil
end

Table.skip = function (tbl, n)
	return table.move(tbl, n+1, #tbl, 1, table.create(#tbl-n))
end

Table.take = function (tbl, n)
	return table.move(tbl, 1, n, 1, table.create(n))
end

Table.range = function (tbl, start, finish)
	return table.move(tbl, start, finish, 1, table.create(finish - start + 1))
end

Table.skipAndTake = function (tbl, skip, take)
	return table.move(tbl, skip + 1, skip + take, 1, table.create(take))
end

Table.random = function (tbl)
	return tbl[RNG:NextInteger(1, #tbl)]
end

Table.join = function (tbl0, tbl1)
	local nt = table.create(#tbl0 + #tbl1)
	local t2 = table.move(tbl0, 1, #tbl0, 1, nt)
	return table.move(tbl1, 1, #tbl1, #tbl0 + 1, nt)
end

Table.removeObject = function (tbl, obj)
	local index = Table.indexOf(tbl, obj)
	if index then
		table.remove(tbl, index)
	end
end

Table.expand = function (tbl, byAmount)
	if (byAmount < 0) then
		error("Cannot expand a table by a negative amount of objects.")
	end
	
	local newtbl = table.create(#tbl + byAmount)
	for i = 1, #tbl do
		newtbl[i] = tbl[i]
	end
	return newtbl
end

return Table