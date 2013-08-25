DMD=rdmd -g -w --build-only -ofbin/$@ -L-lncursesw $^

all: 	helloUnicode helloWorld

helloWorld: 	helloWorld.d
	$(DMD)

helloUnicode: 	helloUnicode.d
	$(DMD)

simpleColor: 	simpleColor.d
	$(DMD)

keyCode: 	keyCode.d
	$(DMD)

clean: 
	@rm bin/*
