#!/bin/bash

# Copyright 2018 The Kubernetes Authors.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

set -o errexit
set -o nounset
set -o pipefail

REPO_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
ENVTEST_K8S_VERSION=${ENVTEST_K8S_VERSION:-1.37.0}
SETUP_ENVTEST_VERSION=${SETUP_ENVTEST_VERSION:-release-0.25}
LOCALBIN="$REPO_ROOT/bin"

cd "$REPO_ROOT"
mkdir -p "$LOCALBIN"
if [ ! -x "$LOCALBIN/setup-envtest" ]; then
	GOFLAGS= GOBIN="$LOCALBIN" go install "sigs.k8s.io/controller-runtime/tools/setup-envtest@${SETUP_ENVTEST_VERSION}"
fi

KUBEBUILDER_ASSETS="$("$LOCALBIN/setup-envtest" use "$ENVTEST_K8S_VERSION" --bin-dir "$LOCALBIN" -p path)"
export KUBEBUILDER_ASSETS

make unit
