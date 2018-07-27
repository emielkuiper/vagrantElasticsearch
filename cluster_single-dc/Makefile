PHONY: initial_license_check provision snapshot_create snapshot_restore

snapshot_create:
	scripts/create_snapshot.sh

snapshot_restore:
	scripts/restore_snapshot.sh

initial_license_check:
	curl -XGET 'localhost:9200/_xpack/license'

provision:
	vagrant provision
