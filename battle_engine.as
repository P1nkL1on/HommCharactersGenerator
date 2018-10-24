class battle_engine{
	static function test(){
		var o1:Object = new Object();
		var o2:Object = new Object();
		o1.name = 'unit1'; o2.name = 'unit2';
		
		unit_stat.setName(o1, undefined, undefined, 'человек', 'м', 25);
		unit_stat.setName(o2, 'Элитнэ', 'Твёрдая стрела', 'эльф', 'ж', 65);
	
		stat_engine.A(o1, 'максимальное ОЗ');
		stat_engine.A(o2, 'максимальное ОЗ');
	}
}