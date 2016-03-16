--##############################  Main Code Begin  ##############################--

--local commonConfig = require("CommonSettings")
local Mohican = require("scenes.character.Mohican")
local Ice = require("scenes.character.Ice")
local tree = require("scenes.character.tree")
local physics = require("physics")
local GameConfig = require("GameConfig")
local EnterFrameManager = require("EnterFrameManager")
--GameConfig.init()
local createBg, createUi, createMohican, createEnemy, gameOver , stageClear
GameConfig.setScore(0)
local level = GameConfig.getStagelevel()
local numMohican = GameConfig.getMohican()
local numEnemy = level*level
local deadEnemy = 0 
local hp_tree=90+GameConfig.getTreelevel()*10

--physics.setDrawMode("hybrid")
physics.start()
physics.setGravity( 0, 0 )


local composer = require( "composer" )
local scene = composer.newScene()

-- "scene:create()"
function scene:create( event )
	local sceneGroup = self.view

	-- 여기서부터 시작


	createBg(sceneGroup)

	
	
	
	


	
	local tr = tree.create(sceneGroup)

	createUi(sceneGroup)

	
	

	



	tr.collision = on_Collision
	tr:addEventListener("collision",tr)

	createEnemy(sceneGroup)
	


end

-- -------------------------------------------------------------------------------

-- Listener setup
scene:addEventListener( "create", scene )

-- -------------------------------------------------------------------------------

createBg = function (sceneGroup)
	local bg = display.newImage(sceneGroup, "images/bg_battle.png", 0, 0)

	local scaleFactor = __appContentHeight__ / bg.height

	bg.width, bg.height = bg.width * scaleFactor, bg.height * scaleFactor
	bg.x = (__appContentWidth__ * 0.5) - (bg.width * 0.5)

	return bg
end

createUi = function(sceneGroup)

	local btn_mohican = display.newImage(sceneGroup,"images/head_mohican.png")
	__setScaleFactor(btn_mohican,0.2)

	btn_mohican.x, btn_mohican.y = __appContentWidth__*0.2, 0

	local function on_ButtonMohican(e)

		if( numMohican > 0) then
			createMohican(sceneGroup)
			numMohican = numMohican-1
			GameConfig.setMohican(numMohican)	
		end
		
	end
	btn_mohican:addEventListener("tap", on_ButtonMohican)

	local numMohicanTxt = display.newText(sceneGroup,tostring(numMohican),btn_mohican.width+btn_mohican.x+10,0,0,0,native.systemFontBold,21)
	--numMohicanTxt.y = btn_mohican.height *0.5 
	numMohicanTxt:setFillColor(1,0,0,1)

	local function on_ChangeMohicanTest( e )
		numMohicanTxt.text = tostring(e.mohican)
	end
	Runtime:addEventListener("changeMohican",on_ChangeMohicanTest)


	local hpbar = display.newGroup()
	sceneGroup:insert(hpbar)
	local hpbar_tr =  display.newRect(hpbar,__appContentWidth__*0.5,0,90+GameConfig.getTreelevel()*10,20)

	hpbar_tr:setFillColor(1,0,0,1)

	local hp_txt = display.newText(hpbar,tostring(90+GameConfig.getTreelevel()*10), hpbar_tr.x,hpbar_tr.y,0,0,21)
	hp_txt.anchorX, hp_txt.anchorY = 0, 0
	hp_txt:setFillColor(1,1,1,1)


	local scoreTxt = display.newText(sceneGroup,GameConfig.getScore(),5,5,0,0,21)
	scoreTxt:setFillColor(1,0,0,1)

	local function on_ChangeTreehp(e)
		hpbar_tr.path.x4= hpbar_tr.path.x4-10
		hpbar_tr.path.x3= hpbar_tr.path.x3-10
		hp_tree = e.hp
		hp_txt.text = tostring(e.hp)
	end
	Runtime:addEventListener("changeTreehp",on_ChangeTreehp)

	local function on_ChangeScore(e)
		scoreTxt.text = e.score


	end

	Runtime:addEventListener("changeScore", on_ChangeScore) 
	
	
 	
end
createEnemy = function ( sceneGroup)


	local function enemy ( event )
		-- body


		local ice = Ice.create(sceneGroup)
		ice.myname = "ice"
		ice.hp = 5

		local function on_Collision (self, event )

			event.target:removeEventListener("collision",on_Collision)

			if event.other.myname == "mohican" then

				local test = {} 
				function test:timer (e)
					print(event.other.myname..event.other.hp)
				

					if event.other.hp <= 0 then
						timer.cancel(e.source)
						
					elseif event.target.hp <= 0 then
						timer.cancel(e.source)
						

						if event.target.dead then
						else
							event.target.dead = true
							local score = 10
							GameConfig.setScore(GameConfig.getScore() + score)
							print(GameConfig.getScore())
							event.target:removeEventListener("collision",on_Collision)

							


							event.target.destroy()


							deadEnemy = deadEnemy +1
							if deadEnemy == numEnemy then
								stageClear(sceneGroup,GameConfig.getScore(),hp_tree)
							end
						end

					else
						event.other.hp = event.other.hp-1
					end
				end

				timer.performWithDelay(1000, test, 0)
			elseif event.other.myname == "tree"then
				
				event.other.hp = event.other.hp-10
				
				local evt = {name = "changeTreehp", hp = event.other.hp}
				Runtime:dispatchEvent(evt)
				
				event.target.dead =true
				event.target.destroy()

				deadEnemy = deadEnemy +1
				if deadEnemy == numEnemy then
					stageClear(sceneGroup,GameConfig.getScore(),hp_tree)
				end
				if( event.other.hp <10)then
					gameOver()
				end
			end
		
		end


		ice.collision = on_Collision
		ice:addEventListener("collision",ice)
	end
	EnemyTimer = timer.performWithDelay(math.random(0,2500),enemy,numEnemy)

end
createMohican = function ( sceneGroup )
	-- body
	local mohican = Mohican.create(sceneGroup)
	mohican.myname = "mohican"
	mohican.hp = 1 



	local function on_EnermyPreCollision ( self,  e2 )

		-- local _mohican = e2.target
		
		-- _mohican:removeEventListener("collision", on_EnermyPreCollision)

		local test = {} 
		function test:timer (e)
			print(e2.other.hp)
			

			if e2.other.hp <= 0 then
				timer.cancel(e.source)
				--e2.other.destroy()
			elseif e2.target.hp <= 0 then
				timer.cancel(e.source)
				if e2.target.dead then
				else
					e2.target.dead=true
					e2.target.destroy()
				end

			
			else
				e2.other.hp = e2.other.hp-1
			end

		end

		timer.performWithDelay(700, test, 0)
		

	end

	mohican.collision =on_EnermyPreCollision
	mohican:addEventListener("collision",mohican)

end


gameOver = function()
	-- 모두 정지
	physics.stop()
	EnterFrameManager.removeAllListeners()
	for id, value in pairs(timer._runlist) do
		timer.cancel(value)
	end
	

	-- 게임 오버 이벤트 발생 (GameInfoBox 사용)
	Runtime:dispatchEvent({name="gameOver"})

	--============= 씬 이동(현재 씬 제거) Begin =============--
	local currScene = composer.getSceneName("current")
	composer.removeScene(currScene)

	local options = {
		effect = "fade",
		time = 300,
--			params = nil
	}
	
	--============= 씬 이동(현재 씬 제거) End =============--
end


stageClear = function(sceneGroup, score, hp)

	physics.stop()
	EnterFrameManager.removeAllListeners()
	for id, value in pairs(timer._runlist) do
		timer.cancel(value)
	end
	

	Runtime:dispatchEvent({name="stageClear"})

	local mainG = display.newGroup()
	sceneGroup:insert(mainG)

	local bg = display.newRect(mainG,0,0,__appContentWidth__,__appContentHeight__)
	bg:setFillColor(0,0,0,0.7)

	local clearTitle = display.newText(mainG,"clear",0,100,0,0,native.systemFontBold,21)

	clearTitle.x = __appContentWidth__*0.5 -(clearTitle.width*0.5)

	local leaf = display.newImage(mainG,"images/leaf.png",0,clearTitle.y+clearTitle.height+ 45)
	__setScaleFactor(leaf,0.2)
	leaf.x =clearTitle.x

	
	local numLeaf =  score/10 + hp/10
	
	local resLeaf = display.newText(mainG,numLeaf,0,0,0,0,native.systemFontBold,18)
	resLeaf.y = leaf.y
	resLeaf.x = leaf.x + 100

	numLeaf = GameConfig.getLeaf() + numLeaf
	GameConfig.setLeaf(numLeaf)
	GameConfig.setStagelevel(level+1)

	local btn_continue = display.newText(mainG,"continue",0,leaf.y+leaf.height+45,0,0,native.systemFontBold,20)
	--__setScaleFactor(btn_continue,0.3)
	btn_continue.x = (__appContentWidth__ *0.5) - (btn_continue.width*0.5)

	local function on_ButtonContinue( e )
		local currScene = composer.getSceneName("current")
		composer.removeScene(currScene)

		local options = {
			effect = "fade",
			time = 300,
			params = {prevSceneName="scenes.IntroScene"}
		}
		composer.gotoScene("scenes.ReadyScene", options)

		-- body
	end
	btn_continue:addEventListener("tap",on_ButtonContinue)


end



return scene
--##############################  Main Code End  ##############################--