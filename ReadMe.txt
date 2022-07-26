
You need to convert all data to 0.5 spatial resolution using the "Convertion to 0.5degree spatial resolution.ncl" code.

In "Convertion to 0.5degree spatial resolution.ncl" code, you will need to specify iyear_start and iyear_end. iyear_start is the first year of data and 
iyear_end is the end year.

The "addfile" command is for uploading the NetCDF file.

For running "RCI.ncl" code, the input ncl dataset must have 8-day time resolution. The parameter names in RCI.ncl is for applying it to SIF datset.
It is appliable to ET and GPP datasets, however, you might need to change line 7, regarding the parameters name in your dataset.

In th "Standard anomalies.ncl" code, you need to convert all datasets to monthly time resolution.







