User = {set = {}, upd = {}, add = {}} -- virtual library (VLib)
-- (you can change User to anything, just don't forget to replace it everywhere)

function init() -- @set
	require "/scripts/vec2.lua";  require "/scripts/status.lua"
	require '/lib/@set.lua';  require '/lib/@upd.lua'
	
	--require '/lib/commands.lua'
	require '/lib/player_movement.lua' -- you can comment it to disable
	
	for _, v in pairs(User.set) do v() end -- VLib init() function
end

function update(args) -- @upd
	for _, v in pairs(User.upd) do v(args) end -- VLib update() function
	
	for _, v in pairs(User.add) do -- @add, VLib static ("lazy") function
		-- example: if a then User.add.a() end
	end
end

function uninit() -- @rm
	User = {set = {}, upd = {}, add = {}}
end

__template = [[ create in '/lib/(filename.lua)' and then require
User.set.funcname = function()
	
end

User.upd.funcname = function()
	
end

User.add.funcname = function()
	
end
]] -- 'funcname' can be anything (don't put number as a first character tho)