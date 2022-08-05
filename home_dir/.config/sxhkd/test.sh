#!/bin/bash


super + {_,alt} + {_,shift} + {1-9,0}
	MON={'1','2'}; \
	SEL={'desktop -f','node -d'}; \
	FOLLOW=`[[ $SEL == 'node -d' ]] && echo --follow`; \
	echo $SEL $MON $FOLLOW; \
	bspc `echo $SEL` ^$MON:^{1-9,10} $FOLLOW
