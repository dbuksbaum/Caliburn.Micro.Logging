@echo off

:: Set repository info
set key="54ba607a-b16c-4bd8-bbd4-703331dac98d"
set url="http://nuget.org/"

:: Make sure the nuget executable is writable
attrib -R NuGet.exe

:: Make sure the nupkg files are writeable and create backup
IF EXIST *.nupkg (
	echo.
	echo Creating backup...
	forfiles /m *.nupkg /c "cmd /c attrib -R @File"
	forfiles /m *.nupkg /c "cmd /c move /Y @File @File.bak"
)

echo.
echo Updating NuGet...
cmd /c nuget.exe update -Self

echo.
echo Creating package...
echo nuget.exe pack Caliburn.Micro.Logging.nuspec -Verbose -Version %1
nuget.exe pack Caliburn.Micro.Logging.nuspec -Verbose -Version %1

:: Check if package should be published
IF /I "%2"=="Publish" goto :publish
goto :eof

:publish
 IF EXIST *.nupkg (
 	echo.
 	echo Publishing package...
 	echo API Key: %key%
 	echo NuGet Url: %url%
 	forfiles /m *.nupkg /c "cmd /c nuget.exe push @File %key% -Source %url%"
	goto :eof
)

:eof