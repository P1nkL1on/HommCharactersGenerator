class unit_stat{

	static function setName(who:Object, name:String, lastName:String, race:String, gender:String, dateBirth){
		
		stat_engine.addStat(who, stat_engine.createStat('����', race, '���������'));
		stat_engine.addStat(who, stat_engine.createStat('���', gender, '���������'));
		stat_engine.addStat(who, stat_engine.createStat('��������', dateBirth, '���������'));
		
		stat_engine.addStat(who, stat_engine.createStat('���', name, '���������'));
		stat_engine.addStat(who, stat_engine.createStat('�������', lastName, '���������'));
		
		var resName = stat_engine.watchUniqueStatValue(who, '���');
		var resLastName = stat_engine.watchUniqueStatValue(who, '�������');
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