// if we get some stat from a unit, but he has none of it, we come here!!

class stat_default{

	
	static var statDefault = new Array(
		
		// параметр имя имеет некоторые дефолтные значения
		// 
		new Array(new Array('name', 'имя'), 
			new Array('раса-гном;пол-Ж', 'Марта'),
			new Array('раса-гном;пол-М', 'Ульрих'),
			new Array('раса-человек;пол-Ж', 'Мари'),
			new Array('раса-человек;пол-М', 'Вильям'),
			new Array('', '??')
			),
		new Array(new Array('lastname', 'фамилия'), 
			new Array('раса-гном', 'Берсон'),
			new Array('раса-человек', 'Стоун'),
			new Array('', '??')
			),
			
		new Array(new Array('str','strength','сил','сила'), new Array('', 8)),
		new Array(new Array('dex','dexterity','лов','ловкость'), new Array('', 8)),
		new Array(new Array('con','constitution','тел','телосложение'), new Array('', 8))
	
	);

	// static function goCheckCondition(who, template):Boolean{
		// !!!ut.Trace('  testing ' + who.name + " for a " + template);
		// var rules:Array = template.split(';');
		// var result = true;
		// for (var i = 0; i < rules.length; ++i){
			// rules[i] = rules[i].split('-');
			// !!!если параметр 1 и его у юнита совсем нету, то сразу нет
			// var hasThatParam = stat_engine.hasStatWithName(who, rules[i][0]);
			// if (hasThatParam == false){ /* ut.Trace(' X ' + who.name + ' do not have a stat ' + rules[i][0]); */ return false; }
			
			// var statInd = stat_engine.statIndex(who, rules[i][0]);
			// var paramVal = rules[i][1];
			// var isInArray = false;
			// for (var j = 0; j < who.stats[statInd].length; ++j)
				// if (who.stats[statInd][j] == paramVal) isInArray = true;
			// if (isInArray != true)
				// { /* ut.Trace(' X ' + who.name + ': ' + rules[i][0] + ' is not ' + rules[i][1]); */ return false; }
		// }
		// ut.Trace('  Luckly, ' + who.name + ' is ' + template);
		// return result;
	// }
	
	 static function getDefaultStat(who, statName):Object{
		// ut.Trace('  Finding a default value for ' + who.name + ': ' + statName);
		// var resultStat:Array = new Array();
		// resultStat.push(statName);
		// for (var stDefInd = 0; stDefInd < statDefault.length; ++stDefInd){
			// var statNameVariants = statDefault[stDefInd][0];
			// var nameIndT = -1;
			// for (var nameInd = 0; nameInd < statDefault[stDefInd][0].length; ++nameInd){
				// var possibleName = statDefault[stDefInd][0][nameInd];
				// !!!!!!!!!! ut.Trace('  Equals? ' + statName + '  ' + possibleName);
				// if (possibleName == statName || (possibleName.charAt(0) == '%' && (statName.indexOf(possibleName.substr(1)) >= 0)))
					// {nameIndT = nameInd; ut.Trace('  Exist a default param with name ' + statName + ': ' + nameIndT);break;}
			// }
			// if (nameIndT >= 0){
				// var statName = statDefault[stDefInd][0][nameIndT];
				// for (var caseInd = 1; caseInd < statDefault[stDefInd].length; ++caseInd){
					// var goCopy = false;
					// if (statDefault[stDefInd][caseInd][0] == '' )	// no condition
						// goCopy = true;
					// else
						// goCopy = goCheckCondition(who, statDefault[stDefInd][caseInd][0]);// go check condition
					// if (goCopy == true){
						// for (var i = 1; i < statDefault[stDefInd][caseInd].length; ++i)
							// resultStat.push(statDefault[stDefInd][caseInd][i]);
						// ut.Trace('  So, ' + statName + ' becomes -> ' + resultStat);
						// return resultStat;
					// }						
				// }
				
				// ut.Trace('Bad, but there is no default values with condition getting. ' + who + ' ' + statName);
			// }
		// }
		// resultStat.push(undefined);
		// return resultStat;
		return undefined;
	}
}