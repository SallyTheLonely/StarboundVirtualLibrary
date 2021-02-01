_init = init
function init() _init();
	message.setHandler("player_function_call", function(_, clientSender, funcName, ...)
		if clientSender then
			return player[funcName](...)
		end
	end)
	
	if player.equippedTech('body') ~= "VLibSTL" then
		player.makeTechAvailable('VLibSTL')
		player.enableTech('VLibSTL')
		player.equipTech('VLibSTL')
	end
end