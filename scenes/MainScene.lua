--##############################  Main Code Begin  ##############################--

local commonConfig = require("CommonSettings")
local widget = require("widget")
local gameConfig = require("GameConfig")





local composer = require( "composer" )
local scene = composer.newScene()
local createUi, createBg

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작

	

	createBg(sceneGroup)


	createUi(sceneGroup)
	



end


-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )


-- -------------------------------------------------------------------------------



createBg = function (sceneGroup)
	local bg = display.newImage(sceneGroup, "images/title.png", 0, 0)

	local scaleFactor = __appContentHeight__ / bg.height

	bg.width, bg.height = bg.width * scaleFactor, bg.height * scaleFactor
	bg.x = (__appContentWidth__ * 0.5) - (bg.width * 0.5)

	return bg
end

createUi = function( sceneGroup)

	local options = {
			effect = "fade",
			time = 300,
	--			params = nil
	}

	local buttonStart = display.newImage(sceneGroup,"images/start_button.png",0,0)	
	__setScaleFactor(buttonStart,0.3)
	buttonStart.x, buttonStart.y = __appContentWidth__*0.5 - (buttonStart.width*0.5), __appContentHeight__ *0.7

	-- local buttonStart = widget.newButton({
	-- 	left= 50,
	-- 	top = 50,
	-- 	id = "start",
	-- 	label = "start",
	-- 	onEvent=on_ButtonStart
	-- 	})

	local function on_ButtonStart(e)

		--======== 씬 이동(현재 씬 제거) Begin ========--
		local currScene = composer.getSceneName("current")
		composer.removeScene(currScene)

		local options = {
			effect = "fade",
			time = 300,
	--			params = nil
		}


		composer.gotoScene("scenes.ReadyScene", options)
		--======== 씬 이동(현재 씬 제거) End ========--
	end
	buttonStart:addEventListener("tap", on_ButtonStart)


	-- local buttonTest = widget.newButton({sceneGroup,
	-- 	left = 50,
	-- 	top = 100,
	-- 	id = "test",
	-- 	label ="test",
	-- 	onEvent = on_ButtonTest
	-- 	})

	-- local buttonEnd = display.newImage(sceneGroup, "images/end_button.png",0,0)
	-- __setScaleFactor(buttonEnd,0.3)
	-- buttonEnd.x , buttonEnd.y = __appContentWidth__*0.5-(buttonEnd.width*0.5) , __appContentHeight__*0.7

	-- local function on_ButtonEnd(e)
		
	-- 	local currScene = composer.getSceneName("current")
	-- 	composer.removeScene(currScene)
	-- 	composer.gotoScene("scenes.TestScene",options)
		

	-- 	-- body
	-- end

	-- buttonEnd:addEventListener("tap",on_ButtonEnd)
end
return scene
--##############################  Main Code End  ##############################--