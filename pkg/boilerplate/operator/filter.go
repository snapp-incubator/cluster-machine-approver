package operator

import "github.com/openshift/cluster-machine-approver/pkg/boilerplate/controller"

func FilterByNames(names ...string) controller.Filter {
	return controller.FilterByNames(nil, names...)
}
