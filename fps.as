class fps{

	static var currentFps=30;
	
	static var timeinit:Date = new Date;
	static var lasttime=timeinit.getMilliseconds();
	static var timepassed:Number = 1;
	
	static var TimePassed:Number = 1;
	
	static function countDeltaTime(){
		var time:Date = new Date;
		//on each frame, figure out how much time has passed by comparing the milliseconds of the last frame to
		//the milliseconds of the current frame
		timepassed=((time.getMilliseconds()-lasttime)>=0)?(time.getMilliseconds()-lasttime):(1000+(time.getMilliseconds()-lasttime));
		//convert the time passed between frames to frames per second. Round it to the nearest tenth.
		currentFps = Math.round(10000/timepassed)/10;
		//set last time for the next frame.
		lasttime=time.getMilliseconds();
		
		TimePassed = timepassed / 1000;
	}

	static function startFPSCounting (depth){
		if (_root.fpsC == undefined)
			_root.fpsC = _root.attachMovie('fpsCounter', 'fpsC', (depth == undefined)? -1 : depth);
		_root.fpsC.onEnterFrame = function (){
			countDeltaTime();
			this.info.text = currentFps;
		}
	}
	
}