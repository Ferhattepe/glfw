project "GLFW"
    kind "StaticLib"
    language "C"

    targetdir ("bin/" .. outputdir .. "/%{prj.name}")
    objdir ("bin-int/" .. outputdir .. "/%{prj.name}")

    files
    {
        "include/GLFW/glfw3.h",
        "include/GLFW/glfw3native.h"
        "src/glfw_config.h",
        "src/context.c",
        "src/init.c",
        "src/input.c",
        "src/monitor.c",
        "src/vulkan.c",
        "src/window.c"
    }

    filter "system:windows"
        buildoptions {"-std=c11","-lgdi32"}
        systemversion "lastest"
        staticruntine "on"

        files
        {
            "src/win32_init.c",
            "src/win32_joystick.c",
            "src/win32_monitor.c",
            "src/win32_time.c",
            "src/win32_thread.c",
            "src/win32_window.c",
            "src/wg1_context.c",
            "src/eg1_context.c",
            "src/osmesa_context.c"
        }

        defines
        {
            "_GLFW_WIN32",
            "_CRT_SECURE_NO_WARNINGS"
        }

    filter "configurations:Debug"
        runtime "Debug"
        symbols "on"

    filter { "system:windows", "configurations:Debug-AS" }
        runtine "Debug"
        symbols "on"
        sanitize { "Address" }
        flags {"NoRuntimeChecks", "NoIncrementalLink"}

    filter "configurations:Release"
        runtine "Release"
        optimize "speed"

filter "configurations:Dist"
        runtime "Release"
        optimize "speed"
        symbols "off"
