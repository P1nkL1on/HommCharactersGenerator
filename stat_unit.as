class stat_unit{

	// ��� ����� ���������� �������� � ������������� ������� �������
	// ��� �������� ���������� ������� �����
	
	

	// name == ���, �������, lastName - �������, race - �������
	// �� ���� �������\����. �� ���������� ���� ��� � �� ������ (������� ��������\����������!)
	// gender = {� | � | � | ? | -}
	// ������� ������� �������� ���������� ������� ���� ��������� ������ ����!
	// age - ������� � ������!!!!1
	// 
	static function setName(who, name, lastName, race, gender, age){
		if (race == undefined) race = '������������ �����';
		if (gender == undefined) gender = '?';
		if (age == undefined) age = -1;
		stat_engine.addStat(who, new Array('����', race));
		stat_engine.addStat(who, new Array('�������', age));
		stat_engine.addStat(who, new Array('���', gender));
		stat_engine.addStat(who, new Array('���', name));
		stat_engine.addStat(who, new Array('�������', lastName));
	}

}