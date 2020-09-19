.ONESHELL:
.PHONY: all diretto

all:
	cd ..
	git add .
	echo "Enter commit message"
	read text
	git commit -m "$$text"
	git push origin develop
	git checkout master
	cp -r ./_site/* .
	git add .
	git commit -m "$$text"
	git push origin master
	git checkout develop
diretto:
	cd ..
	git add .
	echo "Enter commit message"
	read text
	git commit -m "$$text"
	git push origin develop
	bundle exec jekyll serve
	git checkout master
	cp -r ./_site/* .
	git add .
	git commit -m "$$text"
	git push origin master
	git checkout develop