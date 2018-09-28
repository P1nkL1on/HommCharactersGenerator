class consoleactions{

	static function init (){
		if (_root.console == undefined)
			_root.console = _root.attachMovie('console', 'console', 0);
		
		_root.console.mouseControlling = false;
		_root.console.mouseControlTimer = 0;
		
		_root.console._x = 200; _root.console._y = 0;
		
		_root.console.items = new Array();
		_root.console.activeElement = null;
		
		
		_root.console.onMouseMove = function (){
			this.mouseControlling = true;
			this.mouseControlTimer = 3;
		}
		
		_root.console.onEnterFrame = function (){
			// switching to mouse controlling and back
				if (this.mouseControlTimer <= 0)
					this.mouseControlling = false;
				else
					this.mouseControlTimer -= fps.TimePassed;
			// 
		}
		
		_root.console.spawnGUIelement = function (guielementtype, X, Y, number, nam, action){
			if (X == 'default') X = 100;
			if (number == undefined) number = this.items.length + 1;
			if (action == undefined) action = doNothing;
			if (nam == undefined) nam = "GUI element " + number;
			
			var newGUI = this.attachMovie(guielementtype, guielementtype + '_' + number, this.getNextHighestDepth());
			newGUI._x = X;
			newGUI._y = Y;
			newGUI.stop();
			newGUI.gui_text = nam; newGUI.rewriteText();
		}
		
		
		_root.console.spawnButtons = function (names:Array, actions:Array){
			for (var i = 0; i < names.length; ++i)
				this.spawnGUIelement('console_button', 'default', 382.5 + 20*( i + 1 - names.length ), i, names[i], actions[i]);
		}
		
		_root.console.spawnTest = function (){
			this.spawnButtons(new Array('вариант первый', undefined, 'Готово'), new Array(doNothing, doNothing, doNothing));
		}
	}
	
	static function doNothing (){trace('Nothing happened.');}

}