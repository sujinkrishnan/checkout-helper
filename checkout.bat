@echo off


SET moduleName=%1
SET branchName=%2
SET isBuild=%3

REM Add your workspace location here-
SET workspaceLocation="D:\Workspace\Telenet GIT workspace\Tina Workspace"

REM -- Add your git URL here- in format <myrepo URL>/%moduleName%.git
SET gitURL=https://github.com/sujinkrishnan/%moduleName%.git






if [%moduleName%]==[] (
	echo "Module Name not specified"
	exit /b
	)
	
if [%branchName%]==[] (
	echo "Branch not specified"
	exit /b
	)


echo ------------------------------------------------------------------------------
echo Cloning %moduleName% git url %gitURL%
echo ------------------------------------------------------------------------------

D:
cd %workspaceLocation%
git clone %gitURL%
SET gitExitCode=%ERRORLEVEL%
echo Git Exit Code %gitExitCode%
	
IF %gitExitCode%==0 (
	echo ------------------------------------------------------------------------------
	echo Checking out %branchName%
	echo ------------------------------------------------------------------------------
	cd %moduleName%
	git checkout %branchName%
	
	IF NOT [%isBuild%]==[] (
	
		IF "%isBuild%"=="1" (
			echo ------------------------------------------------------------------------------
				echo Going to build module %moduleName%
				echo ------------------------------------------------------------------------------
			mvn clean install -e
		)
	)
)


IF %gitExitCode%==128 (

  if exist %moduleName%\ (
	echo ------------------------------------------------------------------------------
	echo Module aready exist checking out %branchName%
	echo ------------------------------------------------------------------------------
	cd %moduleName%
	git checkout %branchName%
	
	IF NOT [%isBuild%]==[] (
	
		IF "%isBuild%"=="1" (
			echo ------------------------------------------------------------------------------
				echo Going to build module %moduleName%
				echo ------------------------------------------------------------------------------
			mvn clean install -e
		)
	)
  )
)

cmd /k