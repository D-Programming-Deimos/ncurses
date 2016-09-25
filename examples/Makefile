DC=rdmd -g -w --build-only -ofbin/$@ -I../source -L-lncursesw $^

all: 	init helloUnicode helloWorld simpleColor simpleKey simpleSpectrum keyCode chgat acsVars printw simplePanel winBorder.d simpleMenu.d otherBorder mouseMenu scrollMenu attribMenu printBold

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

simpleMenu: 	simpleMenu.d
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

printBold: 	printBold.d
	$(DC)

winBorder: 	winBorder.d
	$(DC)

otherBorder: 	otherBorder.d
	$(DC)

mouseMenu: 	mouseMenu.d
	$(DC)

scrollMenu: 	scrollMenu.d
	$(DC)

attribMenu: 	attribMenu.d
	$(DC)

clean:
	@rm bin/*
	@echo "done."
