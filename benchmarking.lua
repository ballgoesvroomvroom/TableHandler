local th = require(game:GetService("ServerScriptService"):WaitForChild("TableHandler"))
local o = th.new() -- table_handler object

local bm = {} -- to store the timings; schematic for each categ: {big, medium, small}
local test_set = { -- store all the generated datasets per category
	{}, -- big-sized datasets; 10000 items
	{}, -- medium-sized datasets; 2000 items
	{}  -- small-sized datasets; 100 items
}
local dataset_len = {
	10000,
	2000,
	100
}

-- CONSTANTS
local TEST_SIZE = 100 -- 10 datasets per category

-- generate datasets
for categ =  1, 3 do
	for x = 1, TEST_SIZE do -- amount of datasets
		local dataset = {}
		for y = 1, dataset_len[categ] do -- amount of values in one dataset
			table.insert(dataset, math.random(100 *5 *(4 -categ))/10)
		end
		table.insert(test_set[categ], dataset)
	end
end

-- actual benchmarking
for i = 1, 5 do
	local results = { -- local results of the current algorithm
		{},
		{},
		{}
	}

	o.Algorithm = i
	print("Algorithm no.", o.Algorithm)
	local elapsed_time_global = {}
	for categ = 1, 3 do
		local total_etime = 0
		for iteration, dataset in pairs(test_set[categ]) do
			print(("Dataset's length: %d"):format(#dataset))
			local start_time = tick() -- in seconds
			o:Sort(dataset)
			local e_time = tick() -start_time
			print(("Elapsed time for categ %d, %d dataset: %.6f"):format(categ, iteration, e_time))
			total_etime = total_etime + e_time
		end
		table.insert(elapsed_time_global, total_etime/TEST_SIZE)
	end
	table.insert(bm, elapsed_time_global)
end
print(bm)
--[[
categ = 1; big-sized dataset
bm = {
	{timetaken_bigdataset, timetaken_mediumdataset, timetaken_smalldataset}, -- categ = 1; timetaken(seconds)
	{timetaken_bigdataset, timetaken_mediumdataset, timetaken_smalldataset}, -- categ = 2; timetaken(seconds)
	{timetaken_bigdataset, timetaken_mediumdataset, timetaken_smalldataset} -- categ = 3; timetaken(seconds)
}
results:
                    [1] =  ▼  { bubble sort
                       [1] = 0.02536289691925049,
                       [2] = 0.0009749650955200196,
                       [3] = 0.0006644964218139648
                    },
                    [2] =  ▼  { insertion sort
                       [1] = 0.0008423566818237304,
                       [2] = 0.0008470535278320313,
                       [3] = 0.0006061792373657227
                    },
                    [3] =  ▼  { heap sort
                       [1] = 0.001693916320800781,
                       [2] = 0.0006920814514160157,
                       [3] = 0.0006024837493896484
                    },
                    [4] =  ▼  { quick sort
                       [1] = 0.01447045803070068,
                       [2] = 0.0007505416870117188,
                       [3] = 0.0005757570266723633
                    },
                    [5] =  ▼  { selection sort
                       [1] = 0.01673722267150879,
                       [2] = 0.0007632017135620117,
                       [3] = 0.0008028268814086914
                    }
--]]