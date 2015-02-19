//  ************************** 
//  Object Tools
//  for dealing with Creative properties * Abstract Decoupled
//  ************************** 



function Properties (){

	this.store=function(obj, prop){
		var ipv = obj.initPropValues ={};
		var setString = function(prop){
			if (typeof prop == 'string' && obj[prop]){
				ipv[prop]=obj[prop];
			}
		}
		if (prop instanceof Array){
			// JS
			Array.prototype.forEach.call(prop, 
				function(e,i,a){
					setString(e);
				})
			return;
		}
		setString(prop);
	},

	this.reset=function(obj){
		if(!obj.initPropValues) return;
		var ipv = obj.initPropValues;
		for (var prop in ipv){
			obj[prop] = ipv[prop];
		}
	},

	this.manipulate=function(compoundObj, func){
		// make it obj structure agnostic ?
		for (var item in compoundObj) {
			compoundObj[item].forEach( func );
		}
	}

}


//  ************************** 
//  Creative
//  Repesents the programatic structure of the creative. View
//  ************************** 

//  store movieclips that are animated - this is an opportunity to group things for mass sequencing


function Creative(obj){
	
	var elements={};
	var sequencer;

	/*
	(function init(obj){

		})();
	*/

	for (var prop in obj){
		elements[prop]=obj[prop];
	}

	//
	// property manipulation
	//

	this.set(element, function){
		//fancy functions
	}

	this.setAll=function(func){
		// make it obj structure agnostic ?
		for (var prop in elements) {
			elements[prop].forEach( func );
		}
	}

	//
	// animation sequencing
	//

	// be able to switch between -array and -switch ?
	this.animation = new AnimationSequencer(this);
	
	this.addSequencer=function(asequencer){
		sequencer = asequencer;
	}	
}

//////////////////////////////////////////
/// Requires Creative


function AnimationSequencer (Creative) {

	var creative = Creative;
	var loops=2;
    var _incrementor=0;
    var currentloop=1;
    var _this = this;
    var _started=false; 
    // every method returns obj---------v
    var queue=[],
    
    this.run = function(){
        
        if(_incrementor == queue.length-1) currentloop++;
        if(_incrementor == queue.length) _incrementor=0;

        if(currentloop>loops) return;
        
        /* by incrementing first you allow AnimationSequencer.run() to be
        called emidiately within queued function */
        _incrementor++ ;
        
        queue[ _incrementor-1 ]();
        
    };

    this.add = function(func){
        queue.push(func)
    };    
    
    // ads init resonsibilities to end of array
    this.start = function(){
    	(_started)? return : _started=true;
        this.add(
            function(){          	

				creative.setAll(function(el, i, arr){
						Properties.reset(el);
					}); 
                
                _this.run();
            });
        // start sequence   
        this.run();   
    };
    
}

/*
AnimationSequencer.add(
    function(){

    });
*/

///////////////////////////////////////////////////////////////////////////////////////////////////////
									
//									CUSTOM BUILD

///////////////////////////////////////////////////////////////////////////////////////////////////////
// Formalize !!!!
/////////////////////////////////////////////////////////////////////////////////////////////////////////


var c = new Creative({
	f1:[creativeMC.f1],
	f2:[creativeMC.f2],
	//
	mask:[creativeMC.interactive.msk],
	car:[creativeMC.interactive.car],	
	intrctv:[creativeMC.interactive],
	airbmp:[creativeMC.interactive.airbump],
	//
	f3:[creativeMC.f3],
	f4:[creativeMC.f4],
	f5:[creativeMC.f5],
	//
	logo:[creativeMC.logo],	
	cta:[creativeMC.cta],
	ctec:[creativeMC.ctec],
	arrow:[creativeMC.cta.arrow]
});


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Interactions
//////////////////////////////////////////////////////////////////////////////////////////////////////////////

//setup

c.setAll(function(el, i, arr){
		el.visible=false;
	});

// actionscript
c.setAll(function(el, i, arr){
		Properties.store(el, ['x', 'y', 'scaleX', 'scaleY', 'width', 'height', 'alpha', 'visible'] );
	});


// fancy functions


//////////////////////////////////////////////////////////////////////////////////////////////////////////////
/////////// Interactions
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


AnimationSequencer.add(
    function(){
        setTimeout(
            function(){ 
                console.log('a'); 
                AnimationSequencer.run() 
                }, 1000)
                });

 AnimationSequencer.add(
    function(){
        setTimeout(
            function(){ 
                console.log('b'); 
                AnimationSequencer.run() 
                }, 3000)
                });               

 AnimationSequencer.add(
    function(){
        setTimeout(
            function(){ 
                console.log('c'); 
                AnimationSequencer.run() 
                }, 3000)
                }); 

AnimationSequencer.start();
