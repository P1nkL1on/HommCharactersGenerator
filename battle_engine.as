class battle_engine{
	static function test(){
		var o1:Object = new Object();
		var o2:Object = new Object();
		o1.name = 'unit1'; o2.name = 'unit2';
		
		unit_stat.setName(o1, undefined, undefined, 'קוכמגוך', 'ל', 25);
		unit_stat.setName(o2, 'Ýכטעם‎', 'ׂג¸נהאÿ סענוכא', '‎כüפ', 'ז', 65);
	
		setMainBattleStats(o1)
		setMainBattleStats(o2)
		
		trace(stat_calculator.showStat(o2, '־ַ'));
	}
	
	static function setMainBattleStats(o:Object){
		stat_engine.A(o, '־ַ');
		stat_engine.A(o, '־ָ');
		
		
		o.hp = stat_engine.watchStatValue(o, '־ַ');
		o.ap = stat_engine.watchStatValue(o, '־ָ');
		
		stat_engine.listStats(o);
	}
}