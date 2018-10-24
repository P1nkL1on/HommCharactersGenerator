// if we get some stat from a unit, but he has none of it, we come here!!

class stat_default{

	static var statDefaultCategory = new Array(
		new Array('биография', new Array('имя','фамилия','отец','мать','брак','рождение','раса','пол'))
		,new Array('состояние-болезнь', new Array('рана','перелом'))
		,new Array('стат', new Array(2,3,4))
	);
	
	static var statDefault = new Array(
		new Array(new Array('name', 'имя'),
			new Array('раса:гном|пол:ж', 'Марта'),
			new Array('раса:гном|пол:м', 'Ульрих'),
			new Array('раса:человек|пол:ж', 'Мари'),
			new Array('раса:человек|пол:м', 'Вильям'),
			new Array('', 'Безымянный')
			),
		new Array(new Array('lastname', 'фамилия'), 
			new Array('раса:гном', 'Берсон'),
			new Array('раса:человек', 'Стоун'),
			new Array('', 'Безфамильный')
			),
			
		new Array(new Array('str','strength','сил','сила'), new Array('', 8)),
		new Array(new Array('dex','dexterity','лов','ловкость'), new Array('', 8)),
		new Array(new Array('con','constitution','тел','телосложение'), new Array('', 8)),
		
		new Array(new Array('base HP', 'базовое ОЗ'), new Array('', stat_calculator.baseHP)),
		new Array(new Array('max HP', 'максимальное ОЗ'), new Array('', stat_calculator.maxHP))
	
	);	
	
	
	
	
	
	
	
	
	
	static function findDefaultCategory(statName){
		for (var i = 0; i < statDefaultCategory.length; ++i)
			for (var j = 0; j < statDefaultCategory[i][1].length; ++j)
				if (statName == statDefaultCategory[i][1][j])
					return statDefaultCategory[i][0];
		return 'стат';
	}
	
	static function goCheckCondition(who, template):Boolean{
		var rules:Array = template.split('|');
		var result = true;
		for (var i = 0; i < rules.length; ++i){
			rules[i] = rules[i].split(':');
			var statNam = rules[i][0];
			var paramVal = rules[i][1];
			
			var val = stat_engine.watchStatValue(who, statNam);
			
			var found = false;
			for (var j = 0; j < val.length; ++j)
				if (val[j] == paramVal) found = true;
			if (found != true)
				{ ut.TraceDebug('- ' + who.name + ': ' + rules[i][0] + ' - не ' + paramVal);  return false; }
		}
		ut.TraceDebug('> Шаблон подходит: ' + who.name + ' является ' + template);
		return result;//result;
	}
	
	 static function getDefaultStat(who, statName):Object{
		ut.TraceDebug('? найти дефолтное значение для ' + who.name + ': ' + statName);
		var resStatName:String = statName;
		var resStatValue:Array = new Array();
		//resultStat.push();
		for (var stDefInd = 0; stDefInd < statDefault.length; ++stDefInd){
			var statNameVariants = statDefault[stDefInd][0];
			var nameIndT = -1;
			for (var nameInd = 0; nameInd < statDefault[stDefInd][0].length; ++nameInd){
				var possibleName = statDefault[stDefInd][0][nameInd];
				if (possibleName == statName || (possibleName.charAt(0) == '%' && (statName.indexOf(possibleName.substr(1)) >= 0)))
					{nameIndT = nameInd; ut.TraceDebug('+ Существует параметр с именем "' + statName + '": ' + nameIndT);break;}
			}
			if (nameIndT >= 0){
				var statName = statDefault[stDefInd][0][nameIndT];
				for (var caseInd = 1; caseInd < statDefault[stDefInd].length; ++caseInd){
					var goCopy = false;
					if (statDefault[stDefInd][caseInd][0] == '' )	// no condition
						goCopy = true;
					else
						goCopy = goCheckCondition(who, statDefault[stDefInd][caseInd][0]);// go check condition
					if (goCopy == true){
						for (var jj = 1; jj < statDefault[stDefInd][caseInd].length; ++jj){
							if (typeof(statDefault[stDefInd][caseInd][jj])+'' == 'function'){
								resStatValue.push(statDefault[stDefInd][caseInd][jj](who));
								ut.TraceDebug('Рассчёт параметра '+statName+' по функции.');
							}
							else
								resStatValue.push(statDefault[stDefInd][caseInd][jj]);
						}
						
						var newStat = stat_engine.createStat(resStatName, resStatValue);
						newStat.category = findDefaultCategory(newStat.name);
						ut.Trace('Дефолтное значение для "' + statName + '" становится -> ' + stat_engine.statToString(newStat));
						
						return newStat;
					}						
				}
				
				ut.TraceDebug('- В базе дефолтных значений, нет правильного значения для ' + who + ':' + statName+ ', ему присвоено значение пустого массива {}');
			}
		}
		return stat_engine.createStat(resStatName, undefined);
	}
}