# etl-individual-project

The Individual Project involves 3 dimensional table(customer, product, date) connected with one fact table sales.

We have used environment Variable etl_user to connect to the MYSQL server.
Also environment variable is used to connect to the respective directeries.

00- Source: Files where the tables are Preserved.
01- Extract :the extract process from excel files is transfered to sourceDB.
02- Transfer :The Customer data is fetched from the AWS MYSQL server and dumped  into Stage DB.
03- Load Dim : The Database is now processed and stored in Datamart.
04- Load fact: The Fact table is them=n constructed from the Loaded Dimensional table.
