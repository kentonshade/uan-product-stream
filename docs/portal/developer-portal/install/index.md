# Cray EX User Access Nodes Software Installation

> version: @product_version@
>
> build date: @date@

This section describes the procedure for installing the UAN software package and
verifying the installation is successful.

---

## Contents

* [Download and Prepare the UAN Software Package](#prep)
* [Run the Installation Script (Offline/air-gapped Install)](#offline)
* [Run the Installation Script (Online Install)](#online)
* [Installation Verification](#verify)

---

<a name="prep"></a>
## Download and Prepare the UAN Software Package

1. Download the UAN software package and place it on the system.
2. Unpackage the file and change into the directory with the installation content.

    ```bash
    ncn-m001:~ $ tar zxf uan-@product_version@.tar.gz
    ncn-m001:~ $ cd uan-@product_version@/
    ```
3. Apply the patch
**`IMPORTANT`** Before proceeding refer to the "UAN Patch Assembly" section of the Shasta Install Guide 
to apply any needed patch content for UAN. It is critical to perform these steps to ensure that the correct
UAN release artifacts are deployed.
 
<a name="offline"></a>
## Run the Installation Script (Offline/air-gapped Install)

If the Cray EX system is configured for offline/air-gapped installations, use
this section.

1. Run the UAN installation script:

    ```bash
    ncn-m001:~/ $ ./install.sh
    ```

<a name="online"></a>
## Run the Installation Script (Online Install)

If the Cray EX system is configured for online installations, use this section.

1. Run the UAN installation script with the `online` option:

    ```bash
    ncn-m001:~/ $ ./install.sh --online
    ```

<a name="verify"></a>
## Installation Verification

1. Verify that the UAN configuration, images, and recipes have been imported and
   added to the `cray-product-catalog` ConfigMap in the Kubernetes `services`
   namespace. Ensure that an entry exists with the @product_version@ version,
   and that the `configuration`, `images`, and `recipes` sections contain
   information similar to the output below.

   **NOTE**: The output from the command below may contain more than one version
             of the UAN product if previous versions have been installed.

   ```bash
   ncn-m001:~ $ kubectl get cm cray-product-catalog -n services -o json | jq -r .data.uan

   @product_version@:
     configuration:
       clone_url: https://vcs.<shasta domain>/vcs/cray/uan-config-management.git
       commit: 6658ea9e75f5f0f73f78941202664e9631a63726
       import_branch: cray/uan/@product_version@
       import_date: 2021-07-28 03:26:00.399670
       ssh_url: git@vcs.<shasta domain>:cray/uan-config-management.git
     images:
       cray-shasta-uan-cos-sles15sp2.x86_64-0.2.24:
         id: c880251d-b275-463f-8279-e6033f61578b
     recipes:
       cray-shasta-uan-cos-sles15sp2.x86_64-0.2.24:
         id: cbd5cdf6-eac3-47e6-ace4-aa1aecb1359a
   ```

   If the previous command does not show the @product_version@ content, check
   the Kubernetes jobs responsible for importing the configuration content:

   ```bash
   ncn-m001:~ $ kubectl get pods -n services -l job-name=uan-config-import-@product_version@
   NAME                             READY   STATUS      RESTARTS   AGE
   uan-config-import-@product_version@-gsvrc   0/3     Completed   0          5m
   ```

   and the image and recipe content:

   ```bash
   ncn-m001:~ $ kubectl get pods -n services -l job-name=uan-image-recipe-import-@product_version@
   NAME                                   READY   STATUS      RESTARTS   AGE
   uan-image-recipe-import-@product_version@-2fvr7   0/3     Completed   0          6m
   ```

   to ensure they have successfully completed.

1. Verify that the UAN RPM repositories have been created in Nexus. Navigate to
   `https://nexus.<shasta domain>/#browse/browse` to view the list of
   repositories. Ensure that the following repositories are present:
   * uan-2.1.0-sle-15sp2
   * uan-2.1-sle-15sp2

   Alternatively, use the Nexus REST API to display the repositories prefixed
   with the name `uan`:

   ```bash
   ncn-m001:~/ $ curl -s -k https://packages.local/service/rest/v1/repositories | jq -r '.[] | select(.name | startswith("uan")) | .name'

   uan-2.1-sle-15sp2
   uan-2.1.0-sle-15sp2
   ```