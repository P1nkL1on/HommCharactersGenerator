class sounds
{
	static var isLoaded:Boolean = false;
	//
	static var soundFolder:String = "sounds";
	static var soundNames:Array = new Array();
	static var soundFiles:Array = new Array();
	
	//
	static function pushSounds(whatSounds:Array){
		for (var i = 0; i < whatSounds.length; i++)
			soundNames.push(whatSounds[i]);
		return;
	}
	
	static function guiSounds():Array{
	
		var sName = new Array("btn");
		var sCount = new Array(4, 0);
		var sEndCount = new Array('.mp3');
		var sos:Array = new Array();
		for (var i = 0; i < sName.length; i++){
			for (var j = 1; j <= sCount[i]; j++)
				sos.push(sName[i] + j + sEndCount[i]);
		}
		return sos;
	}
	static function pushAllSounds(){
		pushSounds(guiSounds());
	}
	
	
	static function loadAllSounds(){
		if (isLoaded) return;
		pushAllSounds();
		trace("Awaits loading of " + soundNames.length + " sounds;");
		for (var i = 0; i < soundNames.length; i++){
			soundFiles.push(new Sound());
										// ставим каждый на загрузку соответствующего адреса
			soundFiles[i].loadSound(soundFolder+"/"+soundNames[i],false); 
			soundFiles[i].name = soundNames[i].substring(0, soundNames[i].lastIndexOf('.'));
			soundFiles[i].isLoaded = false;
			soundFiles[i].onLoad = function(success:Boolean):Void { if (success){ this.isLoaded = true;}}	
		}
		isLoaded = true;
	}
	
	// Воспроизвести звук по имени. (Звук выбирается из массива sounds)
	static public function playSound(nam:String, times):Sound{
		if (times == undefined)
			times = 1;
		for (var i=0; i<soundFiles.length; i++)
			if (soundFiles[i].name == nam){ soundFiles[i].start(0, times); return soundFiles[i]; }															//воспроизвести звук совпадающий по имени
		trace("No sound '"+nam+"' in library!");
		return null;
	}
}