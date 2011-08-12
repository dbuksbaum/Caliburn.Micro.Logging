properties {
  $base_dir  = resolve-path .
  $build_dir = "$base_dir\build"
  $buildartifacts_dir = "$build_dir"
 	$config = "Debug"
#	$lib_dir = "$base_dir\SharedLibs"
	$nuget_packages_dir = "$base_dir\packages"
	$sln_base = "Caliburn.Micro.Logging"
  $sln_file = "$base_dir\$sln_base.sln"
  $target = "Rebuild"
  $verbosity = "m"
  $version = "1.2.1"
#  $samples_dir = "$base_dir\samples"
#  $samples_sln_file = "$samples_dir\Caliburn.Micro.Autofac.Samples.sln"
  $src_dir = "$base_dir\src"
  $tools_dir = "$base_dir\tools"
  $release_dir = "$base_dir\release"
#  $uploader = "..\Uploader\S3Uploader.exe"
  $upload_category = "Caliburn.Micro.Logging"
	$v4_net_version = (ls "$env:windir\Microsoft.NET\Framework\v4.0*").Name
	$project_base = "$src_dir\$sln_base"

	$project_dlls = @( "Caliburn.Micro.Logging.dll" );
	$project_nlog_dlls = @( "Caliburn.Micro.Logging.NLog.dll" );
	$project_log4net_dlls = @( "Caliburn.Micro.Logging.log4net.dll" );

	$platforms = @( "NET4", "NET4CP" );
	$build_dirs = @( $release_dir, $build_dir, "$build_dir\content", "$build_dir\content\Caliburn", `
		"$build_dir\content\Caliburn\Micro", "$build_dir\content\Caliburn\Micro\Logging" );
	$nupack_dirs = @(	"NuPack", "NuPack\content", "NuPack\content\Caliburn", "NuPack\content\Caliburn\Micro", `
		"NuPack\content\Caliburn\Micro\Logging", "NuPack\lib", "NuPack\lib\net40", "NuPack\lib\net40-client" );
}

include .\psake_ext.ps1

FormatTaskName (("-"*25) + "[{0}]" + ("-"*25))

task default -depends PublishToNuget

task PublishToNuget -depends CreateNugetPackage {
  $accessPath = "$base_dir\..\Nuget-Access-Key.txt"

  if( $global:uploadCategory -ne $upload_category ) # we only publish the stable version out
  {
    Write-Host "Not a stable build, skipping nuget package publishing"
    return
  }
  
  if( $config -ne "Release" )
  {
  	Write-Host "Not a release build, skipping nuget package publishing"
  	return
  }

  if ( (Test-Path $accessPath) -eq $false )
  {
    return;
  }
  
  $accessKey = Get-Content $accessPath
  $accessKey = $accessKey.Trim()
  

	&"nuget" push -source http://packages.nuget.org/v1/ "$sln_base.$version.nupkg" $accessKey
	&"nuget" push -source http://packages.nuget.org/v1/ "$sln_base.NLog.$version.nupkg" $accessKey
	&"nuget" push -source http://packages.nuget.org/v1/ "$sln_base.log4net.$version.nupkg" $accessKey
}

task CreateNugetPackage -depends Release {
  if( $global:uploadCategory -ne $upload_category) # we only publish the stable version out
  {
    Write-Host "Not a stable build, skipping nuget package creation"
    return
  }
  
  if( $config -ne "Release" )
  {
  	Write-Host "Not a release build, skipping nuget package creation"
  	return
  }
  
  del $base_dir\*.nupkg
	remove-item $build_dir\Nupack -force -recurse -erroraction silentlycontinue

  foreach($nupack_dir in $nupack_dirs) {
		new-item "$build_dir\$nupack_dir" -itemType directory -ErrorAction SilentlyContinue
	}

	cp $build_dir\NET4\*.dll $build_dir\Nupack\lib\net40
	cp $build_dir\NET4CP\*.dll $build_dir\Nupack\lib\net40-client
	cp $build_dir\content\Caliburn\Micro\Logging\*.* $build_dir\Nupack\content\Caliburn\Micro\Logging
	
	########### Caliburn.Micro.Logging.nupkg
  $nupack = [xml](get-content $base_dir\$sln_base.nuspec)
	
  $nupack.package.metadata.version = "$version"

  $writerSettings = new-object System.Xml.XmlWriterSettings
  $writerSettings.OmitXmlDeclaration = $true
  $writerSettings.NewLineOnAttributes = $true
  $writerSettings.Indent = $true
	
  $writer = [System.Xml.XmlWriter]::Create("$build_dir\Nupack\$sln_base.nuspec", $writerSettings)
	
  $nupack.WriteTo($writer)
  $writer.Flush()
  $writer.Close()

  #Write-Host "nuget pack $build_dir\NuPack\$sln_base.nuspec"
  &"nuget" pack $build_dir\NuPack\$sln_base.nuspec

	########### Caliburn.Micro.Logging.NLog.nupkg
  $nupack = [xml](get-content $base_dir\$sln_base.NLog.nuspec)
	
  $nupack.package.metadata.version = "$version"
	foreach($node in $nupack.package.metadata.dependencies.dependency) {
		if($node.id -eq $sln_base){
			$node.version = $version
		}
 	}

  $writerSettings = new-object System.Xml.XmlWriterSettings
  $writerSettings.OmitXmlDeclaration = $true
  $writerSettings.NewLineOnAttributes = $true
  $writerSettings.Indent = $true
	
  $writer = [System.Xml.XmlWriter]::Create("$build_dir\Nupack\$sln_base.NLog.nuspec", $writerSettings)
	
  $nupack.WriteTo($writer)
  $writer.Flush()
  $writer.Close()

  #Write-Host "nuget pack $build_dir\NuPack\$sln_base.NLog.nuspec"
  &"nuget" pack $build_dir\NuPack\$sln_base.NLog.nuspec

	########### Caliburn.Micro.Logging.log4net.nupkg
  $nupack = [xml](get-content $base_dir\$sln_base.log4net.nuspec)
	
  $nupack.package.metadata.version = "$version"
	foreach($node in $nupack.package.metadata.dependencies.dependency) {
		if($node.id -eq $sln_base){
			$node.version = $version
		}
 	}
  
  $writerSettings = new-object System.Xml.XmlWriterSettings
  $writerSettings.OmitXmlDeclaration = $true
  $writerSettings.NewLineOnAttributes = $true
  $writerSettings.Indent = $true
	
  $writer = [System.Xml.XmlWriter]::Create("$build_dir\Nupack\$sln_base.log4net.nuspec", $writerSettings)
	
  $nupack.WriteTo($writer)
  $writer.Flush()
  $writer.Close()

  #Write-Host "nuget pack $build_dir\NuPack\$sln_base.log4net.nuspec"
  &"nuget" pack $build_dir\NuPack\$sln_base.log4net.nuspec
}

task Release -depends CopyBuildFiles {
	$global:uploadCategory = $upload_category
}

task Samples -depends CopyBuildFiles {
	exec { &"c:\Windows\Microsoft.NET\Framework\$v4_net_version\MSBuild.exe" ""$samples_sln_file"" /v:$verbosity /t:$target /p:Configuration=$config }
}

task Test -depends CopyBuildFiles {
  $old = pwd
  cd $build_dir
  Write-Host $test_prjs
  foreach($test_prj in $test_prjs) {
    Write-Host "Testing $build_dir\$test_prj"
  }
  cd $old
}

task CopyBuildFiles -depends Compile {

  foreach($platform in $platforms) {
  	if(Test-Path "$project_base-$platform")
  	{	#	copy base project
		  foreach($project_dll in $project_dlls) {
  			cp "$project_base-$platform\bin\$config\$project_dll" $build_dir\$platform
			}
		}
		if(Test-Path "$project_base.NLog-$platform")
		{	#	copy nlog
		  foreach($project_dll in $project_nlog_dlls) {
				cp "$project_base.NLog-$platform\bin\$config\$project_dll" $build_dir\$platform
			}
		}
  	if(Test-Path "$project_base.log4net-$platform")
  	{	#	copy log4net
		  foreach($project_dll in $project_log4net_dlls) {
				cp "$project_base.log4net-$platform\bin\$config\$project_dll" $build_dir\$platform
			}
		}
 	}
 	
 	# copy content
	cp "$project_base-NET4\DebugLogger.cs" $build_dir\content\Caliburn\Micro\Logging
}

#-PreAction {"*** Pre-Test ***"} -PostAction {"*** Post-Test ***"}
task Compile -depends Init -Action { 
	exec { &"c:\Windows\Microsoft.NET\Framework\$v4_net_version\MSBuild.exe" ""$slnFile"" /v:$verbosity /t:$target /p:Configuration=$config }
} 

task Init -depends SetVsPaths, Verify40, Clean, DisplayConfig {

  if($env:BUILD_NUMBER -ne $null) {
    $env:buildlabel  = $env:BUILD_NUMBER
	}
	
	if($env:buildlabel -eq $null) {
		$env:buildlabel = "9999"
	}

	Write-Host "Build Number $env:BUILD_NUMBER"
	
	$projectFiles = ls -path $base_dir -include *.csproj -recurse 
# | 
#				Where { $_ -notmatch [regex]::Escape($lib_dir) } | 
				Where { $_ -notmatch [regex]::Escape($tools_dir) }

	# add list of assemblies that are not CLS compliant here
	$notclsCompliant = @( )
	
	foreach($projectFile in $projectFiles) {
		$projectDir = [System.IO.Path]::GetDirectoryName($projectFile)
		$projectName = [System.IO.Path]::GetFileName($projectDir)
		
		$asmInfo = [System.IO.Path]::Combine($projectDir, [System.IO.Path]::Combine("Properties", "AssemblyInfo.cs"))
		
		$clsComliant = "true"
		
		if([System.Array]::IndexOf($notclsCompliant, $projectName) -ne -1) {
      $clsComliant = "false"
		}
		
		Generate-Assembly-Info `
			-file $asmInfo `
			-title "$projectName $version.0" `
			-description "Logging for Caliburn.Micro" `
			-company "David Buksbaum - http://buksbaum.us" `
			-product "Caliburn.Micro.Logging $version.0" `
			-version "$version.0" `
			-fileversion "1.0.0.$env:buildlabel" `
			-copyright "Copyright © David Buksbaum 2009-2011" `
			-clsCompliant $clsComliant
	}
	
	foreach($new_dir in $build_dirs) {
		new-item $new_dir -itemType directory -ErrorAction SilentlyContinue
	}
	
  foreach($platform in $platforms) {
		new-item "$build_dir\$platform" -itemType directory -ErrorAction SilentlyContinue
		new-item "$release_dir\$platform" -itemType directory -ErrorAction SilentlyContinue
  }
}

task SetVsPaths {
#	VsVars32 "10.0"
}

task Verify40 {
	if( (ls "$env:windir\Microsoft.NET\Framework\v4.0*") -eq $null ) {
		throw "Building Caliburn.Micro.Logging requires .NET 4.0, which doesn't appear to be installed on this machine"
	}
}

task Clean {
  remove-item -force -recurse $buildartifacts_dir -ErrorAction SilentlyContinue
  remove-item -force -recurse $release_dir -ErrorAction SilentlyContinue
}

task DisplayConfig {
	Write-Host "base_dir = $base_dir"
  Write-Host "target = $target"
	Write-Host "config = $config"
  Write-Host "verbosity = $verbosity"
  Write-Host "sln_file = $sln_file"
  Write-Host "samples_sln_file = $samples_sln_file"
  Write-Host "version = $version"
}
