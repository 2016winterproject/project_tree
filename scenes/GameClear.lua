--##############################  Main Code Begin  ##############################--

local commonConfig = require("CommonSettings")
local physics = require("physics")




local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작

	local bg = display.newRect(sceneGroup, 0, 0, display.actualContentWidth, display.actualContentHeight)
	bg:setFillColor(1, 1, 1, 1)

	local clearText = display.newText(sceneGroup,"Congratulation!",__appContentWidth__*0.5,__appContentHeight__*0.5,0,0,native.systemFontBold,30)



	--createBg(sceneGroup)





	
  

end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

-- -------------------------------------------------------------------------------



return scene
--##############################  Main Code End  ##############################--