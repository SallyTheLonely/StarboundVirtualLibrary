	_____________________________ i n f o r m a t i o n _____________________________
	
	Check the comments (-- text), they gives better understanding about what's going
	on in general. To add new functions yourself - browse the /doc/lua folder in
	your game directory, it includes information about global functions in the game
	(not all of them are available to you), and then just follow the templates.
	
	_________________________________ s e t t i n g _________________________________
	
	At first you should open /lib/@set.lua and set the number of 'characterAmount'
	to the amount characters you have, or leave it if you have only one character. It
	is required for commands to work properly. That's all, you can do anything now.
	
	Well, what to do? Create new functions/commands, of course!
	Commands are located in the function you checked above. Just copypaste and modify
	the template.
	To create new functions you should check the template in the main function
	(@VLib.lua) at first. Mostly you only have to use 'User.set.funcname' and
	'User.upd.funcname'. 'User.add.funcname' is an additional support func, basically
	just for setting the script more logically and accurately.
	Function definitions:
	
	. funcname :: just a name, it can be anything (but only letters and numbers);
	it should begin with a letter, though.
	
	. User.set.funcname :: initial function which loads only once everytime you
	change/reset your current instance [init()].
	
	. User.upd.funcname :: a loop function, it's update rate (delta (or dt)) is 60
	ticks per second. Basically you only have to put the call of the function you
	set in 'User.set.funcname' inside it.
	
	. User.add.funcname :: same as 'User.upd.funcname' but will only work if called
	right in the main function (@VLib.lua). Basically it is used inside an 'if'
	statement to activate a specified function at specified moment.
	
	Right after building a function you have to require it in the main script.
	Head to /@VLib.lua and locate your call near the other ones. The syntax is:
	require '/lib/yourfunc.lua'
	
	Additionally, if you still don't understand things much, you could check all
	of the functions located in '/lib', they are basically the templates. Good luck!
	
	_________________________________ c o n t e n t _________________________________
	
	/readme.txt :: hi
	
	/@VLib.lua :: general lib which reads the functions
	
	/_G.lua :: shares 'player' global function and automatically equips tech
	
	/default_actor_movement.config :: adds multijump and expands speed limit
	
	/player.config.patch :: includes _G in deployment to require player global
	
	/_metadata :: ingame mod information
	
	/lib/ :: function storage
	
	/res/ :: resource storage
	
	/res/tech.tech ; /res/tech_icon.png :: parts of the tech
	
	/lib/@commands.lua :: metadata read function, modify at your risk (better not)
	
	/lib/@set.lua :: init() function for VLib, includes metadata (chat) commands
	
	/lib/@upd.lua :: update() function for VLib
	
	/lib/player_movement.lua :: advanced movement manipulations, can be disabled
	
	_________________________________________________________________________________
	
	PS: there may be further updates/addons so check the repository sometimes.
	https://github.com/SallyTheLonely
