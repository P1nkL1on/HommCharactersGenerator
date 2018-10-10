import fight.unit.buff_template;


class fight.unit.stat_system{
	
	static function givePermanentBaseStats(person){
		if (person.stats != undefined)
			return;
		// stats is Array as  { stat_1_id, stat1_value, stat2_id, stat2_value... etc }
		person.stats = new Array();
		
		person.getStat = function(stat_id){
			if (this.stats == undefined) return -1;
			var stat_ind = arrIndexOf(this.stats, stat_id);
			if (stat_ind == -1) 
				return -1;
			// return value of stat
			return this.stats[stat_ind + 1];
		}
		person.setStat = function (stat_id, stat_value){
			if (this.stats == undefined){
				trace("Can not add stats to " + this.name);
				return;
			}
			var stat_ind = arrIndexOf(this.stats, stat_id);
			if (stat_ind < 0){
				this.stats.push(stat_id);
				this.stats.push(stat_value);
				trace("Stat " + stat_id + " of " + this.name + " added and set to " + stat_value);
				return;
			}
			this.stats[stat_ind + 1] = stat_value;
			trace("Stat " + stat_id + " of " + this.name + " set to " + stat_value);
		}
		person.traceStats = function (string_style){
			for (var i = 0; i < this.stats.length / 2; ++i)
				trace(this.name + '\'s ' + stat_name.getName(this.stats[i * 2], string_style) + ' : ' + this.stats[i * 2 + 1]);
		}
		person.addStat = function (stat_id, stat_add_value){
			setStat(stat_id, getStat(stat_id) + stat_add_value);
		}
		
		if (first_stats != undefined)
			for (var i = 0; i < basicFirstStat.length; ++i)
				person.stats.push(basicFirstStat[i]);
	}
	
	
	static function arrIndexOf(arr, val):Number{
		if (arr == undefined)
			return -1;
		for (var i = 0; i < arr.length; ++i)
			if (arr[i] == val)
				return i;
		return -1;
	}
	static var basicFirstStat = new Array(-10, 10, -11, 8, -12, 5, -13, 5, -14, 5, -15, 5);
	
	
	static function test(){
		var hu:Object = new Object;
		hu.name = 'human';
		giveStatArraysIfNone(hu, true);
		trace(hu);
		trace(hu.name);
		hu.setStat(stat_name.STR, 1);
		hu.traceStats();
	}
}