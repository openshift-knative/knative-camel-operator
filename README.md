# Knative Camel

This repository contains the OLM manifests for the Knative Camel addon.

# User instructions

Knative Camel can be installed directly from OperatorHub and it has the following prerequisites:

- Knative Eventing
- Knative Serving
- Camel K

Knative Camel 0.6.0 is compatible with Camel K 0.2.0, that cannot be installed from operator hub.

The Camel K client can be downloaded from the [0.2.0 release page](https://github.com/apache/camel-k/releases/tag/0.2.0) and installed
following the instructions in the [github repository](https://github.com/apache/camel-k#installation).
  
Camel K 0.2.0 can be installed in "Single Namespace" mode only, so you must install it in any namespace where you want to deploy a Camel source.

For example, to use Knative Camel in the "example" namespace, the following steps should be done:
- Install Camel K in the "example" namespace
- From the "Developer Catalog" of the "example" namespace, create a Camel K "Integration Platform" resource (the default example is good for OpenShift)  

After all prerequisites are installed you can proceed to install the Knative Camel addon.

Knative Camel can be installed in "All Namespaces" from the Operator Hub console.

After the installation is complete, in the "Developer Catalog" section a new "Camel Source" object will appear.

The example "Camel Source" resource expect to push events into a Knative Eventing channel, 
so you need to follow the Knative eventing documentation to create a channel named "camel-test".

Once the "camel-test" channel is created, you can create the "example" Camel Source.

After the initialization is done, it will run in the cluster.

# Development instructions

This repo contains only the manifests for installing Knative Camel on a Kubernetes cluster supporting OLM.

To test the CSV, you can push the manifest to quay.io and create a operator source to track it.

To push the manifest to quay:
```
export QUAY_USERNAME=your-user
export QUAY_PASSWORD=your-password
./push-to-quay.sh
```

By default **applications in Quay have private scope**. You need to go to the quay user interface, from the "Applications" tab, select "knative-camel",  and change the visibility to **public**.

Edit the `operatorsource.yaml` file and set your username in the `registryNamespace` field (It's set to *nferraro* by default).

Run:
```
oc create -f operatorsource.yaml
```

The operator should appear in the OpenShift marketplace.

NOTE: if you want to republish the operator, you need first to delete the application from quay.
