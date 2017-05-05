# Running ManageIQ on minishift


## Prepare your minishift cluster

* install minishift
* run `./minishift_up.sh`

The app template will be installed in the default myproject

## Deploy an ManageIQ app

* run `./deploy_miq.sh production`

## Add your minishift cluster to your ManageIQ app

* run `./oc_token.sh`
* paste the output into ` oc rsh production-0 bash -l -c "rails console"`

## Links

* https://docs.openshift.org/latest/minishift/index.html
* http://manageiq.org/docs/guides/providers/openshift
* https://github.com/ManageIQ/manageiq-pods

## TODO

* create a build pipeline to patch the app image with a PR
* enable multiple ManageIQ instances running on the same cluster https://github.com/ManageIQ/manageiq-pods/issues/133
* add hawkular endpoint to provider
