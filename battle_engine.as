class battle_engine{
	static function test(){
		var o1:Object = new Object();
		var o2:Object = new Object();
		o1.name = 'unit1'; o2.name = 'unit2';
		
		unit_stat.setName(o1, undefined, undefined, '�������', '�', 25);
		unit_stat.setName(o2, '������', '������ ������', '����', '�', 65);
	
		stat_engine.A(o1, '������������ ��');
		stat_engine.A(o2, '������������ ��');
	}
}