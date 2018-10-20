class unit_stat{

	// все имена параметров задаются в универсальной русской таблице
	// все значения параметров указаны далее
	
	

	// name == имя, символы, lastName - фамилия, race - словами
	// по типу человек\эльф. не приплетать сюда пол и всё прочее (никаких эльфийка\скелетонша!)
	// gender = {М | Ж | Б | ? | -}
	// мужчина женщина безполый неизвестно понятие пола непринимо вообще бляд!
	// age - возраст в ДНЯХХХ!!!!1
	// 
	static function setName(who:Object, name:String, lastName:String, race:String, gender:String, dateBirth){
		
		stat_engine.addStat(who, stat_engine.createStat('ðàñà', race, 'áèîãðàôèÿ'));
		stat_engine.addStat(who, stat_engine.createStat('ïîë', gender, 'áèîãðàôèÿ'));
		stat_engine.addStat(who, stat_engine.createStat('ðîæäåíèå', dateBirth, 'áèîãðàôèÿ'));
		
		stat_engine.addStat(who, stat_engine.createStat('èìÿ', name, 'áèîãðàôèÿ'));
		stat_engine.addStat(who, stat_engine.createStat('ôàìèëèÿ', lastName, 'áèîãðàôèÿ'));
		
		var resName = stat_engine.watchUniqueStatValueParam(who, 'èìÿ');
		var resLastName = stat_engine.watchUniqueStatValueParam(who, 'ôàìèëèÿ');
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