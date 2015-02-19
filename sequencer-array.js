//create method for adding sequences in animation engine

/////////////////////

var AnimationSequencer = {

    _incrementor:0,  
    // every method returns obj---------v
    queue:[],

    add: function(func){
        AnimationSequencer.queue.push(func)
    },
    
    run:function(){
        
        if( AnimationSequencer._incrementor == AnimationSequencer.queue.length-1) currentloop++;
        if( AnimationSequencer._incrementor == AnimationSequencer.queue.length) AnimationSequencer._incrementor=0;

        if(currentloop>loops) return;
        
        /* by incrementing first you allow AnimationSequencer.run() to be
        called emidiately within queued function */
        AnimationSequencer._incrementor++ ;
        
        AnimationSequencer.queue[ AnimationSequencer._incrementor-1 ]();
        
    },
    
    // ads init resonsibilities to end of array
    start:function(){
        AnimationSequencer.add(
            function(){
                    
                    init(function(el, i, arr){
                        el.visible=false;
                    });
                    init(function(el, i, arr){
                        initprops(el);
                    });
                    
                    AnimationSequencer.run();
            });
        // start sequence   
        AnimationSequencer.run();   
    }
    
}

/*
AnimationSequencer.add(
    function(){

    });
*/

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

AnimationSequencer.run();


