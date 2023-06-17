# GKE on the cheap

[GKE Cluster](https://www.terraform.io/docs/providers/google/r/container_cluster.html)

[GKE Container Node Pool ](https://www.terraform.io/docs/providers/google/r/container_node_pool.html)

~$5USD/mth for a managed one node cluster thanks to a [solid GCP/GKE free tier](https://cloud.google.com/free/docs/gcp-free-tier) and [spot pricing](https://cloud.google.com/compute/docs/instances/preemptible).

Good for learning and scaling up if you need to temporarily while learning or experimenting in your own k8s sandbox.

## IMPORTANT

The key to getting the savings here is to limit the amount of nodes in your cluster (until you need it). The 3 key settings to ensure this is `location`, `node_locations` and `node_count` (or `initial_node_count`).

`location` specifies where to place the cluster (masters). By specifying a zone, you have a free, zonal cluster. If you replaced it with a region instead, it becomes a regional cluster -- ideal for a production cluster, but not part of the free tier offering.

Leaving `node_locations` blank will default your node to be in the same zone as your GKE cluster's zone. Any zone you specify will be **in addition** to the the cluster's zone (i.e. `node_locations = ["northamerica-northeast1-a",]`), meaning your nodes will span more than one zone. This is referred to as a multi-zone cluster.

`node_count` specifies how many nodes **per zone** rather than the total node count in your cluster. Therefore, if you set 3 zones in `node_locations` with a `node_count` of 2, you're going to have 6 nodes in total.

## Enable Required APIs

You can do this via console or...

```
gcloud services enable --async \
  container.googleapis.com
```

## Cheap compute options

Checkout `n2d-standard-2` in the iowa region for a good price/performance option as of July 2022.
