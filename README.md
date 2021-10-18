# Table handler object

An object to carry out array manipulation.  
Mainly sorting.  
For use within Roblox.  

## Notes
Passed arrays are not modified directly; instead a new array with a new memory address will be returned

## Types
#### - [SorterObject](https://github.com/ballgoesvroomvroom/TableHandler#sorterobject)
#### - [SorterObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#properties)
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
5. Merge sort
	- Extra params: None
6. Selection sort
	- Extra params: None

## Functions
### `.new()` - Creates a new [SorterObject](https://github.com/ballgoesvroomvroom/TableHandler#sorterobject)
#### Parameters:
| Name | Desc|
| ---- | ----|
| Properties: [SorterObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--sorterobjectproperties) | An array containing the SorterObject's properties |

## Class
### `SorterObject`
Type: [SorterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sorterobject)

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
	- Desc: If true, it will append elements in the array that are non-numerical at the very end in order when sorting
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
| OverwriteProperties | SorterObjectProperties: [SorterObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--sorterobjectproperties) | Overwrites the properties for the SorterObject | nil |
| Flip | a: array | Flips/Reverses array 'a' | Returns the flipped array of 'a' | Flipped array of 'a'
| Slice | a: array, s: number, e: number, step: number | Slices the array starting from s (inclusive) and ending right before e (non-inclusive), step being the step value | Sliced array of 'a'
| Concat | a: array, b: array | Concatenate the two arrays, 'a' and 'b' | Concatenated array from 'a' and 'b'
| Randomise | a: array, seed: number | Randomise the order of the array, includes non-numerical values | Randomised array of 'a'
| Shift | a: array, c: number | Shift the array by c (negative value to shift left) | Shifted array of 'a'
| Sort | a: array | Sorts the array with the properties in [SorterObjectProperties](https://github.com/ballgoesvroomvroom/TableHandler#--sorterobjectproperties) along with extra arguments (if exists), [SortingParameterObject](https://github.com/ballgoesvroomvroom/TableHandler#--sortingparameterobject) | Sorted array of 'a'
| Deepsort | a: array | Sorts array 'a' along with all nested arrays, treats nested arrays as non-numerical objects and append them to the results regardless of `.IncludeNonSorted` | Sorted array of 'a', along with its nested arrays

---

Version: 0.0.1