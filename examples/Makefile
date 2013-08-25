DC=rdmd -g -w --build-only -ofbin/$@ -I../ -L-lncursesw $^

all: 	init helloUnicode helloWorld simpleColor simpleKey simpleSpectrum keyCode chgat acsVars printw simplePanel
	
init: 
	@echo "building all examples..."

helloWorld: 	helloWorld.d
	$(DC)

helloUnicode: 	helloUnicode.d
	$(DC)

simpleColor: 	simpleColor.d
	$(DC)

simplePanel: 	simplePanel.d
	$(DC)

# TODO fix
simpleKey: 	simpleKey.d
	$(DC)

simpleSpectrum: simpleSpectrum.d
	$(DC)

acsVars: 	acsVars.d
	$(DC)

chgat: 		chgat.d
	$(DC)

keyCode: 	keyCode.d
	$(DC)

tempLeave: 	tempLeave.d
	$(DC)

printw: 	printw.d
	$(DC)

clean: 
	@rm bin/*
	@echo "done."
