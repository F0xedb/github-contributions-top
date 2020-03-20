all: get format
full: get format sync-default
get: 1 2
format: 3

1:
	if [ -e temp-logins.json ]; then mv temp-logins.json old-logins.json; fi;
	coffee get-users.coffee
	# for debug - requires get-users.coffee/get-details.coffee already ran:
	#coffee check-logins.coffee

2:
	coffee get-details.coffee

3:
	coffee format-languages.coffee
	coffee format-users.coffee

4: sync-raw sync-formatted

sync: sync-raw sync-formatted
force-sync: force-sync-raw sync-formatted

sync-raw:
	cd raw && git commit -am 'Update stats.' && git push

force-sync-raw:
	cd raw && git commit -am 'Update stats.' --amend && git push --force

sync-formatted:
	cd formatted && git commit -am 'Sync.' --amend && git push --force

sync-default:
	mv formatted/active.md README.md
	git add .
	git commit -m "Update stats."
	git push origin master


clean:
	rm temp-logins.json
	rm old-logins.json
	rm raw/github-languages-stats.json
	rm raw/github-users-stats.json
	rm formatted/active.md
