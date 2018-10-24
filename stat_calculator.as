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
		return summ( new Array(
			'база',			baseHealth,
			'раса',			select (healthRaceModifier, stat_engine.getStatValue(who, 'раса')[0]),
			//'телосложение',	stat_engine.getStatValue(who, 'телосложение')[0],
			'пол',	select (heatlhGenderModifier, stat_engine.getStatValue(who, 'пол')[0])));
	}
	
	static function maxHP (who):Number{
		return summ( new Array(
			'базовое ОЗ',	stat_engine.getStatValue(who, 'базовое ОЗ')[0],
			'телосложение',	stat_engine.getStatValue(who, 'телосложение')[0]));
	}	
	
	
	
	static function select (from, wh){
		for (var i = 0; i < from.length; i += 2)
			if (from[i] == wh)
				return from[i+1];
		return undefined;
	}
	
	static function summ(params:Array):Number{
		var res = 0;
		var str = "";
		for (var i = 1; i < params.length; i+=2)
		if (params[i] != undefined)
		{
			res += params[i];
			if (params[i] == 0) continue;
			str += (params[i] > 0)? ("+" + params[i]+' '):(params[i]+' ');
			str += " " + params[i-1]+'\n';
		}
		trace('@@ -> '+res+'\n' + str);
		return res;
	}

}