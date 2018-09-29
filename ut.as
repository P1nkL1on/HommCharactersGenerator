
	// constants and enums
	
	class ut{
	
		static function atLeast(X, value):Boolean{
			trace(X+'/'+value)
			return X >= value;
		}
		static function atMax (X, value):Boolean{
			return X <= value;
		}
		
		static function colorTo(who, r, g, b){
			who.clr.setTransform({rb:r, gb:g, bb:b});
		}
		
		static function slowChangeColorTo (who, change, timeInSec, timeInSecFinish, r, g, b, mult){
			if (who.colorChangeTimerSec == undefined){
				who.colorChangeTimerSec = 0;
				who.maxS = 1;
			}
			
			who.needColorUpdate = false;
			if (mult == undefined)
				{ mult = 1;}
			if (who.maxS < mult) who.maxS = mult; if (who.maxS - .1 > mult) who.maxS -= fps.TimePassed;
				
			who.cI = Math.min(who.maxS + .01, Math.max(-.1, who.colorChangeTimerSec / timeInSec));
			
			if (who.clr == undefined)who.clr = new Color(who); 
			
			if (who.cI > mult + .1 && change == true){
				who.needColorUpdate = true;
				who.colorChangeTimerSec -= fps.TimePassed;
				if (who.colorChangeTimerSec < who.timeInSec) who.colorChangeTimerSec = who.timeInSec
			}	
			if (who.cI < mult && change == true){
				who.needColorUpdate = true;
				who.colorChangeTimerSec += fps.TimePassed;
			}
			if (who.cI > 0 && change == false){
				who.needColorUpdate = true;
				who.colorChangeTimerSec -= fps.TimePassed * (timeInSec / timeInSecFinish);
			}
			if (who.needColorUpdate)
				colorTo(who, who.cI * r, who.cI * g, who.cI * b);	
			
		}
		static function slowChangeColorToHoverRGB(whos:Array, change, extra){
			for (var i = 0; i < whos.length; ++i)
				slowChangeColorTo(whos[i], change, .15, .4, consoleactions.hoverRGB[0], consoleactions.hoverRGB[1], consoleactions.hoverRGB[2],
				((extra)? 1.7 : 1));
		
		}
		
	}