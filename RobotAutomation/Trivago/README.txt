***Installation/Setup

Detailed instructions on getting Robot Framework set up/installed below.

***PreRequisites

	Robot framework is a generic test automation framework, this is implemented using Python.

	*Python installation
	Desired version of python can be downloaded from https://www.python.org/downloads/ (please install Python 3.3 & above)

	Verify Python installation on your system
	python --version
	pip --version

	*Configuring PATH
	Add Python installation directory (by default C:\Python27, C:\Python27\Scripts,) and Scripts directory to your path variable

	*Add Chrome browser driver to Scripts folder
	Based on your chrome browser version - download the driver here - https://chromedriver.chromium.org/downloads
	Place this in the Python Scripts directory, this way we don't need to specify the driver executable path in the robot tests
	Note: Firefox driver could be added too - but for this project I have used only chrome


***Installing Robot Framework and Required libraries to run the Automation Tests

	The suggested route to install the robot framework on Python is to use pip.Run the below command

	pip install robotframework

	Verify Robot framework installation
	robot --version
	rebot --version
	pip show robotframework

	Install the other required libraries to work with the Framework
	pip install requests
	pip install robotframework-seleniumlibrary
	pip install robotframework-requests

	Verify installation
	pip show requests
	pip install robotframework-seleniumlibrary
	pip install robotframework-requests
	
	Alternatively, use the below command to install all the libraries listed in requirements.txt
	pip install -r requirements.txt
	
*** Automation Framework details

	The Robot Automation Framework is created with Page Object Model (POM) design pattern

	The components of the framework are:
	|_ Page Objects - locators .py file (contains object locators used for the tests)
	|_ Resources - keyword robot files	(contains keywords and detailed steps that are used in the tests)
	|_ Test cases - test robot files  (contains test cases defined in Gherkin format)

	As all locators are captured on a separate .py file, this would be easy to maintain as any change in the locators can be easily made here

	The test cases are written in Gherkin syntax which is readable and easy to follow, this gives the flexibility to all stakeholders [technical or non-technical] to go through the test scenarios and validations

	The framework is modular and easily extendable, in future as more tests are added
	Grouping of test cases could be done by adding [Tags]
	e.g. [Tag] smoke
	[Tag] regression

	This gives the flexibility to the user to include/exclude different Test suites based on the added Tags

	Also Test Case/Suite Setup and Teardown can be added to perform defined steps before and after the Test cases/Suites

***To execute the tests, download the code from git
	Setup the RobotAutomation > Trivago project on Pycharm or any other IDE
	Ensure python interpreter is set correctly in the IDE Settings

	From the IDE terminal, run the below command to execute the test cases in Test.robot file

	robot --outputdir .\Trivago\Results .\Trivago\TestCases\Test.robot

	Alternatively, run.bat file can also be run to execute the tests
	Note: Before running, please change the project directory path in the run.bat based on where you have placed the project on your system
	
*** Execution Results
	Please see the RobotAutomation > Trivago > Results directory to see the test execution results





