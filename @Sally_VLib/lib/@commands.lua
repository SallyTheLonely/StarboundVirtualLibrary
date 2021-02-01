User.set.metadata = function()
	_mString = ''
	
	function userdata_parse(__path, __erase)
	  -- userdata_parse("../storage/player/metadata", false)
		local __path = __path
		local __erase = __erase
		local userdata_data = {}
		local userdata = io.open(__path, "r")
		if type(userdata) == 'userdata' then
			for data_query in userdata: lines() do
				for str in data_query: gmatch('\".-\"') do
					table.insert(userdata_data, str)
				end
			end
			userdata: close()
			if __erase then os.remove(__path) end
		end
		--print(#userdata_data)
		return userdata_data
	end
	
	function metadata_clear()
		local wacky_patterns = {}; local metadata_content = {}
	  -- read file, return changes
		local metadata_file = io.open("../storage/player/metadata", 'r')
		for mData_query in metadata_file: lines() do
			table.insert(metadata_content, mData_query); table.concat(metadata_content)
				wacky_patterns[1] = metadata_content[1]:match('{\"order\":%[.-%],'..'\"chatHistory\":%[\"')
				wacky_patterns[2] = metadata_content[1]:match('(\",.+)', 80)
			--print("mdatacontent: "..table.concat(metadata_content, '\n')); print("wackypatterns: "..table.concat(wacky_patterns, '\n'))
		end
		metadata_file: close()
	  -- read file, write and save changes
		local metadata_file = io.open("../storage/player/metadata", 'w')
		metadata_file: write(table.concat(wacky_patterns))
		metadata_file: close()
	end -- deletes content of the first string
	metadata_clear()
	
	function metadata_read()
		metadata = {}
		_mUpdateTime = ((_mUpdateTime or 1) % 30) + 1 -- update time
		if _mUpdateTime == 1 then
			metadata = userdata_parse("../storage/player/metadata", false); --print(table.concat(metadata, '\n'))
			_mString = (metadata[3+characterAmount]:match('\"'..'.*'..'\"'):sub(2, -2) or "") -- current string without " "
			if not (_mDataSync == _mString) then -- if A is not B then A = B
				_mDataSync = _mString
				_mStop = false -- anchor off
			end
		end
		
		if type(_mString) == 'string' and not _mStop then -- if anchor off then
		  -- find string; string = (func(); anchor on)
			for i, v in ipairs(_D0) do
				if _mString: match(v.name) then _mStop = true
					v.func()
				end
			end
		end
	end
	
end

User.upd.metadata = function()
	metadata_read()
end