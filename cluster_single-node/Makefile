PHONY: vault vault_edit initial_license_check provision

vault:
	ansible-vault create vagrant/ansible-vault.yml

vault_edit:
	ansible-vault edit vagrant/ansible-vault.yml

initial_license_check:
	curl -XGET 'localhost:9200/_xpack/license'

provision:
	vagrant provision
