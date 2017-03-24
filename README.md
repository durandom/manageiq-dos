# manageiq-dos
ManageIQ Development on OpenShift

## Prepare your cluster

```bash
ansible-playbook -i 'phobos,' prepare-cluster.yml
```

## Startup MIQ

```bash
 oc new-app --template=manageiq -p NAME=miq1
 ```

```bash
oc rsh manageiq-1-... bash -l -c 'rails evm:status'
```
