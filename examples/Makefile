DC=rdmd -g -w --build-only -ofbin/$@ -I../ -L-lncursesw $^

all: 	init helloUnicode helloWorld simpleColor simpleKey simpleSpectrum keyCode withChgat acsVars
	
init: 
	@echo "building all examples..."

helloWorld: 	helloWorld.d
	$(DC)

helloUnicode: 	helloUnicode.d
	$(DC)

simpleColor: 	simpleColor.d
	$(DC)

keyCode: 	keyCode.d
	$(DC)

# TODO fix
simpleKey: 	simpleKey.d
	$(DC)

simpleSpectrum: simpleSpectrum.d
	$(DC)

acsVars: 	acsVars.d
	$(DC)


withChgat: 	withChgat.d
	$(DC)

tempLeave: 	tempLeave.d
	$(DC)

clean: 
	@rm bin/*
	@echo "done."
