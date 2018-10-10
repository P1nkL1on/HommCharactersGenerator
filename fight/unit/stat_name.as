class fight.unit.stat_name{
		static var string_names:Array = new Array(
			new Array(-10, 'STR', 	'СИЛ', 	'сила'), 
			new Array(-11, 'CON', 	'ТЕЛ', 	'телосложение'),
			new Array(-12, 'DEX', 	'ЛОВ', 	'ловкость'), 
			new Array(-13, 'INT', 	'ИНТ', 	'интеллект'), 
			new Array(-14, 'WIS', 	'МУД', 	'мудрость'), 
			new Array(-15, 'CHA', 	'ХАР', 	'харизма'),
			new Array(-20, 'max HP','макс ОЗ', 	'максимальное количество Очков Здоровья'), 
			new Array(-21, 'max MP','макс ОМ', 	'максимальное количество Очков Магии'),
			new Array(-22, 'p dmg', 'физ урн', 	'физический урон'),
			new Array(-23, 'm dmg', 'маг урн', 	'магический урон'),
			new Array(-24, 'm spd', 'скор', 	'скорость перемещения'),
			new Array(-25, 'eva', 	'укл', 	'уклонение'),
			new Array(-26, 'ini', 	'ини', 	'инициатива'),
			new Array(-27, 'p def', 'физ защ', 	'физическая защита')
		);

		static var string_style:Number = 3;
		static function getName(stat_id, style):String{
			if (style == undefined)
				style = string_style;
			var stat_ind = 0;
			while (stat_ind <  string_names.length && string_names[stat_ind][0] != stat_id)
				stat_ind++;
			var res = string_names[stat_ind][style];
			if (res == undefined)
				return '???';
			return res;
		}
		

	// first
		static var strength 		= -10;
		static var constituition 	= -11;
		static var dexteriety 		= -12;
		static var intellect 		= -13;
		static var wisdom 			= -14;
		static var charisma			= -15;

		static var STR = -10;
		static var CON = -11;
		static var DEX = -12;
		static var INT = -13;
		static var WIS = -14;
		static var CHA = -15;
	
	// battle
		static var maximum_health		= -20;
		static var maximum_mana 		= -21;
		static var physical_attack 		= -22;
		static var magick_attack 		= -23;
		static var movement_speed 		= -24;
		static var evasion_chance 		= -25;
		static var initiative			= -26;
		static var physical_defence		= -27;
	
	// battle second
		
		
}