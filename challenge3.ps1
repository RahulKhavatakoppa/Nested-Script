##PowerShell function Get-NestedValue
function Get-NestedValue {
    ###This section defines the parameters of the function. It expects two mandatory parameters: $object (an object) and $key (a string).
    param (
        [Parameter(Mandatory=$true)]
        [object]$object,
        [Parameter(Mandatory=$true)]
        [string]$key
    )
    ##These lines split the $key string into an array of keys using the '/' delimiter and initialize $result with the original $object
    $keys = $key -split '/'
    $result = $object

    ##This line starts a loop that iterates through each key in the $keys array.
    foreach ($k in $keys) 
    {   
        ##This condition checks if the current $result is a dictionary (associative array). If it is, the next nested level can be accessed.
        if ($result -is [System.Collections.IDictionary]) 
        {
            ##If the $result is a dictionary, it retrieves the result associated with the current key $k and updates $result for the next iteration.
            $result = $result[$k]
        } 
        else 
        {
            ###If the current $result is not a dictionary (indicating that the key sequence is invalid), the function sets $result to $null and exits the loop using break.
            $result = $null
            break
        }
    }
    ##After traversing all keys, the function returns the final value of $result.
    return $result
}

###This block demonstrates an example usage of the Get-NestedValue function with a nested object $object1 and a key $key1. 
$object1 = @{ 'a' = @{ 'b' = @{ 'c' = 'd' } } }
$key1 = 'a/b/c'
$value1 = Get-NestedValue -object $object1 -key $key1
###It calls the function and stores the value in $value1, which is then outputted to the console.
Write-Output "Value 1: $value1"

##Similarly,the function with a different nested object $object2 and key $key2. 
$object2 = @{ 'x' = @{ 'y' = @{ 'z' = 'a' } } }
$key2 = 'x/y/z'
$value2 = Get-NestedValue -object $object2 -key $key2
##It calls the function and stores the value in $value2, which is then outputted to the console.
Write-Output "Value 2: $value2"

###The Write-Output statements display the values of the function calls, showing how the function retrieves nested values based on the provided keys.