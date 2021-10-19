--!strict

module_container = {}
algorithms = require(script.algorithms)

mainsorterclass = {}
mainsorterclass.__index = mainsorterclass

-- types
export type SortingParameterObject
export type SorterObject = {
	Ascending: boolean,
	Algorithm: number,
	IncludeNonSorted: boolean,
	SortFirstFew: boolean,
	SortingParameters: type SortingParameterObject = {
		Pivot: number
	}
}

local function __FillSorterObjectParams(): SorterObject
	return {
		Ascending = true,
		Algorithm = 1,
		IncludeNonSorted = true,
		SortFirstFew = -1,
		SortingParameters = {}
	}
end

local function __type_check(var, insisted_type: string)
	return type(var) == insisted_type
end
local function __inrange_check(var, min: number, max: number, inclusive: string)
	-- min must always be lower than max for it to logical work
	-- inclusive = "00" for both non inclusive
	-- inclusive = "01" for max value inclusive, min value non inclusive
	if inclusive == nil then
		inclusive = "00"
	end

	local lowerbound, upperbound = false, false
	if inclusive:sub(1, 1) == "0" then
		-- non inclusive for min
		lowerbound = var > min
	else
		lowerbound = var >= min
	end
	if inclusive:sub(2, 2) == "0" then
		-- non inclusive for max
		upperbound = var < max
	else
		upperbound = var <= max
	end
	return lowerbound and upperbound
end


function module_container.new(properties)
	local x: SorterObject = __FillSorterObjectParams()
	setmetatable(x, mainsorterclass)

	x:OverwriteProperties(properties)
	return x
end

function mainsorterclass:OverwriteProperties(properties)
	if properties.Ascending then
		if not __type_check(properties.Ascending, "boolean") then
			warn(".Ascending value must be a boolean")
		else
			self.Ascending = properties.Ascending
		end
	end
	if properties.Algorithm then
		if not __type_check(properties.Algorithm, "number") then
			warn(".Algorithm value must be a number")
		elseif not __inrange_check(properties.Algorithm, 0, algorithms.LENGTH, "11") then
			warn(".Algorithm value must be within 1 - %d(inclusive)":format(algorithms.LENGTH))
		else
			self.Algorithm = properties.Algorithm
		end
	end
	if properties.IncludeNonSorted then
		if not __type_check(properties.IncludeNonSorted, "boolean") then
			warn(".IncludeNonSorted value must be a boolean")
		else
			self.IncludeNonSorted = properties.IncludeNonSorted
		end
	end
	if properties.SortFirstFew then
		if not __type_check(properties.SortFirstFew, "number") then
			warn(".SortFirstFew must be a number")
		else
			self.SortFirstFew = properties.SortFirstFew
		end
	end
end

function mainsorterclass:Flip(array)
	-- flips/reverse the array
	-- i.e, array = {3, 1, 5, 10}, return = {10, 5, 1, 3}
	-- NOTE: Modifies the actual array passed as an argument
	for i = 1, #array //2 do
		array[i], array[#array -i +1] = array[#array -i +1], array[i]
	end
	return array
end

function mainsorterclass:Slice(array, s: number, e: number, step: number)
	-- s = start, must be positive
	-- e = end, must be positive
	-- step = step value, must be positive
	-- will slice beginning from the start(inclusive) and ending before end value
	-- will return a new array, leaving the passed array(argument) un-modified
	if (s == nil or type(s) ~= "number") then
		error("Start value must be a number")
	elseif (e == nil or type(e) ~= "number") then
		error("End value must be a number")
	elseif (step == nil or type(step) ~= "number") then
		error("Step value must be a number")
	elseif s <= 0 or e <= 0 or step <= 0 then
		error("Start, end, step values must all be positive (> 0)")
	end

	local re = {}
	for i = s, e -1, step do
		table.insert(re, array[i])
	end
	return re
end

function mainsorterclass:Concat(a, b, modify_array)
	-- concatenate two arrays, a and b
	-- i.e, a = {3, 1}, b = {3, 5}, return = {3, 1, 3, 5}
	-- if modify_array is false, it will create a new table
	if modify_array == nil then
		modify_array = true -- default value
	end

	local new = {}
	if modify_array then
		new = a
	else
		for i = 1, #a do
			table.insert(new, a[i])
		end
	end
	for i = 1, #b do
		table.insert(new, b[i])
	end
	return new
end

function mainsorterclass:Randomise(array, seed: number)
	-- randomises the array
end

function mainsorterclass:Shift(array, c: number)
	-- positive c to shift all elements to the right

	local n = #array
	local true_shift = c % n
	if true_shift == 0 then
		-- no shift
		return array
	end
	if c < 0 then
		-- shift left as c is negative
		true_shift = true_shift * -1
	end

	local new_array = {}
	for i = 1, n do
		local old_pos = i - true_shift
		if old_pos <= 0 then
			old_pos = n + old_pos
		elseif old_pos > n then
			old_pos = old_pos - n
		end

		table.insert(new_array, array[old_pos])
	end
	return new_array
end

function mainsorterclass:Sort(array)
	local ToSort = {}
	local ToAppend = {} -- to store the non numerical values

	local iteration_limit
	if self.SortFirstFew > 0 then
		iteration_limit = self.SortFirstFew //1
	end

	for _, v in pairs(array) do
		if type(v) == "number" and (iteration_limit == nil or iteration_limit > 0) then
			table.insert(ToSort, v)
		else
			table.insert(ToAppend, v)
		end
		if iteration_limit ~= nil then
			iteration_limit = iteration_limit - 1
		end
	end

	local SortedList = algorithm.distributor(self.Algorithm, ToSort, self.SortingParameters)
	if not self.Ascending then
		-- SortedList is in Ascending
		SortedList = self:Flip(SortedList)
	end
	if self.IncludeNonSorted then
		-- Appends ToAppend to SortedList
		ToSort = self:Concat(ToSort, ToAppend, true)
	end
	return ToSort
end

function mainsorterclass:__recurse_array(array)
	local ToSort = {}
	local ToAppend = {}

	for _, v in pairs(array) do
		if type(v) == "number" and (iteration_limit == nil or iteration_limit > 0) then
			table.insert(ToSort, v)
		elseif type(v) == "table" then
			table.insert(ToAppend, self:__recurse_array(v))
		else
			table.insert(ToAppend, v)
		end
		if iteration_limit ~= nil then
			iteration_limit = iteration_limit - 1
		end
	end

	local SortedList = algorithm.distributor(self.Algorithm, ToSort, self.SortingParameters)
	if not self.Ascending then
		-- SortedList is in Ascending
		SortedList = self:Flip(SortedList)
	end
	if self.IncludeNonSorted then
		-- Appends ToAppend to SortedList
		ToSort = self:Concat(ToSort, ToAppend, true)
	end
	return ToSort
end

function mainsorterclass:DeepSort(array)
	-- takes in an array where there are nested arrays
	-- i.e, array = {3, 1, 5, 10, {1, 3, 10, 5, 4, {4, 3, 1, 2}}}
	-- return = {1, 3, 5, 10, {1, 3, 4, 5, 10, {1, 2, 3, 4}}}
	-- index of nested arrays are maintained
	return self:__recurse_array(array)
end

return module_container