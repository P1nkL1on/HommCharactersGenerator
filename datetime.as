

	class datetime{
		static var defaultYear = 1200;
		static var n_Years = 0;
	
		static var n_Days = 0;
		static var n_DaysMax = 31;
		static var info_months:Array =
			new Array(new Array(28, 'темень','январь'),
					  new Array(21, 'стоич','февраль'),
					  new Array(14, 'родень','март'),
					  new Array(21, 'свет','апрель'),
					  new Array(21, 'кемарь','май'),
					  new Array(14, 'грешен','июнь'),
					  new Array(28, 'сухан','июль'),
					  new Array(14, 'здвезд','август'),
					  new Array(28, 'пожён','сентябрь'),
					  new Array(28, 'злат','октябрь'),
					  new Array(21, 'ветер','ноябрь'),
					  new Array(21, 'хлад','декабрь'));
		
		static var n_Months = 4;
		static var n_MonthsMax = 12;
		
		static var n_DayPart = 0;
		static var n_DayPartMax = 4;
		static var info_DayPartNames:Array =
			new Array('утро', 'день', 'вечер', 'ночь');
		
		
		// вывести дату
		static function traceDate(format){
			if (format == undefined)
				format = 2;
			trace(dateString(format));
		}
		
		// возвращает строку с датой по стилю
		static function dateString(style):String{
			if (style == undefined){
				style = 1;
				// 1 == full
				// 2 == minimum info
				// 3 == numbers only
				
				// 11 == full with month style2
				// 12 == minimum info with month style2
				// 13 == numbers only with month style2
				
				// etc
			}
			
			var monthNameStyle:Number = Math.floor(style / 10) + 1;
			var etcStyle:Number = style % 10;
			if (etcStyle == 1)
				return info_DayPartNames[n_DayPart] + " " + (n_Days+1)+"-го дня месяца "
					+ info_months[n_Months][monthNameStyle]
					+", год " + (defaultYear + n_Years);
			if (etcStyle == 2)
				return (defaultYear + n_Years)+" год " + info_months[n_Months][monthNameStyle]+" " + (n_Days+1)+"-ое, "
						+ info_DayPartNames[n_DayPart];
			if (etcStyle == 3)
				return (n_Months+1)+"." + (n_Days+1)+": "
						+ info_DayPartNames[n_DayPart];
			if (etcStyle == 4)
				return (n_Months+1)+"." + (n_Days+1)+":" + n_DayPart;
		}
		
		// пропустить сколько то тактов времени
		static function incTime(times, traceWhat){
			if (times == undefined)
				times = 1;
			if (traceWhat == undefined)
				traceWhat = 0;
			// traceWhat == 0 -- trace nothing
			// traceWhat == 1 -- trace only at end
			// traceWhat == 2 -- trace if year change
			// traceWhat == 3 -- trace if month change
			// traceWhat == 4 -- trace if day change
			// traceWhat == 5 -- trace all
			var needTrace:Boolean = false;
			if (traceWhat == 5)
				needTrace = true;
				
			n_DayPart++;
			if (n_DayPart >= n_DayPartMax){
				n_DayPart = 0;
				n_Days++;
			}
			if (n_Days >= info_months[n_Months % 12][0]){
				n_Days = 0;
				n_Months++;
			}
			if (n_Months >= n_MonthsMax){
				n_Years++;
				n_Months = 0;
			}
		}
	}