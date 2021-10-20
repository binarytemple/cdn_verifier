
run_release:
	MIX_ENV=prod mix release --overwrite &&  _build/prod/rel/cdn_verifier/bin/cdn_verifier start
