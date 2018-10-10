import fight.unit.stat_name;

class fight.unit.buff_template{

	// длительность любого бафа даётся в часах

	static var weak_tiredness 			= 1001;
	static var fatigue					= 1002;


	static function giveBuffableStatus (person){
		// сделать юнита или что либо ещё восприимчивым к юафам и дебафам
		person.buffs = new Array();
		// like new Array(arr..., new Array(-11, '+3', '10 ч.', 'принимал растишку утром') , ...arr)
		person.buffs_string = new Array();
	}
	
	
	static function applyBuff(buff_id, buff_length):Number{
		person.buffs.push(buff_id);
		person.buffs.push(buff_length);
	}
	
	static function getBuffStatChange(person, buff_id):Array{
		// усталость - снижает силу, ловкость, мудрость
		if (buff_id == weak_tiredness) 	return new Array(stat_name.STR, -2, stat_name.DEX, -2, stat_name.WIS, -1);
		if (buff_id == fatigue) 		return new Array(stat_name.STR, -3, stat_name.DEX, -4, stat_name.WIS, -2);
	}
	static function defaultBuffLength(buff_id):Number{
		if (buff_id == weak_tiredness) 	return 8;
		if (buff_id == fatigue) 		return 6;
	}
	
	// setOrRemove = 1 - if you apply buff, -1 - if you want to finish buff
	// stat array - is {stad1_id, stat1_changeValue, stat2_id, stat2_changeValue, . .. etc}
	static function applyStatChange(person, setOrRemove, stat_array){
		if (person.stats == undefined)
			trace('Error! Can not change stats of ' + person.name+ ' cause he does not have any!');
		if (setOrRemove == undefined)
			setOrRemove = 1;
		for (var i = 0; i < stat_array.length / 2; ++i)
			person.addStat(stat_array[2 * i], setOrRemove * stat_array[2 * i + 1]);
	}

}