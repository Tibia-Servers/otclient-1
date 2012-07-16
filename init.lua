-- this is the first file executed when the application starts
-- we have to load the first modules form here

-- setup logger
g_logger.setLogFile(g_resources.getWorkDir() .. g_app.getCompactName() .. ".log")

-- print first terminal message
g_logger.info(g_app.getName() .. ' ' .. g_app.getVersion() .. ' rev ' .. g_app.getBuildRevision() .. ' (' .. g_app.getBuildCommit() .. ') built on ' .. g_app.getBuildDate() .. ' for arch ' .. g_app.getBuildArch())

--add base folder to search path
g_resources.addSearchPath(g_resources.getWorkDir())

-- add modules directory to the search path
if not g_resources.addSearchPath(g_resources.getWorkDir() .. "modules", true) then
  g_logger.fatal("Unable to add modules directory to the search path.")
end

-- try to add mods path too
g_resources.addSearchPath(g_resources.getWorkDir() .. "mods", true)

-- setup directory for saving configurations
g_resources.setupUserWriteDir(g_app.getCompactName())

-- search all packages
g_resources.searchAndAddPackages('/', '.otpkg', true)

-- load configurations
g_configs.load("/config.otml")

g_modules.discoverModules()

-- core modules 0-99
g_modules.autoLoadModules(99)
g_modules.ensureModuleLoaded("corelib")

-- client modules 100-499
g_modules.autoLoadModules(499)
g_modules.ensureModuleLoaded("client")

-- game modules 500-999
g_modules.autoLoadModules(999)
g_modules.ensureModuleLoaded("game")

-- mods 1000-9999
g_modules.autoLoadModules(9999)

if g_resources.fileExists("/otclientrc.lua") then
  dofile("/otclientrc.lua")
end

