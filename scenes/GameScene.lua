--##############################  Main Code Begin  ##############################--

local commonConfig = require("CommonSettings")
local physics = require("physics")



physics.setDrawMode("hybrid")
physics.start()
physics.setGravity( 0, 1 )


local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작

	local bg = display.newRect( 0, 0, display.actualContentWidth, display.actualContentHeight)
	bg:setFillColor(1, 1, 1, 1)



	--createBg(sceneGroup)





	
    local bottomImg = "images/bottom_outline.png"
   	
   	
   	local bot = display.newImage(bottomImg)
   
    local scaleFactor = __appContentWidth__ / bot.width

	bot.width, bot.height = bot.width * scaleFactor, bot.height * scaleFactor
	
    
    bot.y = __appContentHeight__ - bot.height
    --local bottomOutline = graphics.newOutline(2,bottomImg)

    physics.addBody(bot,"static",{friction = 10 , density=10, filter={categoryBits=1, maskBits=6}})
   
   	local wallT = display.newRect(0,-9,__appContentWidth__,10)
   	wallT:setFillColor(1,0,0,1)
   	physics.addBody(wallT,"static",{friction = 10 , density=10})
    
	



	local options =
	{

		frames = 
		{

			{

				x = 0,
				y = 0,
				width = 80,
				height = 80

			},

			{	
				x = 80,
				y = 0,
				width = 80,
				height = 80

			}

		}

	}	

	local sheet = graphics.newImageSheet("images/mohican_walk.png",options)
	local sheet2 = graphics.newImageSheet("images/ice_attack.png",options)

	--local frame2 = display.newImage(sheet,2)

	local sequenceData = {
    	name="walking",
    	start = 1,
    	count = 2,
    	--frames= { 1, 2 }, -- frame indexes of animation, in image sheet
    	time = 500, -- Optional. In ms. If not supplied, then sprite is frame-based.
    	loopCount = 0 -- Optional. Default is 0.
	}


	local character = display.newSprite( sheet, sequenceData )
	local ice = display.newSprite(sheet2, sequenceData)
	local ice2 = display.newSprite(sheet2, sequenceData)

	character:play()
	ice:play()

	local framenum = 1

	local character_out = graphics.newOutline(2, sheet, framenum)	
	local character_out2 = graphics.newOutline(2, sheet2, 2)	

	character.x = __appContentWidth__*0.9
	character.y = __appContentHeight__*0.5

	ice.x = __appContentWidth__*0.1
	ice.y = __appContentHeight__*0.5

	ice.x = __appContentWidth__*0.1
	ice.y = __appContentHeight__*0.2

	physics.addBody(character,"dynamic",{radius = 35, filter={categoryBits=2, maskBits=5}})
	physics.addBody(ice,"dynamic",{radius = 35, filter={categoryBits=4, maskBits=3}})
	physics.addBody(ice2,"dynamic",{radius = 35, filter={categoryBits=4, maskBits=3}})

	character:applyForce(-1,-1,character.x,character.y)
	ice:applyForce(1.5,1.5,ice.x,ice.y)
	--character.rotation = 0
	ice.rotation=0
    

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

return scene
--##############################  Main Code End  ##############################--