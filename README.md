# Knative Camel

This repository contains the OLM manifests for the Knative Camel add-on.

# User instructions

Knative Camel can be installed directly from Operator Hub and it has the following prerequisites:

- Knative Eventing
- Knative Serving
- Camel K

>**NOTE:** Knative Camel 0.10.0 is compatible with Camel K 1.0.0-M4, which cannot be installed from Operator Hub.

The Camel K client can be downloaded from the [1.0.0-M4 release page](https://github.com/apache/camel-k/releases/tag/1.0.0-M4) and installed following the instructions in the [github repository](https://github.com/apache/camel-k#installation).
  
Camel K 1.0.0-M4 should be installed in "All Namespaces" mode in order to use it in Camel Sources.

For example, to use Knative Camel in an example namespace, follow these steps:

## Installing Camel K in an example namespace

1. Create the `example` namespace by navigating to **Home > Projects** in the Web Console. Click **Create Project** and a dialog box will appear.

1. Enter `example` in the name field and click **Create**. The `example` namespace is now created. Alternatively you can use `oc` or `kubectl` to create.

1. Navigate to the **Developer Catalog** of the namespace to create a Camel K **Integration Platform** resource.

1. Once all prerequisites are installed, you can install the Knative Camel add-on.

1. Knative Camel can be installed in **All Namespaces** from the Operator Hub console.

1. After the installation is complete, in the **Developer Catalog** section a new `Camel Source` object will be listed.

1. The example `Camel Source` resource aim to push events into a Knative Eventing channel, 
so follow the [Knative Eventing documentation](https://knative.dev/docs/eventing/channels/default-channels/) to create a channel named `camel-test`.

1. Once the `camel-test` channel is created, you can create the `example` Camel Source.

1. After the initialization is done, it will run in the cluster.

# Development instructions

This repo contains only the manifests for installing Knative Camel on a Kubernetes cluster supporting OLM.

To test the CSV, you can push the manifest to quay.io and create a operator source to track it.

To push the manifest to quay, use the commands:
```
export QUAY_USERNAME=your-user
export QUAY_PASSWORD=your-password
./push-to-quay.sh
```

By default **applications in Quay have private scope**. You need to go to the quay user interface, from the **Applications** tab, select **knative-camel**,  and change the visibility to **public**.

Edit the `operatorsource.yaml` file and set your username in the `registryNamespace` field (it is set to *nferraro* by default).

Run:
```
oc create -f operatorsource.yaml
```

The operator will be displayed in the OpenShift marketplace.

>**NOTE:** If you want to republish the operator, you need to first delete the application from quay.
