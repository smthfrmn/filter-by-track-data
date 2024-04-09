# Filter by Track Data
MoveApps

Github repository: *https://github.com/smthfrmn/filter-by-track-data*

## Description
This app allows users to filter their data set by a given field in your track data. Track data are the attributes of the track (e.g., sex of animal, deployment ID, animal group ID), but not the location (i.e., event attributes) data themselves. If you're curious about the distinction between track and event attributes, you can read more about it in the move2 documentation here: https://cran.r-project.org/web/packages/move2/vignettes/programming_move2_object.html. In Movebank terminology, this track attribute data is a combination of reference data (i.e., animals, deployments, and tags) and study data. Take a look at the Movebank documentation to understand what fields may -- depending on whether they are populated -- be available in the user's track data on MoveApps: https://www.movebank.org/cms/movebank-content/movebank-attribute-dictionary. 

## Documentation
This App filters the input data given user-defined filter settings. For example, one can retain female tracks, tracks from a given herd, or tracks deployed after a given timestamp. In the settings, we provide some default track data fields that users may want to filter by, but any populated track data field can be filtered by, by selecting 'Other' in the Track Data Field dropdown menu. Note: when using 'Other', the 'Other' field must be present in the track data. 

### Input data
move2 in Movebank format

### Output data
move2 in Movebank format

### Artefacts
none

### Settings
**Track Data Field (`variab`):** The track data field by which a user wants to filter. There are some defaults provided, but the user can also select 'Other' in order to enter their preferred field to filter by.

**Other (`other`):** Name of the required individual parameter, if for `variab` 'other' has been selected. The 'Other' field must exist in the track data, app will log error and return a null result if the field is not present in the track data.

**Filter Relation (`rel`):** By this parameter the relation in the required filter has to be selected. The possible values differ by parameter data type.

**Filter Value (`valu`):** Value of the relation that the filtered part of the data set has to fulfill. In case of `rel` = 'is one of the following' commas have to be used to separate the possible values. In case of a timestamp parameter, please use the timestamp format with year, month, day, hour, minute and second as in the example: '2021-06-23 09:34:00'."

**Time field? (`time`):** Boolean indicating whether or not the filter field is a timestamp.  

### Null or error handling:
**Setting `variab`:** If this value is null or an empty string, an error will be logged and a null result will be returned.

**Setting `other`:** If `variab` is 'other' and this value is null or an empty string, an error will be logged and a null result will be returned.

**Setting `rel`:** If none of the relation options are selected, an error will be logged and a null result will be returned. Keep in mind that when using ">" or "<" for character/factor data types, R will filter based on alphabetical order and that results may be unexpected.

**Setting `valu`:** If this value is null or an empty string, an error will be logged and a null result will be returned. The data type of the entered value has to fit with the selected variable.

**Setting `time`:** If the selected variable is a timestamp and it was not indicated here, the variable will be treated as a string of text and possibly not handled correctly, leading to errors. Similarly if your variable is not a timestamp and it is indicated here. Default is 'false'.

**Data:** If none of the tracks in the data set fulfill the filter settings, a warning is given and an empty data set is returned.