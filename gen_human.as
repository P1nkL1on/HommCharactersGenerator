class gen_human{

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
	
	static function hairRandomStyle(age, gender):Number{
		if (gender != 1)	return 26;			// BOLD WOMEN!
	
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
	static function hairRandomColor(age, raceInd):Array{
		if (raceInd <= 1){
			if (age < 40) return hr_clrs[random(5)];
			if (age < 50) return hr_clrs[random(5) + 1];
			return hr_clrs[random(3) + 5];
		}
		if (age < 40) return hr_clrsColor[(random(4) == 0)? 0 : 1];
		if (age < 50) return hr_clrsColor[random(4)];
		return hr_clrsColor[2+random(2)];
	}
	static function hairColorOffset(hairRGB:Array, maxOffset):Array{
		return new Array(hairRGB[0] + random(maxOffset * 2) - maxOffset,
						 hairRGB[1] + random(maxOffset * 2) - maxOffset,
						 hairRGB[2] + random(maxOffset * 2) - maxOffset);
	}
	static function mimicRandomType(age, gender):Number{
		if (gender != 1) return -1;
		
		if (age < 25) return 1;
		if (age < 40) return 1 + random(3);
		return 3+random(3);
	}
	static function mimicRandomAlpha(age):Number{
		if (age < 25) return 0;
		if (age <= 40) return (age - 25) * 3 + random(10);
		return Math.min(100, (age - 40) * 3 + random(21) - 10);
	}
	
	// gender : male = 1, female = 0
	static function generateFace(person, age, gender, raceInd){
		//trace('Age: ' + age + '   Gender: ' + gender + '    Race: ' + raceInd);
		
		person.view_head_type = random(7)+1
		person.view_ears_type = random(7)+1
		person.view_eyes_type = random(20)+1
		person.view_broves_type = random(15)+1
		person.view_nose_type = random(18)+1
		person.view_mouth_type = random(20)+1
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
		
		
	}
		// hr_clr_ind = random(hr_clrs.length);
		// hr_clr = new Array(hr_clrs[hr_clr_ind][0]+random(19)-9,
						   // hr_clrs[hr_clr_ind][1]+random(19)-9,`
						   // hr_clrs[hr_clr_ind][2]+random(19)-9);
		// br_clr = new Array(hr_clrs[hr_clr_ind][0]+random(29)-14,
						   // hr_clrs[hr_clr_ind][1]+random(29)-14,
						   // hr_clrs[hr_clr_ind][2]+random(29)-14);
		
		
	
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
		head._xscale = person.view_head_scaleX; 
		head._yscale = person.view_head_scaleY;
				
		ut.colorTo(head.skin, person.view_skin_color);
		ut.colorTo(head.ears.skin, person.view_skin_color);
		ut.colorTo(head.hair, person.view_hair_color);
		ut.colorTo(head.hair2, person.view_hair2_color);
		
		head.cacheAsBitmap = true;
	}
	
}