class stat_unit{

	// все имена параметров задаются в универсальной русской таблице
	// все значения параметров указаны далее
	
	

	// name == имя, символы, lastName - фамилия, race - словами
	// по типу человек\эльф. не приплетать сюда пол и всё прочее (никаких эльфийка\скелетонша!)
	// gender = {М | Ж | Б | ? | -}
	// мужчина женщина безполый неизвестно понятие пола непринимо вообще бляд!
	// age - возраст в ДНЯХХХ!!!!1
	// 
	static function setName(who, name, lastName, race, gender, age){
		if (race == undefined) race = 'неопознанная хуйня';
		if (gender == undefined) gender = '?';
		if (age == undefined) age = -1;
		stat_engine.addStat(who, new Array('раса', race));
		stat_engine.addStat(who, new Array('возраст', age));
		stat_engine.addStat(who, new Array('пол', gender));
		stat_engine.addStat(who, new Array('имя', name));
		stat_engine.addStat(who, new Array('фамилия', lastName));
	}

}