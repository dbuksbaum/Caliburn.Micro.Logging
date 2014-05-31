Caliburn.Micro.Logging
======================
                       
Source code to the [Caliburn.Micro.Logging nuget package](http://nuget.org/List/Packages/Caliburn.Micro.Logging).
See [Re-Introducing Caliburn.Micro.Logging blog post](http://buksbaum.us/2014/05/21/re-introducing-caliburn-micro-logging/)

__Version 2.0.3 - 2014/05/31__

  * Upgraded Caliburn.Micro 2.0.0-beta2 to Caliburn.Micro.Core 2.0.0


__Version 2.0.2-beta2 - 2014/05/21__

  * Upgraded solution / project files to Visual Studio 2013 Update 2
  * Upgraded Caliburn.Micro 1.4 to Caliburn.Micro.Core 2.0.0-beta2
  * Converted Caliburn.Micro.Logging to a portable class library (.NET4.5, Win8, WPA8.1 WPSL8)
  * Dropped support for TraceLogger since it is not supported in a PCL
  * Dropped SilverLight 4/5 and Windows Phone 7.1 support
  * Added a key for strong name support for all assemblies
  * Added support for Symbols

__Version 1.5.0 - 2012/12/15__

 	* Upgraded solution / project files to VS2012
 	* Upgraded Caliburn.Micro to 1.4
 	* Added support for Windows Phone 8
 	* Split Caliburn.Micro.Logging, Caliburn.Micro.Logging.NLog, & Caliburn.Micro.Logging.log4net into their own solutions
 	* Changed NuGet packaging to be a project in the solutions
 	* Minor changes to the physical directory structure

__Version 1.3.0 - 2012/05/19__

	* Minor project file updates to support TeamCity CI
  * Cleaned up AssemblyInfo
  * Modified .gitignore to support NuGet PackageRestore
  * Deprecated psake build scripts. These will be removed in the next release.
  * Updated Caliburn.Micro to 1.3.1
  * Added support for SilverLight 4
  * Added support for SilverLight 5
  * Added support for Windows Phone 7.1
  
__Version 1.2.1 - 2011/08/12__
	
  * Upgraded .NET 4 and Silverlight 4 versions to Caliburn.Micro 1.2.0
  * Created a psake build script to be used in Continious Integration
  * Moved samples into their own solution
  
__Version 1.2 - 2011/07/05__
  
  * Added GlobalAssemblyInfo.cs and VersionAssemblyInfo.cs to contain common AssemblyInfo attributes
  * Removed DebugLogger.cs from the Caliburn.Micro.Logging assembly
  * Added DebugLogger.cs to the NuGet content directory
  * Support for .NET 4.0 and NET 4.0 Client Profile

Caliburn.Micro.Logging.log4net
==============================
__Version 2.0.2-beta2 - 2014/05/21__

  * Upgraded solution / project files to Visual Studio 2013 Update 2
  * Upgraded Caliburn.Micro 1.4 to Caliburn.Micro.Core 2.0.0-beta2
  * Upgraded log4net to 1.2.13.0
  * Using portable class library version of Caliburn.Micro.Logging
  * Added a key for strong name support for all assemblies
  * Added support for Symbols

__Version 1.5.0 - 2012/12/15__
  
  * Upgraded solution / project files to VS2012
  * Upgraded Caliburn.Micro to 1.4
  * Added support for Windows Phone 8
  * Split Caliburn.Micro.Logging, Caliburn.Micro.Logging.NLog, & Caliburn.Micro.Logging.log4net into their own solutions
  * Changed NuGet packaging to be a project in the solutions
  * Minor changes to the physical directory structure
  
__Version 1.3.0 - 2012/05/19__
	
  * Minor project file updates to support TeamCity CI
	* Cleaned up AssemblyInfo
	* Updated to log4net 2.0.0 / 1.2.11 - don't ask me why log4net needs 2 version numbers
	* Updated Caliburn.Micro to 1.3.1
	* Changed reference from NuGet package for Caliburn.Micro.Logging to the project reference
	* Added support for .NET 4 Client Profile

__Version 1.2.1 - 2011/08/11__
	
  * Upgraded .NET 4 and Silverlight 4 versions to Caliburn.Micro 1.2.0
	* Created a psake build script to be used in Continious Integration

__Version 1.0 - 2011/07/06__
  
  * Support for .NET 4.0 only

Caliburn.Micro.Logging.NLog
===========================
__Version 2.0.2-beta2 - 2014/05/21__

  * Upgraded solution / project files to Visual Studio 2013 Update 2
  * Upgraded Caliburn.Micro 1.4 to Caliburn.Micro.Core 2.0.0-beta2
  * Upgraded NLog to 2.1.0
  * Using portable class library version of Caliburn.Micro.Logging
  * Added a key for strong name support for all assemblies
  * Added support for Symbols

__Version 1.5.0 - 2012/12/15__
  
 	* Upgraded solution / project files to VS2012
 	* Upgraded Caliburn.Micro to 1.4
 	* Added support for Windows Phone 8
 	* Split Caliburn.Micro.Logging, Caliburn.Micro.Logging.NLog, & Caliburn.Micro.Logging.log4net into their own solutions
  * Changed NuGet packaging to be a project in the solutions
  * Minor changes to the physical directory structure
  
__Version 1.3.0 - 2012/05/19__
	
  * Minor project file updates to support TeamCity CI
	* Cleaned up AssemblyInfo
	* Updated Caliburn.Micro to 1.3.1
	* Updated NLog to 2.0.0.2000 from 2.0.0.1904
	* Changed reference from NuGet package for Caliburn.Micro.Logging to the project reference
	* Added support for SilverLight 4
	* Added support for Windows Phone 7.1

__Version 1.2.1 - 2011/08/11__
	
  * Upgraded .NET 4 and Silverlight 4 versions to Caliburn.Micro 1.2.0
	* Created a psake build script to be used in Continious Integration

__Version 1.0 - 2011/07/06__

  * Support for .NET 4.0 and .NET 4.0 Client Profile
