class tabs{
	static var default_width = 200;
	static var default_tab_x = 200;
	static var default_tab_x_offset = 0;
	
	static var holder = null;
	static var tab_ever_open_count:Number = 0;
	static var border_holder = null;
	
	// position = 0, 1, 2
	// wid = 1, 2, 3
	static function makeNewHolder(){
		holder = _root.attachMovie('GUI_tab_holder', 'GUI_tab_holder', _root.getNextHighestDepth());
		
		border_holder = holder.attachMovie('GUI_border', 'bord', holder.getNextHighestDepth());
		border_holder._visible = false;
	}
	
	static function makeNewTab(position, wid, maxWid){
		if (_root.GUI_tab_holder == undefined)
			makeNewHolder();
		tab_ever_open_count++;
		var lastTab = holder.attachMovie('GUI_tab', 'tab'+tab_ever_open_count, holder.getNextHighestDepth());
		lastTab.swapDepths(border_holder);
		if (wid == undefined) wid = 1;
		if (position == undefined) position = 0;
		if (maxWid == undefined) maxWid = 3;
		
		lastTab.wid = wid; lastTab.position = position; lastTab.maxWid = maxWid;
		lastTab.scaling = 0;
		
		placeTab(lastTab);
		
		lastTab.onEnterFrame = function (){
			
		}
		lastTab.onMouseDown = function (){
			if (this.leftScale.hitTest(_root._xmouse, _root._ymouse, true)) this.scaling = -1;
			if (this.rightScale.hitTest(_root._xmouse, _root._ymouse, true)) this.scaling = 1;
			if (this.scaling){
				this.traceMessage('scale to ' + this.scaling);
				border_holder._visible = true;
			}
		}
		lastTab.onMouseUp = function (){
			if (this.scaling){
				this.traceMessage('stop scale');
				border_holder._visible = true;
			}
			this.scaling = 0;
		}
		lastTab.onMouseMove = function (){
			//trace(this)
		}
		lastTab.traceMessage = function (mess){
			trace(this._name + ': ' + mess);
		}
	}

	static function placeTab(tab:MovieClip){
		tab._x = default_tab_x_offset + default_tab_x * tab.position; 
		tab.gotoAndStop(tab.wid);
	}
}