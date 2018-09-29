class consoleactions{

	static var hoverRGB:Array = new Array(58, 116, 190);
	static var timeNeedToPressButton:Array = new Array(.1, .5, .8, 1, 1.35, 1.5);

	static function init (){
		if (_root.console == undefined)
			_root.console = _root.attachMovie('console', 'console', 0);
		
		_root.console._x = 200; _root.console._y = 0;
		
		_root.console.items = new Array();
		
		_root.console.onMouseMove = function (){
		}
		
		_root.console.onEnterFrame = function (){
		}
		
		_root.console.pid = 0;
		_root.console.spawnGUIelement = function (guielementtype, X, Y):MovieClip{
			++this.pid;
			var newGUI = this.attachMovie(guielementtype, guielementtype + '_' + this.pid, this.getNextHighestDepth());
			newGUI._x = X; newGUI._y = Y; newGUI.gotoAndStop(1);
			this.items.push(newGUI);
			return newGUI;
		}
		
		
		_root.console.spawnButton = function (X, Y, wid, buttonName, buttonDescription, action, multiplePressingAvailable){
		
			if (X == 'default') X = 10;
			if (Y == 'default') Y = 200;
			if (wid == 'default') wid = 180;
			if (multiplePressingAvailable == undefined) multiplePressingAvailable = false;
			
			var newButton = this.spawnGUIelement('console_button', X, Y);
			newButton.itemName =  buttonName;
			newButton.requiredWidth = wid; 
			newButton.nedUpd = true;
			newButton.action = action;
			newButton.multiplePressingAvailable = multiplePressingAvailable;
		}
		
		_root.console.spawnTest = function (){
			for (var i = 0; i < 1; ++i)
			this.spawnButton('default',50 + i * 17,'default','oka y ' + i,'this is just okay button', doNothing, true)					 
		}
	}
	
	static function doNothing (){trace('Nothing happened.');}

}