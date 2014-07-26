Run Analysis Code Book
======================

Main function "create_tidy_data"
--------------------------------
Creates a tidy data with mean and stardard deviation averages by activity and subject.
Parameters:
	<path_ini> should contain the root path to the train/test data

	
Function "merge_train_with_test"
--------------------------------
Merge train and test data into a data set and set the appropriate column names
Parameters:
	<data_name> can be "x", "Y" or "subject". 
	Used to merge the <data_name>_train.txt and <data_name>_test.text files
	
	<col_names> can be "feature", "activity" or "subject"
	Used to find the files containing the column names
	

Function "filter_columns_by"
--------------------------
Filter the column names by pattern matching
Parameters:
	<pattern> can be "mean()" or "std()"
	Used to filter the column names containing the pattern word
	
	<column_names> are a vector containing all the columns in the data set

	
Function "label_column_data_by"
-----------------------------
Map each row from a data column with the correspondent label
Parameters:
	<label_name> is "activity"
	Used to read all activity values
	
	<column_data> is a vector containing all items for the specified label name column
	Each value will be transformed to the correspondent label (WALKING, ...)
	
	
Helper functions
----------------
Used to read the appropriate data files into a vector or matrix