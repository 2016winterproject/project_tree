--##############################  Main Code Begin  ##############################--

--local commonConfig = require("CommonSettings")
local widget = require("widget")
local EnterFrameManager = require("EnterFrameManager")
local GameConfig = require("GameConfig")
--gameConfig.init()


local createBg, createUi

local tree, leaf, mohican 

tree = GameConfig.getTreelevel()
leaf = GameConfig.getLeaf()
mohican = GameConfig.getMohican()



local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작

	

	EnterFrameManager.init()
	createBg(sceneGroup)

	createUi(sceneGroup)
	


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

createUi = function ( sceneGroup )



	print(tree, leaf, mohican)


	local valkyrie = display.newImage(sceneGroup, "images/valkyrie.png",0,0)

	local scaleFactor = __appContentHeight__ / valkyrie.height

	__setScaleFactor(valkyrie,scaleFactor)

	valkyrie.x = __appContentWidth__ - valkyrie.width

	function on_Valkyrie( e )
		local currScene = composer.getSceneName("current")
		composer.removeScene(currScene)

		local options = {
			effect = "fade",
			time = 300,
	--			params = nil
		}


		composer.gotoScene("scenes.TestScene", options)
	end
	valkyrie:addEventListener("tap", on_Valkyrie)

	local readyLeaf = display.newImage(sceneGroup,"images/leaf.png",0,0)
	__setScaleFactor(readyLeaf, 0.2)
	readyLeaf.x , readyLeaf.y = 0,0

	local numReadyLeaf = display.newText(sceneGroup,tostring(leaf) ,readyLeaf.width,0,0,0,native.systemFontBold,30)
	numReadyLeaf.y =  readyLeaf.height- numReadyLeaf.height
	numReadyLeaf:setFillColor(1,1,1,1)

	local function on_ChangeLeaf(e)
		numReadyLeaf.text = tostring(e.leaf)
	end

	Runtime:addEventListener("changeLeaf",on_ChangeLeaf)




	local viewMohican = display.newImage(sceneGroup,"images/head_mohican.png",0,0)
	__setScaleFactor(viewMohican,0.2)
	viewMohican.x, viewMohican.y = numReadyLeaf.x + 30 , 0

	local numReadyMohican = display.newText(sceneGroup,tostring(mohican),viewMohican.x +viewMohican.width,0,0,0,native.systemFontBold,30)
	numReadyMohican.y = viewMohican.height- numReadyMohican.height
	numReadyMohican:setFillColor(1,1,1,1)

	local function on_ChangeMohican( e )

		numReadyMohican.text = tostring(e.mohican)
		
	end

	Runtime:addEventListener("changeMohican", on_ChangeMohican)

	local viewTree = display.newText(sceneGroup,"Tree Level:",0,0,0,0,native.systemFontBold,30)
	viewTree.x = __appContentWidth__*0.5 - ( viewTree.width* 0.5)
	viewTree:setFillColor(0,1,1,1)

	local numReadyTree = display.newText(sceneGroup,tostring(tree),viewTree.x +viewTree.width + 10 ,0,0,0,native.systemFontBold,30)
	numReadyTree:setFillColor(1,1,1,1)

	local function on_ChangeTree( e )
		numReadyTree.text  =tostring(e.treelevel)
		if e.treelevel == 10 then
			local currScene = composer.getSceneName("current")
			composer.removeScene(currScene)

			local options = {
				effect = "fade",
				time = 300,
	--			params = nil
			}


			composer.gotoScene("scenes.GameClear", options)
		end 
	end
	Runtime:addEventListener("changeTreelevel",on_ChangeTree)

	local buyMohican = display.newImage(sceneGroup,"images/plus_mohican.png",0,0)
	__setScaleFactor(buyMohican,0.4)
	buyMohican.x , buyMohican.y = __appContentWidth__*0.2, __appContentHeight__*0.5 - (buyMohican.height*0.5)

	local function on_BuyMohican( e )

		if( leaf >0) then
			leaf = leaf - 1
			GameConfig.setLeaf(leaf)

			mohican = mohican+1
			GameConfig.setMohican(mohican)

		end		
	end
	buyMohican:addEventListener("tap",on_BuyMohican)

	local buyTree = display.newImage(sceneGroup,"images/plus_tree.png",0,0)
	__setScaleFactor(buyTree,0.3)
	buyTree.x , buyTree.y = __appContentWidth__*0.4, __appContentHeight__*0.5 - (buyTree.height*0.5)

	local function on_BuyTree( e )

		if(leaf > 10)then
			leaf = leaf -10

			GameConfig.setLeaf(leaf)
			tree= tree +1
			GameConfig.setTreelevel(tree)
		end
	end
	buyTree:addEventListener("tap",on_BuyTree)



end


return scene
--##############################  Main Code End  ##############################--