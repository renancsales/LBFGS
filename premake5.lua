workspace "LBFGS"
	architecture "x64"
	startproject "LBFGS"
	
	configurations
	{
		"Debug",
		"Release",
		"Dist"
	}

outputdir = "%{cfg.buildcfg}-%{cfg.system}-%{cfg.architecture}"

-- Include directories relative to root folder (sol. directory)
IncludeDir = {}
IncludeDir["liblbfgs"] = "LBFGS/vendor/liblbfgs/include"

-- Add the premake file from liblbfgs to this premake file
include "LBFGS/vendor/liblbfgs"
			
project "LBFGS"
	location "LBFGS"
	kind "ConsoleApp"
	language "C++"
	cppdialect "C++17"
	staticruntime "on"

	targetdir ("bin/" .. outputdir .. "/%{prj.name}")
	objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

	files
	{
		"%{prj.name}/src/**.h",
		"%{prj.name}/src/**.cpp"
	}

	includedirs
	{
		"LBFGS/src",
		"LBFGS/vendor",
		"%{IncludeDir.liblbfgs}",
	}

	links
	{
		"liblbfgs"
	}

	-- Filter: Configurations only applied to specific platforms
	filter "system:windows"
		systemversion "latest"


	filter "configurations:Debug"
		runtime "Debug"
		symbols "on"

	filter "configurations:Release"
		runtime "Release"
		optimize "on"

	filter "configurations:Dist"
		runtime "Release"
		optimize "on"