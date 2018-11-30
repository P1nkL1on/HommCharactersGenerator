class stat_calculator{
	
	static var baseHealth = 20;
	static var healthRaceModifier = new Array(
		'человек', 0,
		'эльф', 2,
		'гном', -3
	);
	static var heatlhGenderModifier = new Array(
		'м', 0,
		'ж', -3
	);

	static function baseHP (who):Number{
		return summ( who, new Array(
			'базовое ОЗ',
			'база',			baseHealth,
			'раса',			select (healthRaceModifier, stat_engine.getStatValue(who, 'раса')[0]),
			//'телосложение',	stat_engine.getStatValue(who, 'телосложение')[0],
			'пол',	select (heatlhGenderModifier, stat_engine.getStatValue(who, 'пол')[0])));
	}
	
	static function maxHP (who):Number{
		return summ( who, new Array(
			'максимальное ОЗ',
			'базовое ОЗ',	stat_engine.getStatValue(who, 'базовое ОЗ')[0],
			'телосложение',	stat_engine.getStatValue(who, 'телосложение')[0]));
		// ++ items
	}	
	static function curHP (who):Number{
		return summ( who, new Array(
			'ОЗ',
			'максимальное ОЗ',	stat_engine.getStatValue(who, 'максимальное ОЗ')[0]));
	}
	
	
	
	static function select (from, wh){
		for (var i = 0; i < from.length; i += 2)
			if (from[i] == wh)
				return from[i+1];
		return undefined;
	}
	
	static function summ(who, params:Array):Number{
		var res = 0;
		var str = "";
		for (var i = 2; i < params.length; i+=2)
		if (params[i] != undefined)
		{
			//check the same
			var existStat = showStat(who, params[i - 1]);
			res += params[i];
			if (existStat != undefined){
				str += '+' + params[i] + " " + params[i - 1] +"\n\t" + replace(existStat, '\n', '\n\t')+"\n"; continue;
			}
			//
			if (params[i] == 0) continue;
			str += ((str != "")?'\n':'') + ((params[i] > 0)? ("+" + params[i]+' '):(params[i]+' '));
			str += " " + params[i-1];
		}
		addInfo(who, params[0], str);
		return res;
	}

	static function showStat(who, statName):String{
		for (var j = 0; j < who.calculation_info.length; j += 2)
			if (who.calculation_info[j] == statName)
				return who.calculation_info[j+1];
		return who.name + ":" + statName + ' задано извне.';
	}
	// static function findStatDescription(who, statName):String{
		////trace(who.calculation_info);
		// var d;
		// var stN;
		// var dSp;
		// var res = "";
		// var foundAny:Boolean = false;
		// for (var i = 1; i < who.calculation_info.length; i+=2){
			// stN = who.calculation_info[i - 1];
			// d = who.calculation_info[i];
			// if (stN != statName) continue;
			//// trace("name: " + stN + '\ndescr: ' + );
			// dSp = d.split('\n');
			// foundAny = true;
			// for (var i = 0; i < dSp.length; ++i)if (dSp[i] != ''){
				//    var adS = findStatDescription(who, dSp);
				// var dpsisp = dSp[i].split(' ').splice(2).join(' ');
				// var res_add = 'ok';
				//   var res_add = findStatDescription(who, dpsisp);
				// if (res_add == undefined)
					// res += dSp[i].substring(0, dSp[i].indexOf(' ')) + ' база';
				// else
					// res += res_add;
				// res += "\n";
			// }
		// }
		// if (!foundAny)
			// return undefined;
			
		// return res;
	// }
	
	
	
	static function addInfo (who, statName, statCalculation){
		who.calculation_info.push(statName);
		who.calculation_info.push(statCalculation);
	}
	
	static function replace (S, c1, c2){
		var res = "";
		for (var i = 0; i < S.length; ++i)
			if (S.charAt(i) == c1)
				res += c2;
			else
				res += S.charAt(i);
		return res;
	}
}