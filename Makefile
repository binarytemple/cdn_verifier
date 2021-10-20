install_apollo:
	npm install -g apollo

install_firebase:
	npm install -g firebase-tools

update_schema:
	apollo schema:download ./priv/graphql-schemas/monday.json --endpoint=https://api.monday.com/v2  --header="Authorization: $${MONDAY_API_TOKEN:?missing}" 

#firebase_init:
#	firebase login
#	firebase init
#
#run_firebase:

run_release:
	MIX_ENV=prod mix release --overwrite &&  _build/prod/rel/poc_monday/bin/poc_monday start
