class gen_face_man{

	//skin_colors CONST
	static var pink = new Array(0,0,0);
	static var south = new Array(-180,-160,-240);
	static var white = new Array(50,50,50);
	static var yellow = new Array(50,50,-150);
	static var red = new Array(-30,-150,-200);
	static var clrs = new Array(pink,white,yellow,red,south);
	
	
	
	
	static var hr_blond = new Array(101, 92, 18);
	static var hr_orang = new Array(119, 17, -136);
	static var hr_yell = new Array(70, 6, -85);
	static var hr_cary = new Array(45, -20, -62);
	static var hr_brown = new Array(-36, -48, -74);
	static var hr_black = new Array(-79, -81, -91);
	static var hr_gray = new Array(68, 68, 68);
	static var hr_white = new Array(100, 102, 94);
	//								0		1			2			3		4			5 		6 		7
	static var hr_clrs = new Array(hr_brown, hr_yell ,hr_orang ,hr_blond ,hr_cary, hr_black, hr_gray, hr_white  );
	static var hr_clrsColor = new Array(hr_brown, hr_black, hr_gray, hr_white  );
	
	
	// race is 
	// 0 - pink, 1 - white, 2 - yellow, 3 - red, 4 - south
	static function raceRandomColor(raceInd):Array{
		var clrsRand = new Array();
		if (raceInd == 0) clrsRand = new Array(clrs[0], clrs[1], clrs[3], clrs[2], clrs[4]);
		if (raceInd == 1) clrsRand = new Array(clrs[1], clrs[0], clrs[2], clrs[3], clrs[4]);
		if (raceInd == 2) clrsRand = new Array(clrs[2], clrs[0], clrs[1], clrs[3], clrs[4]);
		if (raceInd == 3) clrsRand = new Array(clrs[3], clrs[4], clrs[0], clrs[2], clrs[1]);
		if (raceInd == 4) clrsRand = new Array(clrs[4], clrs[3], clrs[0], clrs[2], clrs[1]);
		
		var ks = new Array(.4 + random(300) / 1000, random(60) / 1000, random(60) / 1000, random(80) / 1000, random(80) / 1000);
		ks.push(1 - ks[0] - ks[1] - ks[2] - ks[3]);
		var rgb:Array = new Array(0,0,0);
		for (var i = 0; i < clrs.length; ++i)
			for (var c = 0; c < 3; ++c)
				rgb[c] += clrsRand[i][c] * ks[i];
		return rgb;
	}
	
	static function raceParentColor(fatherRGB, motherRGB):Array{
		var way = random(4);
		var rgb:Array = new Array(0,0,0);
		for (var c = 0; c < 3; ++c)
			rgb[c] = (way < 2)? (fatherRGB[c] * .5 + motherRGB[c] * .5) : ((way == 2)? fatherRGB[c] : motherRGB[c]);
		return rgb;
	}
	
	static function randomGirlFreeHair(age):Number{
		if (age < 10) return 30 + random(5);
		if (age < 24) return 34 + random(11);
		if (age < 50) return 30 + random(17);
		return (random(3)==0)? (30+random(8)):(44+random(3));
	}
	static function randomGirlLockedHair(age):Number{
		if (age < 10) return 47 + random(15);
		if (age < 50) return 47 + random(19);
		return 70 - random(6);
	}
	
	static function hairRandomStyle(age, gender):Number{
		if (gender != 1){	
			if (age < 2 || age > 90) return 26;			// BOLD WOMEN!
			if ((age < 36 && random(5) != 0) || random(3) == 0)
				return randomGirlFreeHair(age);
			return randomGirlLockedHair(age); 
		}
	
		if (random(8) == 0) return random(26)+1;	// chance to have exactly random hair
		if (age <= 4) return 24 + random(3);		// bold children
		if (age < 13) return random(10) + 1;		// first cool hair with 4-13
		if (age < 25) return random(17) + 1;
		if (age < 45) return 10 + random(12);
		return 12 + random(15);	
	}
	static function manBeardRandomStyle(age):Number{
		if (age <= 10) return 1;			// no beard kids
		if (age < 16) return random(6) + 1;
		if (age < 20) return random(11) + 1;
		if (age < 30) return 2 + random(12);
		if (age < 40) return 8 + random(11);
		if (age < 52) return 12 + random(11);
		return 14 + random(9);	
	}
	static function hairRandomDarkColor():Array{
		return hr_clrsColor[random(3)];
	}
	static function hairRandomColor(age, raceInd):Array{
		if (raceInd == 0){
			if (age < 40) return hr_clrs[random(5)];
			if (age < 50) return hr_clrs[random(5) + 1];
			return hr_clrs[random(3) + 5];
		}
		if (raceInd == 1)
			return hr_clrs[(new Array(3,6,7)[random(3)])];
		
		if (age < 40) return hr_clrsColor[(random(4) == 0)? 0 : 1];
		if (age < 50) return hr_clrsColor[random(4)];
		return hr_clrsColor[2+random(2)];
	}
	static function hairColorOffset(hairRGB:Array, maxOffset):Array{
		return new Array(hairRGB[0] + random(maxOffset * 2) - maxOffset,
						 hairRGB[1] + random(maxOffset * 2) - maxOffset,
						 hairRGB[2] + random(maxOffset * 2) - maxOffset);
	}
	static function hairColorDiff(hairRGB:Array, diff):Array{
		return new Array(hairRGB[0] + diff,
						 hairRGB[1] + diff,
						 hairRGB[2] + diff);
	}
	static function mimicRandomType(age, gender):Number{
		//if (gender != 1) return -1;
		
		if (age < 25) return 1;
		if (age < 40) return 1 + random(3);
		return 3+random(3);
	}
	static function mimicRandomAlpha(age):Number{
		if (age < 25) return 0;
		if (age <= 40) return (age - 25) * 3 + random(10);
		return Math.min(100, (age - 40) * 3 + random(21) - 10);
	}
	static function bodyType(age, gender){
		if (age < 10) return 'kid' + gender;
		if (age < 15) return ((new Array('slim', 'norm'))[random(2)]) + gender;
		if (age < 40) {
			if (gender == 1) return ((new Array('slim', 'norm', 'power', 'fat'))[random(4)]) + 1;
			return ((new Array('slim', 'norm', 'power', 'fat','norm', 'fat'))[random(6)]) + 0;
		}
		if (age < 55) return ((new Array('slim', 'norm', 'old', 'fat'))[random(4)]) + gender;
		return ((new Array('slim', 'old', 'fat'))[random(3)]) + gender;
	}
	static function titsType(age){
		if (age < 10) return 1 + random(2);
		if (age < 18) return 1 + random(6);
		if (age < 29) return 2 + random(8);
		if (age < 45) return 4 + random(7);
		return 7 + random(4);
	}
	static function bodyHairTypeLeg(age, raceInd, bodyHair):Number{
		var func = Math.min;
		if (raceInd > 1) func = Math.max;
		if (age <= 10) return 10;
		if (age <= 16) return func(bodyHair, 10 - random(5));
		if (age <= 25) return func(bodyHair, 10 - random(8));
		return func(bodyHair, 1 + random(8));
	}
	static function bodyHairTypeBody(age, raceInd):Number{
		var dif = 1;
		if (raceInd > 1) dif = 2;
		if (age <= 10) return 13 - Math.floor(random(3) / dif);
		if (age <= 18) return 13 -  Math.floor(random(6) / dif);
		if (age <= 50) return 9 - Math.floor(random(9) / dif);
		return 10 - Math.floor(random(10) / dif);
	}
	static function bodyHairTypeAss(age):Number{
		if (age <= 8) return 5;
		if (age <= 15) return 4 - random(4);
		return 1+random(2);
	}
	static function randomBodyHairColor (raceInd, hair2){
		return ((random(2+raceInd)) && raceInd != 1 && !(!random(5) && hair2[0]>50))? hairRandomDarkColor() : 
				hairColorDiff(hair2, -(5+random(15)));
	}
	static function randomHandType (bodyT, gender):Number{
		if (bodyT.indexOf('kid') == 0) return 5;
		if (bodyT.indexOf('old') == 0) return (new Array(1,2,5))[random(3)];
		if (bodyT.indexOf('slim') == 0) return 2;
		if (gender == 0) return 1 + 5 * random(2);
		if (bodyT.indexOf('power') == 0) return 3+random(2);
		return 1+random(3);
	}
	
	
	// gender : male = 1, female = 0
	static function generateView(person, age, gender, raceInd){
		person.age = age;
		person.gender = gender;
		person.raceInd = raceInd;
		
		
		do {person.view_head_type = random(9 - 2*gender)+1; }while(person.view_head_type == 7 && !gender);
		person.view_ears_type = random(7)+1
		person.view_eyes_type = 	(!gender)? (1+random(19)) : (10+random(20))
		person.view_broves_type = 	(!gender)? (1+random(9)) : (1+random(15))
		person.view_nose_type = 	(!gender)? (1+random(16)) : (6+random(18))
		person.view_mouth_type = 	(!gender)? (1+random(15)) : (10+random(20))
		person.view_hair_type = hairRandomStyle(age, gender)
		person.view_hair2_type = (gender == 1)? manBeardRandomStyle(age) : 1;
		person.view_mimic_type = mimicRandomType(age, gender);
		person.view_mimic_alpha = mimicRandomAlpha(age);
		person.view_hair_color = hairColorOffset(hairRandomColor(age, raceInd), 10);
		person.view_hair2_color = hairColorOffset(person.view_hair_color, 15);
		person.view_skin_color = raceRandomColor(raceInd);
		person.view_head_scaleX = 95+random(11);
		person.view_head_scaleY = 95+random(11);
		person.view_head_eye_scale = 70 + random(51);
		person.view_body_scaleX = 96 + random(8);
		person.view_body_scaleY = 94 + random(8 + 6 * gender);
		
		person.view_hair_body_color = randomBodyHairColor(raceInd, person.view_hair2_color);
		person.view_body_type = bodyType(age, gender);
		person.view_body_hair_body_type = bodyHairTypeBody(age, raceInd);
		person.view_body_hair_ass_type = bodyHairTypeAss(age);
		person.view_body_hair_leg_type = bodyHairTypeLeg(age, raceInd, person.view_body_hair_body_type);
		
		if (!gender){// female
			person.view_tit_type = titsType(age);
			person.view_body_hair_leg_type = Math.min(10-1*(age>20), Math.round(person.view_body_hair_leg_type + 4));
		}
		person.view_hand_type = randomHandType(person.view_body_type, gender);
	}
	
	static function proectFace(person, head){
		head.gotoAndStop(person.view_head_type);
		head.ears.gotoAndStop(person.view_ears_type);
		head.broves.gotoAndStop(person.view_broves_type);
		head.eyes.gotoAndStop(person.view_eyes_type);
		head.nose.gotoAndStop(person.view_nose_type);
		head.mouth.gotoAndStop(person.view_mouth_type);
		head.hair.gotoAndStop(person.view_hair_type);
		head.hair2.gotoAndStop(person.view_hair2_type);
		head.mimic.gotoAndStop(person.view_mimic_type);
		head.mimic._alpha = (person.view_mimic_alpha);
		head.eyes._xscale = head.eyes._yscale = person.view_head_eye_scale;
				
		ut.colorTo(head.skin, person.view_skin_color);
		ut.colorTo(head.ears.skin, person.view_skin_color);
		ut.colorTo(head.hair, person.view_hair_color);
		ut.colorTo(head.hair2, person.view_hair2_color);
		
		head.cacheAsBitmap = true;
	}
	
	static var bodyPartNames = 't012345';
	
	static function proectBody(person, person_model:MovieClip){
		person_model.gotoAndStop(person.view_body_type);
		if (person.view_tit_type != undefined){
			person_model.tits.gotoAndStop(person.view_tit_type);
			ut.colorTo(person_model.tits.skin, person.view_skin_color);
		}
		//var invalid = random(3);if (random(3))while(--invalid > 0)person.nextFrame();
		// hands
		var hands:Array = new Array(person_model.hand_right, person_model.hand_left, person_model.hand_right2, person_model.hand_left2);
		for (var i = 0; i < 4; ++i) if (hands[i] != undefined){
			hands[i].gotoAndStop(person.view_hand_type);
			ut.colorTo(hands[i].skin, person.view_skin_color);
		}
		
		ut.colorTo(person_model.skin, person.view_skin_color);
		for (var i = 0; i < 7 + 4; ++i){
			var gotoFrame = person.view_body_hair_leg_type;
			if (i == 1) gotoFrame = person.view_body_hair_ass_type;
			if (i == 0) gotoFrame = person.view_body_hair_body_type;
			
			var hair_element = person_model['h'+bodyPartNames.charAt(i)];
			if (i >= 7){ 
				var hand = hands[Math.floor((i - 7)/2 + .1)];
				hair_element = hand['h'+((i - 7) % 2 + 1)]; 
			}
			hair_element.gotoAndStop(gotoFrame);
			ut.colorTo(hair_element, person.view_hair_body_color);
		}
		person_model._xscale = person.view_body_scaleX;
		person_model._y -= person._height * (person.view_body_scaleY - 100)/200;
		person_model._yscale = person.view_body_scaleY;
		
		person_model.info.text = Math.round(person.age);//+' '+person.raceInd;
		person_model.cacheAsBitmap = true;
	}
	
}