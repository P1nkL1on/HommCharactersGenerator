class consoleactions{

	static var hoverRGB:Array = new Array(110, 15, 5);//(58, 116, 190);
	static var timeNeedToPressButton:Array = new Array(.1, .5, .8, 1, 1.35, 1.5);

	static function init (){
		if (_root.console == undefined)
			_root.console = _root.attachMovie('console', 'console', 0);
		
		var ActionConsole = _root.console;
		
		ActionConsole._x = 440; ActionConsole._y = 0;
		
		ActionConsole.items = new Array();
		
		ActionConsole.onMouseMove = function (){
		}
		
		ActionConsole.onEnterFrame = function (){
		}
		
		ActionConsole.pid = 0;
		ActionConsole.spawnGUIelement = function (guielementtype, X, Y):MovieClip{
			++this.pid;
			var newGUI = this.attachMovie(guielementtype, guielementtype + '_' + this.pid, this.getNextHighestDepth());
			newGUI._x = X; newGUI._y = Y; newGUI.gotoAndStop(1);
			this.items.push(newGUI);
			return newGUI;
		}
		
		
		ActionConsole.spawnButton = function (X, Y, wid, buttonName, buttonDescription, action, multiplePressingAvailable){
		
			if (X == 'default') X = 10;
			if (Y == 'default') Y = 200;
			if (wid == 'default') wid = 180;
			if (buttonDescription == 'default') buttonDescription = buttonName;
			if (multiplePressingAvailable == undefined) multiplePressingAvailable = false;
			
			var newButton = this.spawnGUIelement('console_button', X, Y);
			newButton.itemName =  buttonName;
			newButton.requiredWidth = wid; 
			newButton.nedUpd = true;
			newButton.action = action;
			newButton.multiplePressingAvailable = multiplePressingAvailable;
		}
		
		ActionConsole.spawnCheckBox = function (X, Y, wid, checkboxName, checkboxDescription, checked, action){
			if (X == 'default') X = 10;
			if (Y == 'default') Y = 200;
			if (wid == 'default') wid = 180;
			if (checkboxDescription == 'default') checkboxDescription = checkboxName;
			if (checked == 'default') checked = false;
			
			var newCheckBox = this.spawnGUIelement('console_checkbox', X, Y);
			newCheckBox.itemName =  checkboxName;
			newCheckBox.requiredWidth = wid; 
			newCheckBox.requiredCheck = checked;
			newCheckBox.nedUpd = true;
			newCheckBox.action = action;
		}
		
		
		
		ActionConsole.spawnTest = function (){
			for (var i = 0; i < 3; ++i)
			this.spawnButton('default',50 + i * 17,'default','oka y ' + i,'this is just okay button', doNothing, random(2)==0)		


			for (var i = 0; i < 7; ++i)
			this.spawnCheckBox('default',101 + 12 * i,'default',' on '+i+'/ off','this is just okay checkbox', !random(2), doNothing2)				
		}
	}
	
	static function doNothing (){trace('Nothing happened.');}
	static function doNothing2 (S){trace('Nothing happened. ' + S);}

}