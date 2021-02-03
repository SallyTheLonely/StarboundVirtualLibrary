User.set.movement = function()
	_sit = false
	
	function player_movement()
	--[[
		Moving normally until you press [S] or [W] in the air. When you're standing still it's impossible to move you.
		-> while NOT on the ground and NOT colliding: move in the air until you [Jump] (collisions disabled)
		-> while holding [Jump] and NOT [S]: collisions are disabled
		-> while holding [Jump] AND [S]: fall down until collided
		-> if [W] and [S] then: sit on the air/entity at cursor pos
	]]
	  -- movement in the air
		if j then tech.setParentState() end
		if not _sit then sitEntity = nil;
			if (s or w) and (not j and not mcontroller.onGround()) then fix_movement = true end
			if fix_movement and not tech.parentLounging() then
				mcontroller.controlParameters({ collisionEnabled = false })
				
				if not (a or d or j) then
					if not set_lastPos then lastPos = pos end
					set_lastPos = true;  tech.setParentState("stand")
					mcontroller.setVelocity({0, 0});  mcontroller.setPosition(lastPos)
					mcontroller.controlModifiers({ movementSuppressed = true })
				end
				
				if (a or d) and not j then
					set_lastPos = false;  _xVel = (_xVel or 1) + 1
					mcontroller.setYVelocity(0);  tech.setParentState('run')
					mcontroller.setRotation(math.rad(math.max(math.min(mcontroller.xVelocity(), 15), -15))*-1)
					mcontroller.controlModifiers({ speedModifier = 1.4 })
					if d and _xVel < 10 then mcontroller.addMomentum({6, 0}) end -- initial sprint boost
					if a and _xVel < 10 then mcontroller.addMomentum({-6, 0}) end
				else _xVel = 0; end
				
				if s and not j then mcontroller.zeroG();
					tech.setParentState("duck");  mcontroller.setVelocity({0, 0})
					mcontroller.controlModifiers({ movementSuppressed = true })
				elseif j then fix_movement = false end
				
				if tech.parentLounging() then tech.setParentState() end
			end
			
			if (a or d or s or j) and mcontroller.onGround() then
				tech.setParentState();  set_lastPos = false
				mcontroller.controlModifiers({ groundMovementModifier = 1.4, speedModifier = 1.4, airJumpModifier = 1.4 })
			end
			if j and not s then set_lastPos = false;
				mcontroller.controlModifiers({ airJumpModifier = 1.4 })
				mcontroller.controlParameters({ collisionEnabled = false })
			end
			
			if (mcontroller.onGround() or (j and s)) and not set_lastPos then
				fix_movement = false;  lastPos = pos
			end
		end
		
	  -- lock position after a short delay if not moving
		if mcontroller.onGround() and not (a or d or w or s or j or _sit) then
			if not set_lastPos then lastPos = pos end
			set_lastPos = true;  tech.setParentState("stand")
			mcontroller.setVelocity({0, 0});  mcontroller.setPosition(lastPos)
			mcontroller.controlModifiers({ movementSuppressed = true })
			if (a or d or w or s or j or _sit) then set_lastPos = false end
		end
		
	  -- sit on the [cursor pos]/[entity at cursor pos] --
		sitQ = world.entityQuery(cur, 3, { boundMode = 'position', order = 'nearest', includedTypes = {'mobile'}, withoutEntityId = me })
		if (w and s) then
			stopWS = (stopWS or 0) + 1 -- quick anchor
			if stopWS == 1 then
				_sit = not _sit;  sitEntity = false
				if sitQ[1] then sitEntity = sitQ[1] else mcontroller.setPosition(cur) end
			end else stopWS = 0
		end
		if _sit then
			tech.setParentState('sit');  mcontroller.setVelocity({0, 0})
			mcontroller.controlModifiers({ movementSuppressed = true })
		end
		if sitEntity then
			if world.entityExists(sitEntity) then
				tech.setParentState('sit'); -- 'if' statements below are made because player metaBoundBox is very large
				if entity.entityType(sitEntity) ~= 'player' then mcontroller.setPosition(vec2.add( world.entityPosition(sitEntity), {0, world.entityMetaBoundBox(sitEntity)[3]-1} )) end
				if entity.entityType(sitEntity) == 'player' then mcontroller.setPosition(vec2.add( world.entityPosition(sitEntity), {0, 3} )) end
				else sitEntity = nil
			end
		end
		
	  -- direction follows the cursor --
		if a or d then -- only flip when moving in sides
			mcontroller.setRotation(math.rad(math.max(math.min(mcontroller.xVelocity(), 15), -15))*-1)
		end
		if not (a or d or j) then -- slight rotation
			-- right
			if (math.deg(dir) > 0 and math.deg(dir) < 91) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 0, math.deg(dir) ), 3 ) )) ) end
			if (math.deg(dir) > 270 and math.deg(dir) < 361) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 357, math.deg(dir) ), 360 ) ) -360) ) end
			-- left
			if (math.deg(dir) > 90 and math.deg(dir) < 181) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 177, math.deg(dir) ), 180 ) ) -180) ) end
			if (math.deg(dir) > 180 and math.deg(dir) < 271) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 180, math.deg(dir) ), 183 ) ) -180) ) end
		end
		if j then -- moderate rotation
			-- right
			if (math.deg(dir) > 0 and math.deg(dir) < 91) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 0, math.deg(dir) ), 10 ) )) ) end
			if (math.deg(dir) > 270 and math.deg(dir) < 361) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 350, math.deg(dir) ), 360 ) ) -360) ) end
			-- left
			if (math.deg(dir) > 90 and math.deg(dir) < 181) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 170, math.deg(dir) ), 180 ) ) -180) ) end
			if (math.deg(dir) > 180 and math.deg(dir) < 271) then mcontroller.setRotation( math.rad(math.floor( math.min( math.max( 180, math.deg(dir) ), 190 ) ) -180) ) end
		end
		if dir < math.pi/2 or dir > math.pi*3/2 then -- right
			facingDir = 1;  else facingDir = -1 -- left
		end mcontroller.controlFace(facingDir)
	end
	
end

User.upd.movement = function()
	player_movement()
end