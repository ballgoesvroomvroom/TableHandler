# Table handler object

An object to carry out array manipulation.  
Mainly sorting.  
For use within Roblox.  

## Notes
Passed arrays are not modified directly; instead a new array with a new memory address will be returned

## Types
#### - [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject)
#### - [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#properties)
#### - SortingParameterObject

## List of sorting algorithms
1. Bubble sort
	- Extra params: None
2. Insertion sort
	- Extra params: None
3. Heap sort
	- Extra params: None
4. Quick sort
	- Extra params:
		- `.Pivot`: Determines the starting pivot when beginning the first recursion
5. Selection sort
	- Extra params: None

## Functions
### `.new()` - Creates a new [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject)
#### Parameters:
| Name | Desc|
| ---- | ----|
| *Properties: [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties) | An array containing the TableHandlerObject's properties |

#### Returns
A [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject)

### `.getver()` - Returns the version of the current module in the format, `major.minor.patch`
#### Parameters
| Name | Desc|
| ---- | ----|
| *type: string | Determines the value to return, either 'major', 'minor' or 'patch' |

#### Returns
String

## Class
### `TableHandlerObject`
Type: [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobject)
Note: Read only table, cannot modify properties by indexing it, use `:WriteProperties()` method instead

#### Properties
- `.Ascending`
	- Default: true
	- Type: boolean
	- Desc: Determines if array should be returned in ascending order (if true) when calling any sorting functions
- `.Algorithm`
	- Default: 1
	- Type: 4
	- Desc: Determines the sorting algorithm to use.<br />Refer to [List of sorting algorithms](https://github.com/ballgoesvroomvroom/TableHandler#list-of-sorting-algorithms)
- `.IncludeNonSorted`
	- Default: true
	- Type: boolean
	- Desc: If true, it will append elements in the array that are non-sorted(non-numerical) at the very end in order when sorting
- `.SortFirstFew`
	- Default: -1
	- Type: number
	- Desc: Determines the amount of elements (it counts non-numerical elements) to sort\A value of -1 to indicate to sort all the elements in the passed array
- `.SortingParameters`
	- Default: {}
	- Type: [SortingParameterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sortingparameterobject)
	- Desc: Stores arguments that sorting functions can use\Such as the initial pivot, `.Pivot`, when using quicksort algorithm

#### Methods
| Name | Params | Desc | Returns
| ---- | ----| ----| ----|
| GetProperties | - | Gets the properties of the TableHandlerObject | Returns an dictionary(type: [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties)) containing all the properties of the current TableHandlerObject |
| WriteProperties | TableHandlerObjectProperties: [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties) | Overwrites the properties for the TableHandlerObject | nil |
| Flip | a: array | Flips/Reverses array 'a' | Returns the flipped array of 'a' | Flipped array of 'a'
| Slice | a: array, s: number, e: number, *step(default = 1): number | Slices the array starting from s (inclusive) and ending right before e (non-inclusive), step being the step value<br />Includes negative indexes, if s = -2, it will start slicing right at the last two elements, likewise for e | Sliced array of 'a'
| Concat | a: array, b: array, *modify_array(default = true): boolean | Concatenate the two arrays, 'a' and 'b'<br />If `modify_array` is true, it will append b onto a, else it would create a new table and dump a into it and followed by b | Concatenated array from 'a' and 'b'
| Randomise | a: array, seed: number | Randomise the order of the array, includes non-numerical values | Randomised array of 'a'
| Shift | a: array, c: number | Shift the array by c (negative value to shift left) | Shifted array of 'a'
| Sort | a: array | Sorts the array with the properties in [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties) along with extra arguments (if exists), [SortingParameterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sortingparameterobject) | Sorted array of 'a'
| Deepsort | a: array | Sorts array 'a' along with all nested arrays, treats nested arrays as non-numerical objects and append them to the results regardless of `.IncludeNonSorted` | Sorted array of 'a', along with its nested arrays


## Examples
Begin with an assignment of a [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject) to variable `o`
```lua
local table_handler = require(game:GetService("ServerScriptService"):WaitForChild("TableManager"))
local o = table_handler.new()
```

### Eg 1:
`:Flip()` method
```lua
local array_to_flip = {4, 3, 1}
local flipped_array = o:Flip(array_to_flip)
print(array_to_flip, "\n", flipped_array)
```
Output:
```bash
{4, 3, 1}
{1, 3, 4}
```
The initial array was not modified, this case follows for all other methods unless stated otherwise :)

### Eg 2:
`:Slice()` method
```lua
local a = {"a", "b", "c", "d", "e", "f"}
local b = o:Slice(a, 1, 3)
local c = o:Slice(a, 2, 4)
local d = o:Slice(a, -1, 1, -1) -- returns the same results as :Flip() method
local e = o:Slice(a, 1, -2)
local f = o:Slice(a, 1, -2, 2)

print(b, "\n", c, "\n", d, "\n", e, "\n", f)
```
Output:
```bash
{"a", "b"}
{"b", "c"}
{"f", "e", "d", "c", "b", "a"}
{"a", "b", "c", "d"}
{"a", "c"}
```

### Eg 3:
`:Concat()` method
```lua
local array_a = {"a", "b", "c"}
local array_b = {"c", "b", "a", 0, 1, 2, 3}
local array_merged = o:Concat(array_a, array_b, true)
local array_merged_new = o:Concat(array_a, array_b, false)

print(array_merged, "\n", array_merged_new, "\n", array_a)
```
Output:
```bash
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3}
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3, "c", "b", "a", 0, 1, 2, 3}
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3}
```
As shown, when the third argument of `:Concat()`, `modify_array`, is true, `array_a` was modified, hence when calling `:Concat()` a second time, it took the modified `array_a` which was the results of `:Concat(arrray_a, array_b, true)` and concatenating it with `array_b`

### Eg 4:
`:Randomise()` method
Work in progress.

### Eg 5:
`:Shift()` method
```lua
local array_to_shift = {"a", "b", "c"}
local shifted_array_a = o:Shift(array_to_shift, 2)
local shifted_array_b = o:Shift(array_to_shift, 5)
local shifted_array_c = o:Shift(array_to_shift, -1)
local shifted_array_d = o:Shift(array_to_shift, -4)
local shifted_array_e = o:Shift(array_to_shift, -16)

print(shifted_array_a, "\n", shifted_array_b, "\n", shifted_array_c, "\n", shifted_array_d, "\n", shifted_array_e, "\n")
```
Output:
```bash
{"b", "c", "a",} 
{"b", "c", "a",} 
{"c", "a", "b",} 
{"c", "a", "b",} 
{"c", "a", "b",} 
```
Second argument, `c` wraps around so it can be greater/lesser than the array length<br />
Positive value of `c` will shift array towards the right<br />
Negative value of `c` will shift array towards the left

### Eg 6:
`:Sort()` method
```lua
local array_to_sort = {3, 4, 1, 2}
local sorted_array = o:Sort(array_to_sort)

print(sorted_array)
```
Output:
```bash
{1, 2, 3, 4}
```
### Eg 6.1:
`.Ascending`
```lua
local array_to_sort = {3, 4, 1, 2}

o.Ascending = false
local sorted = o:Sort(array_to_sort)

print(sorted)
```
Output:
```bash
{4, 3, 2, 1}
```

### Eg 6.2:
`.IncludeNonSorted`
```lua
local array_to_sort = {1, "d", 3, "a", "b", 5, 4, "c"}

o.IncludeNonSorted = true -- default value; redundant; here just to show
local sorted_a = o:Sort(array_to_sort)

o.IncludeNonSorted = false
local sorted_b = o:Sort(array_to_sort)

print(sorted_a, "\n", sorted_b)
```
Output:
```bash
{1, 3, 4, 5, "d", "a", "b", "c"}
{1, 3, 4, 5}
```
Placement of non-numerical values are consistent

### Eg 6.3:
`.SortFirstFew`
```lua
local array_to_sort = {3, "a", 7, 1, 10, 6, 9}

o.IncludeNonSorted = true
o.SortFirstFew = 3
local sorted_a = o:Sort(array_to_sort)

o.SortFirstFew = 5
local sorted_b = o:Sort(array_to_sort)

o.IncludeNonSorted = false
o.SortFirstFew = 3
local sorted_c = o:Sort(array_to_sort)

print(sorted_a, "\n", sorted_b, "\n", sorted_c)
```
Output:
```bash
{3, 7, "a", 1, 10, 6, 9}
{1, 3, 7, 10, "a", 6, 9}
{3, 7}
```
It will treat the rest as non-numerical values and append them to the results if `.IncludeNonSorted` is set to true

### Eg 7:
`:DeepSort()`
```lua
local array_to_sort {3, 6, 1, "a", {5, 2, "b" 8, {4, 2}, "c"}, "d"}

o.IncludeNonSorted = true -- default is true; this line is redundant
local a = o:DeepSort(array_to_sort)

o.IncludeNonSorted = false
local b = o:DeepSort(array_to_sort)

print(a, "\n", b)
```
Output:
```bash
{1, 3, 6, "a", {2, 5, 8, "b", {2, 4}, "c"}, "d"}
{1, 3, 6, {2, 5, 8, {2, 4}}}
```
Table objects are treated as non-numerical values
Placement of non-numerical values are consistent

### Eg 7.1:
`.SortFirstFew`
```lua
local array_to_sort {3, 6, 1, "a", {5, 2, "b" 8, {4, 2}, "c"}, "d", {5, 2, 3}}

o.SortFirstFew = 5
o.IncludeNonSorted = true -- default is true; this line is redundant
local a = o:DeepSort(array_to_sort)

o.IncludeNonSorted = false
local b = o:DeepSort(array_to_sort)

print(a, "\n", b)
```
Output:
```bash
{1, 3, 6, "a", {2, 5, 8, "b", {2, 4}, "c"}, "d", {5, 2, 3}}
{1, 3, 6, {2, 5, 8, {2, 4}}}
```

## Algorithms' performances
There are 3 different sizes of datasets that I have benchmarked<br />
Big:    10, 000 items<br />
Medium: 2000 items<br />
Small:  100 items<br />

A total of 100 datasets per sizes were used and the average was taken<br />

### Bubble sort
Time taken to sort each dataset:<br />
| Small | Medium | Big |
| ---   | ---    | --- |
| 0.664ms | 0.7949ms | 25.362ms

### Insertion sort
Time taken to sort each dataset:<br />
| Small | Medium | Big |
| ---   | ---    | --- |
| 0.617ms | 0.847 | 0.842ms

### Heap sort
Time taken to sort each dataset:<br />
| Small | Medium | Big |
| ---   | ---    | --- |
| 0.602ms | 0.692ms | 1.693ms

### Quick sort
Time taken to sort each dataset:<br />
| Small | Medium | Big |
| ---   | ---    | --- |
| 0.575 | 0.750ms | 14.470ms

### Selection sort
Time taken to sort each dataset:<br />
| Small | Medium | Big |
| ---   | ---    | --- |
| 0.802ms | 0.763ms | 16.737ms

#### [Code used to benchmark](https://github.com/ballgoesvroomvroom/TableHandler/blob/main/benchmarking.lua)

---

Version: 0.1.0