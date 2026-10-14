FROM docker.io/library/golang:1.27 AS builder
WORKDIR /go/src/github.com/openshift/cluster-machine-approver
COPY . .
RUN CGO_ENABLED=0 make build

FROM registry.access.redhat.com/ubi10/ubi-minimal:latest
COPY --from=builder /go/src/github.com/openshift/cluster-machine-approver/machine-approver /usr/bin/
COPY manifests /manifests
ENTRYPOINT ["/usr/bin/machine-approver"]
LABEL io.k8s.display-name="OpenShift cluster-machine-approver" \
      io.k8s.description="This is an OpenShift component for managing machine approval" \
      com.redhat.component="cluster-machine-approver" \
      maintainer="OpenShift Auth Team <aos-auth-team@redhat.com>" \
      name="openshift/ose-cluster-machine-approver" \
      version="v4.0.0" \
      io.openshift.tags="openshift" \
      io.openshift.release.operator=true
