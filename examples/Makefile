DMD=rdmd -g -w --build-only -ofbin/$@ -I../ -L-lncursesw $^

all: 	init helloUnicode helloWorld simpleColor simpleKey keyCode
	
init: 
	@echo "building all examples..."

helloWorld: 	helloWorld.d
	$(DMD)

helloUnicode: 	helloUnicode.d
	$(DMD)

simpleColor: 	simpleColor.d
	$(DMD)

keyCode: 	keyCode.d
	$(DMD)

# TODO fix
simpleKey: 	simpleKey.d
	$(DMD)

clean: 
	@rm bin/*
	@echo "done."
