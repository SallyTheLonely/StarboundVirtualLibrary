----------------- update -----------------------------------------
User.upd[1] = function(args)
	me = entity.id(); pos = mcontroller.position(); cur = tech.aimPosition()
	dir = vec2.angle(world.distance(tech.aimPosition(), mcontroller.position()))
	w = args.moves["up"]; s = args.moves["down"]; a = args.moves["left"]; d = args.moves["right"]
	j = args.moves["jump"]; lc = args.moves["primaryFire"]; rc = args.moves["altFire"]
	f = args.moves["special1"]; g = args.moves["special2"]; h = args.moves["special3"]
	pHand = (world.entityHandItemDescriptor(me,'primary') or {}); aHand = (world.entityHandItemDescriptor(me,'alt') or {})
	dt = script.updateDt()
	
  -- uncheck comments if want to automatically refill HP and Energy
	--if status.resourcePercentage('health') < 1 then status.setResourcePercentage("health", 1) end
	--if status.resourcePercentage('energy') < 1 then status.setResourcePercentage("energy", 1) end
	
end