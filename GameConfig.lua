local EnterFrameManager = require("EnterFrameManager")
local SQLiteManager = require("SQLiteManager")

local Class = {}

Class.DB_PLAYER_SKIN_TYPE = "playerSkinType" -- 0 ~ 2
Class.DB_LEAF = "leaf" -- int
Class.DB_TREEMILK = "treemilk"
Class.DB_NUMMILK = "nummilk"
Class.DB_TECHMILK = "techmilk"
Class.DB_MOHICAN = "mohican"
Class.DB_ARCHER = "archer"
Class.DB_TREELEVEL = "treelevel"
Class.DB_STAGELEVEL = "stagelevel"
Class.SCORE = "score"

--========= 플레이어 스킨 타입 Get/Set Begin =========--
local _playerSkinType -- 0 ~ 2

Class.getPlayerSkinType = function ()
	return tonumber(_playerSkinType)
end

Class.setPlayerSkinType = function (value)
	_playerSkinType = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_PLAYER_SKIN_TYPE, _playerSkinType)

	local evt = {name="changePlayerSkinType", type=_playerSkinType}
	Runtime:dispatchEvent(evt)
end
--========= 플레이어 스킨 타입 Get/Set End =========--



local _score

Class.getScore = function ()
	return tonumber(_score)
end

Class.setScore = function (value)
	_score = tonumber(value)

	-- DB 업데이트
	--SQLiteManager.setConfig(Class.SCORE, _score)

	local evt = {name="changeScore", score=_score}
	Runtime:dispatchEvent(evt)
end




--========= 점수(코인) 관련 Get/Set Begin =========--
local _leaf

Class.getLeaf = function ()
	return tonumber(_leaf)
end

Class.setLeaf = function (value)
	_leaf = tonumber(value)

	-- DB 업데이트
	--SQLiteManager.setConfig(Class.DB_LEAF, _leaf)

	local evt = {name="changeLeaf", leaf=_leaf}
	Runtime:dispatchEvent(evt)
end
--========= 점수(코인) 관련 Get/Set End =========--



local _nummilk

Class.getNummilk = function ()
	return tonumber(_nummilk)
end

Class.setNummilk = function (value)
	_nummilk = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_NUMMILK, _nummilk)

	local evt = {name="changeNummilk", nummilk=_nummilk}
	Runtime:dispatchEvent(evt)
end


local _treemilk

Class.getTreemilk = function ()
	return tonumber(_treemilk)
end

Class.setTreemilk = function (value)
	_treemilk = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_TREEMILK, _treemilk)

	local evt = {name="changeTreemilk", treemilk=_treemilk}
	Runtime:dispatchEvent(evt)
end



local _techmilk

Class.getTechmilk = function ()
	return tonumber(_techmilk)
end

Class.setTechmilk = function (value)
	_techmilk = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_TECHMILK, _techmilk)

	local evt = {name="changeTechmilk", techmilk=_techmilk}
	Runtime:dispatchEvent(evt)
end


local _mohican

Class.getMohican = function ()
	return tonumber(_mohican)
end

Class.setMohican = function (value)
	_mohican = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_MOHICAN, _mohican)

	local evt = {name="changeMohican", mohican=_mohican}
	Runtime:dispatchEvent(evt)
end


local _archer

Class.getArcher = function ()
	return tonumber(_archer)
end

Class.setArher = function (value)
	_archer = tonumber(value)

	-- DB 업데이트
	SQLiteManager.setConfig(Class.DB_ARCHER, _archer)

	local evt = {name="changeArcher", archer=_archer}
	Runtime:dispatchEvent(evt)
end


local _treelevel

Class.getTreelevel = function ()
	return tonumber(_treelevel)
end

Class.setTreelevel = function (value)
	_treelevel = tonumber(value)

	-- DB 업데이트
	--SQLiteManager.setConfig(Class.DB_TREELEVEL, _treelevel)

	local evt = {name="changeTreelevel", treelevel=_treelevel}
	Runtime:dispatchEvent(evt)
end


local _stagelevel

Class.getStagelevel = function ()
	return tonumber(_stagelevel)
end

Class.setStagelevel = function (value)
	_stagelevel = tonumber(value)

	-- DB 업데이트
	--SQLiteManager.setConfig(Class.DB_STAGELEVEL, _stagelevel)

	local evt = {name="changeStagelevel", stagelevel=_stagelevel}
	Runtime:dispatchEvent(evt)
end



--========= 일시정지 관련 Get/Fn Begin =========--
local _isPaused = false

Class.isPaused = function ()
	return _isPaused
end

Class.pauseGame = function (dispatchEvent)
	dispatchEvent = dispatchEvent or true

	if _isPaused == true then return end

	_isPaused = true

	if dispatchEvent == true then Runtime:dispatchEvent({name="pauseGame"}) end
end

Class.resumeGame = function (dispatchEvent)
	dispatchEvent = dispatchEvent or true

	if _isPaused == false then return end

	_isPaused = false

	if dispatchEvent == true then Runtime:dispatchEvent({name="resumeGame"}) end
end
--========= 일시정지 관련 Get/Fn End =========--

--========= 사운드 제어 Begin =========--
local bgmChannel = nil
Class.playBGM = function (sndPath)
	Class.stopBGM()
	
	local gbm = audio.loadStream(sndPath)
	bgmChannel = audio.play( gbm, { channel=1, loops=-1 } )
end

Class.stopBGM = function ()
	if bgmChannel ~= nil then audio.stop(bgmChannel) end
	bgmChannel = nil
end

Class.playEffectSound = function (sndPath)
	local snd = audio.loadSound(sndPath)
	local availableChannel = audio.findFreeChannel()
	audio.play( snd, { channel=availableChannel } )
end

Class.stopAllSounds = function ()
	audio.stop()
end

Class.setVolume = function (value)
	audio.setVolume(value)
end
--========= 사운드 제어 End =========--

--========= 설정 초기화 Begin =========--
Class.init = function ()
	
	_playerSkinType = tonumber(SQLiteManager.getConfig(Class.DB_PLAYER_SKIN_TYPE))
	
	_leaf = tonumber(SQLiteManager.getConfig(Class.DB_LEAF))
	_treemilk = tonumber(SQLiteManager.getConfig(Class.DB_TREEMILK))
	_techmilk = tonumber(SQLiteManager.getConfig(Class.DB_TECHMILK))
	_nummilk = tonumber(SQLiteManager.getConfig(Class.DB_NUMMILK))
	_mohican = tonumber(SQLiteManager.getConfig(Class.DB_MOHICAN))
	_archer = tonumber(SQLiteManager.getConfig(Class.DB_ARCHER))
	_treelevel = tonumber(SQLiteManager.getConfig(Class.DB_TREELEVEL))

	_isPaused = false

	EnterFrameManager.init()
end
--========= 설정 초기화 End =========--

return Class