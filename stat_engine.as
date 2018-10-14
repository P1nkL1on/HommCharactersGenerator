class stat_engine{

	static function addStatHolder(who){
		who.stats = new Array();
		who.hasStats = true;
	
		return who;
	}
	
	static function hasStatWithName(who, statName:String):Boolean{
		return statIndex(who, statName) >= 0;
	}
	
	static function statIndex(who, statName:String):Number{
		if (who.hasStats != true)
			return -1;
		for (var i = 0; i < who.stats.length; ++i)
			if (who.stats[i][0] == statName)
				return i;
		return -1;
	}
	
	// static function getStat(who, statName):Array{
		// var statInd = statIndex(who, statName);
		// if (statInd < 0)
			// return null;
		// return who.stats[statInd];
	// }
	
	// static function getStatParameter(who, statName, paramIndex){
		
		// return -1;//who.stats[][paramIndex];
	// }
	
	static function listStats(who){
		ut.Trace(who.name);
		for (var i = 0; i < who.stats.length; ++i)
			ut.Trace(' ' + (i+1)+') ' + who.stats[i]);
		
	}
	
	static function addStat(who, stat:Array){
		if (who.hasStats != true)
			addStatHolder(who);
		// stat0 == stat's name
		if (hasStatWithName(who, stat[0])){
			ut.Trace(who.name + ' already has stat with name ' + stat[0]);
			return;
		}
		// check for incomplete stat!
		if (stat[0] != undefined){
			var allOtherEmpty = true;
			for (var i = 1; i < stat.length; ++i)
				if (stat[i] != undefined) allOtherEmpty = false;
			if (allOtherEmpty){
				ut.Trace('Added a stat ' + stat[0] + ', but with no values, will get a default values!');
				stat = stat_default.getDefaultStat(who, stat[0]);
				
			}
		}
		
		who.stats.push(stat);
		ut.Trace(stat[0] + ' added to ' + who.name+" :: \t" + stat);
	}
	
	static function changeStat(who, statName, statParamInd, newValue){
		var statInd = statIndex(who, statName);
		if (who.hasStats != true || who.stats.length <= statInd)
			return;
		statParamInd -= 1;
		
		var vas:String = '  >>> ' + who.name + ": " + who.stats[statInd][0] + ": " + who.stats[statInd][statParamInd] + " -> ";
		who.stats[statInd][statParamInd] = newValue;
		ut.Trace(vas + who.stats[statInd][statParamInd]);
	}
	
	static function incrementStat(who, statName, statParamInd, addCount){
		var statInd = statIndex(who, statName);
		if (who.hasStats != true || who.stats.length <= statInd)
			return;
		statParamInd -= 1;
		var vas:String = '  >>> ' + who.name + ": " + who.stats[statInd][0] + ": " + who.stats[statInd][statParamInd] + " -> ";
		who.stats[statInd][statParamInd] += addCount;
		ut.Trace(vas + who.stats[statInd][statParamInd]);
	}

	
	
	static function test(){
		var o:Object = new Object();
		o.name = 'unit';
		stat_unit.setName(o, undefined, undefined, 'человек', 'М', undefined);
		
		addStat(o, new Array('сила', 12));
		addStat(o, new Array('проворность', 4));
		
		
		changeStat(o, 'проворность', 1, 'ловкость');
		incrementStat(o, 'ловкость', 2, -10);
		incrementStat(o, 'ловкость', 2, +10);
		
		listStats(o);
	}
}