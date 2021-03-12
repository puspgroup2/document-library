# Get the system running locally

## 1. First steps
To get the project going follow these steps:
1. Pull the latest version of the `work-library` repository to your local machine.
2. Open Eclipse EE
3. Click *"Open Projects from File Systems"*
4. Browse -> FILEPATH/PUSS214205_SDDD
5. Click *"Finish"*. You should get **2** folders in the Project Explorer.
6. Click *Servers* tab in the bottom. If no tomcat is selected:
   1.  Click *new server*.
   2.  Choose "Tomcat v9.0 Server"
   3.  Add `SDDD` -> 
   4.  Click "Finish"
7. Ensure Java build path
   1. Right click on project
   2. Click "Properties"
   3. Click "Java Build Path"
   4. Click "Libraries"
   5. Click "Classpath"
   6. Click "Add External JARS"
   7. Select the `servlet-api.jar` located in `apache-tomcat/lib`
   8. Click "Apply and close"
8. Right click *Servers* tab in the bottom. 
9. Click "Start"
10. Open a browser, navigate to `http://localhost:8080
11. Be happy in massive success.

## 2. Unknown issues
### 1. If Eclipse fails to find some of the classes, you might try the following
1. Right click on project
2. Click "Properties"
3. Click "Project Facets"
4. Click "Runtimes" (to the right)
5. Click "New"
6. Add `Apache Tomcat v9.0`
7. Click the checkbox
8. Click "Apply and close"

## 3. Still doesn't work??
1. Delete the folders from the eclipse workspace. (*SDDD* and *servers*)
2. Follow the steps on **1. First steps**.
