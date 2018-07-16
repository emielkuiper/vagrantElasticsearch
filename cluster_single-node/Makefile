PHONY: vault vaultedit licensecheck provision

vault:
	ansible-vault create vagrant/ansible-vault.yml

vaultedit:
	ansible-vault edit vagrant/ansible-vault.yml

licensecheck:
	curl -XGET 'localhost:9200/_xpack/license'

provision:
	vagrant provision
