class gen_face_man{

	//skin_colors CONST
	static var pink = new Array(0,0,0);
	static var south = new Array(-180,-160,-240);
	static var white = new Array(50,50,50);
	static var yellow = new Array(50,50,-150);
	static var red = new Array(-30,-150,-200);
	static var clrs = new Array(pink,white,yellow,red,south);
	
	ks = new Array(.4 + random(300) / 1000, random(60) / 1000, random(60) / 1000, random(80) / 1000, random(80) / 1000);
	ks.push(1 - ks[0] - ks[1] - ks[2] - ks[3]);
	
	
	static var hr_blond = new Array(101, 92, 18);
	static var hr_orang = new Array(119, 17, -136);
	static var hr_yell = new Array(70, 6, -85);
	static var hr_cary = new Array(45, -20, -62);
	static var hr_brown = new Array(-36, -48, -74);
	static var hr_black = new Array(-79, -81, -91);
	static var hr_gray = new Array(68, 68, 68);
	static var hr_white = new Array(100, 102, 94);
	static var hr_clrs = new Array(hr_brown,hr_black ,hr_yell ,hr_orang ,hr_white ,hr_gray ,hr_blond ,hr_cary);
	
	
	// race is 
	// 0 - pink, 1 - white, 2 - yellow, 3 - red, 4 - south
	static function raceRandomColor(raceInd):Array{
		static var clrsRand = new Array();
		if (raceInd == 0) clrsRand = new Array(clrs[0], clrs[1], clrs[3], clrs[2], clrs[4]);
		if (raceInd == 1) clrsRand = new Array(clrs[1], clrs[0], clrs[2], clrs[3], clrs[4]);
		if (raceInd == 2) clrsRand = new Array(clrs[2], clrs[0], clrs[1], clrs[3], clrs[4]);
		if (raceInd == 3) clrsRand = new Array(clrs[3], clrs[4], clrs[0], clrs[2], clrs[1]);
		if (raceInd == 4) clrsRand = new Array(clrs[4], clrs[3], clrs[0], clrs[2], clrs[1]);
		
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
	
	static function hairRandomStyle(age):Number{
		if (random(8) == 0) return random(26)+1;	// chance to have exactly random hair
		if (age <= 4) return 24 + random(3);		// bold children
		if (age < 13) return random(10) + 1;		// first cool hair with 4-13
		if (age < 25) return random(17) + 1;
		if (age < 45) return 10 + random(12);
		return 12 + random(15);	
	}
	static function manBeardRandomStyle(age):Number{
		if (random(8) == 0) return random(26)+1;	// chance to have exactly random hair
		if (age <= 4) return 24 + random(3);		// bold children
		if (age < 13) return random(10) + 1;		// first cool hair with 4-13
		if (age < 25) return random(17) + 1;
		if (age < 45) return 10 + random(12);
		return 12 + random(15);	
	}
	
	// gender : male = 1, female = 0
	static function generateFace(person, head, age, gender, raceRGB){
		// hr_clr_ind = random(hr_clrs.length);
		// hr_clr = new Array(hr_clrs[hr_clr_ind][0]+random(19)-9,
						   // hr_clrs[hr_clr_ind][1]+random(19)-9,`
						   // hr_clrs[hr_clr_ind][2]+random(19)-9);
		// br_clr = new Array(hr_clrs[hr_clr_ind][0]+random(29)-14,
						   // hr_clrs[hr_clr_ind][1]+random(29)-14,
						   // hr_clrs[hr_clr_ind][2]+random(29)-14);
		
		// head.gotoAndStop(random(7)+1);
		// head.ears.gotoAndStop(random(7)+1);
		// head.broves.gotoAndStop(random(15)+1);
		// head.eyes.gotoAndStop(random(20)+1);
		// head.nose.gotoAndStop(random(18)+1);
		// head.mouth.gotoAndStop(random(20)+1);
		// head.hair.gotoAndStop(random(26)+1);
		// head.hair2.gotoAndStop(random(21)+1);
		// head.mimic.gotoAndStop(random(3)+1);
		
		// head.eyes._xscale = head.eyes._yscale = 70 + random(51);
		// head._xscale = 95+random(11);
		// head._yscale = 95+random(11);
		
				
		// ut.colorTo(head.skin, raceRGB[0], raceRGB[1], raceRGB[2]);
		// ut.colorTo(head.ears.skin, raceRGB[0], raceRGB[1], raceRGB[2]);
		// ut.colorTo(head.hair, hr_clr[0], hr_clr[1], hr_clr[2]);
		// ut.colorTo(head.hair2, br_clr[0], br_clr[1], br_clr[2]);
	}
	
	
}