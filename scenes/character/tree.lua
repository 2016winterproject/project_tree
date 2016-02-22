local EnterFrameManager = require("EnterFrameManager")
local physics = require("physics")
local GameConfig = require("GameConfig")
local Class = {}



Class.create = function (_parent)

	local tree = display.newGroup()
	_parent:insert(tree)

	
	local treeLevel = GameConfig.getTreelevel()

	local treeImage = "images/tree.png"
	local treeOutLine = graphics.newOutline(2,treeImage)

	local tr = display.newImage(tree, treeImage)
	scaleFactor =  __appContentHeight__ / tr.height
	tr.width, tr.height = tr.width * scaleFactor, tr.height * scaleFactor
	tr.anchorX , tr.anchorY = 0,0
	--tr.x = (__appContentWidth__ * 0.5) - (tr.width * 0.5)

	
	local colBox = display.newRect(tree,__appContentWidth__*0.8, tr.y, tr.width*0.2, tr.height)
	colBox.myname = "tree"

	
	colBox.hp = 90 + treeLevel*10

	colBox.anchorX, colBox.anchorY =0,0
	colBox:setFillColor(0,0,0,0)
	physics.addBody(colBox,"static",{density=10,filter={categoryBits=2, maskBits=4}})
	--__setScaleFactor(tree)
	--tree.anchorX, tree.anchorY = 0.5,1



	--physics.addBody(tree,"static",{radius=40, density=10})

	



	return tree

end



return Class