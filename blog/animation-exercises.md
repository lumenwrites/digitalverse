This is a collection of animation exercises that will  take you from learning the fundamentals of animation to creating advanced acting scenes.

## Fundamentals of animation

- Bouncing ball.(Slow in/out, Squash and Stretch.)  
[Example 1](https://www.youtube.com/watch?v=ViUfPcXT47w)  
- Light ball and a heavy cannon ball. (Timing. Showing Weight.)  
[Example 1](https://www.youtube.com/watch?v=slI-TXXFK7A)  
- Pendulum platform. 
- Tailor obstacle course. (Arcs and Overlapping action.)  
[Example 1](https://www.youtube.com/watch?v=Na8k1C3g7Gc)
- Poses.

### Walkcycles

- Simple normal walk.  
[Example 1](https://www.youtube.com/watch?v=FEHWx1qAVuc)  
[Example 2](https://www.youtube.com/watch?v=0g60SSh00tk)  
[Example 3](https://www.youtube.com/watch?v=RAwo-nga_XU)  
- Run cycle.  
[Example 1](https://www.youtube.com/watch?v=zkCPYG1b24U)  
- Happy. 
- Sad/Tired.
- Angry  
[Example 1](https://www.youtube.com/watch?v=mMnYlY5fPVs)  
- Injured leg  
- Sneaking.   
[Example 1](https://www.youtube.com/watch?v=2kkIGUFTsbA)
- Skipping.
- Personality walk.  
[Example 1](https://www.youtube.com/watch?v=cwnafMmrdwo)  
[Example 2](https://www.youtube.com/watch?v=0u9j89dJ7Ms)  
- Dog walkcycle  
[Example 1](https://www.youtube.com/watch?v=Dw9qFmlFRI0)  

## Basic body mechanics

- 180 degree turn.
- Jumping from point to point(Between poles/puddles/stones, hopscotch).  
[Example 1](https://youtube.com/watch?v=MgELVm6Yd94)  
[Example 2](https://youtube.com/watch?v=7Zo9o6ua0-s)  
[Example 3](https://youtube.com/watch?v=MgELVm6Yd94)  
- Kick a ball.  
[Example 1](https://youtube.com/watch?v=7Zo9o6ua0-s)  
[Example 2](https://youtube.com/watch?v=1cwF35mLIfw)  
- Walk against heavy wind.  
[Example 1](https://youtube.com/watch?v=wGZejfftB8A)  

- Lift.  
[Example 1](https://youtube.com/watch?v=QrtpzXL-rIY)  
- Jump. (Over the gap, on/off the table.)  
[Example 1](https://youtube.com/watch?v=rBNljCuXVKU)  
[Example 2](https://youtube.com/watch?v=wafsC0eV6g0)  
[Example 3](https://youtube.com/watch?v=NS9sPSYCpNM)  
- Pull a heavy thing.  
[Example 1](https://youtube.com/watch?v=GDnBS3udAPE)  
- Trying to open a sticky door.  
[Example 1](https://youtube.com/watch?v=tIWGjcw6RVY)  
- Back flip.  
[Example 1](https://youtube.com/watch?v=9SHjDT_c_Q4)  
- Throwing a ball.  
[Example 1](https://youtube.com/watch?v=76-rstTKtcU)  



## Advanced body mechanics

- Parkour/Chase. Obstacle course. Acrobatics.    
[Example 1](https://youtube.com/watch?v=zCpBWncMSOE)  
[Example 2](https://www.youtube.com/watch?v=GGUB9sGgnjo)  
[Example 3](https://www.youtube.com/watch?v=4x0jk5GAOfs)  
[Example 4](https://www.youtube.com/watch?v=QkzimaqdDbI)  
[Example 5](https://www.youtube.com/watch?v=P_2CRAlEIEY)  
- Dance.  
[Example 1](https://youtube.com/watch?v=nZTdfFPFVvs)  
- Fight. Sword fight.  
[Example 1](https://www.youtube.com/watch?v=C5JBD2tPat8)  


## Basic acting:

- Pantomime. (Cooking, cleaning, studying. Winning a lottery, getting scared.)  
[Example 1](https://www.youtube.com/watch?v=mZsSCM9TH-A)  
[Example 2](https://www.youtube.com/watch?v=4pXFrFsvd7Y)  
[Example 3](https://www.youtube.com/watch?v=LWV6fneTrM0)  
[Example 4](https://www.youtube.com/watch?v=28W35z95VZE)  
[Example 5](https://www.youtube.com/watch?v=785VjLasEvU)  
- Monologue. (One character, short. Movie quote.)  
[Example 1](https://www.youtube.com/watch?v=cL1buPHi1bs)  
[Example 2](https://www.youtube.com/watch?v=1w6P1HFCMg0)  
[Example 3](https://www.youtube.com/watch?v=7a5MHMXeGx4)  

## Advanced acting:

- Dialogue.  
[Example 1](https://www.youtube.com/watch?v=Q2YZCVVQxb4)  
[Example 2](https://www.youtube.com/watch?v=rmZ2n-DJwOw)  




<script>
$(document).ready(function(){

function replaceLink(link){
        var pattern = /(?:http?s?:\/\/)?(?:www\.)?(?:youtube\.com|youtu\.be)\/(?:watch\?v=)?(.+)/g;
				var timepattern = /\?t=(.*)/;
        if(pattern.test(link)){

						//if (timepattern.exec(link)) {
						//			var time = timepattern.exec(link)[0]
						//} else { var time = ""}

              var replacement = '<iframe width="640" height="360" src="http://www.youtube.com/embed/$1" frameborder="0" allowfullscreen></iframe><br/>';
              var embed = link.replace(pattern, replacement);
        } 

        return embed;
}    

$('.post-body').find("a").each(function() {
    $(this).click(function(event) {
	event.preventDefault();
	console.log($(this).attr('href'));
	link = 	$(this).attr('href');
	$(this).replaceWith(replaceLink(link));
    });
    
})
})

</script>
