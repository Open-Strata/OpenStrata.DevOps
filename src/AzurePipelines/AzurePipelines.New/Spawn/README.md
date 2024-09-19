# Introduction 
The purpose of this repository is to serve as a starting point for easily standing up a respository for a Dataverse Solution managed by the OpenStrata Framework..  

This repo consists of an azure-pipelines.yml file and a nuget.config file.  These files will be used to initialize the OpenStrata Dotnet project structure for managaging the Dataverse Solution.

# Create Dataverse Solution Repository
Follow the steps below to create a repository of an  Dataverse Solution by clonsing this repository.
1.	Ensure you have a PAT for at a minimum read-only access to this repository.
2.  In the appropriate devops project, select the option to "Import repository"
3.	In the clone URL text box, enter is repository's address: [TBD].
4.  Check Requires Authentication.  Enter the PAT from step 1 into the Password / PAT * text box.  Disregard the username text box.
4.	In the Name text box, replace [TBD]] with the unique name of the Dataverse Solution.
5.	Click the Import Button.

# Use a pipeline to initialize Dotnet Project Structure.
Follow the steps below to create a pipeline which will be used to initialize the project structure and process future devops actions.
1.	Within the devops project hosting the git repository previously created, navigate to pipelines and select the button to create a New pipeline.
2.  At the "Where is your code?" prompt, select Azure Repos Git.
3.	At the "Select a repository" prompt, select the previously created repository.
4.  After selecting the repository, A pipeline based on the azure-pipelines.yml file in included in this repo will be displayed and you will have the option to run or save the pipeline.
5.	DO NOT MAKE ANY CHANGES TO THE PIPELINE.
6.	Prior to running the pipeline, be prepared to specify the following:  Add Plugin Project, Add Document Templates Project, and Add Legacy Power Pages Project.  If you don't know the answer, don't specify yes.  These projects can be added later.
7.  Click Run.  In most cases, the default parameter values are adequate.  If the Repository name is not the same as the solution name, enter the solution name.  As a best practice, it is strongly recommened that the repository names are the same as the Dataverse solution unique name.
8.  Select Run.  The pipeline will create the Dotnet project solution structure and check in the changes.

