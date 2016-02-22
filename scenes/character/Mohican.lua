local EnterFrameManager = require("EnterFrameManager")
local physics = require("physics")
local Class = {}

Class.create = function (_parent)

	-- local mainG = display.newGroup()
	-- _parent:insert(mainG)

	-- local mohican = display.newGroup()
	

	

	local mohicanSpeed = 1

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


	local sheet = graphics.newImageSheet("images/mohican_final.png",options)

	local spriteInstance = display.newSprite( _parent, sheet, sequenceData )


	physics.addBody(spriteInstance,"dynamic",{radius = 35, filter={categoryBits=2, maskBits=4}})

	spriteInstance.x , spriteInstance.y = __appContentWidth__,  __appContentHeight__ * 0.65

	spriteInstance:play()

	-- mainG:insert(mohican)

	local on_EnterFrame = EnterFrameManager.addListener(function (e)
		spriteInstance.x = spriteInstance.x-mohicanSpeed
		


	end)

	spriteInstance.dead = false

	spriteInstance.destroy = function ()

		EnterFrameManager.removeListener(on_EnterFrame)

		if spriteInstance.dead then

			display.remove(spriteInstance)
		end
		-- body
	end

	return spriteInstance

end

return Class