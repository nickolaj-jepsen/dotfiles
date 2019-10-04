# Defined in - @ line 1
function super-reset --description 'reset dev env'
	cd ~/Development/devenv
	docker-compose down
	docker-compose build
    sudo rm -rf ~/Development/devenv/data/*
	sudo find . -name "*.pyc" -exec rm -f {} \;
	docker-compose up --force-recreate -d
	make shop-reset-db
	make flex-reset-db
end
