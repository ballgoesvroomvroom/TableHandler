# Table handler object

An object to carry out table manipulation; created with efficiency and speed in mind<br />

Mainly used in ROBLOX

## Notes

Passed arrays are not modified directly when sorting functions are called; instead a new array with a new memory address will be returned, regardless of `.ModifyArray`; due to the nature of how it works, it will be very inefficient to modify the array, you're better off reassigning the value and let garbage collection do its work<br />

In this document, both the terms `array` and `table` are used interchangeably loosely<br />

Parameters with an asterisk (*) before their names are optional, they already have a default value<br />

`.Algorithm = 4`; Quicksort algorithm is not fully implemented yet, please refrain from using it at all cost



## Table of contents

- [Types](https://github.com/ballgoesvroomvroom/TableHandler#types)
- [List of sorting algorithms](https://github.com/ballgoesvroomvroom/TableHandler#list-of-sorting-algorithms)
- [Algorithms' performances](https://github.com/ballgoesvroomvroom/TableHandler#algorithms-performances)
- [Functions](https://github.com/ballgoesvroomvroom/TableHandler#functions)
- [Class](https://github.com/ballgoesvroomvroom/TableHandler#class)
- [Examples](https://github.com/ballgoesvroomvroom/TableHandler#examples)

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



## Algorithms' performances

There are 3 different sizes of datasets that I have used to benchmarked<br />
Big:    10, 000 items<br />
Medium: 2000 items<br />
Small:  100 items<br />

A total of 100 datasets per sizes were used and the average time taken to sort was taken<br />

### Bubble sort

Time taken to sort each dataset:<br />

| Small   | Medium   | Big      |
| ------- | -------- | -------- |
| 0.664ms | 0.7949ms | 25.362ms |

### Insertion sort

Time taken to sort each dataset:<br />

| Small   | Medium | Big     |
| ------- | ------ | ------- |
| 0.617ms | 0.847  | 0.842ms |

### Heap sort

Time taken to sort each dataset:<br />

| Small   | Medium  | Big     |
| ------- | ------- | ------- |
| 0.602ms | 0.692ms | 1.693ms |

### Quick sort

Time taken to sort each dataset:<br />

| Small | Medium  | Big      |
| ----- | ------- | -------- |
| 0.575 | 0.750ms | 14.470ms |

### Selection sort

Time taken to sort each dataset:<br />

| Small   | Medium  | Big      |
| ------- | ------- | -------- |
| 0.802ms | 0.763ms | 16.737ms |

#### [Code used to benchmark](https://github.com/ballgoesvroomvroom/TableHandler/blob/main/benchmarking.lua)



## Functions

### `.new()`

#### Parameters:

​	- *properties: [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties)

#### Description:

​	 Creates a new [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject)

#### Returns:

​	[TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#tablehandlerobject)

### `.getver()`

#### Parameters:

 - *typ: string -- Determines the value to return, either 'major', 'minor' or 'patch'

#### Description:

​	Returns the version of the current module in the format, `major.minor.patch`

#### Returns:

​	String

## Class

### `TableHandlerObject`

Type: [TableHandlerObject](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobject)
Note: Modify properties using simple indexing will call [:WriteProperties()](https://github.com/ballgoesvroomvroom/TableHandler#writeproperties)

#### Properties:

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
- `.ModifyArray`
  - Default: false
  - Type: boolean
  - Desc: For certain functions, if this is true, it will modify the current table and return it instead of returning a new table
- `.SortFirstFew`
  - Default: -1
  - Type: number
  - Desc: Determines the amount of elements (it counts non-numerical elements) to sort\A value of -1 to indicate to sort all the elements in the passed array
- `.SortingParameters`
  - Default: {}
  - Type: [SortingParameterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sortingparameterobject)
  - Desc: Stores arguments that sorting functions can use\Such as the initial pivot, `.Pivot`, when using quicksort algorithm

#### Methods:

##### `:GetProperties()`

###### Parameters:

​	None

###### Description

​	Gets the properties of the TableHandlerObject

###### Returns

​	Returns an [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties) containing all the properties of the current TableHandlerObject



##### `:WriteProperties()`

###### Parameters:

 - [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties)

###### Description:

​	Overwrites the properties for the TableHandlerObject<br />

​	When rewriting values of the properties, it will call this method automatically and pass the key and value arguments automatically :)

###### Returns

​	None



##### `:Flip()`

###### Parameters:

 - a: array

###### Description:

​	Flips/Reverses the array 'a'<br />

​	If `.ModifyArray` property of TableHandlerObject is `true`, it will modify array `a` instead of returning a new array.

###### Returns

​	Returns the flipped array of `a`



##### `:Slice()`

###### Parameters:

 - a: array
 - s: number
 - e: number
 - *step(default = 1): number

###### Description:

​	Slices the array, `a`, starting right from `s`(inclusive) and ending right before `e`, with regards to the `step` value, which is defaulted at `1`<br />

​	Includes negative indexes, `-1` to represent the last element in the array; and negative step values

###### Returns:

​	The sliced array of `a`



##### `:Concat()`

###### Parameters:

 - a: array
 - b: array

##### Description:

​	Concatenate the two arrays, `a` and `b`<br />

​	If `.ModifyArray` is `true`, it will append array `b` onto `a`, else it would create a new array and add `a` and `b` into it, with respect to the order

##### Returns:

​	Concatenated array from `a` and `b`



##### `:Randomise()`

#### Work in progress



##### `:Shift()`

###### Parameters:

 - a: array
 - c: number

###### Descriptions:

​	Shift array, `a` by `c`<br />

​	Will not modify array `a` regardless of `.ModifyArray`<br />

​	If `c` is positive, it will shift towards the right<br />

​	If `c` is negative, it will shift towards the left<br />

​	The amount to shift is calculated by `c` % `#a`

###### Returns:

​	Shifted array of `a`



##### `:Sort()`

###### Parameters:

 - a: array

###### Description:

​	Sorts the array `a` with the properties [TableHandlerObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--tablehandlerobjectproperties) along with extra arguments (if exists), [SortingParameterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sortingparameterobject)<br />

​	Will not modify the array regardless of `.ModifyArray`

###### Returns:

​	Sorted array of `a`



##### `:DeepSort()`

###### Parameters:

 - a: array

###### Description:

​	  Sorts array `a` along with all nested arrays, treats nested arrays as non-numerical objects and append them to the results regardless of `.IncludeNonSorted`

###### Returns:

​	Sorted array of `a`, along with its nested arrays




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

o.ModifyArray = false -- already default; redundant line
local flipped_array = o:Flip(array_to_flip)

print(array_to_flip, "\n", flipped_array)
```

Output:

```bash
{4, 3, 1}
{1, 3, 4}
```

The initial array was not modified

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

o.ModifyArray = true -- defualt: false
local array_merged = o:Concat(array_a, array_b)
print(array_merged)

local array_merged_new = o:Concat(array_a, array_b)

print(array_merged_new, "\n", array_a)
```

Output:

```bash
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3}
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3, "c", "b", "a", 0, 1, 2, 3}
{"a", "b", "c", "c", "b", "a", 0, 1, 2, 3, "c", "b", "a", 0, 1, 2, 3}
```

As shown, when `.ModifyArray` is `true`, it will modify the passed array, hence, on the second call, the modified array was used, resulting in a longer array.

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
local array_to_sort = {3, 6, 1, "a", {5, 2, "b", 8, {4, 2}, "c"}, "d"}

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
local array_to_sort = {3, 6, 1, "a", {5, 2, "b", 8, {4, 2}, "c"}, "d", {5, 2, 3}}

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

---

Version: 0.1.1