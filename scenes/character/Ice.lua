local EnterFrameManager = require("EnterFrameManager")
local physics = require("physics")
local Class = {}

Class.create = function (_parent)

	-- local mainG = display.newGroup()
	-- _parent:insert(mainG)

	--local ice = display.newGroup()
	-- mainG:insert(ice)


	local iceSpeed = 1

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

	local sequenceData = {
    	name="walking",
    	start = 1,
    	count = 2,
    	--frames= { 1, 2 }, -- frame indexes of animation, in image sheet
    	time = 500, -- Optional. In ms. If not supplied, then sprite is frame-based.
    	loopCount = 0 -- Optional. Default is 0.
	}


	local sheet = graphics.newImageSheet("images/ice_final.png",options)

	-- local spriteInstance = display.newSprite( sheet, sequenceData )


	-- physics.addBody(spriteInstance,"dynamic",{radius = 35, filter={categoryBits=4, maskBits=3}})

	-- spriteInstance.x , spriteInstance.y = -10,  __appContentHeight__ * 0.65

	-- spriteInstance:play()


	-- local on_EnterFrame = EnterFrameManager.addListener(function (e)
	-- 	spriteInstance.x = spriteInstance.x + iceSpeed


	-- end)

	local ice = display.newSprite(_parent,sheet,sequenceData)
	physics.addBody(ice,"dynamic",{radius = 35, filter={categoryBits=4, maskBits=2}})
	ice.y=__appContentHeight__*0.65
	ice:play()
	local on_EnterFrame = EnterFrameManager.addListener(function (e)
		ice.x = ice.x + iceSpeed


	end)

	ice.dead = false


	ice.destroy = function ()

		print(ice)
		EnterFrameManager.removeListener(on_EnterFrame)

		if ice.dead then
			display.remove(ice)
		end
		-- if ice ~= nil then
		-- 	ice:removeSelf() 
		-- end
		

		-- body
	end

	return ice

end

return Class