class stat_engine{


	static function test(){
		var o:Object = new Object();
		var en:Object = new Object();
		en.name = 'sucker knight';
		o.name = 'unit';
		o.setName(o, undefined, undefined, 'человек', 'М', 25);
		
		addStat(o, createStat('сила', 12));
		addStat(o, createStat('проворность', 4));
		
		addStat(o, createStat('рана', new Array(2, 4, 8), 'состояние-болезнь', undefined, en));
		addStat(o, createStat('рана', new Array(1, 3, 8), 'состояние-болезнь', undefined, en));
		addStat(o, createStat('рана', new Array(2, 2, 8), 'состояние-болезнь', undefined, en));
		addStat(o, createStat('рана', new Array(3, 1, 16), 'состояние-болезнь', undefined, statWithName(o, 'рана', 2)));
		
		//changeUniqueStatValue();
		
		trace('');
		trace('');
		listStats(o)
		
		
		// changeStat(o, 'проворность', 1, 'ловкость');
		// incrementStat(o, 'ловкость', 2, -10);
		// incrementStat(o, 'ловкость', 2, +10);
		
		// trace('result2: ' + getStat(o, new Array('телосложение')));
		
		// incrementStat(o, 'телосложение', 2, +1);
		
		//listStats(o);
	}

	static function createStat(
		name:String,
		value,
		category:String,
		dateTime:Number,
		source:Object
	):Object{
		var nStat:Object = new Object();
		nStat.name = name;
		if (value == undefined) nStat.value = new Array(); else {
			var isArray = isNaN(value + 5);
			if (isArray)
				nStat.value = value;
			else{
				nStat.value = new Array(); nStat.value.push(value);	// add a {value1}, non valu1
			}
		}
		if (category == undefined) nStat.category = 'стат'; else nStat.category = category;
		nStat.dateTime = dateTime;
		nStat.source = source;
		
		nStat.isStat = true;
		return nStat;
	}
	
	static function statToString(stat:Object):String{
		var res:String = "";
		if (stat.category != undefined) res += stat.category+"-";
		res += stat.name + ": {" + stat.value + "}";
		if (stat.source != undefined) res += " от " + ((stat.source.isStat == true)? (stat.source.host.name+":"):"") +(stat.source.name);
		if (stat.dateTime != undefined) res += " с " + stat.dateTime;
		return res;
	}
	
	static function traceStat(stat:Object){
		ut.Trace(statToString(stat));
	}

	static function addStatHolder(who){
		who.stats = new Array();
		who.hasStats = true;
		return who;
	}
	
	static function addStat(who, stat:Object){
		if (who.hasStats != true)
			addStatHolder(who);
		// stat0 == stat's name
		if (statCountWithName(who, stat.name) > 0){
			// т.е. если это обычный стат, то низя
			if (stat.category.indexOf ('стат') >= 0){
				ut.Trace(who.name + ' already has stat with name ' + stat.name);
				return;
			}
		}
		// check for incomplete stat!
		if (stat.name != undefined){
			var isEmpty = (stat.value.length == 0);
			if (isEmpty){
				ut.Trace('Added a stat ' + stat.name + ', but with no values, will get a default values!');
				stat = stat_default.getDefaultStat(who, stat.name);
			}
		}
		stat.host = who;
		who.stats.push(stat);
		ut.Trace(stat.name + ' added to ' + who.name+" :: \t" + statToString(stat));
	}
	
	static function listStats(who){
		ut.Trace(who.name);
		for (var i = 0; i < who.stats.length; ++i)
			traceStat(who.stats[i]);
	}
	
	
	static function statsWithName(who, statName:String):Array{
		if (who.hasStats != true) return new Array();
		var arr = new Array();
		for (var i = 0; i < who.stats.length; ++i)
			if (who.stats[i].name == statName)
				arr.push(who.stats[i]);
		return arr;
	}
	
	static function statCountWithName(who, statName:String):Number{
		return statsWithName(who, statName).length;
	}
	
	static function statWithName(who, statName:String, indexMult):Object{
		var arr = statsWithName(who, statName);
		if (arr.length == 0) {ut.Trace(who.name + ' has no stat named ' + statName); return undefined;}
		if (arr.length == 1) return arr[0];
		if (indexMult != undefined) return arr[indexMult];
		// indexMult == undefined -> get first, if other said
		ut.Trace(who.name + ' has ' + arr.length + ' stats named ' + statName + ' but get only first!');
		return arr[0];
	}
	
	static function watchStatValue(who, statName:String, indexMult):Array{
		return statWithName(who, statName, indexMult).value;
	}
	
	static function statIndexWithName (who, statName:String, indexMult):Number{
		var indices = new Array();
		for (var i = 0; i < who.stats.length; ++i)if (who.stats[i].name == statName)indices.push(i);
		if (indices.length == 0) return -1;
		if (indices.length == 1) return indices[0];
		if (indexMult != undefined) return indices[indexMult];
		return indices[0];
	}
	
	static function changeStatValue(who, statName:String, indexMult, newValue, paramNumber):Object{
		var statIndex = statIndexWithName(who, statName, indexMult);
		if (paramNumber == undefined) 
			paramNumber = 0;
		if (newValue != undefined)
			who.stats[statIndex].value[paramNumber] = newValue;
		return who.stats[statIndex];
	}
	
	static function changeUniqueStatValue(who, statName:String, newValue, paramNumber):Object{
		return changeStatValue(who, statName, undefined, newValue, paramNumber);
	}
	
	// static function statIndex(who, statName:String):Number{
		// if (who.hasStats != true)
			// return -1;
		// for (var i = 0; i < who.stats.length; ++i)
			// if (who.stats[i].name == statName)
				// return i;
		// return -1;
	// }
	
	// static function watchStat(who, statName):Array{
		// var statInd = statIndex(who, statName);
		// if (statInd < 0) return null;
		// return who.stats[statInd];
	// }
	
	// //!!!! get is like watch, but if none, then add default and return it!
	// static function getStat(who, statName):Array{
		// var statInd = statIndex(who, statName);
		// if (statInd < 0){
			// ut.Trace('requested ' + statName + ' from ' + who.name+', but none found. Adding default ' + statName);
			// addStat(who, statName);
			// statInd = who.stats.length - 1;
		// }
		// return who.stats[statInd];
	// }
	
	//static function getStatParameter(who, statName, paramIndex){
		
	//	return -1;//who.stats[][paramIndex];
	//}
	
	
	
	// static function changeStat(who, statName, statParamInd, newValue){
		// var statInd = statIndex(who, statName);
		// if (who.hasStats != true || who.stats.length <= statInd)
			// return;
		// statParamInd -= 1;
		
		// var vas:String = '  >>> ' + who.name + ": " + who.stats[statInd][0] + ": " + who.stats[statInd][statParamInd] + " -> ";
		// who.stats[statInd][statParamInd] = newValue;
		// ut.Trace(vas + who.stats[statInd][statParamInd]);
	// }
	
	// static function incrementStat(who, statName, statParamInd, addCount){
		// var statInd = statIndex(who, statName);
		// if (who.hasStats != true || who.stats.length <= statInd)
			// return;
		// statParamInd -= 1;
		// var vas:String = '  >>> ' + who.name + ": " + who.stats[statInd][0] + ": " + who.stats[statInd][statParamInd] + " -> ";
		// who.stats[statInd][statParamInd] += addCount;
		// ut.Trace(vas + who.stats[statInd][statParamInd]);
	// }

}