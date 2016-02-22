--##############################  Main Code Begin  ##############################--

local commonConfig = require("CommonSettings")
local widget = require("widget")
local EnterFrameManager = require("EnterFrameManager")






local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작

	

	EnterFrameManager.init()
	createBg(sceneGroup)


	


end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )


-- -------------------------------------------------------------------------------



createBg = function (sceneGroup)
	local bg = display.newImage(sceneGroup, "images/bg_ready.png", 0, 0)

	local scaleFactor = __appContentHeight__ / bg.height

	bg.width, bg.height = bg.width * scaleFactor, bg.height * scaleFactor
	bg.x = (__appContentWidth__ * 0.5) - (bg.width * 0.5)

	return bg
end

return scene
--##############################  Main Code End  ##############################--