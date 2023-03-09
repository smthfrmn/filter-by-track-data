# Filter by Animal Data
MoveApps

Github repository: *github.com/movestore/Filter-by-IdData*

## Description
Filters your data set by one property of the individual animals.

## Documentation
This App filters the input data set to all locations of the individual animals with user-defined properties. So, for example, to only retain the data of all females or tracks ending before a certain timestamp. The list of suggested properties is based on Movebank individual data, but also 'other' properties can be entered. They have to be part of the input MoveStack.

### Input data
moveStack in Movebank format

### Output data
moveStack in Movebank format

### Artefacts
none

### Settings 
**Animal Properties (`variab`):** This is a selected individual parameter according to which the data shall be filtered. If the required parameter is not in this list, 'other' can be chosen en and its name entered below.

**Other (`other`):** Name of the required individual parameter, if for `variab` 'other' has been selected. Take care that this parameter also exists in the ID data of the input data set.

**Filter Preference Relation (`rel`):** By this parameter the relation in the required filter has to be selected. The possible values differ by parameter data type, only numeric and timestamps variables can relate by '==', '>' or '<'.

**Filter Value (`valu`):** Value of the relation that the filtered part of the data set has to fullfill. In case of `rel` = 'is one of the following' commas have to be used to separate the possible values. In case of a timestamp parameter please use the timestamp format with year, month, day, hour, minute and second as in the example: '2021-06-23 09:34:00"

**Time variable? (`time`):** Please tick this parameter if your selected variable is a timestamp type, so that the App can properly work with it.

### Null or error handling:
**Setting `variab`:** If none of the options of this checkbox selection is chosen, an error will be returned.

**Setting `other`:** If there is no individual variable with the name given here, an error will be returned. This parameter only becomes effective if `variab`='other' has been selected.

**Setting `rel`:** If none of the relation options are selected, an error will be returned. It has to be carefully considered that the selected relation fits with the data type of the selected variable. Only numeric and timestamps variables can relate by '==', '>' or '<'.

**Setting `valu`:** If there is no value entered, an error will be returned. The data type of the entered value has to fit with the selected variable.

**Setting `time`:** If the selected variable is a timestamp and it was not indicated here, the variable will be treated as a string of text and possibly not handled correctly, leading to errors. Similarly if your variable is not a timestamp and it is indicated here. Default is 'false'.

**Data:** If none of the individuals in the input data set fullfill the selected relation, a warning is given and a NULL data set is returned. The NULL return value likely produces an error.
