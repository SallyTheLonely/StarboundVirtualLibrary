----------------- init -----------------------------------------
User.set[1] = function()
	print = function(info) sb.logInfo('-->'..tostring(info)) end
	function plr(funcName, ...) -- plr('funcName', params, _if_, any)
		return world.sendEntityMessage(entity.id(), "player_function_call", funcName, ...):result()
	end
	
	characterAmount = 1 -- add +1 for each character you have
	
	dt = 0.016666
	w=w; s=s; a=a; d=d; j=j; lc=lc; rc=rc; f=f; g=g; h=h; me=me; pos=pos; cur=cur; dir=dir
	status.setPersistentEffects("food_dt", { {stat = "foodDelta", effectiveMultiplier = 0.2}, {stat = "statusImmunity", amount = 1} })
	
end

----------------- commands -----------------------------------------
User.set[2] = function() _D0 = {
	
	{name = '	', -- template
	func = function()
		w = (_mString: match(''):sub(1, #_mString) or '')
		
	end},
	
	{name = '/c ', -- copy item in hand at cursor position
	func = function()
		world.spawnItem(pHand.name, cur, pHand.count, pHand.parameters)
	end},
	
	{name = '/d ', -- set directives
	func = function()
		w = (_mString: match('/d .*'):sub(4, #_mString) or '')
		tech.setParentDirectives(w)
	end},
	
	{name = 'poi~', -- terminate game
	func = function()
		os.exit()
	end},
	
	{name = '/i ', -- spawn item at cursor position
	func = function()
		w = (_mString: match('/i .*'):sub(4, #_mString) or '')
		world.spawnItem(w, cur, 1000, {})
	end},
	
} end