oc new-app manageiq/manageiq
oc create route passthrough --service manageiq --port 443


# create monolithic template
❯ oc create -f manageiq-pods/templates/miq-template-monolithic.yaml
template "manageiq-monolithic" created

❯ oc process --parameters -n miq manageiq-monolithic
NAME                       DESCRIPTION                                                                                                 GENERATOR           VALUE
NAME                       The name assigned to all of the frontend objects defined in this template.                                                      manageiq
APPLICATION_DOMAIN         The exposed hostname that will route to the application service, if left blank a value will be defaulted.
DATABASE_VOLUME_CAPACITY   Volume space available for database.                                                                                            1Gi


# automate adding local cluster to miq

# trying to install containerized openshift
ansible-playbook -i ansible/inventory_file openshift-ansible/playbooks/byo/config.yml -e 'ansible_python_interpreter=/usr/bin/python3' --ask-become-pass

oc new-app --template=manageiq-monolithic
oc rollout latest manageiq


# install miq with seeded db

