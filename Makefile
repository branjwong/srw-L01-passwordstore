# Local Dev Initialization

ln:
	ln -sf ../../review/PasswordStore.t.sol contracts/test/PasswordStore.t.sol

fixperm:
	sudo chmod -R a+rwX .
	sudo chmod -R g+rwX .
	sudo find . -type d -exec chmod g+s '{}' +
