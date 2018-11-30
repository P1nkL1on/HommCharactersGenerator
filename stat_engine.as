class stat_engine{


	static function test(){
		var o:Object = new Object();
		var en:Object = new Object();
		en.name = 'рыца соса';
		o.name = 'unit';
		unit_stat.setName(o, undefined, undefined, 'человек', 'М', 25);
		
		A(o, 'сила', 12);
		A(o, 'проворность', new Array(4, 5,6));
		
		A(o, 'рана', new Array(2, 4, 8), 'состояние-болезнь', undefined, en);
		A(o, 'рана', new Array(3, 1, 16), 'состояние-болезнь', undefined, statWithName(o, 'рана', 0));
		
		
		trace(watchUniqueStatValueParam(o, 'проворность', 2));
		listStats(o)
		//телосложение
		//trace(getStatValue(o, 'телосложение'));
		
		
		changeUniqueStatValue(o, 'сила', getStatValue(o, 'телосложение')[0]+2);
		//changeUniqueStatValue(o, 'проворность', 10,1);
		//changeStatValue(o, 'проворность', undefined, 12,1);
		//changeStatValue(o, 'рана', undefined, 3);
		//changeStatValue(o, 'рана', 3, 2);
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
			var isArray = (typeof(value) +'')== 'object'; // string + 5 == isNaN
			if (isArray)
				nStat.value = value;
			else{
				nStat.value = new Array(); nStat.value.push(value);// add a {value1}, non valu1
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
		ut.Trace(" -" + statToString(stat));
	}

	static function A(who, name:String, value, category:String, dateTime:Number, source:Object):Object{
		var newStat = createStat(name, value, category, dateTime, source);
		addStat(who, newStat);
		return newStat;
	}
	static function S(X):Array{
		var res:Array = new Array();
		res.push(X);
		return res;	
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
		if (statExistWithName(who, stat.name)){
			// т.е. если это обычный стат, то низя
			if (stat.category.indexOf ('стат') >= 0){
				ut.Trace(who.name + ' уже имеет уникальный стат с именем "' + stat.name);
				return;
			}
		}
		// check for incomplete stat!
		if (stat.name != undefined){
			var isEmpty = (stat.value.length == 0);
			if (isEmpty){
				ut.TraceDebug('+ добавлено "' + stat.name + '", но, тк значение не передано, ему будет присвоено дефолтное значение.');
				stat = stat_default.getDefaultStat(who, stat.name);
			}
		}
		stat.host = who;
		who.stats.push(stat);
		ut.TraceDebug('+ добавлен стат "' + stat.name+'" y ' + who.name);
		ut.Trace(who.name + ' теперь имеет "' + stat.name+"\"=" + stat.value);
		traceStat(stat);
	}
	
	static function listStats(who){
		ut.Trace(who.name);
		for (var i = 0; i < who.stats.length; ++i)
			traceStat(who.stats[i]);
	}
	
	static function statsWithName(who, statName:String):Array{
		ut.TraceDebug('? найти все статы "' + statName + '", которыми владеет ' + who.name);
		if (who.hasStats != true) return new Array();
		var arr = new Array();
		for (var i = 0; i < who.stats.length; ++i)
			if (who.stats[i].name == statName)
				arr.push(who.stats[i]);
		ut.TraceDebug('+ найдено '+arr.length+' стат(ов) с именем "' + statName);
		return arr;
	}
	
	static function statExistWithName(who, statName):Boolean{
		ut.TraceDebug('? есть ли стат с именем "' + statName + '" у ' + who.name);
		if (who.hasStats != true) return false;
		var arr = new Array();
		for (var i = 0; i < who.stats.length; ++i)
			if (who.stats[i].name == statName)
				return true;
		ut.TraceDebug('- нет стата с именем "' + statName + '"');
		return false;
	}
	
	static function statCountWithName(who, statName:String):Number{
		return statsWithName(who, statName).length;
	}
	
	static function statWithName(who, statName:String, indexMult):Object{
		var arr = statsWithName(who, statName);
		if (arr.length == 0) {ut.TraceDebug('! ' + who.name + ' не имеет стата с именем "' + statName); return undefined;}
		if (arr.length == 1) {ut.TraceDebug('+ найден уникальный стат "' + statName); return arr[0];}
		if (indexMult != undefined) return arr[indexMult];
		ut.Trace('~ ' + who.name + ' имеет ' + arr.length + ' статов с именем "' + statName + '", но т.к. не сказано, какой нужен, выдан первый найденный!');
		return arr[0];
	}
	
	static function watchStatValue(who, statName:String, indexMult):Array{
		ut.TraceDebug('? найти массив значений стата с именем "' + statName + '"');
		return (statWithName(who, statName, indexMult)).value;
	}
	
	static function watchUniqueStatValueParam(who, statName:String, paramIndex):Number{
		if (paramIndex == undefined) paramIndex = 0;
		ut.TraceDebug('? найти '+paramIndex+'-ое значение из массива значений стата с именем "' + statName + '"');
		var res:Array = watchStatValue(who, statName, undefined);
		ut.TraceDebug('+ найден стат с именем "' + statName+'" и значением ' + res); 
		ut.TraceDebug('+ взято значение "' + statName+'"('+paramIndex+') :: ' + res[paramIndex]);
		return res[paramIndex];
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
		if (newValue != undefined){
			ut.TraceDebug('+ изменен стат '+who.stats[statIndex].value[paramNumber] + " -> " + newValue + '    ' + who.name+':'+  who.stats[statIndex].name + ((indexMult != undefined)? (' (' +indexMult+ ')'): ('')));
			who.stats[statIndex].value[paramNumber] = newValue;
			ut.Trace(who.name + ':'+statName + ' менеяется. '+ "Теперь \"" +statName + "\" = "+ who.stats[statIndex].value);
		}
		return who.stats[statIndex];
	}
	
	static function changeUniqueStatValue(who, statName:String, newValue, paramNumber):Object{
		return changeStatValue(who, statName, undefined, newValue, paramNumber);
	}
		
	static function getStatValue(who, statName:String, indexMult):Array{
		ut.TraceDebug('? взять значение стата "' + statName + '" у ' + who.name);
		if (statExistWithName(who, statName))
			return (statWithName(who, statName, indexMult)).value;
		ut.TraceDebug('! в таком случае добавить стат "' + statName + '" с дефолтным значением для ' + who.name);
		A(who, statName);
		// recursive! kidding
		return watchStatValue(who, statName, indexMult);
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