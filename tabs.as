class tabs{
	static var default_width = 200;
	static var default_tab_x_offset = 0;
	static var def_strange = 30;
	
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
		lastTab.scroling = 0;
		
		placeTab(lastTab);
		
		lastTab.onMouseDown = function (){
			if (/* this.position > 0 &&  */this.leftScale.hitTest(_root._xmouse, _root._ymouse, true)) 
				this.scaling = -1;
			if (/* ((this.position + this.wid) < 3) &&   */this.rightScale.hitTest(_root._xmouse, _root._ymouse, true)) 
				this.scaling = 1;
			if (this.sb.hitTest(_root._xmouse, _root._ymouse, true))
				this.scrolling = 1;
			if (this.scaling){
				this.traceMessage('scale to ' + this.scaling);
				border_holder._visible = true;
				border_holder._x = this._x + (this.scaling < 0) * default_width * (this.wid - 1);
				border_holder.l.x_offset = 0 - (this.scaling < 0)* default_width * (this.wid - 1); 
				border_holder.r.x_offset = 0 + (this.scaling > 0)* default_width * (this.wid - 1);
				border_holder.l._x = border_holder.l.xx + border_holder.l.x_offset;
				border_holder.r._x = border_holder.r.xx + border_holder.r.x_offset;
			}
			if (this.scrolling)
				this.traceMessage('scrolling iamge');
				
		}
		lastTab.onMouseUp = function (){
			if (this.scaling){
				this.traceMessage('stop scale');
				//border_holder._visible = false;
				this.newScale = Math.round((border_holder.r.x_offset - border_holder.l.x_offset) / default_width);
				if (this.scaling > 0){
					border_holder.r.x_offset = this.newScale * default_width;
					border_holder.r.onPlace = false;
					this.wid = Math.max(1, Math.min(3, this.newScale + 1));
					this.traceMessage('Scaled -> to width: ' + this.wid);
					placeTab(this);
				}
				if (this.scaling < 0){
					border_holder.l.x_offset = - this.newScale * default_width;
					border_holder.l.onPlace = false;
					this.position -= this.newScale - this.wid + 1;
					this.wid = Math.max(1, Math.min(3, this.newScale + 1));
					this.traceMessage('Scaled <- to width: ' + this.wid);
					placeTab(this);
				}
			}
			if (this.scrolling){
				
				this.traceMessage('Scroll stop');
			}
			this.scaling = 0;
			this.scrolling = 0;
		}
		lastTab.onMouseMove = function (){
			if (this.scaling){
				if (this.scaling > 0) this.placeRight();
				if (this.scaling < 0) this.placeLeft();
			}
			if (this.scroling)
				this.placeActionLayer(_root._xmouse);
			
		}
		lastTab.onEnterFrame = function (){
			if (border_holder._visible && !Key.isDown(1) && (border_holder.r.onPlace && border_holder.l.onPlace))
				border_holder._visible = false;
			this.g.text = this._name + ' : ' + this.position + '  ' + this.wid;
			//this.dWid = this.maxWid - this.dWid;
		}
		lastTab.placeRight = function (){
			this.maxRight = (this.maxWid - 1) * default_width + def_strange;
			this.minRight = -def_strange;
			border_holder.r.x_offset = 
				Math.max( this.minRight, Math.min( this.maxRight, _root._xmouse - this._x - default_width + 10));
		}
		lastTab.placeLeft = function (){
			this.maxLeft = def_strange;
			this.minLeft = -(this.maxWid - 1) * default_width - def_strange;
			border_holder.l.x_offset = 
				Math.max( this.minLeft, Math.min( this.maxLeft,_root._xmouse - this._x - 10 - default_width * (this.wid - 1)));
		}
		lastTab.traceMessage = function (mess){
			trace(this._name + ': ' + mess);
		}
		lastTab.placeActionLayer = function (xx){
			this.s._width =  this.sb._width * Math.min( 1,(default_width * this.wid / this.action_layer._width));
			if (xx == undefined){
				this.action_layer._x = (default_width * this.wid - this.action_layer._width ) * .5;
				this.s._x = this.sb._x + ( - this.action_layer._x / this.action_layer._width)  * (this.sb._width);
			}
		}
		lastTab.placeActionLayer();
	}
	

	static function placeTab(tab:MovieClip){
		tab._x = default_tab_x_offset + default_width * tab.position; 
		tab.gotoAndStop(tab.wid);
		tab.placeActionLayer();
	}
	
	static function makeBorder(who){
		who.xx = who._x;
		who.x_offset = 0;
		who.spd = 4;
		who.onEnterFrame = function (){
			this.onPlace = true;
			if (Math.abs(this._x - (this.xx + this.x_offset)) < 1) return;
			this._x += (this.xx + this.x_offset - this._x) / this.spd;
			this.onPlace = false;
		}
	}
	static function makeBorderAlpha(who, tt, pos){
		who.gotoAndStop(2);
		who._x += default_width * pos;
		who.onEnterFrame = function (){
			if (Math.abs(this._x - (this.xx + this.x_offset)) < 1) return;
			this._x += (this.xx + this.x_offset - this._x) / this.spd;
		}
		who.tt = tt;
		who.onMouseDown = function (){ this._alpha = 0; }
		who.onMouseMove = function (){
			if (_parent._visible == false) return;
			this._alpha = Math.max(0, 100 - .5 * Math.abs(this._x - this.tt._x));
		}
	}
}