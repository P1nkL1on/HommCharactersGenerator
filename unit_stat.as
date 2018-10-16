class unit_stat{

	static function setName(who:Object, name:String, lastName:String, race:String, gender:String, dateBirth){
		
		stat_engine.addStat(who, stat_engine.createStat('раса', race, 'биография'));
		stat_engine.addStat(who, stat_engine.createStat('пол', gender, 'биография'));
		stat_engine.addStat(who, stat_engine.createStat('рождение', dateBirth, 'биография'));
		
		stat_engine.addStat(who, stat_engine.createStat('имя', name, 'биография'));
		stat_engine.addStat(who, stat_engine.createStat('фамилия', lastName, 'биография'));
		
		var resName = stat_engine.watchUniqueStatValue(who, 'имя');
		var resLastName = stat_engine.watchUniqueStatValue(who, 'фамилия');
		trace(resName + '/' + resLastName);
		var finName = "";
		if (resName != undefined)
			finName += (resName.length < 4)? (resName) : (resName.substring(0,4)); 
		if (resLastName != undefined)
			finName += (resLastName.length < 4)? (resLastName) : (" " + resLastName.substring(0,4)); 
		if (finName.length > 0)
			who.name = finName;
	}
	
}