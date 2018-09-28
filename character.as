

	class character{
	
			function character(courage0, sociability0,
							   politness0, diligence0,
							   modesty0){
				this.courage	= (courage0	  != undefined)? courage0 : random(5);
				this.sociability= (sociability0 != undefined)? sociability0 : random(4);
				this.politness  = (politness0 != undefined)? politness0 : random(8);
				this.diligence  = (diligence0 != undefined)? diligence0 : random(9);
				this.modesty	= (modesty0	!= undefined)? modesty0 : random(5);
			}
			
			
	
		// to other humans
		
			private var courage:Number;
			static var courage_cowardly = 	0;		// 0 -- cowardly трус
			static var courage_fearfull = 	1;		// 1 -- fearfull побаивается
			static var courage_normal = 	2;		// 2 -- normal
			static var courage_persistent = 3;		// 3 -- persistent
			static var courage_brave = 		4;		// 4 -- brave
			
			private var sociability:Number;
			static var sociability_secretive = 	0;	// 0 -- secretive
			static var sociability_normal	 = 	1;	// 1 -- normal
			static var sociability_frank 	= 	2;	// 2 -- frank
			static var sociability_chatty	 = 	3;	// 3 -- chatty
			
			private var politness:Number;
			static var politness_scornful = 	0;	// 0 - scornful презирающий
			static var politness_rude = 		1;	// 1 -- rude
			static var politness_ironic = 		2;	// 2 -- ironic
			static var politness_casual = 		3;	// 3 -- casual
			static var politness_respectful	 = 	4;	// 4 -- respectful
			static var politness_benevolent	 = 	5;	// 5 -- benevolent доброжелательный
			static var politness_polite	 = 		6;	// 6 -- polite
			static var politness_aristocratic =	7;	// 7 -- aristocratic
			
	
		// to his deals
			
			private var diligence:Number; // трудолюбие
			static var diligence_unscrupulous = 0; 		// 0 - unscrupulous недобросовестный
			static var diligence_irresponsible =1;		// 1 - irresponsible
			static var diligence_lazy = 		2;		// 2 -- lazy
			static var diligence_distracted = 	3;		// 3 -- distracted
			static var diligence_normal = 		4;		// 4 -- normal
			static var diligence_intrested = 	5;		// 5 -- intrested
			static var diligence_active = 		6;		// 6 -- active
			static var diligence_hardworking = 	7;		// 7 -- hardworking
			static var diligence_devoted = 		8;		// 8 -- devoted
			
		// to himself
		
			private var modesty:Number; // скромность
			static var modesty_egocentric = 	0;	// 0 -- egocentric
			static var modesty_selfish	 = 		1;	// 1 -- selfish
			static var modesty_normal	 = 		2;	// 2 -- normal
			static var modesty_unpretentious = 	3;	// 3 -- unpretentious неприхотливй
			static var modesty_humble	 = 		4;	// 4 -- humble - скромный\покорный
			
			
			
			function isTeamworker ():Boolean{
				return (ut.atLeast(sociability, sociability_normal)
					 && ut.atLeast(politness, politness_ironic));
			}
			
			
			function setCourage		(value){ courage	= Math.min(Math.max(0,value), 4);}
			function setSociability (value){ sociability= Math.min(Math.max(0,value), 3);}
			function setPolitness   (value){ politness  = Math.min(Math.max(0,value), 7);}
			function setDiligence   (value){ diligence  = Math.min(Math.max(0,value), 8);}
			function setModesty	    (value){ modesty	= Math.min(Math.max(0,value), 4);}
			
			function incCourage		(){ setCourage		(courage + 1) }
            function incSociability	(){ setSociability  (sociability + 1) }
            function incPolitness 	(){ setPolitness   	(incPolitness + 1) }
            function incDiligence  	(){ setDiligence   	(incDiligence + 1) }
            function incModesty		(){ setModesty	    (incModesty + 1) }

			function decCourage		(){ setCourage		(courage - 1) }
            function decSociability	(){ setSociability  (sociability - 1) }
            function decPolitness 	(){ setPolitness   	(incPolitness - 1) }
            function decDiligence  	(){ setDiligence   	(incDiligence - 1) }
            function decModesty		(){ setModesty	    (incModesty - 1) }
			
			function getCourage		(){return courage;}
			function getSociability (){return sociability;}
            function getPolitness   (){return politness;}
            function getDiligence   (){return diligence;}
            function getModesty		(){return modesty;}
			
			
			function getCourageK	(){return courage / 4;}
			function getSociabilityK(){return sociability / 3;}
            function getPolitnessK  (){return politness / 7;}
            function getDiligenceK  (){return diligence / 8;}
            function getModestyK	(){return modesty / 4;}

}			