
How to run the app
-------------------

1) Initialize the MySQL DB

Run the following scripts one by one given in "queries.sql" file
-----------------------------------------------------



2) Run the application

Dependencies
	Python3
	FLASK
	MySQL

inside the "restapi-python-flask-mysql"
* Run the requirements.txt file using following command "pip install -r requirements.txt"


* run "python rest.py" command on the terminal
------------------------------------------------------------------------------

Application end-point will available on localhost:5001


localhost:5001/products - shows the list of products available

localhost:5001/baskets - shows the list of buckets available

localhost:5001/baskets/<int:id> - shows the bucket selected

localhost:5001/additem/<int:id> - add new item to the bucket

localhost:5001/delete/<string:id> - deletes an item from the bucket items list


